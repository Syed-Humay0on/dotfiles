
#!/bin/bash

volume=$(pamixer --get-volume)
is_muted=$(pamixer --get-mute)

if [[ "$is_muted" == "true" || "$volume" -eq 0 ]]; then
    icon="󰝟"
    color="#707880"  # muted color
    echo "%{F$color}$icon muted%{F-}"
else
    icon="󰕾"

    if [[ "$volume" -gt 100 ]]; then
        color="#A54242"  # red color for over 100%
    else
        color="#88c0d0"  # normal volume color
    fi

    echo "%{F$color}$icon $volume%%{F-}"
fi

