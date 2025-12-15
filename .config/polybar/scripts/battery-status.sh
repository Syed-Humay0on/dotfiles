#!/bin/bash
# ~/.config/polybar/scripts/battery-status.sh

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Nord Colors
primary="#89b4fa"
secondary="#a6e3a1"
tertiary="#EBCB8B"
alert="#f38ba8"

# Choose icon and color
if [ "$status" == "Charging" ]; then
  icon=""
  color="$secondary"         # green
elif [ "$battery_level" -ge 90 ]; then
  icon="󰁹"
  color="$secondary"         # green
elif [ "$battery_level" -ge 70 ]; then
  icon="󰂁"
  color="$primary"           # blue
elif [ "$battery_level" -ge 40 ]; then
  icon="󰁽"
  color="$primary"           # blue
elif [ "$battery_level" -ge 15 ]; then
  icon="󰁼"
  color="$tertiary"           # blue
elif [ "$battery_level" -ge 10 ]; then
  icon="󰁺"
  color="$alert"             # red
else
  icon="󰁺"
  color="$alert"             # red
fi

# Output with color formatting
echo "%{F$color}$icon%{F-} $battery_level%"

