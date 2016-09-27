#!/bin/bash

stepTrackerFile="$(dirname $0)/.fresh-install-track"

if [ ! -e "${stepTrackerFile}" ]; then
  echo "0" > ${stepTrackerFile}
fi

step=$(cat ${stepTrackerFile})
rebootAfterwards=false

if [ -e "$(dirname $0)/steps/${step}.sh" ]; then
  echo "Starting step $step..."
  source "$(dirname $0)/steps/${step}.sh"
  echo "Finished step $step..."
  echo "$[step+1]" > ${stepTrackerFile}
  if [ rebootAfterwards == true ]; then
    echo "Rebooting computer in 3 seconds..."
    sudo shutdown -r 3s
    exit 0
  fi
  $0 #Running next step
  exit 0
fi

if [ ! -e "$(dirname $0)/steps/${step}.sh" ]; then
  echo "Finished running all steps. Enjoy :)."
  exit 0
fi

exit 0
