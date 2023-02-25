``` shell
# 文件太多时，网页直接打开会报错，可以用plantuml.jar生成本地图片
$ swiftplantuml --config /Users/blf/Downloads/SwiftPlantUML-main/Configuration/Examples/Rich/.swiftplantuml.yml --output consoleOnly > sources.txt | java -DPLANTUML_LIMIT_SIZE=8192 -jar /Users/blf/Downloads/plantuml.jar $1

# 报错 1
Warning: the font "Times" is not available, so "Lucida Bright" has been substituted, but may have unexpected appearance or behavor. Re-enable the "Times" font to remove this warning.
Warning: the font "Times" is not available, so "Lucida Bright" has been substituted, but may have unexpected appearance or behavor. Re-enable the "Times" font to remove this warning.
java.io.IOException: Cannot run program "/opt/local/bin/dot": error=2, No such file or directory
# 解决办法
# Graphviz 是一个开源的图可视化工具，非常适合绘制结构化的图标和网络。Graphviz 使用一种叫 DOT 的语言来表示图形。
$ brew install Graphviz
$ dot -version
```

