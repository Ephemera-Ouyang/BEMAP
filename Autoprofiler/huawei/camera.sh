#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The camera.sh PID is :"$$
sleep 1
while [ $(ps -ef | grep -c "auto.sh") -gt 1 ]
do
  sleep 3
  adb shell input keyevent 27   # KEYCODE_CAMERA
done
