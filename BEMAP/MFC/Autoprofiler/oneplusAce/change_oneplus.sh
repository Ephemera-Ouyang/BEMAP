#echo "The change.sh PID is :"$$
echo "The change.sh PID is :"$$
sleep 1
while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
do
   #adb shell input keyevent 61
   adb shell input tap 120 2285
   sleep 3
   adb shell input tap 320 2285
   sleep 3
   #adb shell input tap 570 2085
   #sleep 3
   adb shell input tap 770 2285
   sleep 3
   adb shell input tap 990 2285
   sleep 3
done