#!/bin/bash

#
# ---------------------------------------------------------------------
# Mate 30 & Note 10 & Xiaomi 10 pro App events test startup script.
#
#History:
#2021/04/09    OYCH    First release
# ---------------------------------------------------------------------
#

app_name_list=("Alipay" "article" "autonavi" "baidu" "beike" "booking" "ctrip" "didi" "health" "homelink" "hwireader" "jingdong" "mediacenter" "mm" "netease" "pinduoduo" "qiyi" "qqlive" "qqmusic" "ss" "tmall" "UCMobile" "umetrip" "weibo" "ximalaya" "zhihu" "bili" "duapp" "gifmaker" "keep" "kiwi" "liulishuo" "meituan" "mooc" "reader" "taobao" "tieba" "xhs" "mtxx" "wiz" "coolapk" "fenbi" "netdisk" "wps" "xueersi" "xunlei" "yinxiang" "popcap" "AndroidAnimal" "pubgmhd" "antutu" "ludashi" "dianping" "autohome" "dragon" "ele" "cmb" "douyu" "jiayuan" "qqdownload" "qqmail" "mail" "qgame" "kuaikan" "video" "dwrg" "miniworld" "snake" "onmyoji" "sgame" "snapchat" "facebook" "messenger" "telegram" "amazonshop" "amazonmusic" "dealspure" "twitch" "facebookgaming" "kindle" "youtube" "twitter" "instagram" "playgame" "googlemap" "calm" "bigolive" "carousell" "starmaker" "tango" "webtoon" "googledrive" "onedrive" "uplive" "joox"  "easymoney" "shein" "reddit" "tubitv" "outlook") 


do_name_list=("sliding" "switching" "quenching")

for i in ${do_name_list[@]};
do export do_name=$i;
export app_name=${app_name_list[0]}
sleep 10
bash auto_test.sh;
done
