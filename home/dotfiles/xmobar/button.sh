#!/bin/sh
STATUS=$(playerctl -p vlc -s status)

# No options if no music is playing
if [[ $STATUS == "" ]]
then
  exit 0
fi

if [[ $STATUS == "Playing" ]]
then
  echo -n "[ pause ]"
else
  # The extra space makes it line up with pause in xmobar
  echo -n "[ play  ]"
fi
