## Ruby Version Manager

rvm & rbenv

- 安装、管理和使用多个Ruby环境
- 这两个工具的本质都是在PATH上做手脚，一个在执行前，一个在执行中

``` shell
# 先安装homebrew(Mac 的包管理工具)
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
# 安装arm版本的homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

# 查看当前安装的ruby
rvm list
rvm list known # 显示rvm能够管理的ruby版本有哪些
rvm use ruby-2.7.3

# 安装最新版本
$ rvm install ruby --head

# 安装ruby
$ brew install ruby
```



## gem

ruby第三方管理工具

Gem是一个管理Ruby库和程序的标准包，它通过Ruby Gem（如http://rubygems.org/ ）源来查找、安装、升级和卸载软件包，非常的便捷

Gemfile文件：项目依赖的Gem库描述

``` shell
gem search -r/-f <gem>
gem install <gem> --version <num>
gem list

# 更换 gem 源
$ gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
$ gem sources -l
https://gems.ruby-china.com

# 查看本地已安装 gems
gem list
# (查看gem版本)
gem --version 
# (更新gem)
gem update --system
# (查看数据源)
gem sources
# 删除数据源
gem sources --remove https://rubygems.org/
# (添加数据源)
gem sources -a https://ruby.taobao.org/
# (搜索软件包)
gem search 软件包关键字
# (安装软件包)
gem install 软件包名称
# (安装上一个版本软件包)
gem install cocoapods --pre
# (卸载安装包)
gem uninstall 软件包名称


# 查看cocoapods安装信息
$ gem info cocoapods
$ echo $GEM_HOME
/Users/blf/.rvm/gems/ruby-2.7.0
```



## RubyGems

Bundler 能够跟踪并安装所需的特定版本的gem，以此来为Ruby项目提供一致的运行环境

![image-20220511224401809](/Users/blf/Library/Application Support/typora-user-images/image-20220511224401809.png)

``` ruby
source 'https://rubygems.org'
gem 'rails', '4.0.1'
gem 'rack-cache'
gem 'nokogirl', '~> 1.6.1'
```

``` shell
# 根据 Gemfile 安装 gem，安装到了当前ruby的gem目录中 /Users/blf/.rvm/gems/ruby-2.7.0/ $GEM_HOME
bundle install
```



Gemfile -> Podfile

bundle instal -> pod install

Gemfile.lock -> Podfile.lock



## ruby-debug-ide gem

![image-20220511224704067](/Users/blf/Library/Application Support/typora-user-images/image-20220511224704067.png)



## debase

![image-20220511224744500](/Users/blf/Library/Application Support/typora-user-images/image-20220511224744500.png)



## bundle exec

![image-20220511224819629](/Users/blf/Library/Application Support/typora-user-images/image-20220511224819629.png)



## rubocop

![image-20220511224854119](/Users/blf/Library/Application Support/typora-user-images/image-20220511224854119.png)



## solargrahp

![image-20220511224932330](/Users/blf/Library/Application Support/typora-user-images/image-20220511224932330.png)

![image-20220511232855850](/Users/blf/Library/Application Support/typora-user-images/image-20220511232855850.png)

``` shell
# 安装
gem install solargraph

# 查看 solargraph命令的路径
which solargraph
/Users/blf/.rvm/gems/ruby-2.7.0/bin/solargraph
```





## VSCode 插件

![image-20220511225040840](/Users/blf/Library/Application Support/typora-user-images/image-20220511225040840.png)



## cocoapods-binary

![image-20220511225147381](/Users/blf/Library/Application Support/typora-user-images/image-20220511225147381.png)



## launch.json

``` json
{
  // https://github.com/rubyide/vscode-ruby/wiki/2.-Launching-from-VS-Code#available-vs-code-defined-variables
  "configurations": [
    {
    "name": "Debug Ruby Code",
    // 输出调试信息
    "showDebuggerOutput": true,
    // 告诉VS Code要运行什么调试器。
    "type": "Ruby",
    // "launch"允许直接从VS Code启动提供的程序-或"attach"-允许您附加到远程调试会话。
    "request": "launch",
    // rdebug-ide在内运行bundler exec
    "useBundler": true,
    // 始终在入口处停止
    "stopOnEntry": false,
    // "program"的工作目录
    "cwd": "${workspaceRoot}", 
    // 指定调试脚本，调试当前打开的文件"program": "${file}"
    "program": "${file}",
    // 提供program命令参数
    "args": [],
    // 启动程序之前，提供要设置的环境变量
    "env": {
         "PATH":"/Applications/Google Chrome.app/Contents/MacOS:/opt/MonkeyDev/bin:/Users/blf/.rvm/gems/ruby-2.7.0/bin:/Users/blf/.rvm/gems/ruby-2.7.0@global/bin:/Users/blf/.rvm/rubies/ruby-2.7.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Applications/Wireshark.app/Contents/MacOS:/Users/blf/.rvm/bin:/Applications/010 Editor.app/Contents/CmdLine:/usr/local/:/Users/blf/Documents/flutter/bin",
         "GEM_HOME":"/Users/blf/.rvm/gems/ruby-2.7.0",
         "GEM_PATH": "/Users/blf/.rvm/gems/ruby-2.7.0:/Users/blf/.rvm/gems/ruby-2.7.0@global",
         "RUBY_VERSION": "ruby-2.7.0"
    		}
    }
  ]
}

```

生成env

``` shell
printf "\n\"env\": {\n \"PATH\":\"$PATH\",\n \"GEM_HOME\":\"$GEM_HOME\",\n \"GEM_PATH\": \"$GEM_PATH\",\n \"RUBY_VERSION\": \"$RUBY_VERSION\"}\n\n"
```



## 调试CocoaPods

launch.json

``` json
{
  "configurations": [
    {
      "name": "Debug CocoaPods Plugin",
      "showDebuggerOutput": true,
      "type": "Ruby",
      "request": "launch",
      "useBundler": true,
      "cwd": "${workspaceRoot}/TestLibrary", // pod 命令执行的路径
      "program": "${workspaceRoot}/CocoaPods/bin/pod",
      "args": [
        "install"
      ], // `pod` 命令的参数
      "env": {
        "PATH": "/Applications/Google Chrome.app/Contents/MacOS:/opt/MonkeyDev/bin:/Users/blf/.rvm/gems/ruby-2.7.0/bin:/Users/blf/.rvm/gems/ruby-2.7.0@global/bin:/Users/blf/.rvm/rubies/ruby-2.7.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Applications/Wireshark.app/Contents/MacOS:/Users/blf/.rvm/bin:/Applications/010 Editor.app/Contents/CmdLine:/usr/local/:/Users/blf/Documents/flutter/bin",
        "GEM_HOME": "/Users/blf/.rvm/gems/ruby-2.7.0",
        "GEM_PATH": "/Users/blf/.rvm/gems/ruby-2.7.0:/Users/blf/.rvm/gems/ruby-2.7.0@global",
        "RUBY_VERSION": "ruby-2.7.0"
      }
    }
  ]
}
```



### pod install 命令的ruby文件路径

CocoaPods/lib/cocoapods/command/install.rb

可以在run函数下断点调试



### 遇到的问题

``` shell
could not find concurrent-ruby-1.1.8 in any of the sources
# 解决办法
gem install concurrent-ruby -v 1.1.8
```



## 创建gem库

``` shell
# 类似创建私有库
bundle gem <gem-name>
```



``` shell
# 安装自定义gem到本地
# rake : 类似cmake 
rake install::local
# 查看是否安装成功
gem info cocoapods-hmap
```





- vscode 插件目录：用户/.vscode/extensions