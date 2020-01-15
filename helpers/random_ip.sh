#!/bin/zsh

# select random IP address for inclusion in request context

randomize_ip() {
  FIRST=$(((RANDOM %= 88) + 11))
  SECOND=$((RANDOM %= 223))
  THIRD=$((RANDOM %= 223))
  FOURTH=$((RANDOM %= 223))

  echo "${FIRST}.${SECOND}.${THIRD}.${FOURTH}"
}

IP=$(randomize_ip)

echo $IP
