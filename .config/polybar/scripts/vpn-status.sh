#!/bin/bash

# Define both possible interface names
IFACES=("protonvpn" "proton0")

# Check if any of the interfaces are up
is_vpn_up=false
for iface in "${IFACES[@]}"; do
  if [[ -d "/sys/class/net/$iface" ]]; then
    STATE=$(cat /sys/class/net/$iface/operstate)
    if [[ "$STATE" == "up" || "$STATE" == "unknown" ]]; then
      is_vpn_up=true
      break
    fi
  fi
done

if $is_vpn_up; then
  echo "%{F#88c0d0}󰖂%{F-} VPN"

else
  echo "%{F#707880}󰖂%{F-} VPN"
fi

