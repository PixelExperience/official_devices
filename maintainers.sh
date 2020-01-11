#!/usr/bin/env bash
# Copyright © 2019 PixelExperience Project
#
# SPDX-License-Identifier: GPL-3.0
#
### Script to check if our maintainers updated in the previous month

function sendAdmins() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001463677498&disable_web_page_preview=true&parse_mode=Markdown" > /dev/null
}

function sendMaintainers() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001287849567&disable_web_page_preview=true&parse_mode=Markdown" > /dev/null
}

sendAdmins "\`I am starting monthly update check cron job\`"
sendMaintainers "\`I am starting monthly update check cron job\`"

node monthly_update_check.js
RESULT=$?

if [ "$RESULT" -eq 1 ]; then
  sendAdmins "\`My script seems to fail.\` @baalajimaestro \`check the CI.\`"
  exit 1
else
  sendMaintainers "$(cat /tmp/devices_to_kick)"
  sendAdmins "$(cat /tmp/devices_to_kick)"
fi
