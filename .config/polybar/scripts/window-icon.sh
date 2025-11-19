#!/bin/bash

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
    local color="#e5e9f0"  # Secondary color
    
    case "$class" in
        # System Monitoring
        btop*) icon="" ;;
        
        # Browsers & Web
        tor*|navigator) icon="" ;;
        firefox*) icon="";;
        chromium*|google-chrome*|chrome|brave*) icon="" ;;
        electron*) icon="󱀤" ;;
        cyberchef*) icon="" ;;
        zap*) icon="" ;;
        
        # Security & Privacy
        protonvpn*|veracrypt*) icon="" ;;
        wireshark*) icon="󰒖" ;;
        burpsuite*) icon="󰤄" ;;
        bless*) icon="" ;;
        ghidra*|cutter*|iaito*|radare2*) icon="" ;;
        etherape*) icon="" ;;
        autopsy*) icon="" ;;
        
        # Development & Code
        neovim*|vim*) icon="" ;;
        code*|vscodium*|codium*) icon="" ;;
        jupyter*|python*) icon="" ;;
        java*|openjdk*|gedit*) icon="" ;;
        postman*) icon="" ;;
        
        # Media & Design
        obsidian*) icon="" ;;
        kdenlive*|mpv*) icon="" ;;
        inkscape*) icon="" ;;
        obsstudio*) icon="" ;;
        flameshot*) icon="" ;;
        zathura*) icon="" ;;
        
        # File Management
        yazi*|thunar*|nautilus*|dolphin*) icon="" ;;
        localsend*) icon="" ;;
        
        # Terminal
        kitty*|xterm*|alacritty*|gnome-terminal*) icon="" ;;
        
        # Communication
        vesktop*|discord*) icon="󰙯" ;;
        telegram*) icon="" ;;
        
        # Office
        # libreoffice*|soffice*) icon="" ;;
        
        # Hardware
        qflipper*) icon="" ;;
        
        # Default (no icon)
        *) echo ""; return ;;
    esac
    
    # Return colored icon
    echo "%{F$color}$icon%{F-}"
}

# Main execution
window_class=$(get_window_class)
[ -n "$window_class" ] && get_icon "$window_class"
