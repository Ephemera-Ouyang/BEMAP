#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The slide.sh PID is :"$$
sleep 3
adb shell input tap 210 300
sleep 1
while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   adb shell input swipe 700 1600 700 1000
   sleep 2
   adb shell input swipe 700 1600 700 1000
   sleep 2
   adb shell input swipe 700 1000 700 1600
   sleep 2
   adb shell input swipe 700 1000 700 1600
   sleep 2
   adb shell input swipe 700 1600 700 1000
   sleep 2
   adb shell input swipe 700 1000 700 1600
   sleep 2
done
