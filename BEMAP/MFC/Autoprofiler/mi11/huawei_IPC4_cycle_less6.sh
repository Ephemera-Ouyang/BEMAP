#!/bin/bash

sleep 10
things_list=("branch-load-misses" "branch-loads" "dTLB-load-misses" "dTLB-loads" "iTLB-load-misses" "iTLB-loads" "L1-dcache-load-misses" "L1-dcache-loads" "L1-icache-load-misses" "L1-icache-loads" "branch-misses" "bus-cycles" "cache-misses" "cache-references" "stalled-cycles-backend" "stalled-cycles-frontend" "raw-ase-spec" "raw-br-immed-retired" "raw-br-immed-spec" "raw-br-indirect-spec" "raw-br-pred" "raw-br-mis-pred" "raw-br-mis-pred-retired" "raw-br-retired" "raw-br-return-retired" "raw-br-return-spec" "raw-bus-access" "raw-bus-access-rd" "raw-bus-access-wr" "raw-bus-cycles" "raw-cid-write-retired" "raw-dtlb-walk" "raw-cnt-cycles" "raw-crypto-spec" "raw-dmb-spec" "raw-dp-spec" "raw-dsb-spec" "raw-exc-dabort" "raw-exc-hvc" "raw-exc-irq" "raw-exc-pabort" "raw-exc-return" "raw-exc-svc" "raw-exc-taken" "raw-exc-trap-dabort" "raw-exc-trap-other" "raw-exc-undef" "raw-inst-retired" "raw-inst-spec" "raw-isb-spec" "raw-itlb-walk" "raw-l1d-cache" "raw-l1d-cache-refill" "raw-l1d-cache-inval" "raw-l1d-cache-rd" "raw-l1d-cache-refill-rd" "raw-l1d-cache-refill-inner" "raw-l1d-cache-refill-outer" "raw-l1d-cache-wb" "raw-l1d-cache-wb-clean" "raw-l1d-cache-wb-victim" "raw-l1d-cache-wr" "raw-l1d-cache-refill-wr" "raw-l1d-tlb" "raw-l1d-tlb-refill" "raw-l1d-tlb-rd" "raw-l1d-tlb-refill-rd" "raw-l1d-tlb-wr" "raw-l1d-tlb-refill-wr" "raw-l1i-cache" "raw-l1i-cache-refill" "raw-l1i-tlb" "raw-l1i-tlb-refill" "raw-l2d-cache" "raw-l2d-cache-refill" "raw-l2d-cache-allocate" "raw-l2d-cache-inval" "raw-l2d-cache-rd" "raw-l2d-cache-refill-rd" "raw-l2d-cache-wb" "raw-l2d-cache-wb-clean" "raw-l2d-cache-wb-victim" "raw-l2d-cache-wr" "raw-l2d-cache-refill-wr" "raw-l2d-tlb" "raw-l2d-tlb-refill" "raw-l2d-tlb-rd" "raw-l2d-tlb-refill-rd" "raw-l2d-tlb-wr" "raw-l2d-tlb-refill-wr" "raw-l3d-cache" "raw-l3d-cache-refill" "raw-l3d-cache-allocate" "raw-l3d-cache-rd" "raw-l3d-cache-refill-rd" "raw-ld-retired" "raw-ld-spec" "raw-ldrex-spec" "raw-ldst-spec" "raw-ll-cache-rd" "raw-ll-cache-miss-rd" "raw-mem-access" "raw-mem-access-rd" "raw-mem-access-wr" "raw-pc-write-retired" "raw-pc-write-spec" "raw-rc-ld-spec" "raw-rc-st-spec" "raw-st-retired" "raw-st-spec" "raw-stall-backend" "raw-stall-frontend" "raw-strex-fail-spec" "raw-strex-pass-spec" "raw-strex-spec" "raw-vfp-spec" "raw-sve-inst-retired" "raw-ttbr-write-retired" "raw-unaligned-ld-spec" "raw-unaligned-st-spec" "raw-unaligned-ldst-retired" "raw-unaligned-ldst-spec")


#

action_app_name=${do_name}_${app_name}
#echo $action_app_name
#if [ "$make_sure" = "Y" -o "$make_sure" = "y" ]; then
#   while [ $(ps -ef | grep -c "auto_test.sh") -gt 1 ]
   i=0
   while [ "$i" -lt 1 ]
   do
	  for n in ${things_list[@]};
	  do
		adb shell su -c /data/local/tmp/./simpleperf stat -p $pid_name -e instructions,cpu-cycles,$n   --duration 10 |tee -a $action_app_name.txt;sleep 1;
	  done
      echo $i
      i=$((i+1))
   done

#elif [ "$make_sure" = "N" -o "$make_sure" = "n" ]; then
#   echo "Exit by user!"
#   exit 1

#else
#   echo "Exit by user!"
#   exit 1
#fi
