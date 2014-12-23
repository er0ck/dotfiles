ls -1tr > files.txt
#mencoder -nosound -ovc lavc -o lapse.avi -mf type=jpeg:fps=4 mf://@files.txt -vf scale=720:540,crop=720:405:0:0 -lavcopts vcodec=mpeg4

# better, two pass, h264, higher res
mencoder -nosound -of lavf -lavfopts format=avi -vf scale=1280:960,crop=1280:720:0:0 -ovc x264 -x264encopts pass=1:bitrate=1620000:crf=24 -o lapse2.avi -mf type=jpeg:fps=5 mf://@files.txt

mencoder -of lavf -lavfopts format=avi -vf scale=1280:960,crop=1280:720:0:0 -ovc x264 -x264encopts pass=2:bitrate=1620000 -o lapse2.avi -mf type=jpeg:fps=5 mf://@files.txt -audiofile "/mnt/raid/mpthree/Com Truise/Galactic Melt/06 Hyperlips.mp3" -oac copy
