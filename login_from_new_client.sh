#!/bin/zsh

# Set Context Info
USER_ID="user_with_new_device_$((RANDOM))"
CONTEXT_IP='99.101.100.100'
CONTEXT_USER_AGENT='Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-G955U Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/5.4 Chrome/51.0.2704.106 Mobile Safari/537.36'
CONTEXT_HEADERS='
{
  "Accept": "text/html",
  "Accept-Language": "fr-ca,fr;q=0.5",
  "Connection": "Keep-Alive",
  "Content-Length": "122",
  "Content-Type": "application/xml"
}'

random_ip() {
  ./helpers/random_ip.sh
}

random_ua() {
  ./helpers/random_ua.sh
}

random_headers() {
  ./helpers/random_headers.sh
}

# Send a $login.succeeded event from default location
echo "\n\n\nLogin 1 from Location IP: ${CONTEXT_IP} with User-Agent: ${CONTEXT_USER_AGENT}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

# Change Device and login again
sleep 3
CONTEXT_USER_AGENT=$(random_ua)
CONTEXT_HEADERS=$(random_headers)
echo "\n\n\nLogin 2 from Location IP: ${CONTEXT_IP} with User-Agent: ${CONTEXT_USER_AGENT}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"

# Change Location and Device and login again
sleep 3
CONTEXT_IP='79.85.170.130'
CONTEXT_USER_AGENT=$(random_ua)
CONTEXT_HEADERS=$(random_headers)
echo "\n\n\nLogin 3 from Location IP: ${CONTEXT_IP} with User-Agent: ${CONTEXT_USER_AGENT}"
./helpers/authenticate.sh -e '$login.succeeded' -u "${USER_ID}" -i "${CONTEXT_IP}" -b "${CONTEXT_USER_AGENT}" -h "${CONTEXT_HEADERS}"
