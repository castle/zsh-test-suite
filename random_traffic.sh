#!/bin/zsh

while true; do
  DICE=$((RANDOM %= 100))
  if [[ $DICE < 60 ]]; then
    zsh ./login_from_new_client.sh;
  elif [[ $DICE < 90 ]]; then
    zsh ./login_from_new_region.sh;
  elif [[ $DICE < 94 ]]; then
    zsh ./forgetful_user.sh;
  elif [[ $DICE < 96 ]]; then
    zsh ./credential_stuffing.sh;
  elif [[ $DICE < 98 ]]; then
    zsh ./brute_force.sh;
  elif [[ $DICE < 101 ]]; then
    zsh ./brute_force_botnet.sh;
  fi
  date ;
  sleep 60;
done
