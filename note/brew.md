
brew search python@3.4

### 拆卸3.9版本的python
brew uninstall python@3.9

``` shell
# 安装软件
$ brew install git

# 拆卸软件
$ brew uninstall git 

# 搜索软件
$ brew search git

# 显示已安装列表
$ brew list

# 更新某个具体软件
$ brew upgrade git

# 显示某个软件信息
$ brew info git 

# 显示包的安装树
$ brew deps --installed --tree

# 查看哪些已安装的程序需要更新
$ brew outdated
```



### 报错

``` shell
# 报错 1
$ jenkins state
/opt/homebrew/bin/jenkins: line 3: /Users/qiyee/@@HOMEBREW_JAVA@@/bin/java: No such file or directory
/opt/homebrew/bin/jenkins: line 3: exec: /Users/qiyee/@@HOMEBREW_JAVA@@/bin/java: cannot execute: No such file or directory
# 解决办法
$ HOMEBREW_BOTTLE_DOMAIN= brew reinstall jenkins
$ brew services restart jenkins
```

