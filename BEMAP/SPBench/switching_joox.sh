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
   adb shell input tap 280 180
   sleep 3
   #adb shell input tap 430 180
   #sleep 3
   adb shell input tap 510 180
   sleep 3
   adb shell input tap 770 180
   sleep 3
done

