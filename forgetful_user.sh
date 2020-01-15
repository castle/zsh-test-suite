#!/bin/zsh

# Set Context Info
USER_ID='forgetful_user'
CONTEXT_IP='99.100.100.100'
CONTEXT_USER_AGENT='Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.85 Safari/537.36'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Connection": "Keep-Alive",
  "Content-Type": "application/xml"
}'

# Send 10 $login.failed events
for i in {1..10}; do
  echo "FAILED LOGIN ${i}:"
  ./helpers/track.sh -e '$login.failed' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"
  sleep 0.2
done

# Send a $login.succeeded event
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"