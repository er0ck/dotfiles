#!/bin/sha
# eg: $1 == cfacter
git clone https://github.com/er0ck/${1}.git
cd ${1}
git remote rename origin er0ck
git remote add puppet https://github.com/puppetlabs/${1}.git
git remote set-url --push puppet no-push
cd ..
