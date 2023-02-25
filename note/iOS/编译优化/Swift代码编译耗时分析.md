### 类型检查警告

我们可以在Other Swift Flags配置检查警告项：

``` 
-Xfrontend -warn-long-function-bodies=100
-Xfrontend -warn-long-expression-type-checking=100
```
##### 编译器诊断选项
在 Swift 编译器性能[2]中，Apple 官方提到了几个诊断选项：


我们重点关注-debug-time-function-bodies、-debug-time-expression-type-checking。
-debug-time-function-bodies可以统计打印出 Swift 文件中函数体编译耗时：

``` bash
-driver-time-compilation
-Xfrontend -debug-time-function-bodies

# 更精细的打印
-Xfrontend -debug-time-expression-type-checking

# 0.20ms  test.swift:17:16
# 1.82ms  test.swift:18:12
# 6.35ms  test.swift:19:8
# 0.11ms  test.swift:22:5
# 0.02ms  test.swift:24:10
# 0.02ms  test.swift:30:16
# ...

-Xfrontend -print-stats
-Xfrontend -print-clang-stats
-Xfrontend -print-stats -Xfrontend -print-inst-counts
```


### BuildTimeAnalyzer 分析工具