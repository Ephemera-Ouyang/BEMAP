#!/bin/bash
#
# ---------------------------------------------------------------------
# Mate 30  App events test startup script.
#
#History:
#2020/06/09    WQN&OYCH    First release
# ---------------------------------------------------------------------
#

echo $$
declare -A dic_process
dic_process=([ss]="com.ss.android.ugc.aweme"	[mm]="com.tencent.mm"	[Alipay]="com.eg.android.AlipayGphone"	[tmall]="com.tmall.wireless"	[jingdong]="com.jingdong.app.mall"	[didi]="com.sdu.didi.psnger"	[autonavi]="com.autonavi.minimap"	[article]="com.ss.android.article.news"	[ctrip]="ctrip.android.view"	[weibo]="com.sina.weibo"	[baidu]="com.baidu.searchbox"	[pinduoduo]="com.xunmeng.pinduoduo"	[beike]="com.lianjia.beike"	[homelink]="com.homelink.android"	[qqlive]="com.tencent.qqlive"	[qiyi]="com.qiyi.video"	[netease]="com.netease.cloudmusic"	[qqmusic]="com.tencent.qqmusic"	[mediacenter]="com.huawei.music"	[umetrip]="com.umetrip.android.msky.app"	[booking]="com.booking"	[zhihu]="com.zhihu.android"	[health]="com.huawei.health"	[hwireader]="com.huawei.hwireader"	[ximalaya]="com.ximalaya.ting.android"	[sgame]="com.tencent.tmgp.sgame"	[pubgmhd]="com.tencent.tmgp.pubgmhd"	[bili]="tv.danmaku.bili"	[duapp]="com.shizhuang.duapp"	[kiwi]="com.duowan.kiwi"	[gifmaker]="com.smile.gifmaker"	[liulishuo]="com.liulishuo.engzo"	[meituan]="com.sankuai.meituan"	[mooc]="cn.com.open.mooc"	[reader]="com.kmxs.reader"	[taobao]="com.taobao.taobao"	[keep]="com.gotokeep.keep"	[tieba]="cn.xiaochuankeji.tieba"	[xhs]="com.xingin.xhs"	[mtxx]="com.mt.mtxx.mtxx"	[wiz]="cn.wiz.note"	[coolapk]="com.coolapk.market"	[netdisk]="com.baidu.netdisk"	[wps]="cn.wps.moffice_eng"	[xueersi]="com.xueersi.parentsmeeting"	[xunlei]="com.xunlei.downloadprovider"	[yinxiang]="com.yinxiang"	[AndroidAnimal]="com.happyelements.AndroidAnimal"	[antutu]="com.antutu.ABenchMark"	[ludashi]="com.ludashi.benchmark"	[dianping]="com.dianping.v1"	[autohome]="com.cubic.autohome"	[dragon]="com.dragon.read"	[ele]="me.ele"	[cmb]="cmb.pb"	[douyu]="air.tv.douyu.android"	[jiayuan]="com.jiayuan"	[qqdownload]="com.tencent.android.qqdownloader"	[qqmail]="com.tencent.androidqqmail"	[kuaikan]="com.kuaikan.comic"	[video]="com.ss.android.article.video"	[dwrg]="com.tencent.tmgp.dwrg"	[miniworld]="com.playmini.miniworld"	[snake]="com.wepie.snakeoff"	[onmyoji]="com.tencent.tmgp.yys.zqb"	[mail]="com.netease.mail"	[fenbi]="com.fenbi.android.solar"	[qgame]="com.tencent.qgame"	[popcap]="com.tencent.tmgp.pvz2hdtxyyb"	[UCMobile]="com.UCMobile"	[snapchat]="com.snapchat.android"
[facebook]="com.facebook.katana"	[messenger]="com.facebook.orca"
[telegram]="org.telegram.messenger"     [amazonshop]="com.amazon.mShop.android.shopping"
[amazonvideo]="com.amazon.avod.thirdpartyclient"   [amazonmusic]="com.amazon.music.tv"
[dealspure]="com.dealspure.wild"        [twitch]="tv.twitch.android.app"
[facebookgaming]="com.facebook.games"   [kindle]="com.amazon.kindle"
[youtube]="com.google.android.youtube"  [twitter]="com.twitter.android"
[instagram]="com.instagram.android"     [playgame]="com.google.android.play.games"
[googlemap]="com.google.android.apps.maps"	[calm]="com.calm.android"
[bigolive]="sg.bigo.live"
[carousell]="com.thecarousell.Carousell"	[starmaker]="com.starmakerinteractive.starmaker"   [tango]="com.sgiggle.production"
[webtoon]="com.naver.linewebtoon"	[googledrive]="com.google.android.apps.docs"
[onedrive]="com.microsoft.skydrive"	[uplive]="com.asiainno.uplive"
[joox]="com.tencent.ibg.joox"		[easymoney]="proxima.easymoney.android"
[shein]="com.zzkko"			[reddit]="com.reddit.frontpage"
[tubitv]="com.tubitv"			[outlook]="com.microsoft.office.outlook"
[Chrome]="com.android.chrome"		[Gmail]="com.google.android.gm")

#read -p "Please input app name you want to test:" app_name
echo $app_name

# ---------------------------------------------------------------------
# Light up the program to unlock.First,you need to know the unlock password or pattern password.
# Notice:(face,iris,fingerprints will definitely not work)
# ---------------------------------------------------------------------



# ---------------------------------------------------------------------
# Open the app you want to test.
# ---------------------------------------------------------------------

if [ "$app_name" = "totemweather" ]; then
   export package_name="com.huawei.android.totemweather"
   export cmp="com.huawei.android.totemweather/com.huawei.android.totemweather.WeatherHome"
   adb shell am start com.huawei.android.totemweather/com.huawei.android.totemweather.WeatherHome
elif [ "$app_name" = "douyin" -o "$app_name" = "ss" ]; then
   adb shell am start com.ss.android.ugc.aweme/.splash.SplashActivity
elif [ "$app_name" = "Wechat" -o "$app_name" = "mm" ]; then
   adb shell am start com.tencent.mm/com.tencent.mm.ui.LauncherUI
elif [ "$app_name" = "homelink" ]; then
   adb shell am start com.homelink.android/com.homelink.android.SplashScreenActivity
elif [ "$app_name" = "Alipay" ]; then
   adb shell am start com.eg.android.AlipayGphone/com.eg.android.AlipayGphone.AlipayLogin
elif [ "$app_name" = "tmall" ]; then
   adb shell am start com.tmall.wireless/com.tmall.wireless.splash.TMSplashActivity
elif [ "$app_name" = "jingdong" ]; then
   adb shell am start com.jingdong.app.mall/com.jingdong.app.mall.main.MainActivity
elif [ "$app_name" = "didi" ]; then
   adb shell am start com.sdu.didi.psnger/com.didi.sdk.app.launch.LauncherActivity
elif [ "$app_name" = "autonavi" ]; then
   adb shell am start com.autonavi.minimap/com.autonavi.map.activity.SplashActivity
elif [ "$app_name" = "article" ]; then
   adb shell am start com.ss.android.article.news/com.ss.android.article.news.activity.MainActivity
elif [ "$app_name" = "ctrip" ]; then
   adb shell am start ctrip.android.view/ctrip.business.splash.CtripSplashActivity
elif [ "$app_name" = "Qunar" ]; then
   adb shell am start com.Qunar/com.mqunar.splash.SplashActivity
elif [ "$app_name" = "sina" -o "$app_name" = "weibo" ]; then
   adb shell am start com.sina.weibo/com.sina.weibo.SplashActivity
elif [ "$app_name" = "baidu" ]; then
   adb shell am start com.baidu.searchbox/com.baidu.searchbox.SplashActivity
elif [ "$app_name" = "pinduoduo" ]; then
   adb shell am start com.xunmeng.pinduoduo/com.xunmeng.pinduoduo.ui.activity.MainFrameActivity
elif [ "$app_name" = "beike" ]; then
   adb shell am start com.lianjia.beike/com.lianjia.activity.MainActivity
elif [ "$app_name" = "qiyi" ]; then
   adb shell am start com.qiyi.video/.WelcomeActivity
elif [ "$app_name" = "qqlive" ]; then
   adb shell am start com.tencent.qqlive/com.tencent.qqlive.ona.activity.SplashHomeActivity
elif [ "$app_name" = "netease" ]; then
   adb shell am start com.netease.cloudmusic/com.netease.cloudmusic.activity.LoadingActivity
elif [ "$app_name" = "qqmusic" ]; then
   adb shell am start com.tencent.qqmusic/com.tencent.qqmusic.activity.AppStarterActivity
elif [ "$app_name" = "mediacenter" ]; then
   adb shell am start com.android.mediacenter/.PageActivity
elif [ "$app_name" = "umetrip" ]; then
   adb shell am start com.umetrip.android.msky.app/com.umetrip.android.msky.app.module.startup.SplashActivity
elif [ "$app_name" = "booking" ]; then
   adb shell am start com.booking/com.booking.startup.HomeActivity
elif [ "$app_name" = "zhihu" ]; then
   adb shell am start com.zhihu.android/com.zhihu.android.app.ui.activity.LauncherActivity
elif [ "$app_name" = "gallery3d" ]; then
   adb shell am start com.android.gallery3d/com.huawei.gallery.app.GalleryMain
elif [ "$app_name" = "hwmirror" -o "$app_name" = "mirror" ]; then
   adb shell am start com.android.hwmirror/.Mirror
elif [ "$app_name" = "flashlight" ]; then
   adb shell am start com.yunxi.flashlight/com.aso114.project.mvp.activity.StarActivity
elif [ "$app_name" = "camera" ]; then
   adb shell am start com.huawei.camera/com.huawei.camera
elif [ "$app_name" = "hwireader" ]; then
   adb shell am start com.huawei.hwireader/com.chaozh.iReader.ui.activity.WelcomeActivity
elif [ "$app_name" = "ximalaya" ]; then
   adb shell am start com.ximalaya.ting.android/.host.activity.MainActivity
elif [ "$app_name" = "health" ]; then
   adb shell am start com.huawei.health/com.huawei.health.MainActivity
elif [ "$app_name" = "sgame" ]; then
   adb shell am start com.tencent.tmgp.sgame/.SGameActivity
elif [ "$app_name" = "pubgmhd" ]; then
   adb shell am start com.tencent.tmgp.pubgmhd/com.epicgames.ue4.SplashActivity
elif [ "$app_name" = "UCMobile" ]; then
   adb shell am start com.UCMobile/.main.UCMobile
elif [ "$app_name" = "gifmaker" -o "$app_name" = "kuaishou" ]; then
   adb shell am start com.smile.gifmaker/com.yxcorp.gifshow.HomeActivity
elif [ "$app_name" = "bili"  ]; then
   adb shell am start tv.danmaku.bili/.MainActivityV2
elif [ "$app_name" = "kiwi" -o "$app_name" = "huya" ]; then
   adb shell am start com.duowan.kiwi/.simpleactivity.SplashActivity
elif [ "$app_name" = "snake" ]; then
   adb shell am start com.wepie.snake.huawei/com.wepie.snake.app.activity.StartActivity
elif [ "$app_name" = "AndroidAnimal" ]; then
   adb shell am start com.happyelements.AndroidAnimal/com.happyelements.hellolua.MainActivity
elif [ "$app_name" = "dwrg" ]; then
   adb shell am start com.netease.dwrg.huawei/com.netease.dwrg.Launcher
elif [ "$app_name" = "sky" ]; then
   adb shell am start com.netease.sky.huawei/com.tgc.sky.netease.GameActivity_Netease
elif [ "$app_name" = "reader" -o "$app_name" = "maoqi" ]; then
   adb shell am start com.kmxs.reader/com.km.app.home.view.LoadingActivity
elif [ "$app_name" = "tieba" -o "$app_name" = "zuiyou" ]; then
   adb shell am start cn.xiaochuankeji.tieba/.ui.base.SplashActivity
elif [ "$app_name" = "keep" ]; then
   adb shell am start com.gotokeep.keep/.splash.SplashActivity
elif [ "$app_name" = "xhs" -o "$app_name" = "xiaohongshu" ]; then
   adb shell am start com.xingin.xhs/.index.v2.IndexActivityV2
elif [ "$app_name" = "popcap" -o "$app_name" = "jiangshi" ]; then
   sleep 1
   #adb shell am start com.popcap.pvz2cthdhwct/com.talkweb.twOfflineSdk.activity.PermisionActivity
elif [ "$app_name" = "mooc" ]; then
   adb shell am start cn.com.open.mooc/com.imooc.component.imoocmain.splash.MCSplashActivity
elif [ "$app_name" = "liulishuo" ]; then
   adb shell am start com.liulishuo.engzo/com.liulishuo.lingodarwin.app.LauncherActivity liulishuo
elif [ "$app_name" = "duapp" -o "$app_name" = "dewu" ]; then
   adb shell am start com.shizhuang.duapp/.modules.home.ui.HomeActivity
elif [ "$app_name" = "meituan" ]; then
   adb shell am start com.sankuai.meituan/com.meituan.android.pt.homepage.activity.MainActivity
elif [ "$app_name" = "taobao" ]; then
   adb shell am start com.taobao.taobao/com.taobao.tao.TBMainActivity
elif [ "$app_name" = "xunlei" ]; then
   adb shell am start com.xunlei.downloadprovider/.launch.LaunchActivity
elif [ "$app_name" = "netdisk" ]; then
   adb shell am start com.baidu.netdisk/.ui.MainActivity
elif [ "$app_name" = "wiz" ]; then
   adb shell am start cn.wiz.note/.MainActivity
elif [ "$app_name" = "ludashi" ]; then
   adb shell am start com.ludashi.benchmark/.SplashActivity
elif [ "$app_name" = "yinxiang" ]; then
   adb shell am start com.yinxiang/com.evernote.ui.HomeActivity
elif [ "$app_name" = "mtxx" ]; then
   adb shell am start com.mt.mtxx.mtxx/.MainActivity
elif [ "$app_name" = "xueersi" ]; then
   adb shell am start com.xueersi.parentsmeeting/.module.home.LaunchActivity
elif [ "$app_name" = "3dmark" ]; then
   adb shell am start com.futuremark.dmandroid.application/com.futuremark.flamenco.controller.product.compatibility.OpenGLTestActivity
elif [ "$app_name" = "fenbi" ]; then
   adb shell am start com.fenbi.android.solar/.activity.RouterActivity
elif [ "$app_name" = "ele" ]; then
   adb shell am start me.ele/.Launcher
elif [ "$app_name" = "dragon" ]; then
   adb shell am start com.dragon.read/.pages.splash.SplashActivity
elif [ "$app_name" = "qqmail" ]; then
   adb shell am start com.tencent.androidqqmail/com.tencent.qqmail.launcher.desktop.LauncherActivity
elif [ "$app_name" = "mail" ]; then
   adb shell am start com.netease.mail/com.netease.mobimail.activity.LaunchActivity
elif [ "$app_name" = "coolapk" ]; then
   adb shell am start com.coolapk.market/.view.main.MainActivity
elif [ "$app_name" = "one" ]; then
   adb shell am start com.One.WoodenLetter/.LetterActivity
elif [ "$app_name" = "geekbench" ]; then
   adb shell am start com.primatelabs.geekbench/.HomeActivity
elif [ "$app_name" = "blizzard" ]; then
   adb shell am start com.blizzard.wtcg.hearthstone.cn.huawei/com.blizzard.wtcg.hearthstone.HearthstoneActivity
elif [ "$app_name" = "wps" ]; then
   adb shell am start cn.wps.moffice_eng/cn.wps.moffice.documentmanager.PreStartActivity
elif [ "$app_name" = "qqdownload" ]; then
   adb shell am start com.tencent.android.qqdownloader/com.tencent.assistant.activity.SplashImplActivity 
elif [ "$app_name" = "dragon" ]; then
   adb shell am start com.dragon.read/.pages.splash.SplashActivity
elif [ "$app_name" = "x19" ]; then 
   adb shell am start com.netease.x19/com.mojang.minecraftpe.MainActivity
elif [ "$app_name" = "dianping" ]; then
   adb shell am start com.dianping.v1/.NovaMainActivity
elif [ "$app_name" = "douyu" ]; then
   adb shell am start air.tv.douyu.android/com.douyu.module.home.pages.main.MainActivity
elif [ "$app_name" = "video" ]; then
   adb shell am start com.ss.android.article.video/.activity.SplashActivity
elif [ "$app_name" = "jiayuan" ]; then
   adb shell am start com.jiayuan/.MainActivity
elif [ "$app_name" = "bh3" ]; then
   adb shell am start com.miHoYo.bh3.huawei/com.miHoYo.overridenativeactivity.OverrideNativeActivity
elif [ "$app_name" = "autohome" ]; then
   adb shell am start com.cubic.autohome/.MainActivity
elif [ "$app_name" = "cmb" ]; then
   adb shell am start cmb.pb/.app.mainframe.container.PBMainActivity
elif [ "$app_name" = "miniworld" ]; then
   adb shell am start com.minitech.miniworld.huawei/com.minitech.miniworld.MiniWorldActivity
elif [ "$app_name" = "antutu" ]; then
   adb shell am start com.antutu.ABenchMark/com.android.module.app.ui.start.ABenchMarkStart
elif [ "$app_name" = "mail" ]; then
   adb shell am start cmp=com.netease.mail/.biz.main.MainITabActivity 
elif [ "$app_name" = "kuaikan" ]; then
   adb shell am start com.kuaikan.comic/com.kuaikan.main.LaunchActivity
elif [ "$app_name" = "qgame" ]; then
   adb shell am start com.tencent.qgame/.presentation.activity.MainActivity
elif [ "$app_name" = "onmyoji" ]; then
   adb shell am start com.netease.onmyoji.huawei/com.netease.onmyoji.Launcher
elif [ "$app_name" = "snapchat" ]; then
   adb shell am start com.snapchat.android/.LandingPageActivity 
elif [ "$app_name" = "facebook" ]; then
   adb shell am start com.facebook.katana/.LoginActivity
elif [ "$app_name" = "messenger" ]; then
   adb shell am start com.facebook.orca/.auth.StartScreenActivity
elif [ "$app_name" = "telegram" ]; then
   adb shell am start org.telegram.messenger/org.telegram.ui.LaunchActivity
elif [ "$app_name" = "amazonshop" ]; then
   adb shell am start com.amazon.mShop.android.shopping/com.amazon.mShop.home.HomeActivity 
elif [ "$app_name" = "amazonvideo" ]; then
   adb shell am start com.amazon.avod.thirdpartyclient/.LauncherActivity
elif [ "$app_name" = "amazonmusic" ]; then
   adb shell am start com.amazon.mp3/.client.activity.LauncherActivity
elif [ "$app_name" = "dealspure" ]; then
   adb shell am start com.dealspure.wild/.MainActivity
elif [ "$app_name" = "twitch" ]; then
   adb shell am start tv.twitch.android.app/.core.LandingActivity
elif [ "$app_name" = "facebookgaming" ]; then
   adb shell am start com.facebook.games/.app.login.GamesLoginActivity 
elif [ "$app_name" = "kindle" ]; then
   adb shell am start com.amazon.kindle/com.amazon.kcp.oob.MainActivity
elif [ "$app_name" = "youtube" ]; then
   adb shell am start com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity
elif [ "$app_name" = "twitter" ]; then
   adb shell am start com.twitter.android/.StartActivity
elif [ "$app_name" = "instagram" ]; then
   adb shell am start com.instagram.android/.activity.MainTabActivity
elif [ "$app_name" = "playgame" ]; then
   adb shell am start com.google.android.play.games/com.google.android.gms.games.ui.destination.main.MainActivity
elif [ "$app_name" = "googlemap" ]; then
   adb shell am start com.google.android.apps.maps/com.google.android.maps.MapsActivity
elif [ "$app_name" = "calm" ]; then
   adb shell am start com.calm.android/.ui.misc.SplashActivity
elif [ "$app_name" = "amazonvideo" ]; then
   adb shell am start com.amazon.avod.thirdpartyclient/.LauncherActivity
elif [ "$app_name" = "bigolive" ]; then
   adb shell am start sg.bigo.live/.home.MainActivity
elif [ "$app_name" = "carousell" ]; then
   adb shell am start com.thecarousell.Carousell/.activities.EntryActivity
elif [ "$app_name" = "starmaker" ]; then
   adb shell am start com.starmakerinteractive.starmaker/com.ushowmedia.starmaker.activity.SplashActivity
elif [ "$app_name" = "tango" ]; then
   adb shell am start com.sgiggle.production/.SplashScreen
elif [ "$app_name" = "webtoon" ]; then
   adb shell am start com.naver.linewebtoon/.splash.SplashActivity
elif [ "$app_name" = "googledrive" ]; then
   adb shell am start com.google.android.apps.docs/.app.NewMainProxyActivity
elif [ "$app_name" = "onedrive" ]; then
   adb shell am start com.microsoft.skydrive/.MainActivity
elif [ "$app_name" = "uplive" ]; then
   adb shell am start com.asiainno.uplive/.init.splash.SplashActivity
elif [ "$app_name" = "joox" ]; then
   adb shell am start com.tencent.ibg.joox/com.tencent.wemusic.ui.main.LauncherUI

elif [ "$app_name" = "easymoney" ]; then
   adb shell am start proxima.easymoney.android/.MainActivity
elif [ "$app_name" = "shein" ]; then
   adb shell am start com.zzkko/com.shein.user_service.welcome.WelcomeActivity
elif [ "$app_name" = "reddit" ]; then
   adb shell am start com.reddit.frontpage/launcher.default
elif [ "$app_name" = "tubitv" ]; then
   adb shell am start com.tubitv/.activities.MainActivity
elif [ "$app_name" = "outlook" ]; then
   adb shell am start com.microsoft.office.outlook/.MainActivity
elif [ "$app_name" = "Chrome" ]; then
   adb shell am start com.android.chrome/com.google.android.apps.chrome.Main 
elif [ "$app_name" = "Gmail" ]; then
   adb shell am start com.google.android.gm/.ConversationListActivityGmail 
else

   echo "The app is not exit ,try again!"
   exit 1
   #exec ./auto_test.sh
fi

printf "$app_name test is start\n"

# ---------------------------------------------------------------------
# Choose the app PID you want to test.
# ---------------------------------------------------------------------

sleep 5
echo "---------------------------------------------------------------------------------------------"
echo "The test app pid is following :"
#adb shell ps -e | grep $app_name | tee $app_name\_top.txt
adb shell ps -e | grep ${dic_process[$app_name]} | grep -v ':'
pid_name=$(adb shell ps -e | grep ${dic_process[$app_name]} | grep -v ':' | awk '{print $2}' | awk 'NR==1')
#awk '{print $2}'
echo "---------------------------------------------------------------------------------------------"
#read -p "Please input the app PID you want to test:" pid_name
#printf "PID $pid_name test is selet\n"
echo $pid_name
# ---------------------------------------------------------------------
# Choose the action you want to perform.
# ---------------------------------------------------------------------

#read -p "Please input action you want to test: [slide,change,search,open,playmusic,playradio,camera,none] " do_name
printf "$do_name is selet\n"

# ---------------------------------------------------------------------
# Make sure you want to start.
# ---------------------------------------------------------------------


printf "Test app name is $app_name,Test pid is $pid_name,Test action is $do_name  \n"
#read -p "Make sure you want to start: [Y/n] " make_sure
echo "---------------------------------------------------------------------------------------------"
sleep 10
if [ "$do_name" = "slide" ]; then
   if [ $app_name = "didi" ]; then
	sh ./slide_didi.sh & . ./huawei_IPC4_cycle.sh
   else
        sh ./slide.sh & . ./huawei_IPC4_cycle.sh
   fi
elif [ $do_name = "change" ]; then
   if [ $app_name = "booking" ]; then
	sh ./change_huawei_book.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "didi" ]; then
	sh ./change_op_didi.sh & . ./huawei_IPC4_cycle.sh
#   elif [ $app_name = "netease" ]; then
#	sh ./change_huawei_nte.sh & . ./huawei_IPC4_cycle_less6.sh
   elif [ $app_name = "qqmail" ]; then
	sh ./change_huawei_qqmail.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "Chrome" ]; then
	sh ./change_huawei_Chrome.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "Gmail" ]; then
	sh ./change_huawei_qqmail.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "wiz" ]; then
	sh ./change_op_wiz.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "facebook" ]; then
	sh ./change_samsung_facebook.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "messenger" ]; then
	sh ./change_samsung_messenger.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "telegram" ]; then
	sh ./change_samsung_telegram.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "amazonmusic" ]; then
	sh ./change_samsung_amazonmusic.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "dealspure" ]; then
	sh ./change_samsung_dealspure.sh & . ./huawei_IPC4_cycle.sh
#   elif [ $app_name = "twitch" ]; then
#	sh ./change_samsung_twitch.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "facebookgaming" ]; then
	sh ./change_samsung_facebookgaming.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "kindle" ]; then
	sh ./change_samsung_kindle.sh & . ./huawei_IPC4_cycle.sh
#   elif [ $app_name = "youtube" ]; then
#	sh ./change_samsung_youtube.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "playgame" ]; then
	sh ./change_samsung_facebookgaming.sh & . ./huawei_IPC4_cycle.sh
   elif [ $app_name = "joox" ]; then
	sh ./change_samsung_joox.sh & . ./huawei_IPC4_cycle.sh
   else 
	sh ./change_oneplus.sh & . ./huawei_IPC4_cycle.sh
   fi
elif [ $do_name = "search" ]; then
   sh ./search.sh & . ./huawei_IPC4_cycle.sh
elif [ "$do_name" = "playmusic" ]; then
   sh ./playmusic.sh & . ./huawei_IPC4_cycle.sh
elif [ "$do_name" = "playradio" ]; then
   sh ./playradio.sh & . ./huawei_IPC4_cycle.sh
elif [ $do_name = "camera" ]; then
   sh ./camera.sh & . ./huawei_IPC4_cycle.sh
elif [ $do_name = "open" ]; then
   sh ./open.sh  & . ./huawei_IPC4_cycle.sh
elif [ $do_name = "quench" ]; then
   sh ./quench.sh  & . ./huawei_IPC4_cycle.sh
elif [ "$do_name" = "none" ]; then
    . ./huawei_IPC4_cycle_less6.sh
else
   echo "The action is not exit !"
fi
#adb shell am force-stop ${dic_process[$app_name]}
