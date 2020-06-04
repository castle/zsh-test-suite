#!/bin/zsh

while true; do
  DICE=$((RANDOM %= 100))
  if [[ $DICE < 40 ]]; then
    zsh ./login_from_new_client.sh;
  elif [[ $DICE < 70 ]]; then
    zsh ./login_from_new_region.sh;
  elif [[ $DICE < 90 ]]; then
    zsh ./forgetful_user.sh;
  elif [[ $DICE < 93 ]]; then
    zsh ./credential_stuffing.sh;
  elif [[ $DICE < 96 ]]; then
    zsh ./brute_force.sh;
  elif [[ $DICE > 101 ]]; then
    zsh ./brute_force_botnet.sh;
  fi
  date ;
  sleep 60;
done
