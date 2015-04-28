#!/bin/bash
# $1 glob of filenames
# echo all matches separated by commas

# print usage if no args
[ $# -eq 0 ] && { echo "Usage: $0 glob"; exit 1; }

f=0
numfiles=$(ls -1 ${1} | wc -l)
for THISFILE in ${1}; do
  f=$(($f + 1))
  if [ "$f" -ne "$numfiles" ];then
    echo -n "${THISFILE},"
  else
    echo "${THISFILE}"
  fi
done
