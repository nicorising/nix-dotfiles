#!/usr/bin/env bash

internal="eDP-1"
state_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-monitor-mirror"

mapfile -t externals < <(
    hyprctl monitors all -j |
        jq -r --arg i "$internal" '.[] | select(.name != $i) | .name'
)

if [ "${#externals[@]}" -eq 0 ]; then
    notify-send "Monitors" "No external display connected"
    exit 0
fi

if [ -f "$state_file" ]; then
    rm -f "$state_file"

    for m in "${externals[@]}"; do
        hyprctl keyword monitor "$m, preferred, auto, 1"
    done

    notify-send "Monitors" "Extending display"
else
    touch "$state_file"

    for m in "${externals[@]}"; do
        hyprctl keyword monitor "$m, preferred, auto, 1, mirror, $internal"
    done

    notify-send "Monitors" "Mirroring display"
fi
