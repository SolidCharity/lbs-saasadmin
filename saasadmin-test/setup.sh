#!/bin/bash

branch=main
if [ ! -z "$1" ]; then
  branch=$1
fi

git clone --branch $branch --depth 5 https://github.com/SolidCharity/saasadmin.git
cd saasadmin
make quickstart || exit -1
make collectstatic || exit -1
make messages || exit -1
