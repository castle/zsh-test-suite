#!/bin/zsh

# select random headers for inclusion in request context
CONTEXT_HEADERS_LIST=(
  '"Accept": "text/html"'
  '"Accept-Language": "en-us,en;q=0.5"'
  '"Accept-Encoding": "gzip, deflate, br"'
  '"Connection": "Keep-Alive"'
  '"Content-Length": "122"'
  '"Content-Type": "application/javascript"'
  '"Origin": "https://scripts.castle.io/"'
  '"Referer": "https://scripts.castle.io/login"'
)
TEMP_HEADERS_LIST=()
for i in "${CONTEXT_HEADERS_LIST[@]}"; do
  if [[ $((RANDOM % 2)) == 1 ]]; then
    TEMP_HEADERS_LIST+=(${i})
  fi
done

CONTEXT_HEADERS=$(IFS=, ; echo "{${TEMP_HEADERS_LIST[*]}}")

echo $CONTEXT_HEADERS
