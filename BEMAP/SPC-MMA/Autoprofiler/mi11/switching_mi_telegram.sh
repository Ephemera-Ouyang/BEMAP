#!/bin/bash
#
# ---------------------------------------------------------------------
# Mate 30 change script.
# ---------------------------------------------------------------------
#

echo "The change.sh PID is :"$$
sleep 1
#adb shell input tap 950 320

while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   #adb shell input keyevent 61
   adb shell input tap 700 460
   sleep 3
   adb shell input tap 105 235
   sleep 3
   adb shell input tap 700 700
   sleep 3
   adb shell input tap 105 235
   sleep 3

done

