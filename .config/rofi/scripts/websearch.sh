#!/bin/bash

HISTORY="$HOME/.cache/rofi_web_search_history.txt"
touch "$HISTORY"

# Show recent entries in reverse (newest first) & remove duplicates
query=$(tac "$HISTORY" | awk '!seen[$0]++' | rofi -dmenu -p "Search or URL" -lines 10)

# If user entered nothing, exit
[ -z "$query" ] && exit

# Save to history
echo "$query" >> "$HISTORY"

# Handle input
if [[ "$query" =~ ^https?://.* ]]; then
    xdg-open "$query"
elif [[ "$query" =~ \. ]]; then
    xdg-open "https://$query"
else
    xdg-open "https://www.google.com/search?q=${query// /+}"
fi

