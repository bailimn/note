# 安装

### 安装 selenium

``` shell
pip install selenium
```



### 根据 Chrome 版本号安装对应的 Chrome Driver

- 安装网址：https://chromedriver.storage.googleapis.com/index.html

- 查看 Chrome 版本号，浏览器输入：chrome://version/

### 将下载好的 Chrome Driver 移动到 /user/local/bin

``` shell
mv /Users/blf/Downloads/chromedriver /usr/local/bin
```



# 使用

## 元素定位

``` python
find_element_by_id()
find_element_by_name()
find_element_by_class_name()
find_element_by_tag_name()
find_element_by_link_text()
find_element_by_partial_link_text()
find_element_by_xpath()
find_element_by_css_selector()

# 把element变成elements就是找所有满足的条件，返回数组。
```



# Mac 解决selenium调试每次打开新Chrome浏览器问题

### 将 Chrome 浏览器添加到环境变量中

``` shell
vi ~/.bash_profile

# 添加下面配置
export PATH=/Applications/Google\ Chrome.app/Contents/MacOS:$PATH

source ~/.bash_profile
```

### 命令行打开 Chrome

``` shell
# --user-data-dir: 用户配置项，可以只用默认浏览器的数据，比如书签、Cookie、历史记录等
Google\ Chrome --remote-debugging-port=19222 --user-data-dir="/Users/blf/Library/Application Support/Google/Chrome/"

# 查看 Chrome 个人资料路径，浏览器输入：chrome://version/
```

### 查看端口占用

``` shell
lsof -i:19222
```

### 相关代码

``` python
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager

options = webdriver.ChromeOptions()
options.add_experimental_option("debuggerAddress", "127.0.0.1:19222")
options.add_argument(r'--user-data-dir=/Users/blf/Library/Application Support/Google/Chrome/')
driver = webdriver.Chrome(ChromeDriverManager().install(), options=options)

driver.get('https://www.baidu.com')
```

# 开发中遇到的问题

