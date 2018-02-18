#!/bin/sh
export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"
export LANG=C

# LINE Notify API
access_token="xxxxxxxxxxxxx"

# Notify Subject
subject=$1

# body
body=$2

# LINE Notify run
curl -X POST -H "Authorization: Bearer ${access_token}" \
-F "message=${subject}: ${body}" \
https://notify-api.line.me/api/notify

exit 0

