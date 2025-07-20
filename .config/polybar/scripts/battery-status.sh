
#!/bin/bash
# ~/.config/polybar/scripts/battery-status.sh

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Nord Colors
primary="#88c0d0"
secondary="#a3be8c"
alert="#A54242"

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
elif [ "$battery_level" -ge 50 ]; then
  icon="󰁽"
  color="$primary"           # blue
elif [ "$battery_level" -ge 30 ]; then
  icon="󰁼"
  color="$primary"           # blue
elif [ "$battery_level" -ge 10 ]; then
  icon="󰁺"
  color="$alert"             # red
else
  icon="󰁺"
  color="$alert"             # red
fi

# Output with color formatting
echo "%{F$color}$icon%{F-} $battery_level%"

