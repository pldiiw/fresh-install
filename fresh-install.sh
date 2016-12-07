#!/bin/bash

stepTrackerFile=".fresh-install-track"

if [ ! -e $stepTrackerFile ]; then
  echo 0 > $stepTrackerFile
  echo System reboots may occur.
  echo Run this program until you\'re notified that every
  echo steps are done.
  echo
  read -s -r -n 1 -p "Press any key to start..."
  echo
  echo
fi

step=`cat $stepTrackerFile`

if [ -e steps/$step.sh ]; then
  echo Starting step $step...
  echo $[step+1] > $stepTrackerFile
  source steps/$step.sh
  ./fresh-install.sh
else
  echo
  echo Finished running all steps. Enjoy :\).
  rm -f $stepTrackerFile
fi

exit 0
