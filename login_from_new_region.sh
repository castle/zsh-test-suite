#!/bin/zsh

# Set Context Info
USER_ID="traveling_user_$((RANDOM))"
CONTEXT_IP='99.101.100.100'
CONTEXT_USER_AGENT='Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-G955U Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/5.4 Chrome/51.0.2704.106 Mobile Safari/537.36'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "en-us,en;q=0.5",
  "Connection": "Keep-Alive",
  "Content-Length": "122",
  "Content-Type": "application/xml"
}'

random_ua() {
  ./helpers/random_ua.sh
}

# Send a $login.succeeded event from default location
echo "\n\n\nLogin 1 from Location IP: ${CONTEXT_IP}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

# Change Location and login again
sleep 3
CONTEXT_IP='59.99.71.46'
echo "\n\n\nLogin 2 from Location IP: ${CONTEXT_IP}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

# Change Location and User-Agent and login again
sleep 3
CONTEXT_IP='79.85.170.130'
CONTEXT_USER_AGENT="$(random_ua)"
echo "\n\n\nLogin 3 from Location IP: ${CONTEXT_IP}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

echo "\n\nSuccess! Your Login from New Region Scenario was executed!"
echo "\nVisit https://dashboard.castle.io/users/${USER_ID} to see the results"