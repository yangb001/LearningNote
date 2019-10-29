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

## 使用git stash导致代码消失的一次经历（血泪史）

![96](https://upload.jianshu.io/users/upload_avatars/13250782/4c3a33fe-b969-499c-94e4-70c348b6581f?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96)

[雨_ca3b](https://www.jianshu.com/u/8112f4004267)



0.1 2018.09.04 16:33* 字数 899

### 事情的起因

在写一个项目的时候，因为是多人开发，需要用到git。但总有不想push的时候。可是又想看一下队友的代码，肿么办？？
这时候，今天的主角登场了——

**git stash**
刚知道的这个命令的时候，那叫一个爽呀。不用push，就可以pull别人的代码，在本地合并（当然，大家不要学我，还是要多多push比较好）
但是幸福的日子总是短暂的。很快，我就玩脱了……
一个平静的上午，我`git stash`然后`git pull`在本地合并了之后我输入了`git stash pop`
……
我感觉我的代码并没有发生变化
是不是刚刚那行代码没起作用？
于是，我又在terminal里输入`git stash pop`
……
不！！！
……
一朝回到解放前
其实这时候只要再来一句`git stash pop stash@{0}` 问题就可以解决了
可是……我那时不知道啊！！！
当你突然发现你幸幸苦苦肝了很久的代码，烟消云散，相信我，你会抓狂的：）
从那以后，我再也不敢肆无忌惮的摆弄我项目的git了
并且我开始

### 洗心革面 学习git stash

#### 定义

首先，我们来看看官方文档对 git-stash 的定义吧

> git-stash - Stash the changes in a dirty working directory away

> Use git stash when you want to record the current state of the working directory and the index, but want to go back to a clean working directory. The command saves your local modifications away and reverts the working directory to match the HEAD commit.

蛤？说人话
stash 在汉语中的意思就是 **存储、贮藏** 。
如果你想保留存储工作目录和索引当前状态的记录，但是你又想回到之前干净的工作目录继续工作，就用它啦。它会保存你本地的更改并且使工作目录恢复为HEAD指针所指的提交。

可以再人话一点吗？
这个定义就是说，git-stash 这一大类命令是在你现在写的代码还及其恶心，不能见人（push）的时候，用来将代码的改动存储起来，以免连累那些好代码不能及时有一个好归宿（被push）
当然，你也可以将已经比较稳定的版本先保存起来，如果不小心改烂了代码，也可以回头。只是既然这样不如`git push`。

#### 使用方法

`git stash` 
存储当前工作目录

```
$ git stash
Saved working directory and index state WIP on Practice: 2f70846 Complete practice 
view and network
```

`git stash list` 
查看之前存储的所有版本列表

```
$ git stash list
stash@{0}: WIP on Practice: 2f70846 Complete practice view and network
stash@{1}: WIP on Practice: 2f70846 Complete practice view and network
stash@{2}: WIP on Practice: 2f70846 Complete practice view and network
stash@{3}: WIP on Practice: 2f70846 Complete practice view and network
stash@{4}: WIP on Practice: 812e77b Add collectionView and AnswerView
stash@{5}: WIP on Practice: 53bb0c1 add tableView of questions and refactor the code of scrollView
```

`git stash pop [stash_id]` 
恢复具体某一次的版本,如果不指定stash_id，则默认h恢复最新的存储进度

```
$ git stash pop stash@{0}
Auto-merging WePeiYang/Shared/Network/SolaSessionManager.swift
CONFLICT (content): Merge conflict in WePeiYang/Shared/Network/SolaSessionManager.swift
Auto-merging WePeiYang/Practice/Practice/QuestionTableView/OptionsCell.swift
CONFLICT (content): Merge conflict in WePeiYang/Practice/Practice/QuestionTableView/OptionsCell.swift
Auto-merging WePeiYang/Practice/Practice/Exercise/Model/ExerciseNetwork.swift
Auto-merging WePeiYang.xcodeproj/project.pbxproj
CONFLICT (content): Merge conflict in WePeiYang.xcodeproj/project.pbxproj
```

恢复之后，有时打开工程文件，会发现里面所有文件都不翼而飞了？！
莫慌，莫慌
这是因为出现合并冲突的问题而导致工程文件打不开。
这时候右击工程文件，单击“显示包内容”，打开“project.pbxproj”文件，然后command + f 搜索 “stashed”。把冲突部分删掉就可以重新打开啦

`git stash drop [stash_id]`
删除一个存储的进度。如果不指定stash_id，则默认删除最新的存储进度。

```
$ git stash drop stash@{5}
Dropped stash@{5} (00a18888b0d4c7e9c7d543e9798e7de8df967bc3)
```

`git stash clear`
慎用！！
清除所有的存储进度


