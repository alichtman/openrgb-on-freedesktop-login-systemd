#!/bin/bash

set -e
set -x

SCRIPT_NAME="openrgb-on-freedesktop-login.sh"
SERVICE_NAME="openrgb-on-freedesktop-login.service"

chmod +x $SCRIPT_NAME
cp $SCRIPT_NAME /usr/local/bin/
cp $SERVICE_NAME /etc/systemd/system/

systemctl daemon-reload
systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME
