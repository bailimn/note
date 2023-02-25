
### cocoapods-project-hmap
##### 1. 创建私有源仓库
``` bash
pod repo add my https://gitee.com/bailf/kupu-spec.git
```

##### 2. 安装 mongodb
``` bash
# 进入 /usr/local
cd /usr/local

# 下载
sudo curl -O https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-4.0.9.tgz

# 解压
sudo tar -zxvf mongodb-osx-ssl-x86_64-4.0.9.tgz

# 重命名为 mongodb 目录
sudo mv mongodb-osx-x86_64-4.0.9/ mongodb

#创建一个数据库存储目录 /data/db：
sudo mkdir -p /data/db
```

##### 3. 启动mongodb
``` bash
sudo mongodb
```

##### 4. 静态资源服务器
https://github.com/su350380433/binary-server
``` bash
cd ***/binary-server
npm install
npm start
```

###### 路由
``` bash
.get('/frameworks', frameworks.show)
.get('/frameworks/:names', frameworks.show)
.get('/frameworks/:name/:version', frameworks.show)
.del('/frameworks/:name/:version', frameworks.destroy)
.get('/frameworks/:name/:version/zip', frameworks.download)
.post('/frameworks', frameworks.create)
```

###### 获取组件信息
``` bash
curl http://localhost:8080/frameworks/PodA
> {"PodA":["0.2.4"]}

curl http://localhost:8080/frameworks
> {"TDFCoreProtocol":["1.2.4","1.2.5"],"PodA":["0.2.4-binary","0.2.4"]}
```

###### 推送组件 zip 包
``` bash
curl http://localhost:8080/frameworks -F "name=PodA" -F "version=0.2.4" -F
  "annotate=Mergebranch'release/0.2.3'into'master'" -F
  "file=@/Users/songruiwang/Work/TDF/cocoapods-tdfire-binary/example/PodA/PodA.framework.zip"
  -F "sha=7bf2c8f3ce1184580abfea7129d1648e499d080e"
> 保存成功 PodA (0.2.4)
```

- zip 包存储在 server 根目录的 .binary 目录下

###### 获取组件 zip 包：
``` bash
curl http://localhost:8080/frameworks/PodA/0.2.4/zip > PodA.framework.zip
```

###### 删除组件：
``` bash
curl -X 'DELETE' http://localhost:8080/frameworks/PodA/0.2.4 -O -J
```