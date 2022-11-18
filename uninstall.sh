#!/bin/bash

# set -e
set -x

SCRIPT_NAME="openrgb-on-freedesktop-login.sh"
SERVICE_NAME="openrgb-on-freedesktop-login.service"

systemctl stop $SERVICE_NAME
systemctl disable $SERVICE_NAME
rm /usr/local/bin/$SCRIPT_NAME
rm /etc/systemd/system/$SERVICE_NAME
systemctl daemon-reload
systemctl reset-failed
