#! /bin/sh

SERVER=$1
PORT=$2
TIMEOUT=25
/usr/lib/zabbix/externalscripts/timeout $TIMEOUT /usr/lib/zabbix/externalscripts/ssl-cert-check -s $SERVER -p $PORT -n | sed 's/  */ /g' | cut -f6 -d" "


