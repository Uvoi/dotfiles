#!/bin/bash

# Waits for kernel power-supply events. There is no timed polling here.
set -uo pipefail

ac_online_file="/sys/class/power_supply/AC0/online"
osd_helper="$HOME/.config/hypr/scripts/osd-event.sh"

[[ -r "$ac_online_file" ]] || exit 0
previous=$(<"$ac_online_file")

udevadm monitor --udev --subsystem-match=power_supply |
while IFS= read -r _; do
    [[ -r "$ac_online_file" ]] || continue
    current=$(<"$ac_online_file")
    if [[ "$current" != "$previous" ]]; then
        previous="$current"
        "$osd_helper" power "$current"
    fi
done
