#!/bin/bash
shopt -s nocaseglob
mogrify -quality 30 *.{jpg,jpeg,JPG,JPEG}
for each in *.{jpg,jpeg,JPG,JPEG}
do
s=`du -k $each | awk '{print $1}'`
if [ $s -gt 10 ]; then
w=`identify -format '%w' $each`
h=`identify -format '%h' $each`
min=w
if [ $w -gt $h ]; then
min=h
fi
composite -gravity southeast -geometry $((min / 10))x$((min / 10))+0+0 ../../img/icon.jpeg $each $each 2>/dev/null
echo "$each: done!"
fi
done
exit 0
