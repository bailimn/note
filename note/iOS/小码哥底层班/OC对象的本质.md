### 将Objective-C代码转换为C\C++代码
xcrun  -sdk  iphoneos  clang  -arch  arm64  -rewrite-objc  OC源文件  -o  输出的CPP文件

xcrun  -sdk  iphoneos  clang  -arch  arm64  -rewrite-objc main.m  -o  main.cpp

如果需要链接其他框架，使用-framework参数。比如-framework UIKit

![image-20220226152222537](/Users/blf/Library/Application Support/typora-user-images/image-20220226152222537.png)

![image-20220226152410434](/Users/blf/Library/Application Support/typora-user-images/image-20220226152410434.png)

### NSObject对象占用多少个字节？

16个

![image-20220226162535255](/Users/blf/Library/Application Support/typora-user-images/image-20220226162535255.png)



![image-20220226163119580](/Users/blf/Library/Application Support/typora-user-images/image-20220226163119580.png)



### 结构体内存对齐：结构体的最终大小必须是最大成员大小的倍数

### 操作系统内存对齐：16个字节



sizeof() : 计算一个类型的大小（比如结构体、Int、Double）











