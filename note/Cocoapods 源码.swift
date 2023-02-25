// Cocoapods 命令行工具
git clone https://github.com/CocoaPods/CocoaPods.git
// 处理 space 与 podfile，比如 Podfile DSL 的定义就在这个项目中
git clone https://github.com/CocoaPods/Core.git
// 下载器
git clone https://github.com/CocoaPods/cocoapods-downloader.git
// 解析 .xcodeproj 文件解析
git clone https://github.com/CocoaPods/Xcodeproj.git
// 命令行参数解析器
git clone https://github.com/CocoaPods/CLAide.git
// 依赖分析
git clone https://github.com/CocoaPods/Molinillo.git



CocoaPods git 地址：https://github.com/CocoaPods/CocoaPods#projects
调试Cocoapods 教程：http://www.saitjr.com/ios/cocoapods-debug.html


CLAide模块的Command类: 所有指令类的基类
Pod模块Command类: Pod模块的指令基类
Pod模块Init类: 代表各种命令(install,list等), Pod模块Command的子类

/Users/blf/Documents/Test/CocoapodsTest/CocoaPods/lib/cocoapods/command/init.rb
module Pod
  class Command
    class Init < Command