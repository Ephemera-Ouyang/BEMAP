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
   adb shell input tap 280 440
   sleep 3
   adb shell input tap 65 170
   sleep 3
   adb shell input tap 790 460
   sleep 3
   adb shell input tap 65 170
   sleep 3
done

