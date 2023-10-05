#!/bin/sh

bat=/sys/class/power_supply/BAT1
percent=$(cat $bat/capacity)
status=$(cat $bat/status)
colour="#ffffff"

level=$(expr $percent / 10)
case $level in
    "10") icon="󰁹";;
    "9") icon="󰂁";;
    "8") icon="󰂁";;
    "7") icon="󰂀";;
    "6") icon="󰁿";;
    "5") icon="󰁾";;
    "4") icon="󰁽";;
    "3") icon="󰁼";;
    "2") icon="󰁺";;
    "1") 
        icon="󰁺"
        colour="#bb8800"
        ;;
    "0") 
        icon="󰂎"
        colour="#cc3300"
        ;;
esac


echo "{\
    \"percent\":\"$percent%\",
    \"icon\":\"$icon\",
    \"status\":\"$status\",
    \"colour\":\"$colour\"
}";
