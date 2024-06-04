#!/usr/bin/env bash

while true; do
hyprctl workspaces | grep -o 'workspace ID [0-9]*\|windows: [0-9]*' | awk 'NR%2{printf "{\"id\":\"%s\",",$3} !(NR%2){printf "\"windows\":%s}\n",$2}' | sort -t: -k2 -n | paste -sd ',' - | sed 's/^/[/;s/$/]/'
done
