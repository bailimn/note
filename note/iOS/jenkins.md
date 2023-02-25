``` shell
# 使用docker安装jenkins
# docker 下载地址：https://docs.docker.com/desktop/mac/apple-silicon/
docker run -u root --rm -d -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean
```

![image-20221024183242234](/Users/blf/Library/Application Support/typora-user-images/image-20221024183242234.png)



打开 http://localhost:8080/

jenkins 初始密码地址：/var/jenkins_home/secrets/initialAdminPassword 

docker 需要在docker中进入terminal

43e3d87a2eb54ba188073740ea2743d1



### 疑问

docker中找不到系统已安装的命令



# 命令行安装jenkins

``` shell
# 安装 jdk11
$ brew install openjdk@11

# 安装 jenkins
$ brew install jenkins

#启动jenkins
$ brew services start jenkins
#停止jenkins 
$ brew services stop jenkins
#重启jenkins
$ brew services restart jenkins

# 浏览器访问
localhost:8080

# 获取密码
cat /Users/${计算机名称}/.jenkins/secrets/initialAdminPassword
```

