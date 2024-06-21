#!/bin/bash
#
# ---------------------------------------------------------------------
# Mate 30 change script.
# ---------------------------------------------------------------------
#

echo "The change.sh PID is :"$$
sleep 1
while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   #adb shell input keyevent 61
   adb shell input tap 270 300
   sleep 2
   adb shell input tap 500 300
   sleep 3
   adb shell input tap 900 300
   sleep 3
  # adb shell input tap 600 2260
  # sleep 3

done

