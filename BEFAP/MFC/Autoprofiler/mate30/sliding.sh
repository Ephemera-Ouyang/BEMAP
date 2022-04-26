#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The slide.sh PID is :"$$
sleep 1
#adb shell input tap 1000 165

while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   adb shell input swipe 700 2000 700 500 1000
   adb shell input swipe 700 2000 700 500 1000
   adb shell input swipe 700 2000 700 500 1000
   adb shell input swipe 700 500 700 2000 1000
   adb shell input swipe 700 500 700 2000 1000
   adb shell input swipe 700 500 700 2000 1000
done
