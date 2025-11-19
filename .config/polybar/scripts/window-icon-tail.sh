#!/bin/bash
~/.config/polybar/scripts/window-icon.sh
bspc subscribe node_focus desktop_focus 2>/dev/null | while read -r _; do
    ~/.config/polybar/scripts/window-icon.sh
done
