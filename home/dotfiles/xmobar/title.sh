#!/bin/sh
TITLE=$(playerctl -p vlc -s metadata title)
ARTIST=$(playerctl -p vlc -s metadata artist)
if [[ $TITLE != "" ]]
then
  if [[ $ARTIST != "" ]]
  then
    echo -n "${ARTIST}: "
  fi
  echo -n $TITLE
fi
