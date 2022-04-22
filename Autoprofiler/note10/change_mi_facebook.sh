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
   adb shell input tap 270 150
   sleep 3
   adb shell input tap 450 150
   sleep 3
  # adb shell input tap 600 2260
  # sleep 3
   adb shell input tap 630 150
   sleep 3
   adb shell input tap 805 150
   sleep 3
   adb shell input tap 270 150
done

