``` shell
brew install libimobiledevice
iproxy 8100 8100
```

### 报错
##### 

``` shell
╰─ iproxy 8100 8100
Creating listening port 8100 for device port 8100
bind(): Address already in use
Error creating socket for listen port 8100: Address already in use

# 解决办法
ps -ax|grep -i "iproxy"|grep -v grep|awk '{print "kill -9 " $1}'|sh
```

