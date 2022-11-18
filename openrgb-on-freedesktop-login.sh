#!/bin/sh
# openrgb-on-freedesktop-login.sh
# Author: Aaron Lichtman (https://github.com/alichtman)
# Thanks to Manish Bhatt (https://github.com/mbhatt1) for some help!
#####################################################################################################################
# Purpose: Turn on LEDs when you wake your computer up, using OpenRGB: https://gitlab.com/CalcProgrammer1/OpenRGB
#
# How: Listen for org.freedesktop.login1 signals on the dbus interface of systemd-login. When it detects one,
# the default openrgb profile is loaded.
#
# https://www.freedesktop.org/software/systemd/man/org.freedesktop.login1.html
#
# (Probably) For optimal performance, run OpenRGB in server mode
#####################################################################################################################

# Exit when any command fails.
set -e

log () {
   logger -t openrgb-on-freedesktop-login "$1"
}

OPENRGB_CONFIG_FILE="$XDG_CONFIG_HOME/OpenRGB/OpenRGB.json"
COLOR_PROFILE=$(jq '.AutoStart."profile"' "$OPENRGB_CONFIG_FILE" | sed s/\"//g)
COLOR_PROFILE="$COLOR_PROFILE.orp"

log "OPENRGB_CONFIG_FILE: $OPENRGB_CONFIG_FILE"
log "COLOR_PROFILE:       $COLOR_PROFILE"

log "Starting openrgb-on-freedesktop-login.sh..."
dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Session',member='Unlock'" | \
(
  while true; do
    read -r line
    # shellcheck disable=SC3020
    if echo "$line" | grep "Unlock" &> /dev/null; then
        log "Detected a login! Running openrgb..."
        log "$line"
        { /opt/OpenRGB/openrgb -p "$COLOR_PROFILE"; }
        # Sometimes openrgb fails to load the profile permanently. The LEDs flash and then turn back off.
        # We solve this issue by just running openrgb again. idk.
        log "Running it once more..."
        { /opt/OpenRGB/openrgb -p "$COLOR_PROFILE"; }
    fi
  done
)

# vim: tw=120 wrap
