#!/bin/bash
#
# ---------------------------------------------------------------------
# Mate 30 change script.
# ---------------------------------------------------------------------
#

echo "The change.sh PID is :"$$
sleep 1
adb shell input tap 1000 165

while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   #adb shell input keyevent 61
   adb shell input tap 530 360
   sleep 3
   adb shell input tap 85 165
   sleep 3
   adb shell input tap 530 580
   sleep 3
   adb shell input tap 85 165
   sleep 3

done

