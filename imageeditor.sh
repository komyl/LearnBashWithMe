#!/bin/bash
IFS=$`\n`
clear
mkdir "$HOME/Picture2"
b="1"
files=`ls $Home/Pictures/*jpg`
for i in $files
   do
     convert "$i" -resize 50% "$Home/Pictures2/$b.png"
    echo "$b.png created"
    ((b++))
done
