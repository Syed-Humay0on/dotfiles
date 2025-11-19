#!/bin/bash

# Check if active workspace has any windows
has_windows() {
    bspc query -N -d focused -n .window 2>/dev/null | grep -q .
}

# Get active window class (lowercase)
get_window_class() {
    local window_id=$(xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $NF}' | sed 's/,//')
    [ -z "$window_id" ] || [ "$window_id" = "0x0" ] && return 1
    
    xprop -id "$window_id" WM_CLASS 2>/dev/null | 
        grep -oP '"\K[^"]+(?=")' | 
        tail -1 | 
        tr '[:upper:]' '[:lower:]'
}

# Map window class to Nerd Font icon (colored with secondary)
get_icon() {
    local class="$1"
    local color="#e5e9f0"
    
    case "$class" in
        # System Monitoring
        btop*) icon="" ;;
        
        # Browsers & Web
        firefox*|tor*|navigator) icon="" ;;
        chromium*|google-chrome*|chrome|brave*) icon="" ;;
        
        # Security & Privacy
        protonvpn*|veracrypt*) icon="" ;;
        wireshark*) icon="󰒖" ;;
        burpsuite*) icon="󰤄" ;;
        bless*) icon="" ;;
        ghidra*|cutter*|iaito*) icon="" ;;
        etherape*) icon="" ;;
        autopsy*) icon="" ;;
        
        # Development & Code
        nvim*|vim*) icon="" ;;
        code*|vscodium*|codium*) icon="" ;;
        jupyter*|python*) icon="" ;;
        java*|openjdk*) icon="" ;;
        postman*) icon="" ;;
        
        # Media & Design
        obsidian*) icon="" ;;
        kdenlive*) icon="" ;;
        inkscape*) icon="" ;;
        obsstudio*) icon="" ;;
        flameshot*) icon="" ;;
        zathura*) icon="" ;;
        
        # File Management
        yazi*|thunar*|nautilus*) icon="" ;;
        localsend*) icon="" ;;
        
        # Terminal
        kitty*|xterm*|alacritty*) icon="" ;;
        
        # Communication
        vesktop*|discord*) icon="󰙯" ;;
        telegram*) icon="" ;;
        
        # Office
        libreoffice*|soffice*) icon="" ;;
        
        # Hardware
        qflipper*) icon="" ;;
        
        # Default - no icon
        *) return ;;
    esac
    
    # Return colored icon
    echo "%{F$color}$icon%{F-}"
}

# Main execution
if has_windows; then
    window_class=$(get_window_class)
    get_icon "$window_class"
else
    # Empty workspace - output a space to clear the icon
    echo " "
fi
