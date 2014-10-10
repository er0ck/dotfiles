#!/bin/sh
# eg: $1 == cfacter
git clone https://github.com/er0ck/${1}.git
if [[ $? != 0 ]]; echo "couldn't find repo for ${1}. did you fork it?"; exit $?; fi
 
cd ${1}
git remote rename origin er0ck
git remote add puppet https://github.com/puppetlabs/${1}.git
git remote set-url --push puppet no-push
cd ..
