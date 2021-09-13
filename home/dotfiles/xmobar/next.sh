#!/bin/sh
STATUS=$(playerctl -p vlc -s status)

# No options if no music is playing
if [[ $STATUS != "" ]]
then
  echo -n "[ next ]"
fi
