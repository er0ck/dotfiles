#!/bin/sh
# eg: $1 == cfacter
git clone https://github.com/er0ck/${1}.git
if [[ $? != 0 ]]; then
  echo "Couldn't find repo for ${1}. Did you fork it?"
  exit $?
fi

cd ${1}
git remote add upstream https://github.com/puppetlabs/${1}.git
git remote set-url --push upstream no-push
cd -
