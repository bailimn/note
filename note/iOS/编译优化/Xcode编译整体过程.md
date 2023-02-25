1. 编译信息写入辅助文件，创建文件架构 .app 文件 
2. 处理文件打包信息 
3. 执行 CocoaPod 编译前脚本，checkPods Manifest.lock 
4. 编译.m文件，使用 CompileC 和 clang 命令 
5. 链接需要的 Framework 
6. 编译 xib 
7. 拷贝 xib ，资源文件 
8. 编译 ImageAssets 
9. 处理 info.plist 
10. 执行 CocoaPod 脚本 
11. 拷贝标准库 
12. 创建 .app 文件和签名