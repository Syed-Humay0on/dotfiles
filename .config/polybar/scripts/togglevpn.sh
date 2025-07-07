#!/bin/bash

IFACE="protonvpn"

# Check if the interface exists and is up
if ip link show "$IFACE" &>/dev/null; then
    if [[ "$(cat /sys/class/net/$IFACE/operstate)" == "up" || "$(cat /sys/class/net/$IFACE/operstate)" == "unknown" ]]; then
        sudo wg-quick down "$IFACE"
    else
        sudo wg-quick up "$IFACE"
    fi
else
    sudo wg-quick up "$IFACE"
fi

