#!/bin/bash

absolutePath="$(realpath $(dirname $0))"
stepTrackerFile="$absolutePath/.fresh-install-track"
rcFile="$HOME/.$(basename $SHELL)rc"

if [ ! -e "$stepTrackerFile" ]; then
  echo "0" > "$stepTrackerFile"
fi

if [ "$1" == "-r" ]; then
  echo "Resuming install..."
  echo "Removing scripts dedicated to resume install when starting a new
terminal session..."
  mv "$rcFile.orig" "$rcFile"
fi

step=$(cat "$stepTrackerFile")
rebootAfterwards=false

if [ -e "$absolutePath/steps/$step.sh" ]; then
  echo "Starting step $step..."
  source "$absolutePath/steps/$step.sh"
  echo "Finished step $step..."
  echo "$[step+1]" > "$stepTrackerFile"
  if [ $rebootAfterwards == true ]; then
    echo "Your computer is going to restart."
    echo "Installation is not yet finished, you will just have to start a
terminal session to resume install after the reboot."
    echo "Setting up scripts to resume install when opening up next
terminal session..."
    cp "$rcFile" "$rcFile.orig"
    echo "$0 -r" >> "$rcFile"
    echo "Rebooting computer in 10 seconds..."
    sleep 10 && sudo shutdown -r now
    exit 0
  fi
  $absolutePath/$(basename $0) #Running next step
  exit 0
fi

if [ ! -e "$absolutePath/steps/$step.sh" ]; then
  echo "Finished running all steps. Enjoy :)."
  rm -f "$stepTrackerFile"
  exit 0
fi

exit 0
