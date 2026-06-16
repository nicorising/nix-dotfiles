#!/usr/bin/env bash

paired=$(bluetoothctl devices Paired | grep "^Device ")

if [ -z "$paired" ]; then
    notify-send "Bluetooth" "No paired devices"
    exit 0
fi

menu=""
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d ' ' -f 3-)
    
    if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
        menu+="$mac|$name (connected)\n"
    else
        menu+="$mac|$name\n"
    fi
done <<< "$paired"

chosen=$(printf "%b" "$menu" | grep -v '^$' | cut -d '|' -f 2 | grep -v '^$' | fuzzel --dmenu 2>/dev/null)

if [ -z "$chosen" ]; then
    exit 0
fi

name_clean=$(echo "$chosen" | sed 's/ (connected)$//')
mac=$(echo -e "$menu" | grep "|$name_clean" | cut -d '|' -f 1)

if [ -z "$mac" ]; then
    notify-send "Bluetooth" "Could not find device"
    exit 1
fi

if echo "$chosen" | grep -q "(connected)"; then
    bluetoothctl disconnect "$mac"
    notify-send "Bluetooth" "Disconnected from $name_clean"
else
    bluetoothctl connect "$mac"
    notify-send "Bluetooth" "Connecting to $name_clean..."
fi
