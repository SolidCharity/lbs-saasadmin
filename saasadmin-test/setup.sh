#!/bin/bash

branch=main
if [ ! -z "$1" ]; then
  branch=$1
fi

apt-get -y install git sqlite gettext python3.8-venv || dnf -y install git sqlite gettext || exit -1

git clone --branch $branch --depth 5 https://github.com/SolidCharity/saasadmin.git
cd saasadmin
make quickstart || exit -1
make collectstatic || exit -1
make messages || exit -1
