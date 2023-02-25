``` shell
# 把目录变成Git可以管理的仓库
git init

# 把文件添加到暂存区
git add readme.txt

# 把暂存区内容提交到当前分支
git commit -m "wrote a readme file"

# 查看仓库当前状态
git stauts

# 查看difference(Unix通用的diff格式)
git diff readme.txt

# 提交一次修改
git add readme.txt
git status
git commit -m "add distributed"

# 查看提交日志
# --pretty=oneline ：简化输出
git log --pretty=oneline

# 回退到上一个版本
git reset --hard HEAD^
# 回退到指定版本
git reset --hard <commit id>

# 查看git历史命令
git reflog

# 版本库 替换 工作区
git checkout -- readme.txt

# 把暂存区的修改撤销（unstage），重新放回工作区
git reset HEAD readme.txt

# 删除文件
git rm test.txt

# 当我们创建新的分⽀，例如dev时，Git新建了⼀个指针叫dev，指向master相同的提交，再把HEAD指向dev，就表⽰当前分⽀在dev上

# 创建+切换分支
# -b : 表示创建并切换
git checkout -b dev
# 创建分支 
git branch dev
# 切换分支
git checkout dev
# 查看分支
git branch
# 合并指定分支到当前分支
git merge dev
# 删除dev分支
git branch -d dev

# 查看远程仓库信息
git remote 
git remote -v # 更详细


```



Fast-forward : 快进模式，直接把master指向dev的当前提交，所以合并速度⾮常快。



### 远程仓库

``` shell
# 到.ssh录，⾥⾯有id_rsa和id_rsa.pub
ssh-keygen -t rsa -C "youremail@example.com"

# 关联远程仓库
# origin : 远程仓库的名字
git remote add origin git@server-name:path/repo-name.git

# 把本地master分⽀的最新修改推送⾄GitHub，
# 由于远程库是空的，我们第⼀次推送master分⽀时，加上了-u参数，Git不但会把本地的 master分⽀内容推送的远程新的master分⽀，还会把本地的master分⽀和远程的master 分⽀关联起来，在以后的推送或者拉取时就可以简化命令。
git push -u origin master

```





```bash

#############   tag  ###########
# 提交版本号
$ git tag '0.1.0'
# 查看 tag
$ git tag
# 推送tag到远端仓库
$ git push origin master --tags
```

git push -u origin master 中 -u 是什么意思？

[https://zlargon.gitbooks.io/git-tutorial/content/remote/upstream.html](https://zlargon.gitbooks.io/git-tutorial/content/remote/upstream.html)

[https://www.ctolib.com/topics-143799.html](https://www.ctolib.com/topics-143799.html)

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b3abc75c-6726-4ef1-a5c1-5d33932ae5bd/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b3abc75c-6726-4ef1-a5c1-5d33932ae5bd/Untitled.png)



### 一次完整的提交

``` shell
# 添加文件到暂存区
git add 文件名
# 把暂存区的内容添加到当前分支
git commit -m “版本说明”
# 查看工作区状态
git statues

```

### git log

``` shell
# -p: 显示完整输出
$ git log -p > /Users/blf/Desktop/ddd.txt

# --pretty=oneline。减少输出内容
$ git log --graph --pretty=oneline --abbrev-commit
```



查看文件修改内容

git diff 文件名

git diff HEAD -- 文件名

查看提交历史记录

git log

HEAD 表示当前版本（指向分支的指针）

HEAD^ 上个版本

HEAD^^ 上上个版本

HEAD~100 上100个版本



回退到指定版本

git re**set** --hard 1094a

查看历史命令

git reflog



### 撤销修改

git status 信息中有对应的命令

```bash
# 从暂存区回退到工作区
git restore --staged <file> # 方法1
git reset --soft 5fd2b92
git reset HEAD^ # 方法2 对远程分支无效
git revert HEAD # 方法3 对远程分支有效 
# 撤销工作区修改
git restore <file>... # 方法1
git checkout -- <file> # 方法2
```

### 删除文件

```bash
git rm <file>
```

### 配置远程仓库

```bash
# 生成秘钥对，会在 ~/.ssh 目录中生成 id_rsa.pub 和 id_rsa 两个文件
ssh-keygen -t rsa -C "youremail@example.com"
# 复制公钥到Github的 Account settings -> SSH Keys -> Add SSH Key -> 
# id_rsa.pub 文件里的内容

git remote add origin git@github.com:bailimn/learngit.git
```

### 推送

```bash
# -u 关联远程master和本地master，可以简化以后的提交
git push -u origin master
```

### 分支管理

创建

```bash
# 创建分支
git branch dev
# 创建并切换
git checkout -b dev
# 创建并切换
git switch -c dev 
```

合并

```bash
# 合并指定分支到当前分支 fast-forward模式
git merge dev
git merge --no-ff -m "merge with no-ff" dev # --no-ff：禁用 fast forward 模式

# 第二种合并分支的方法。Rebase实际上就是取出一系列的提交记录，“复制”它们，
# 然后在另外一个地方逐个的放下去。优势就是可以创造更线性的提交历史
# 合并当前分支到main（bugFix为当前分支）
git rebase main

# 不会保留对合入分支的引用
git merge -squash dev
```

切换

```bash
# 切换分支
git checkout dev
git checkout fed2da64
git checkout master^
git checkout master~4

# 切换分支的另一中方式(更科学)
git switch dev
```

```bash
# 查看分支
git branch

# 删除一个没有合并过的分支
git branch -D feature-vulcan
# 删除本地分支
git brach -d [branchname]
# 删除远程分支
git push origin --delete [branchname]

# 推送
git push origin master
git push origin dev

# 创建远程origin的dev分支到本地
git checkout -b dev origin/dev

# 将 main 分支强制指向 HEAD 的第 3 级父提交。
git branch -f main HEAD~3

# 切换仓库地址
git remote set-url origin http://gitlab.qiyeetech.com/qiyee/qiyee_iOS_code/iOS_Boss_Extensions.git
```

### 整理提交树

```bash
git cherry-pick C2 C4 # 将另一分支的C2C4提交复制到当前分支
git cherry-pick 24dc9cd 9894e16
git rebase -i HEAD~4 # 交互式
```

### 解决办法

1. 开发过程中，需要解决其他问题，需要把当前工作现场“储藏”起来，等以后恢复现场后继续工作

```bash
git stash
# 修改BUG后
git stash list
git stash pop

# 恢复方式2
git stash apply stash@{0}

```

2. 已提交本地，现在要撤回

   ```bash
   git reset 057d
   
   # 回退到上个版本
   git reset —head HEAD^
   ```

   

### gitignore

- 空行或是以`#`开头的行即注释行将被忽略。
- 可以在前面添加正斜杠`/`来避免递归,下面的例子中可以很明白的看出来与下一条的区别。
- 可以在后面添加正斜杠`/`来忽略文件夹，例如`build/`即忽略build文件夹。
- 可以使用`!`来否定忽略，即比如在前面用了`.apk`，然后使用`!a.apk`，则这个a.apk不会被忽略``
- *用来匹配零个或多个字符，如`.[oa]`忽略所有以".o"或".a"结尾，`~`忽略所有以`~`结尾的文件（这种文件通常被许多编辑器标记为临时文件）；`[]`用来匹配括号内的任一字符，如`[abc]`，也可以在括号内加连接符，如`[0-9]`匹配0至9的数；`?`用来匹配单个字符。
看了这么多，还是应该来个栗子：

```bash
# 忽略 .a 文件
*.a
# 但否定忽略 lib.a, 尽管已经在前面忽略了 .a 文件
!lib.a
# 仅在当前目录下忽略 TODO 文件， 但不包括子目录下的 subdir/TODO
/TODO
# 忽略 build/ 文件夹下的所有文件
build/
# 忽略 doc/notes.txt, 不包括 doc/server/arch.txt
doc/*.txt
# 忽略所有的 .pdf 文件 在 doc/ directory 下的
doc/**/*.pdf
```

github gitegnore 模板地址：[https://github.com/github/gitignore](https://github.com/github/gitignore)

## 用户管理

```bash
# 查看用户和邮箱地址
git config user.name
git config user.email
# 修改全局用户名和邮箱
git config --global user.name "username"
git config --global user.email "email"
# 修改当前用户名和邮箱
git config --local user.name "username"
git config --local user.email "email"
```

# 查看

```bash
# 提交树
git log --graph --oneline --all
# 给提交树命令起别名
git config --global alias.tree "log --oneline --decorate --all --graph"
# 第三方查看提交树命令
tig

# 查看远程仓库地址
git remote -v
```

## 查看某一次提交的修改

``` shell
# 获取所有 commit 记录
git log
# 根据 commit id 查看修改
git show commitId
# 查看某次 commit 中具体某个文件的修改
git show commitId fileName
```

## 暂存

```bash
# 暂存
git stash # 存储在本地，并将项目本次操作还原
# 使用上一次缓存
git stash pop
# 查看
git stash list
# 清空
git stash clear
```

### 修改分支名

```bash
# 1. 本地分支重命名(还没有推送到远程)
git branch -m oldName newName

# 2. 远程分支重命名 (已经推送远程-假设本地分支和远程对应分支名称相同)
# a. 重命名远程分支对应的本地分支
git branch -m oldName newName
# b. 删除远程分支
git push --delete origin oldName
# c. 上传新命名的本地分支
git push origin newName
# d.把修改后的本地分支与远程分支关联
git branch --set-upstream-to origin/newName
```

### 其他命令

```bash
# 在项目提交历史中找到已删除的文件
git log --all --full-history -- **/SingleOutputView.*

# 根据 commit id 查看详细提交记录
git show 3836efe6a586b1129532e58d8a3151c0e2705639

```

### 移动文件或文件夹

```shell
╰─ git mv help
usage: git mv [<options>] <source>... <destination>

    -v, --verbose         be verbose # verbose : 沉长的
    -n, --dry-run         dry run
    -f, --force           force move/rename even if target exists # 即使目标存在，也要强制移动
    -k                    skip move/rename errors # 跳过移动错误
```

### 版本回退

``` shell
git reset --hard 3f508b8
git push -f # -f: 强制提交

```





## tig命令

[https://juejin.cn/post/6844903606215245831](https://juejin.cn/post/6844903606215245831)

[报错](https://www.notion.so/7540e722d7054164ba7a8b970a338fb8)

