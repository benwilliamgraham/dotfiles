#!/bin/bash
WIN=`xdotool getwindowfocus`

# make sure that the active window isn't i3
NAME=`xdotool getwindowname $WIN`
if [ NAME != 'i3' ]
then
  eval `xdotool getwindowgeometry --shell $WIN`
  xdotool mousemove -window $WIN `expr $WIDTH / 2` `expr $HEIGHT / 2`
fi
