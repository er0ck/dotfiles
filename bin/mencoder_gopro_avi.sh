#!/bin/sh
# name of this script: mencoder_gopro_avi.sh
# mencode all go pro based MP4 files to avi suitable for openshot

for i in *.MP4; do
  if [ -e "$i" ]; then
    file=`basename "$i" .MP4`
    echo "in: $i"
    echo "out: $file.avi"
    mencoder ${i} -oac mp3lame -ovc lavc -vf harddup -lameopts abr:q=5 -lavcopts vcodec=mjpeg -ffourcc MJPG -o ${file}.avi
  fi
done
