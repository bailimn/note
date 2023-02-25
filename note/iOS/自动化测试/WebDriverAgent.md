WebDriverAgent 是适用于 iOS的WebDriver 服务器实现，可用于远程控制 iOS 设备。它允许您启动和终止应用程序、点击和滚动视图或确认屏幕上的视图存在。这使其成为应用程序端到端测试或通用设备自动化的完美工具。它通过链接XCTest.framework和调用 Apple 的 API 来直接在设备上执行命令。WebDriverAgent 是为端到端测试而开发的，并通过XCUITest 驱动程序被Appium成功采用。


### 特征
- 设备和模拟器均支持 iOS 和 tvOS 平台
- 实现大部分[WebDriver 规范](https://w3c.github.io/webdriver/webdriver-spec.html)
- 实现部分[Mobile JSON Wire Protocol Spec](https://github.com/SeleniumHQ/mobile-spec/blob/master/spec-draft.md)
- USB 对设备的支持是通过[appium-ios-device](https://github.com/appium/appium-ios-device)库实现的，并且对第三方工具的依赖为零。
- 简单的开发周期，因为它可以通过 Xcode 直接启动和调试
- 使用[Mac2Driver](https://github.com/appium/appium-mac2-driver)自动化 macOS 应用程序

[](http://localhost:8100)

[](http://localhost:8100/inspector)

[](http://localhost:8100/status)

如果打开这个网站没有获取session id，执行一下curl session命令
http://localhost:8100/status

http://localhost:8100/source


[验证会话是否启动成功](http://localhost:8100/session)

https://github.com/appium/WebDriverAgent



``` python
import wda
driver = wda.Client('http://192.168.1.101:8100')
# 跳转新浪应用
sina_session = driver.session('com.sina.weibo')
# 取得屏幕大小
size = sina_session.window_size()
print(size)
# 点击发现按钮
sina_session(text=u'发现',className='Button').tap()
# 跳转到设置应用
setting_session = driver.session('com.apple.Preferences')
# 点击通知按钮
setting_session(text=u'通知', className='Cell').tap()
```

### 验证WDA是否启动成功
``` shell
╰─ curl --location --request POST 'http://localhost:8100/session' \
--header 'Content-Type: application/json' \
--data-raw '{"capabilities":{}}'
{
  "value" : {
    "sessionId" : "9E41B544-2497-4E0E-B687-1E265225EDDD",
    "capabilities" : {
      "device" : "iphone",
      "browserName" : "淘宝",
      "sdkVersion" : "14.1",
      "CFBundleIdentifier" : "com.taobao.taobao4iphone"
    }
  },
  "sessionId" : "9E41B544-2497-4E0E-B687-1E265225EDDD"
}%

╰─ curl --location --request POST 'http://localhost:8100/session' \
--header 'Content-Type: application/json' \
--data-raw '{"capabilities":{}}'
{
  "value" : {
    "sessionId" : "9E41B544-2497-4E0E-B687-1E265225EDDD",
    "capabilities" : {
      "device" : "iphone",
      "browserName" : "淘宝",
      "sdkVersion" : "14.1",
      "CFBundleIdentifier" : "com.taobao.taobao4iphone"
    }
  },
  "sessionId" : "9E41B544-2497-4E0E-B687-1E265225EDDD"
}%
```

### 查找元素 element
``` python
# For example, expect: True or False
# using id to find element and check if exists
s(id="URL").exists # return True or False

# using id or other query conditions
s(id='URL')
s(name='URL')
s(text="URL") # text is alias of name
s(nameContains='UR')
s(label='Address')
s(labelContains='Addr')
s(name='URL', index=1) # find the second element. index starts from 0

# combines search conditions
# attributes bellow can combines
# :"className", "name", "label", "visible", "enabled"
s(className='Button', name='URL', visible=True, labelContains="Addr")

# 实战，获取Button
# print(driver(xpath='//XCUIElementTypeButton[@name="赚糖领红包"]'))
button = driver(xpath='//XCUIElementTypeButton[@name="赚糖领红包"]')

print("元素的属性： ")
print("button: ", button) # button:  <wda.Selector object at 0x104a2b820>
print("button.get: ", button.get()) # button.get:  <wda.Element(id="11000000-0000-0000-7B25-000000000000")>
print("button.get().info: ", button.get().info) # {'id': '11000000-0000-0000-7B25-000000000000', 'label': '赚糖领红包', 'value': None, 'text': '赚糖领红包', 'name': 'XCUIElementTypeButton', 'className': 'XCUIElementTypeButton', 'enabled': True, 'displayed': True, 'visible': True, 'accessible': True, 'accessibilityContainer': False}
```

``` python
# 取得屏幕大小
size = driver.window_size()
print(size) # Size(width=414, height=736)

# 获取状态
print(driver.status()) # {'message': 'WebDriverAgent is ready to accept commands', 'state': 'success', 'os': {'testmanagerdVersion': 28, 'name': 'iOS', 'sdkVersion': '15.0', 'version': '14.1'}, 'ios': {'ip': '192.168.204.201'}, 'ready': True, 'build': {'time': 'Oct 25 2021 22:38:06', 'productBundleIdentifier': 'com.feirui.test3'}, 'sessionId': '3E667FD9-1F42-4726-9EB3-600D9D95CC6A'}

# 返回主屏幕（相当于按home键）
# c.home()

# 截屏(自动保存)
screenshot = c.screenshot('screen.png') 
print(screenshot) # <PIL.Image.Image image mode=RGB size=1242x2208 at 0x110070400>
# 保存截图
# screenshot.save("s.png")
# 截屏选择90度保存
# c.screenshot().transpose(Image.ROTATE_90).save("correct.png")

# 打印 bundle_id
print(driver.bundle_id) # com.taobao.taobao4iphone
# 打印 session id
print(driver.session_id) # 3E667FD9-1F42-4726-9EB3-600D9D95CC6A



# Print orientation
print(c.orientation)

# Change orientation
c.orientation = wda.LANDSCAPE

# 打开App
s = c.session('bundle id')
# 关闭App
c.close()

el2 = driver.find_element_by_accessibility_id("赚糖领红包")
el2.click()

# 按真機Home鍵
c.home()

# 檢查可用性
print(c.healthcheck())

# 点击屏幕 （支持小数）
s.tap(374,613)

# 滑动屏幕
# 从(x1,y1)划向(x2,y2)
# s.swipe(x1, y1, x2, y2, 0.5) # 0.5s
for j in range(1,15):
  # 模拟上滑
  s.swipe(0.5, 0.5, 0.5, 0.3, 0.3)
  # 暂停一会儿
  time.sleep(0.5)

# 从屏幕右边往左划
s.swipe_left()
# 从屏幕左边往右划
s.swipe_right()
# 从屏幕底部往上划
s.swipe_up()
# 从屏幕顶部往上划
s.swipe_down()

# 长按
driver.tap_hold(100, 100, 1.0)

# Hide keyboard (not working in simulator), did not success using latest WDA
driver.keyboard_dismiss()
```

