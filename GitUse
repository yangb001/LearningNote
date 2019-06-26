## git使用

#### 1、git安装

git安装参考：http://3ms.huawei.com/km/blogs/details/2459247

#### 2、git使用

##### git config :用于设置git使用时的参数信息

```bash
git config --global user.name "W3账号"
git config --global user.email "youremail" 
git config --global core.autocrlf false (默认不修改文本换行符)
git config --global i18n.commitencoding utf-8  (可以在git commit命令中输入中文)
git config --global i18n.logoutputencoding utf-8  （git log命令可以显示中文）
git config --global core.quotepath false  （windows环境下，执行git diff命令正确显示中文路径名）
git config --list  （查看配置是否正确）
```

##### git init:用于启动一个全新的仓库

```bash
git init   d:/css/demo
```

##### git clone: 从现有的url仓库中获取完整的仓库文件(必须复制带hook的地址)

```bash
git clone https://www.baidu.com/gitdemo/master.git
```

##### git status 查看git仓库情况

```bash
git status
```

#### 3、git更新代码

```bash
git pull
```

如果有冲突会更新失败，则处理方式参考

##### 1、先更新再处理冲突

<https://blog.csdn.net/nan7_/article/details/25624637>

<https://www.cnblogs.com/rysly/p/git.html>

```bash
git stash
git pull
git stash pop
## 接下来手动处理文件中的冲突
```

##### 2、直接覆盖本地

```bash
git reset --hard
git pull
```

或者

```bash
git fetch --all                  ##下载代码到本地
git reset --hard origin/master
```

##### 3、github仓库参与

```
*fork一份， 修改提交到fork的仓库然后向原本的仓库发pull request*
```



