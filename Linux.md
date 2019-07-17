# Linux：

以前的一台：  root/yangb001

## 1、基础信息

##### 1、 centos-7-64： 

​	root/123456

init 3	#切换命令行界面

```
curl -sSL https://stackstorm.com/packages/install.sh | bash -s -- --user=st2admin --password=Ch@ngeMe
```

##### 2、设置网卡

```bash
ip addr 
ifconfig	#此时没有ip地址
cd /etc/sysconfig/network-scripts
vi ifcfg-xxx  #将其中的 onboot=no改为  onboot=yes（默认不启动网卡）
esc  :wq	#退出vi编辑器
service network restart	#重启网卡，就有ip了
```

##### 3、注意知识：

- [x] linux严格区分大小写
- [x] linux里面一切以文件为保存形式，包括硬盘
- [x] linux不存在文件扩展名

## 2、文件及目录处理命令

##### 1、目录处理命令及部分文件处理命令

```bash
ctrl+l  或者 clear 	 #清屏
ctrl+c		# 终止任何一个命令

ls		# 显示当前目录结构
ls	-a 显示隐藏
ls	-l 显示全部详细信息		-h（人性化显示）
	-rwxrwxrwx 1  root root 1205  3月3 08：11 abc.config
	 第一部分 第1字符(-表示文件 d表示目录 l表示软链接文件) 	
    		2-9字符（前3个表示所有者权限，中间3个表示所属组，最后3个表示other权限）r读 w写 x执行
     引用次数，所有者，所属组，大小，最后修改时间，文件名
ls  -d 显示当前目录本身属性
ls  -i 显示文件inode节点号（一个inode不一定对应一个文件，硬链接文件特殊）

mkdir  创建目录命令
mkdir -p 循环创建目录
mkdir /opt/d1  /opt/d2 /tmp/df3		批量创建目录
pwd  显示当前的绝对路径
.表示当前目录		..表示当前目录的上级目录

cp /s1.cnfig /s2.cnfig  /root	复制文件（最后修改的时间会变化）
cp -p /s1.cnfig /s2.cnfig  /root/改名.cnfig	复制文件（保留原始的修改时间）
cp -r /opt/d3 /home  复制目录

mv /s1 /root/改名	 剪贴文件或目录

rmdir /opt/d2	删除空目录（不常用）
rm	删除文件
rm -r 删除目录
rm -f 强制删除（不提示询问）
```

##### 2、文件处理命令

```bash
touch 		创建文件（）
touch "program files"  创建带空格的文件名

cat  文件浏览命令（比较适合浏览短一些的文件）
cat -n 浏览的时候加行号
tac  倒着来浏览文件

more 	#浏览文件（适合大文件）
	f/空格   #向后翻页/向下一行
	Enter	 #换行显示
	q/Q		 #退出
less  	#浏览文件（适合大文件）
	f/空格   #向后翻页
	Enter	 #换行显示
	q/Q		 #退出
	上箭头/PageUp	#向上一行/向上翻页
	/abc 回车		#搜索 abc		（高亮显示以后  按n 向下继续查找）
	
head -n 10 /etc/services	#查看services文件的前10行（不加 -n 10 时默认显示前10行）
tail -n 10 /etc/services	#查看services文件的后10行（不加 -n 10 时默认显示后10行）
tail -f /etc/services	#动态实时监控文件末尾

ln -s /etc/issue /tmp/issue.soft	#软链接文件，类似windws快捷方式
ln /etc/issue /tmp/issue.hard		#硬链接文件，能同步更新，删除互时不影响
									#硬链接不能跨分区，不能对目录使用
```

