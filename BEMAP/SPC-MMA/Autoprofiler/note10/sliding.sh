#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The slide.sh PID is :"$$
sleep 3
#adb shell input tap 1000 320
sleep 1
while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   adb shell input swipe 700 1800 700 1000
   adb shell input swipe 700 1800 700 1000
   adb shell input swipe 700 1800 700 1000
   adb shell input swipe 700 1000 700 1800
   adb shell input swipe 700 1000 700 1800
   adb shell input swipe 700 1000 700 1800

done
