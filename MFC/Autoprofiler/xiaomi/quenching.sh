#!/bin/bash
#
# ---------------------------------------------------------------------
# Android Studio startup script.
# ---------------------------------------------------------------------
#

echo "The quench.sh PID is :"$$
sleep 1
if [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]; then 
   adb shell input keyevent 26
fi
