import pandas as pd
import re
import os
import pandas as pd
from openpyxl import load_workbook
col_index_huawei_samsung = ['branch-load-misses','branch-loads','branch-store-misses','branch-stores','dTLB-load-misses','dTLB-loads','iTLB-load-misses','iTLB-loads','L1-dcache-load-misses','L1-dcache-loads','L1-dcache-store-misses','L1-dcache-stores','L1-icache-load-misses','L1-icache-loads','branch-misses','bus-cycles','cache-misses','cache-references','stalled-cycles-backend','stalled-cycles-frontend','raw-ase-spec','raw-br-immed-retired','raw-br-immed-spec','raw-br-indirect-spec','raw-br-pred','raw-br-mis-pred','raw-br-mis-pred-retired','raw-br-retired','raw-br-return-retired','raw-br-return-spec','raw-bus-access','raw-bus-access-rd','raw-bus-access-wr','raw-bus-cycles','raw-cid-write-retired','raw-dtlb-walk','raw-cnt-cycles','raw-crypto-spec','raw-dmb-spec','raw-dp-spec','raw-dsb-spec','raw-exc-dabort','raw-exc-hvc','raw-exc-irq','raw-exc-pabort','raw-exc-return','raw-exc-svc','raw-exc-taken','raw-exc-trap-dabort','raw-exc-trap-other','raw-exc-undef','raw-inst-retired','raw-inst-spec','raw-isb-spec','raw-itlb-walk','raw-l1d-cache','raw-l1d-cache-refill','raw-l1d-cache-inval','raw-l1d-cache-rd','raw-l1d-cache-refill-rd','raw-l1d-cache-refill-inner','raw-l1d-cache-refill-outer','raw-l1d-cache-wb','raw-l1d-cache-wb-clean','raw-l1d-cache-wb-victim','raw-l1d-cache-wr','raw-l1d-cache-refill-wr','raw-l1d-tlb','raw-l1d-tlb-refill','raw-l1d-tlb-rd','raw-l1d-tlb-refill-rd','raw-l1d-tlb-wr','raw-l1d-tlb-refill-wr','raw-l1i-cache','raw-l1i-cache-refill','raw-l1i-tlb','raw-l1i-tlb-refill','raw-l2d-cache','raw-l2d-cache-refill','raw-l2d-cache-allocate','raw-l2d-cache-inval','raw-l2d-cache-rd','raw-l2d-cache-refill-rd','raw-l2d-cache-wb','raw-l2d-cache-wb-clean','raw-l2d-cache-wb-victim','raw-l2d-cache-wr','raw-l2d-cache-refill-wr','raw-l2d-tlb','raw-l2d-tlb-refill','raw-l2d-tlb-rd','raw-l2d-tlb-refill-rd','raw-l2d-tlb-wr','raw-l2d-tlb-refill-wr','raw-l3d-cache','raw-l3d-cache-refill','raw-l3d-cache-allocate','raw-l3d-cache-rd','raw-l3d-cache-refill-rd','raw-ld-retired','raw-ld-spec','raw-ldrex-spec','raw-ldst-spec','raw-ll-cache-rd','raw-ll-cache-miss-rd','raw-mem-access','raw-mem-access-rd','raw-mem-access-wr','raw-pc-write-retired','raw-pc-write-spec','raw-rc-ld-spec','raw-rc-st-spec','raw-st-retired','raw-st-spec','raw-stall-backend','raw-stall-frontend','raw-strex-fail-spec','raw-strex-pass-spec','raw-strex-spec','raw-vfp-spec','raw-sve-inst-retired','raw-ttbr-write-retired','raw-unaligned-ld-spec','raw-unaligned-st-spec','raw-unaligned-ldst-retired','raw-unaligned-ldst-spec']
name_list = ['Alipay','article','autonavi','baidu','beike','booking','ctrip','didi','health','homelink','hwireader','jingdong','mediacenter','mm','netease','pinduoduo','qiyi','qqlive','qqmusic','ss','tmall','UCMobile','umetrip','weibo','ximalaya','zhihu','bili','duapp','gifmaker','keep','kiwi','liulishuo','meituan','mooc','reader','taobao','tieba','xhs','mtxx','wiz','coolapk','fenbi','netdisk','wps','xueersi','xunlei','yinxiang','popcap','AndroidAnimal','pubgmhd','antutu','ludashi','dianping','autohome','dragon','ele','cmb','douyu','jiayuan','qqdownload','qqmail','mail','qgame','kuaikan','video','dwrg','miniworld','snake','onmyoji','sgame','amazonmusic','amazonshop','dealspure','facebook','facebookgaming','kindle','messenger','snapchat','telegram','twitch']
col_index_both = col_index_huawei_samsung

se_slide = 's_' + pd.Series(col_index_both)
se_change = 'c_' + pd.Series(col_index_both)
se_quench = 'q_' + pd.Series(col_index_both)
col_slide = se_slide.tolist()
col_change = se_change.tolist()
col_quench = se_quench.tolist()
col_index_all_action = se_slide.tolist() + se_change.tolist() + se_quench.tolist()

len_col_all = len(col_index_all_action) #126*3
len_col = len(col_index_both) #126
num_app = len(name_list) #80
data_all_2nd = pd.DataFrame()

for m in range(len_col_all):
    for i in range(len_col*num_app*5):
        data_all_2nd.loc[i, col_index_all_action[m]] = 0

#data_all_2nd.to_csv('all_data_different_phone/nor_2nd_huawei_pred.csv',sep=',',index=True,header=True)
data_all_2nd.to_csv('nor_final_huawei_pred.csv',sep=',',index=True,header=True)