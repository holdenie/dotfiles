#!/usr/bin/env bash

spaces (){
    current_window=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
    WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
    seq 1 10 | jq --argjson windows "${WORKSPACE_WINDOWS}" --arg include_id "$current_window" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)}) | map(select((.windows != 0) or (.id == $include_id)))'
}

spaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    spaces
done
