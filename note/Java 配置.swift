// 历史版本下载
https://www.oracle.com/java/technologies/downloads/archive/

// 切换java版本
/usr/libexec/java_home -V // 列出所有Java版本
java -version // 查看当前java版本
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.291.10` // 配置java版本为1.8.291.10
source ~/.bash_profile // 刷新配置
java -version // 验证



// Bugly 上传 符号表
java -jar /Users/blf/Downloads/buglyqq-upload-symbol/buglyqq-upload-symbol.jar -appid 6a63561259 -appkey bb942e84-1d84-43ee-a0ca-96df48d6507e -bundleid com.ds.kupu.jobs -version 1.1.7.681 -platform IOS -inputSymbol /Users/blf/Desktop/iOS_Boss_Offer.framework.dSYM

java -jar /Users/blf/Downloads/buglyqq-upload-symbol/buglyqq-upload-symbol.jar -appid 6a63561259 -appkey bb942e84-1d84-43ee-a0ca-96df48d6507e -bundleid com.ds.kupu.jobs -version 1.1.7.681 -platform IOS -inputSymbol /Users/blf/Downloads/QBoss_development_681\ 2021-09-18\ 20.52.00.xcarchive/dSYMs/KUPU.app.dSYM



xcrun swift-demangle $s14iOS_Boss_Offer23HomeEmployeAcceptedViewC12updateFlexUI13acceptedModelyAA0fL0C_tF

xcrun swift-demangle $s14iOS_Boss_Offer30AcceptedEmployeeViewControllerC05tableF0_12cellForRowAtSo07UITableF4CellCSo0mF0C_10Foundation9IndexPathVtF
atos -o /Users/blf/Desktop/iOS_Boss_Offer.framework.dSYM/Contents/Resources/DWARF/iOS_Boss_Offer -arch arm64 0x000000010bb7a034


Warning: Attempt to present on whose view is not in the window hierarchy!