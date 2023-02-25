### Swagger-Codegen

功能：生成客户端代码

安装

```bash
# 安装
brew install swagger-codegen
# 使用
swagger-codegen generate -i http://petstore.swagger.io/v2/swagger.json -l ruby -o /tmp/test/
```

本地环境运行

```bash
$ git clone https://github.com/swagger-api/swagger-editor
$ npm install -g http-server
$ sudo npm install -g http-server
$ cd /Users/blf/Documents/Swagger/swagger-editor
$ http-server
// 进入http://127.0.0.1 就可以看到swagger页面了。
```

#### KUPU接口文档地址

http://dev-api.kupu.id/position/v2/api-docs
http://dev-api.kupu.id/system/v2/api-docs
http://dev-api.kupu.id/course/v2/api-docs

http://dev-api.kupu.id/resume/v2/api-docs

http://dev-api.kupu.id/user/v2/api-docs

http://dev-api.kupu.id/market/v2/api-docs

http://dev-api.kupu.id/trade/v2/api-docs

http://dev-api.kupu.id/course/v2/api-docs

http://192.168.204.175:8002/v2/api-docs

#### 在线Swagger-Editor

[https://editor.swagger.io/](https://editor.swagger.io/)

封装了Swagger的接口管理软件：

knife4j

http


#### 需要的处理
1. 搜索

   ``` yaml
   definitions:
     AppBonusRes:
   ```

   

2. 删除上面的接口，保留一个就行