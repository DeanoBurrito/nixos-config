#!/bin/sh
eww update spacesjson="$(hyprctl workspaces -j | jq '[.[]] | sort_by(.id)')"
eww update activetitle="$(hyprctl activeworkspace -j)"
