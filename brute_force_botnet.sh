#!/bin/zsh

# Set Default Context Info
USER_ID='brute_force_victim_2'
CONTEXT_IP='99.1.100.101'
CONTEXT_USER_AGENT='Mozilla/5.0 (Linux; Android 5.1.1; SM-N750K Build/LMY47X; ko-kr) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Mobile Safari/537.36 Puffin/6.0.8.15804AP'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Connection": "Keep-Alive",
  "Content-Type": "application/javascript"
}'

random_ip() {
  ./helpers/random_ip.sh
}

# Collect Optional Context Inputs
while getopts u:b: option; do
  case "${option}" in
    u) USER_ID=${OPTARG};;
    b) CONTEXT_USER_AGENT=${OPTARG};;
  esac
done

# Send 50 $login.failed events
for i in {1..50}; do
  echo "FAILED LOGIN ${i}:"
  CONTEXT_IP=$(random_ip)
  ./helpers/track.sh -e '$login.failed' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"
  sleep 0.1
done

# Refresh the IP
CONTEXT_IP=$(random_ip)

# Send a $login.succeeded event
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"