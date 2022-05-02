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
    packages="git sqlite gettext python3-venv"
    apt-get -y install $packages || exit -1
else
    dnf -y install git sqlite gettext || exit -1
fi

git clone --branch $branch --depth 5 https://github.com/SolidCharity/saasadmin.git
cd saasadmin
make quickstart || exit -1
make collectstatic || exit -1
make messages || exit -1
