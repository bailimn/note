

# 安装

https://nrogap.medium.com/install-rvm-in-macos-step-by-step-d3b3c236953b

\1. Install GnuPG

``` shell
$ brew install gnupg

# 报错 1
fatal: not in a git directory
Error: Command failed with exit 128: git
# 解决办法 运行下面命令，根据提示执行相应的命令
$ brew doctor

Please note that these warnings are just used to help the Homebrew maintainers
with debugging if you file an issue. If everything you use Homebrew for is
working fine: please don't worry or file an issue; just ignore this. Thanks!

Warning: Homebrew/homebrew-cask was not tapped properly! Run:
  rm -rf "/opt/homebrew/Library/Taps/homebrew/homebrew-cask"
  brew tap homebrew/cask

Warning: Homebrew/homebrew-core was not tapped properly! Run:
  rm -rf "/opt/homebrew/Library/Taps/homebrew/homebrew-core"
  brew tap homebrew/core

Warning: Xcode alone is not sufficient on Monterey.
Install the Command Line Tools:
  xcode-select --install

$ rm -rf "/opt/homebrew/Library/Taps/homebrew/homebrew-cask"
$ brew tap homebrew/cask
$ rm -rf "/opt/homebrew/Library/Taps/homebrew/homebrew-core"
$ brew tap homebrew/core
$ xcode-select --install

# 报错 2
Error: Another active Homebrew update process is already in progress.
# 解决办法
rm -rf /usr/local/var/homebrew/locks
```

\2. Install GPG keys (pick First way or Second way)

``` shell

gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

\3. Install RVM

```shell
$ \curl -sSL https://get.rvm.io | bash
```

\4. We will receive a thank you 🙏 message in the console.

\5. Quit all Terminal

\6. Lunch a new Terminal and try this

```
$ rvm list
```

\7. We will get this message

```
# No rvm rubies installed yet. Try 'rvm help install'.
```

\8. Install some ruby version such as **2.7.1** (for an old version, such as 2.3.1 please check **Tip** topic below 😉)

```
$ rvm install 2.7.1
```

\9. After installation, check which ruby version available.

```
$ rvm listruby-2.7.1 [ x86_64 ]# Default ruby not set. Try 'rvm alias create default <ruby>'.
```

\10. Create default ruby version

```
$ rvm alias create default 2.7.1
```

\11. That’s it! Enjoys 🎉

