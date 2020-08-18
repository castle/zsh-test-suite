#!/bin/zsh

# Set Default Context Info
USER_ID='brute_force_victim_1'
CONTEXT_IP='99.1.100.101'
CONTEXT_USER_AGENT='Mozilla/5.0 (Linux; Android 5.1.1; SM-N750K Build/LMY47X; ko-kr) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Mobile Safari/537.36 Puffin/6.0.8.15804AP'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Accept-Encoding": "gzip, deflate, br",
  "Connection": "Keep-Alive",
  "Content-Type": "application/javascript"
}'

# Collect Optional Context Inputs
while getopts u:i:b: option; do
  case "${option}" in
    u) USER_ID=${OPTARG};;
    i) CONTEXT_IP=${OPTARG};;
    b) CONTEXT_USER_AGENT=${OPTARG};;
  esac
done

# Send 50 $login.failed events
for i in {1..50}; do
  echo "FAILED LOGIN ${i}/100:"
  ./helpers/track.sh -e '$login.failed' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"
done

# Send a $login.succeeded event
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

echo "\n\nSuccess! Your Brute Force - Single IP Test Scenario was executed!"
echo "\nVisit https://dashboard.castle.io/users/${USER_ID} to see the results"