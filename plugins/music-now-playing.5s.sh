#!/bin/bash

# <xbar.title>Now Playing</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Robb Knight</xbar.author>
# <xbar.author.github>rknightuk</xbar.author.github>
# <xbar.desc>Show music now playing</xbar.desc>
# <xbar.image></xbar.image>
# <xbar.dependencies>BASH</xbar.dependencies>

IS_RUNNING=$(osascript -e "application \"Music\" is running")

if [ "$IS_RUNNING" = "false" ]; then
    echo ""
    exit
fi 

if [ "$1" = 'playpause' ]; then
  osascript -e 'tell application "Music" to playpause'
  exit
fi

if [ "$1" = 'next' ]; then
  osascript -e 'tell application "Music" to play next track'
  exit
fi

if [ "$1" = 'previous' ]; then
  osascript -e 'tell application "Music" to play previous track'
  exit
fi

if [ "$1" = 'open' ]; then
  open -a Music
  exit
fi

STATE=$(osascript -e "tell application \"Music\" to player state as string")

if [ "$STATE" = "stopped" ]; then
    echo ""
    exit
fi

SONG=$(osascript -e "tell application \"Music\" to name of current track")
ARTIST=$(osascript -e "tell application \"Music\" to artist of current track")
ALBUM=$(osascript -e "tell application \"Music\" to album of the  current track")

echo "$SONG - $ARTIST"

echo '---'
echo $ALBUM

PLAYPAUSETEXT="Pause"

if [ $STATE = "paused" ]; then
    PLAYPAUSETEXT="Play"
fi

echo "$PLAYPAUSETEXT | shell='$0' param1=playpause refresh=true"
echo "Next | shell='$0' param1=next refresh=true"
echo "Previous | shell='$0' param1=previous refresh=true"
echo "Open Music | shell='$0' param1=open refresh=true"