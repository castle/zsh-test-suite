#!/bin/zsh

# Set Default Context Info
USER_ID='credential_stuffing_victim'
CONTEXT_IP='99.1.100.101'
CONTEXT_USER_AGENT='Mozilla/5.0 (Linux; Android 5.1.1; SM-N750K Build/LMY47X; ko-kr) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Mobile Safari/537.36 Puffin/6.0.8.15804AP'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Origin": "https://attack.castle.io/",
  "Connection": "Keep-Alive",
  "Content-Type": "application/javascript"
}'

random_ip() {
  ./helpers/random_ip.sh
}

random_ua() {
  ./helpers/random_ua.sh
}

# Send 100 $login.failed events, different User-Agent, IP, and targeted User for each
for i in {1..100}; do
  echo "FAILED LOGIN ${i}:"
  CONTEXT_IP=$(random_ip)
  CONTEXT_USER_AGENT=$(random_ua)
  ./helpers/track.sh -e '$login.failed' -u "${USER_ID}_${i}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"
  echo "USER_AGENT: ${CONTEXT_USER_AGENT}\n\n"
  sleep 0.3
done

# Refresh the IP and User-Agent
CONTEXT_IP=$(random_ip)
CONTEXT_USER_AGENT=$(random_ua)

# Send a $login.succeeded event for the Default UserID
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

echo "\n\nSuccess! Your Credential Stuffing Test Scenario was executed!"
echo "\nVisit https://dashboard.castle.io/users/${USER_ID} to see the results"