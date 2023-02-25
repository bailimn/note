### Mac 解决selenium调试每次打开新Chrome浏览器问题

配置chrome
open -e ~/.zshrc
在结尾添加：
export PATH="/Applications/Google Chrome.app/Contents/MacOS:$PATH"
保存后退出，然后启动一个窗口：
Google\ Chrome --remote-debugging-port=19222 --user-data-dir="~/ChromeProfile"

```
Google\ Chrome --remote-debugging-port=19222 --user-data-dir="/Users/blf/Library/Application Support/Google/Chrome/"
```

其中Google\ Chrome为一个命令，把chrome添加到环境变量就可以看到了
这里是指定chrome的端口19222，这段代码执行结束后也不会退出driver，我们使用：

lsof -i:19222
就可以看到39222端口有监听状态的Google
连接浏览器

from selenium import webdriver

options = webdriver.ChromeOptions()

options.add_experimental_option("debuggerAddress", "127.0.0.1:19222")
driver = webdriver.Chrome(options=options)
driver.get('https://www.baidu.com')
参考网站：https://cosmocode.io/how-to-connect-selenium-to-an-existing-browser-that-was-opened-manually/#2-step-1-launch-browser-with-custom-flags

### QT

##### Qt Designer 路径

/usr/local/lib/python3.9/site-packages/qt5_applications/Qt/bin/Designer.app



/usr/local/bin/pyuic5