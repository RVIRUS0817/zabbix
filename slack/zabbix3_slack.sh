#!/bin/bash


# Slack sub-domain name (without '.slack.com'), user name, and the channel to send the message to
channel='#channel'
username='zabbix'

# Get the Slack incoming web-hook token ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY)
token="https://hooks.slack.com/services/xxxxxxxxxxxxxxxxxxxxxxx"
strSubject="$2"

# Extract status & severity from subject:
# * status [OK|PROBLEM]
# * severity [Not classified|Information|Warning|Average|High|Disaster]
arrSubject=(${strSubject//-/ })
status=${arrSubject[0]}
severity=${arrSubject[1]}

# Change message emoji depending on the status - smile (RECOVERY), frowning (PROBLEM), or ghost (for everything else)
emoji=':zabbix:'
color='#FFFFFF'

recoversub='^RECOVER(Y|ED)?$'
if [[ "$strSubject" =~ ${recoversub} ]]; then
        title=${status}
elif [ "$strSubject" == 'PROBLEM' ]; then
        color="#FF1D00";
        title=${status}:scream:
else
        color="#0BDA51";
        title=${status}:laughing::+1:
fi


# Prepare attachment payload so that we can customize
# how Slack will display allert
attachment="
{
  \"title\":\"${title}\",
  \"fallback\":\"*${title}*\n$3\",
  \"text\":\"$3\",
  \"color\":\"${color}\",
  \"mrkdwn_in\": [\"text\", \"title\", \"fallback\"]
}"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"channel\": \"${channel}\", \"username\": \"${username}\", \"icon_emoji\": \"${emoji}\", \"attachments\":[${attachment}]}"

/usr/bin/curl -m 5 --data-urlencode "${payload}" 'https://hooks.slack.com/services/xxxxxxxxxxxxxxxxxxxxx'
