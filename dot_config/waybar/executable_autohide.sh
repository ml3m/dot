#!/bin/bash

# Auto-hide waybar based on cursor proximity to the top of the screen.
# SIGUSR1 = hide, SIGUSR2 = show (waybar convention)
#
# Also suppresses waybar when a fullscreen window is active (e.g. gaming),
# and hides the cursor via inactive_timeout when fullscreen is detected.

SHOW_THRESHOLD=5    # px from top → trigger show
HIDE_THRESHOLD=40   # px from top → cursor must be below this to hide
DEBOUNCE_COUNT=2    # consecutive polls outside zone before hiding
POLL_INTERVAL=0.1   # seconds between polls

bar_visible=true
was_fullscreen=false

get_y() {
    hyprctl cursorpos -j | jq '.y'
}

get_fullscreen() {
    local fs
    fs=$(hyprctl activewindow -j 2>/dev/null | jq -r '.fullscreen // 0')
    # fullscreen = 0 means not fullscreen; anything else (1, 2) means fullscreen
    if [ "$fs" = "0" ] || [ "$fs" = "false" ]; then
        echo "false"
    else
        echo "true"
    fi
}

while true; do
    Y=$(get_y)
    FS=$(get_fullscreen)

    # On fullscreen state change: manage cursor visibility
    if [ "$FS" = "true" ] && [ "$was_fullscreen" = "false" ]; then
        # Entered fullscreen — hide cursor after 1s of stillness
        hyprctl keyword cursor:inactive_timeout 1
        was_fullscreen=true
    elif [ "$FS" = "false" ] && [ "$was_fullscreen" = "true" ]; then
        # Exited fullscreen — restore cursor always-visible behavior
        hyprctl keyword cursor:inactive_timeout 0
        was_fullscreen=false
    fi
  if [ -z "$Y" ] || [ "$Y" = "null" ]; then

        sleep "$POLL_INTERVAL"
        continue
    fi

    # Show: cursor near top, bar is hidden — but NOT while fullscreen is active
    if [ "$Y" -le "$SHOW_THRESHOLD" ] && [ "$bar_visible" = false ] && [ "$FS" = "false" ]; then
        pkill -SIGUSR2 waybar
        bar_visible=true

    # Hide: cursor far from top and bar is visible — with debounce
    elif [ "$bar_visible" = true ]; then
        outside=0
        while [ "$outside" -lt "$DEBOUNCE_COUNT" ]; do
            sleep "$POLL_INTERVAL"
            Y=$(get_y)
            if [ "$Y" -gt "$HIDE_THRESHOLD" ]; then
                (( outside++ ))
            else
                outside=0  # reset if cursor comes back
            fi
        done
        pkill -SIGUSR1 waybar
        bar_visible=false
    fi

    sleep "$POLL_INTERVAL"
done
