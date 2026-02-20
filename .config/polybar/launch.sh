#!/usr/bin/sh

# Load theme settings
THEME_FILE="$HOME/.config/polybar/current_theme"

if [ -f "$THEME_FILE" ]; then
    THEME=$(cat "$THEME_FILE")
    if [ "$THEME" = "dark" ]; then
        export POLYBAR_BG="#2d2d2d"
        export POLYBAR_BG_ALT="#3c3c3c"
        export POLYBAR_FG="#e0e0e0"
        export POLYBAR_FG_ALT="#a0a0a0"
        export POLYBAR_PRIMARY="#e0e0e0"
        export POLYBAR_SECONDARY="#ed8796"
        export POLYBAR_ALERT="#f87171"
    else
        export POLYBAR_BG="#ffffff"
        export POLYBAR_BG_ALT="#2f343f"
        export POLYBAR_FG="#000000"
        export POLYBAR_FG_ALT="#878786"
        export POLYBAR_PRIMARY="#000000"
        export POLYBAR_SECONDARY="#e60053"
        export POLYBAR_ALERT="#bd2c40"
    fi
else
    # Default to light theme
    export POLYBAR_BG="#ffffff"
    export POLYBAR_BG_ALT="#2f343f"
    export POLYBAR_FG="#000000"
    export POLYBAR_FG_ALT="#878786"
    export POLYBAR_PRIMARY="#000000"
    export POLYBAR_SECONDARY="#e60053"
    export POLYBAR_ALERT="#bd2c40"
fi

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 0.5; done
sleep 1

polybar top &

echo "bars launched"
