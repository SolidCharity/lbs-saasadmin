#!/bin/bash

branch=main
if [ ! -z "$1" ]; then
  branch=$1
fi

. /etc/os-release
OS=$NAME
VER=$VERSION_ID

if [[ "$OS" == "Ubuntu" || "$OS" == "Debian GNU/Linux" ]]
then
    packages="git sqlite3 gettext python3-venv zlib1g-dev"
    apt-get -y install $packages || exit -1
else
    packages="git sqlite gettext"
    dnf -y install $packages || exit -1

    if [[ "$VER" == "9" ]]; then
        yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm || exit -1
    elif [[ "$VER" == "8" ]]; then
        yum -y install epel-release || exit -1
    fi
    if [[ "$VER" == "8" ]]; then
        yum -y install python39-devel || exit -1
        alternatives --set python3 /usr/bin/python3.9 || exit -1
    fi
fi

git clone --branch $branch --depth 5 https://github.com/SolidCharity/saasadmin.git
cd saasadmin
make quickstart || exit -1
make collectstatic || exit -1
make messages || exit -1
