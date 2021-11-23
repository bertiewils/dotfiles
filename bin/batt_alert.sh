#!/usr/bin/env bash

# Script to alert when battery is below the threshold.
# Use a crontab such as:
# */1 * * * * ~/bin/batt_alert.sh

# Get current percentage integer
BATT=$(pmset -g batt | grep -oE "[0-9]{1,3}%" | tr -d '%')

WARN_THRESHOLD=35

# Only alert if not on charge
if pmset -g batt | grep -q discharging; then
    if [ "$BATT" -lt "$WARN_THRESHOLD" ]; then
        /usr/bin/osascript -e "display notification \"Charge Battery\" with title \"BATTERY\""
    fi
fi
