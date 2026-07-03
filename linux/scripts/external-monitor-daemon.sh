#!/usr/bin/env bash

internal="eDP-1"
socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

move_to_external() {
    local name="$1"
    [ -n "$name" ] && [ "$name" != "$internal" ] || return
    hyprctl dispatch moveworkspacetomonitor 10 "$name"
}

# Check for an external monitor on startup
move_to_external "$(
    hyprctl monitors -j |
        jq -r --arg i "$internal" 'first(.[] | select(.name != $i) | .name) // empty'
)"

socat -u "UNIX-CONNECT:$socket" - | while read -r line; do
    [ "${line%%>>*}" = "monitoradded" ] && move_to_external "${line#*>>}"
done
