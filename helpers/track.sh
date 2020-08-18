#!/bin/zsh

if [ -z ${CASTLE_API_SECRET} ]; then 
  echo "ERROR: CASTLE_API_SECRET is unset";
  exit 1; 
fi

EVENT_NAME='$login.failed'
USER_ID='failed_login_user'
CONTEXT_IP='98.1.1.1'
CONTEXT_USER_AGENT='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.4 Safari/605.1.15'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Accept-Encoding": "gzip, deflate, br",
  "Connection": "Keep-Alive",
  "Content-Length": "122",
  "Content-Type": "application/javascript",
  "Origin": "https://scripts.castle.io/",
  "Referer": "https://scripts.castle.io/login"  
}'

while getopts e:u:i:b:h: option; do
  case "${option}" in
    e) EVENT_NAME=${OPTARG};;
    u) USER_ID=${OPTARG};;
    i) CONTEXT_IP=${OPTARG};;
    b) CONTEXT_USER_AGENT=${OPTARG};;
    h) CONTEXT_HEADERS=${OPTARG};;
  esac
done

EVENT_PAYLOAD=`printf '
  {
    "event": "%s",
    "user_id": "%s",
    "user_traits": {
      "email": "%s@test.ing",
      "registered_at": "2018-07-10T17:37:39.123Z"
    },
    "context": {
      "client_id": false,
      "ip": "%s",
      "user_agent": "%s",
      "headers": %s,
      "library": {
        "name": "zsh-test-suite",
        "src": "https://github.com/castle/zsh-test-suite",
        "version": "0.2",
        "platform": "zsh"
      }
    }
  }' \
  $EVENT_NAME \
  $USER_ID \
  $USER_ID \
  $CONTEXT_IP \
  $CONTEXT_USER_AGENT \
  $CONTEXT_HEADERS`

curl https://api.castle.io/v1/track \
  -X POST \
  -u ":${CASTLE_API_SECRET}" \
  -H "Content-Type: application/json" \
  -d $EVENT_PAYLOAD

echo "CASTLE: ${EVENT_NAME} event tracked for UserID ${USER_ID}, IP ${CONTEXT_IP}, User-Agent ${CONTEXT_USER_AGENT}"