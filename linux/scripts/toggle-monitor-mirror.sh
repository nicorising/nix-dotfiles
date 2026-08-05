#!/usr/bin/env bash

internal="eDP-1"
state_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-monitor-mirror"

# An empty mirror target clears mirroring and restores auto positioning
set_monitor() {
    hyprctl eval "hl.monitor({ output = \"$1\", mode = \"preferred\", position = \"auto\", scale = 1, mirror = \"$2\" })"
}

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
        set_monitor "$m" ""
    done

    notify-send "Monitors" "Extending display"
else
    touch "$state_file"

    for m in "${externals[@]}"; do
        set_monitor "$m" "$internal"
    done

    notify-send "Monitors" "Mirroring display"
fi
