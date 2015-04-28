#!/bin/bash

if [ $# -lt 2 ]
then
  echo "Usage: `basename $0` scale filename"
  exit 1
fi

SCALE=${1}
shift

#echo "$2 $3"

for file in $@
do
  # convert the geometry of all files
  # change last . to .sm.
  # 31.25 => 640x480
  #  echo "going to convert $file to $SCALE% of current size."
  convert -geometry $SCALE% $file ${file/\./\.sm\.}
done
