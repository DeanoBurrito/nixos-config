#!/bin/sh
wpctl set-mute @DEFAULT_SINK@ 1

hints="-h int:value:$volume -h string:x-canonical-private-synchronous:volume-level"

notify-send -t 2500 "Volume: muted" $hints
eww update volume_mute=true
