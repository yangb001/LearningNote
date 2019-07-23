# Linux：

以前的一台：  root/yangb001

​						yangb001/123456

## 1、基础信息

##### 1、 centos-7-64： 

​	root/123456

init 3	#切换命令行界面

系统运行级别：	cat  /etc/inittab

| 代号 | 级别                        | 示例                                        |
| :--- | :-------------------------- | :------------------------------------------ |
| 0    | 关机                        | init 0：关机                                |
| 1    | 单用户                      | init 1：类型windows安全模式，只启动核心服务 |
| 2    | 不完全多用户，不包含NFS服务 | init 2：不包含网络文件系统的命令行          |
| 3    | 完全多用户                  | init 3：完全命令行                          |
| 4    | 未分配                      |                                             |
| 5    | 图形界面                    | init 5：切换图形界面                        |
| 6    | 重启                        | init 6：重启                                |

备注：centos7下已经不使用runlevel

> ADDING CONFIGURATION HERE WILL HAVE NO EFFECT ON YOUR SYSTEM. Ctrl-Alt-Delete is handled by /usr/lib/systemd/system/ctrl-alt-del.target systemd uses 'targets' instead of runlevels. By default, there are two main targets: 	multi-user.target: analogous to runlevel 3 	graphical.target: analogous to runlevel 5 To view current default target, run: 	systemctl get-default To set a default target, run: 	systemctl set-default TARGET.target

 















1

```
useradd  user1      #新增用户
```

2

```
passwd  user1   #新增密码
```





##### 2、设置网卡



```

```













1

```
ip addr 
```

2

```
ifconfig    #此时没有ip地址
```

3

```
cd /etc/sysconfig/network-scripts
```

4

```
vi ifcfg-xxx  #将其中的 onboot=no改为  onboot=yes（默认不启动网卡）
```

5

```
esc  :wq    #退出vi编辑器
```

6

```
service network restart #重启网卡，就有ip了

```





##### 3、注意知识：

- linux严格区分大小写
- linux里面一切以文件为保存形式，包括硬盘
- linux不存在文件扩展名

## 2、常用命令

##### 1、目录处理命令及部分文件处理命令















1

```
ctrl+l  或者 clear     #清屏

```

2

```
ctrl+c      # 终止任何一个命令

```

3

```

```

4

```
ls      # 显示当前目录结构

```

5

```
ls  -a 显示隐藏

```

6

```
ls  -l 显示全部详细信息     -h（人性化显示）

```

7

```
    -rwxrwxrwx 1  root root 1205  3月3 08：11 abc.config

```

8

```
     第一部分 第1字符(-表示文件 d表示目录 l表示软链接文件)    

```

9

```
            2-9字符（前3个=所有者=u，中间3个=所属组=g，最后3个=other=o)

```

10

```
            r读 w写 x执行

```

11

```
     引用次数，所有者，所属组，大小，最后修改时间，文件名

```

12

```

```

13

```
ls  -d 显示当前目录本身属性

```

14

```
ls  -i 显示文件inode节点号（一个inode不一定对应一个文件，硬链接文件特殊）

```

15

```

```

16

```
mkdir  创建目录命令

```

17

```
mkdir -p 循环创建目录

```

18

```
mkdir /opt/d1  /opt/d2 /tmp/df3     批量创建目录

```

19

```
pwd  显示当前的绝对路径

```

20

```
.表示当前目录     ..表示当前目录的上级目录

```

21

```

```

22

```
cp /s1.cnfig /s2.cnfig  /root   复制文件（最后修改的时间会变化）

```

23

```
cp -p /s1.cnfig /s2.cnfig  /root/改名.cnfig   复制文件（保留原始的修改时间）

```

24

```
cp -r /opt/d3 /home  复制目录

```

25

```

```

26

```
mv /s1 /root/改名  剪贴文件或目录

```

27

```

```

28

```
rmdir /opt/d2   删除空目录（不常用）

```

29

```
rm  删除文件

```

30

```
rm -r 删除目录

```

31

```
rm -f 强制删除（不提示询问）

```





##### 2、文件处理命令



```

```













1

```
touch       创建文件（）

```

2

```
touch "program files"  创建带空格的文件名

```

3

```

```

4

```
cat  文件浏览命令（比较适合浏览短一些的文件）

```

5

```
cat -n 浏览的时候加行号

```

6

```
tac  倒着来浏览文件

```

7

```

```

8

```
more    #浏览文件（适合大文件）

```

9

```
    f/空格   #向后翻页/向下一行

```

10

```
    Enter    #换行显示

```

11

```
    q/Q      #退出

```

12

```
less    #浏览文件（适合大文件）

```

13

```
    f/空格   #向后翻页

```

14

```
    Enter    #换行显示

```

15

```
    q/Q      #退出

```

16

```
    上箭头/PageUp  #向上一行/向上翻页

```

17

```
    /abc 回车     #搜索 abc     （高亮显示以后  按n 向下继续查找）

```

18

```

```

19

```
head -n 10 /etc/services    #查看services文件的前10行（不加 -n 10 时默认显示前10行）

```

20

```
tail -n 10 /etc/services    #查看services文件的后10行（不加 -n 10 时默认显示后10行）

```

21

```
tail -f /etc/services   #动态实时监控文件末尾

```

22

```

```

23

```
ln -s /etc/issue /tmp/issue.soft    #软链接文件，类似windws快捷方式

```

24

```
ln /etc/issue /tmp/issue.hard       #硬链接文件，能同步更新，删除互时不影响

```

25

```
                                    #硬链接不能跨分区，不能对目录使用

```





##### 3、权限管理命令

###### 1、更改权限

​		只有root及文件的所有者能修改权限



```

```













1

```
chmod   #修改权限

```

2

```
1.chmod u+w,g-r,o+r /name.config        +表示增加，-表示减少

```

3

```
2.chmod u=rwx,g=rw,o=r  /name.config

```

4

```
3.  对应数字：   r=4,  w=2,  x=1

```

5

```
    chmod 777 /name.config   # eg:777=rwxrwxrwx,642=rw-r---w-

```

6

```

```

7

```
chmod -R /opt       # 递归修改目录中的文件权限

```





权限字符说明：

|      | 名称     | 对文件                                 | 对目录                                           |
| :--- | :------- | :------------------------------------- | :----------------------------------------------- |
| r    | 读权限   | 查看文件内容\| cat/more/less/head/tail | 能列出目录中的内容 \| ls                         |
| w    | 写权限   | 修改文件内容 \|vim                     | 能在目录中创建、删除文件 \| touch,rm,mkdir/rmdir |
| x    | 执行权限 | 执行文件 \| script,command             | 能进入目录 \| cd                                 |

###### 2、更改所有者、所属组

​	只有root可以更改所有者及所属组



```

```













1

```
chown [用户] [文件或目录]      #改变文件的所有者

```

2

```

```

3

```
groupadd group1             #新增用户组 group1

```

4

```
chgrp [所属组] [文件及目录]     #改变所属组

```





###### 3、创建文件及目录的缺省

​	创建文件时，所有者默认是创建者，所属组是创建者的缺省组。

​							创建的文件默认不存在x执行权限

​	umask 定义了一个目录的缺省权限



```

```













1

```
umask -S        #创建文件时的默认权限 u=rwx,g=rx,o=rx

```

2

```
umask 022   #设置默认的权限，异或

```

3

```
            # 777=rwxrwxrwx, 022=----w--w-,异或结果为 rwxr-xr-x=755

```

4

```
            # 所以umask 022 后默认的目录权限是 rwxr-xr-x,文件权限是 rw-r--r--

```





##### 4、文件搜索命令

- find会占用服务器资源，建议少用，



```

```













1

```
find [搜索范围] [匹配条件]

```

2

```

```

3

```
匹配条件：

```

4

```
-name   根据文件名搜索，严格区分大小写

```

5

```
    find / -name name       #全局搜索文件名为 name 的文件，严格区分大小写

```

6

```
    find / -name *name*     #文件名模糊搜索，严格区分大小写

```

7

```
    find / -name ?name???   #?匹配单个字符，严格区分大小写

```

8

```
-iname  根据文件名搜索，不区分大小写

```

9

```
    find / -iname *name*    #文件名模糊搜索，不区分大小写

```

10

```
-size 根据文件大小搜索，+n 大于，-n小于，n 等于，1数据块=512byte=0.5K，

```

11

```
    find / -size +204800    #在根目录下搜索大于100MB的文件  100MB=102400K=204800数据块

```

12

```
-user   根据所有者查找

```

13

```
-group  根据所属组查找

```

14

```

```

15

```
-amin   根据访问时间查找 access minitus

```

16

```
-cmin   根据修改文件属性时间查找 change minitus

```

17

```
-mmin   根据修改文件内容时间查找 modify minitus

```

18

```
    find / -cmin -5  #查找5分钟内被修改过属性的文件和目录  +5表示5分钟以前被修改过的

```

19

```
-type  f文件，d目录，l软链接文件 #根据文件类型查找

```

20

```
-inum   根据i节点查找（可以查找硬链接）

```

21

```
    find / -type d

```

22

```

```

23

```
条件连接符：

```

24

```
-a       and

```

25

```
-o       or

```

26

```
    find / -size +102400 -a -size -204800  #查找文件大小在 50MB与100MB之间的文件

```

27

```
-exec/-ok [命令] {} \;    对搜索结果执行操作  {}表示查询结果，-ok会有询问确认

```

28

```
    find / -inum 31351 -exec rm {} \;

```





- locate	从命令维护的文件库中查找，速度快，更新不及时

    ​				/tmp 文件中的文件不收录

```
locate -i yangm		# -i 表示  大小写匹配
updatedb	# 更新文件库

```

- which  查找命令所在目录，及命令是否有别名

```
which cp
    alias cp='cp -i'
        /bin/cp

```

- whereis cp	查找命令所在位置，命令帮助文档所在位置

- grep    在文件中搜寻字符串匹配的行并输出

    ​	-i 不区分大小写   -v 排除指定字符串

```
grep -iv   [指定字串] [文件]
grep -v # /etc/ss.config	#排除掉文件中有#号的行
grep -v ^# /etc/ss.config	#排除掉开头有#号的行 

```

##### 5、文件压缩解压命令

```
gzip/gunzip		#压缩格式为 .gz ，不能压缩目录，不保留原文件

tar -c	打包
	-v  压缩时显示详细信息
	-f	指定文件名
	-z	打包时同时压缩
	-x	解压
    tar -zcf file.tar.gz File 	#先写压缩包文件名，再写需要压缩的文件目录
    tar -cjf file.tar.bz2 file	# .tar.bz2
    tar -zxvf file.tar.gz		#解压
    tar -jxvf file.tar.gz		#解压
    
zip/unzip			#保留原文件
	-r 压缩目录

bzip2/bunzip2		#gzip的升级,生产 .bz2
	-k  压缩完保留原文件

```

##### 6、用户管理命令

```
useradd yangb001	#新增用户
passwd	yangb001	#给用户设置密码
who				#查看服务器登录用户
	tty	本地登录（直接连接虚拟机）
	pts	终端登录
w		#查看登录用户详细信息
	JCPU	m命令执行总时间
	PCPU	最后一次命令执行时间
	WHAT	最后一条执行命令
	

```

##### 7、网络命令

```
write <用户名>		#给 在线 用户发信息
	enter Ctrl+D结束
wall [message]		#给所有在线用户发信息  write all
ping		#给远程主机发信息包	Ctrl+C 结束
	-c 指定循环次数	ping -c 4 127.0.0.1
ifconfig	#查看和设置网卡信息	interface configure
	eth0	表示真实网卡
		link encap：Ethernet	#以太网
	 	HWaddr：xxx			#硬件地址/MAC地址
	 	inet addr：122.*		#ip地址
	lo		回环网卡，测试使用，无网卡也可ping通

mail <用户名>		#查看发送电子邮件
	列序号查看详细，h 返回列表，d 序列号 删除，q 推出

last	 #列出目前与过去登录系统的用户及系统重启的信息
lastlog		#列出所有用户最后一次登录信息
	lastlog -u [用户id]	#特定用户
	
traceroute	[网址]	#显示数据包到主机间的路径
netstat [选项]	#显示网络相关信息
	-t	TCP协议
	-u	UDP协议
	-l	监听
	-r	路由
	-n	显示ip地址及端口号
	netstat -tlun	#查询本机所有正在监听的网络信息
	netstat -an		#查询本机所有正在监听及正在连接的网络信息、程序
	netstat -rn		#查看本机路由表
setup	#redhat专用，修改系统信息工具，修改完需要重启网络服务

service network restart	#重启网络服务

mount [-t 文件系统] 设备文件名 挂载点	#挂载命令
	插入光盘后， mkdir /mnt/cdrom
	mount -t iso9660(固定) /dev/sr0（固定） /mnt/cdrom	#挂载光盘
umount	/dev/sr0 或者 umount /mnt/cdrom	#卸载硬件
```

##### 8、关机重启命令

```
shutdown [选项] 时间
	-c	取消前一个关机命令
	-h	关机
	-r	重启
	shutdown -h now/20：30	shutdown -r now
logout 	#退出登录
```

## 3、文本编辑器 Vim

##### 1、使用

> vi/vim 	[filename]    #进入或者新建文本文件

| 工作模式 | 进入            |
| :------- | :-------------- |
| 命令模式 | 默认进入，ESC键 |
| 编辑模式 | ：进入编辑模式  |
| 插入模式 | i a o           |

```
插入命令：
	a	在光标所在字符后面插入
	A	在光标所在字符行尾插入
	i	在光标所在字符前插入
	I	在光标所在行首插入
	o	在光标下面插入新行
	O	在光标上面插入新行
定位命令：
	:set nu	设置行号
	:set nonu	取消行号
	gg	到第一行
	G	到最后一行
	nG	到第n行	（n为输入的数字）
	:n	到第n行
	$	到行尾
	0	到行首
删除命令：
	x	删除光标所在处字符
	nx	删除光标所在处后n个字符
	dd	删除所在行
	ndd	删除n行
	dG	删除光标所在行至文件末尾的内容
	D	删除光标所在处到行尾的内容
	:n1,n2d	删除n1至n2所在范围的行
复制粘贴：
	yy	复制当前行
	nyy	复制当前行以下n行
	dd	剪贴当前行
	ndd	剪贴当前行以下n行
	p、P	粘贴在当前光标所在行上或行下
替换命令：
	r	替换光标所在处字符
	R	从光标所在处开始替换，按ESC结束
	u	取消上一步操作
搜索和搜索替换命令：
	/str	搜索指定字符串 str
			搜索时忽略大小写	:set ic
			搜索指定字符串出现的下一个位置	n
	:%s/old/new/g	全文将old替换为new
	:n1,n2s/old/new/g	指定范围将old替换为new
保存及退出命令：
	:w	保存修改
	:w new_filename	另存为指定文件
	:wq	保存并退出
	ZZ	保存并退出
	:q!	不保存强制退出
	:wq!	强制保存及退出（对于没有修改权限的文件，文件所有者及root也可以强制修改）
```

##### 2、高级技巧

```bash
r !命令	#导入命令执行结果
	r /etc/s1.config	#将s1.config的内容导入进来
	
:!which 命令	在vim模式下使用bash命令行（完全单独的操作）
:r !date	将命令执行的结果导入到当前文件中

map [快捷键] [触发命令]	#定义快捷键
	e.g.  :map ^P I#<ESC>	#定义快捷键ctrl+P 调到行首插入#（^P 为 ctrl+V+P 的输入，会变色）
		 :map ^B 0x		#删除行首所在的一个字符

:n1,n2s/^/#/g	 #连续行在行首插入#
:n1,n2s/^#//g	 #连续行把行首的#去掉
:n1,n2s/^/\/\//g	#连续行在行首插入//,\为转义字符

:ab mail mymail@163.com		#替换
		输入mail 空格回车，会替换为mymail@163.com
```

