#!/bin/bash
export LANG=C
SLACK_API_URL=
CHANNEL=
ICON_EMOJI=
USERNAME=$PAM_USER
TEXT="Auth Log From `hostname` ( `hostname -I`)\n"
TEXT=$TEXT'```\n'
TEXT=$TEXT"Date: `date '+%Y/%m/%d-%H:%M:%S%Z'`\n"
TEXT=$TEXT"User: $PAM_USER\n"
TEXT=$TEXT"Ruser: $PAM_RUSER\n"
TEXT=$TEXT"Rhost: $PAM_RHOST\n"
TEXT=$TEXT"Service: $PAM_SERVICE\n"
TEXT=$TEXT'```'

PAYLOAD='payload={'
PAYLOAD=$PAYLOAD'"channel":"'$CHANNEL'"'
PAYLOAD=$PAYLOAD', "username":"'$USERNAME'"'
PAYLOAD=$PAYLOAD', "text":"'$TEXT'"'
PAYLOAD=$PAYLOAD', "icon_emoji":"'$ICON_EMOJI'"'
PAYLOAD=$PAYLOAD'}'
curl -X POST --data-urlencode "$PAYLOAD" $SLACK_API_URL
