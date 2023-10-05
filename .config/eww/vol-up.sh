#!/bin/sh
wpctl set-mute @DEFAULT_SINK@ 0
wpctl set-volume @DEFAULT_SINK@ 5%+

vol=$(wpctl get-volume @DEFAULT_SINK@ | cut -d. -f 2)
hints="-h int:value:$volume -h string:x-canonical-private-synchronous:volume-level"

notify-send -t 2500 "Volume: $vol%" $hints
eww update volume_mute=false
eww update volume_level=$vol
