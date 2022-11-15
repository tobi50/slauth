#!/bin/bash
export LANG=C
if [ `id -u` -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

echo "Welcome To Slauth Installer!"
echo "Please Type Slack Incoming Webhook URL (ex: https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX) "
read -p "" INPUT_URL

echo "Please Type Channel name (ex: #hoge) "
read -p "" INPUT_CHANNEL

echo "Please Type Icon EMOJI (ex: :hoge:) "
read -p "" INPUT_EMOJI

cd `dirname $0`

# set Slack Incoming Webhook URL and EMOJI
sed -e "s:SLACK_API_URL=/SLACK_API_URL=$INPUT_URL:g" ./usr/local/bin/auth_notificator.sh > tmp
sed -e "s/CHANNEL=/CHANNEL=$INPUT_CHANNEL/g" tmp > tmp
sed -e "s/ICON_EMOJI=/ICON_EMOJI=$INPUT_EMOJI/g" tmp > tmp

mv ./tmp /usr/local/bin/auth_notificator.sh
chown root:root /usr/local/bin/auth_notificator.sh
chmod 755 /usr/local/bin/auth_notificator.sh
cp ./usr/share/pam-configs/slauth /usr/share/pam-configs
pam-auth-update

# test input data
TEXT="Slauth Test From `hostname` ( `hostname -I`)\n"
PAYLOAD='payload={'
PAYLOAD=$PAYLOAD'"channel":"'$INPUT_CHANNEL'"'
PAYLOAD=$PAYLOAD', "username":"Slauth Tester"'
PAYLOAD=$PAYLOAD', "text":"'$TEXT'"'
PAYLOAD=$PAYLOAD', "icon_emoji":"'$INPUT_EMOJI'"'
PAYLOAD=$PAYLOAD'}'
curl -X POST --data-urlencode "$PAYLOAD" $INPUT_URL

echo "\nPlease check test message in $INPUT_CHANNEL."