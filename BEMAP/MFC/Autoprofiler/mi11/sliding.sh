#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The slide.sh PID is :"$$
sleep 1
while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   adb shell input swipe 700 2500 700 1200
#800
   adb shell input swipe 700 2500 700 1200
   adb shell input swipe 700 2500 700 1200
   adb shell input swipe 700 1200 700 2500
   adb shell input swipe 700 1200 700 2500
   adb shell input swipe 700 1200 700 2500
done
