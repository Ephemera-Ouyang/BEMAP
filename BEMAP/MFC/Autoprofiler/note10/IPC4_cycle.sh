#!/bin/bash

sleep 10
action_app_name=${do_name}_${app_name}
#echo $action_app_name
#if [ "$make_sure" = "Y" -o "$make_sure" = "y" ]; then
#   while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]

   i=0
   while [ "$i" -lt 5 ]
   do
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,branch-load-misses,branch-loads   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,branch-store-misses,branch-stores  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,dTLB-load-misses,dTLB-loads   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,iTLB-load-misses,iTLB-loads  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,L1-dcache-load-misses,L1-dcache-loads  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      echo $i
      i=$((i+1))
   done
   i=0 
   while [ "$i" -lt 5 ]
   do
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,L1-dcache-store-misses,L1-dcache-stores --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,L1-icache-load-misses,L1-icache-loads --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,branch-misses,bus-cycles  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,cache-misses,cache-references        --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,stalled-cycles-backend,stalled-cycles-frontend  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
      echo $i
      i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-ase-spec,raw-br-immed-retired  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-br-immed-spec,raw-br-indirect-spec  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-br-pred,raw-br-mis-pred  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-br-mis-pred-retired,raw-br-retired  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-br-return-retired,raw-br-return-spec --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-bus-access,raw-dtlb-walk --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-bus-access-rd,raw-bus-access-wr  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-bus-cycles,raw-cid-write-retired  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-cnt-cycles,raw-cpu-cycles   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-crypto-spec,raw-dmb-spec       --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-dp-spec,raw-dsb-spec		  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-exc-dabort,raw-exc-svc           --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-exc-hvc,raw-exc-irq           --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-exc-pabort,raw-exc-return         --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-exc-taken,raw-exc-trap-dabort --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-exc-trap-other,raw-exc-undef  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-inst-retired,raw-inst-spec  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-isb-spec,raw-itlb-walk --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache,raw-l1d-cache-refill --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache-inval,raw-l2d-cache-wb-victim   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache-rd,raw-l1d-cache-refill-rd  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache-refill-inner,raw-l1d-cache-refill-outer   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache-wb,raw-l1d-cache-wb-clean,raw-l1d-cache-wb-victim  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-cache-wr,raw-l1d-cache-refill-wr  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-tlb,raw-l1d-tlb-refill  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-tlb-rd,raw-l1d-tlb-refill-rd   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1d-tlb-wr,raw-l1d-tlb-refill-wr   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1i-cache,raw-l1i-cache-refill --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l1i-tlb,raw-l1i-tlb-refill  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-cache,raw-l2d-cache-refill --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-cache-allocate,raw-l2d-cache-inval  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-cache-rd,raw-l2d-cache-refill-rd --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-cache-wb,raw-l2d-cache-wb-clean --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-cache-wr,raw-l2d-cache-refill-wr --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-tlb,raw-l2d-tlb-refill        --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-tlb-rd,raw-l2d-tlb-refill-rd --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l2d-tlb-wr,raw-l2d-tlb-refill-wr --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l3d-cache,raw-l3d-cache-refill    --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l3d-cache-allocate,raw-mem-access   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-l3d-cache-rd,raw-l3d-cache-refill-rd  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done

   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-ld-retired,raw-ld-spec   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-ldrex-spec,raw-ldst-spec  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-ll-cache-rd,raw-ll-cache-miss-rd   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-mem-access-rd,raw-mem-access-wr  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-pc-write-retired,raw-pc-write-spec  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-rc-ld-spec,raw-rc-st-spec --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-st-retired,raw-st-spec          --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-stall-backend,raw-stall-frontend        --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-strex-fail-spec,raw-strex-pass-spec --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-strex-spec,raw-vfp-spec          --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done
   i=0
   while [ "$i" -lt 5 ]
   do
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-sve-inst-retired,raw-ttbr-write-retired  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-unaligned-ld-spec,raw-unaligned-st-spec  --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
     adb shell /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,raw-unaligned-ldst-retired,raw-unaligned-ldst-spec   --duration 10 --use-devfreq-counters |tee -a $action_app_name.txt;sleep 1;
   i=$((i+1))
   done

#elif [ "$make_sure" = "N" -o "$make_sure" = "n" ]; then
#   echo "Exit by user!"
#   exit 1

#else
#   echo "Exit by user!"
#   exit 1
#fi
