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
   adb shell input tap 330 280
   sleep 3
   adb shell input tap 550 280
   sleep 3
   adb shell input tap 600 280
   sleep 3
   adb shell input tap 800 280
   sleep 3
   adb shell input tap 300 280
   sleep 3
   adb shell input tap 300 280
   sleep 3
   adb shell input tap 100 280
   sleep 3
done

