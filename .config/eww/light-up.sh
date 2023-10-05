#!/bin/sh
brightnessctl set +5%

level=$(brightnessctl -m | cut -d, -f 4)
hints="-h int:value:$level -h string:x-canonical-private-synchronous:light-level"

notify-send -t 2500 "Backlight: $level" $hints
eww update brightness=$level
