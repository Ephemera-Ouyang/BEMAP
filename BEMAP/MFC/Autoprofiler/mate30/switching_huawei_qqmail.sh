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
   adb shell input tap 300 450
   sleep 3
   adb shell input tap 60 175
   sleep 2
   adb shell input tap 300 740
   sleep 3
   adb shell input tap 60 175
   sleep 2
   adb shell input tap 300 890
   sleep 3
   adb shell input tap 60 175
   sleep 2
   adb shell input tap 300 1050
   sleep 3
   adb shell input tap 60 175
   sleep 2



done

