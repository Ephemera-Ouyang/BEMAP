export app_name=("geekbench")
export do_name=("click")
#[geekbench]="com.primatelabs.geekbench5"
adb shell ps -e | grep "com.primatelabs.geekbench5" | grep -v ':'
export pid_name=$(adb shell ps -e | grep "com.primatelabs.geekbench5" | grep -v ':' | awk '{print $2}' | awk 'NR==1')
sleep 1
for((i=54;i<=125;i=i+3))
do
#	i = 6
	export n=$i
	bash click_geekbench.sh & bash huawei_CPI4_cycle.sh
	while [ $(ps -ef | grep -c "click_geekbench.sh") -gt 1 ]
	do
		sleep 1
	done
	echo "this is end of "
	echo $i
	sleep 5
done
