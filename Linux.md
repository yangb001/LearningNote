# Linux：

以前的一台：  root/yangb001

​						yangb001/123456

## 1、基础信息

##### 1、 centos-7-64： 

​	root/123456

init 3	#切换命令行界面

系统运行级别：	cat  /etc/inittab

| 代号 | 级别                        | 示例                                        |
| ---- | --------------------------- | ------------------------------------------- |
| 0    | 关机                        | init 0：关机                                |
| 1    | 单用户                      | init 1：类型windows安全模式，只启动核心服务 |
| 2    | 不完全多用户，不包含NFS服务 | init 2：不包含网络文件系统的命令行          |
| 3    | 完全多用户                  | init 3：完全命令行                          |
| 4    | 未分配                      |                                             |
| 5    | 图形界面                    | init 5：切换图形界面                        |
| 6    | 重启                        | init 6：重启                                |

备注：centos7下已经不使用runlevel

> ADDING CONFIGURATION HERE WILL HAVE NO EFFECT ON YOUR SYSTEM.
> Ctrl-Alt-Delete is handled by /usr/lib/systemd/system/ctrl-alt-del.target
> systemd uses 'targets' instead of runlevels. By default, there are two main targets:
> 	multi-user.target: analogous to runlevel 3
> 	graphical.target: analogous to runlevel 5
> To view current default target, run:
> 	systemctl get-default
> To set a default target, run:
> 	systemctl set-default TARGET.target

 

```bash
useradd  user1		#新增用户
passwd	user1	#新增密码
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

## 2、常用命令

##### 1、目录处理命令及部分文件处理命令

```bash
ctrl+l  或者 clear 	 #清屏
ctrl+c		# 终止任何一个命令

ls		# 显示当前目录结构
ls	-a 显示隐藏
ls	-l 显示全部详细信息		-h（人性化显示）
	-rwxrwxrwx 1  root root 1205  3月3 08：11 abc.config
	 第一部分 第1字符(-表示文件 d表示目录 l表示软链接文件) 	
    		2-9字符（前3个=所有者=u，中间3个=所属组=g，最后3个=other=o)
    		r读 w写 x执行
     引用次数，所有者，所属组，大小，最后修改时间，文件名
     
ls  -d 显示当前目录本身属性
ls  -i 显示文件inode节点号（一个inode不一定对应一个文件，硬链接文件特殊）
du -sh [文件名] 	#查看文件大小

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

##### 3、权限管理命令

###### 1、更改权限

​		只有root及文件的所有者能修改权限

```bash
chmod 	#修改权限
1.chmod u+w,g-r,o+r /name.config		+表示增加，-表示减少
2.chmod u=rwx,g=rw,o=r  /name.config
3.	对应数字：   r=4,  w=2,	x=1
	chmod 777 /name.config	 # eg:777=rwxrwxrwx,642=rw-r---w-

chmod -R /opt 		# 递归修改目录中的文件权限
```

权限字符说明：

|      | 名称     | 对文件                                 | 对目录                                           |
| ---- | -------- | -------------------------------------- | ------------------------------------------------ |
| r    | 读权限   | 查看文件内容\| cat/more/less/head/tail | 能列出目录中的内容 \| ls                         |
| w    | 写权限   | 修改文件内容 \|vim                     | 能在目录中创建、删除文件 \| touch,rm,mkdir/rmdir |
| x    | 执行权限 | 执行文件 \| script,command             | 能进入目录 \| cd                                 |

###### 2、更改所有者、所属组

​	只有root可以更改所有者及所属组

```bash
chown [用户] [文件或目录]		#改变文件的所有者

groupadd group1				#新增用户组 group1
chgrp [所属组] [文件及目录]		#改变所属组
```

###### 3、创建文件及目录的缺省

​	创建文件时，所有者默认是创建者，所属组是创建者的缺省组。

​							创建的文件默认不存在x执行权限

​	umask 定义了一个目录的缺省权限

```bash
umask -S		#创建文件时的默认权限 u=rwx,g=rx,o=rx
umask 022	#设置默认的权限，异或
			# 777=rwxrwxrwx, 022=----w--w-,异或结果为 rwxr-xr-x=755
			# 所以umask 022 后默认的目录权限是 rwxr-xr-x,文件权限是 rw-r--r--
```

##### 4、文件搜索命令

- find会占用服务器资源，建议少用，

```bash
find [搜索范围] [匹配条件]

匹配条件：
-name 	根据文件名搜索，严格区分大小写
    find / -name name		#全局搜索文件名为 name 的文件，严格区分大小写
    find / -name *name*		#文件名模糊搜索，严格区分大小写
    find / -name ?name???	#?匹配单个字符，严格区分大小写
-iname 	根据文件名搜索，不区分大小写
	find / -iname *name*	#文件名模糊搜索，不区分大小写
-size 根据文件大小搜索，+n 大于，-n小于，n 等于，1数据块=512byte=0.5K，
	find / -size +204800    #在根目录下搜索大于100MB的文件  100MB=102400K=204800数据块
-user 	根据所有者查找
-group	根据所属组查找

-amin	根据访问时间查找 access minitus
-cmin	根据修改文件属性时间查找 change minitus
-mmin	根据修改文件内容时间查找 modify minitus
	find / -cmin -5  #查找5分钟内被修改过属性的文件和目录  +5表示5分钟以前被修改过的
-type  f文件，d目录，l软链接文件 #根据文件类型查找
-inum	根据i节点查找（可以查找硬链接）
	find / -type d
	
条件连接符：
-a 		 and
-o 		 or
	find / -size +102400 -a -size -204800  #查找文件大小在 50MB与100MB之间的文件
-exec/-ok [命令] {} \;	对搜索结果执行操作  {}表示查询结果，-ok会有询问确认
	find / -inum 31351 -exec rm {} \;
```

- locate	从命令维护的文件库中查找，速度快，更新不及时

    ​				/tmp 文件中的文件不收录

```bash
locate -i yangm		# -i 表示  大小写匹配
updatedb	# 更新文件库
```

- which  查找命令所在目录，及命令是否有别名

```bash
which cp
    alias cp='cp -i'
        /bin/cp
```

- whereis cp	查找命令所在位置，命令帮助文档所在位置

- grep    在文件中搜寻字符串匹配的行并输出

    ​	-i 不区分大小写   -v 排除指定字符串

```bash
grep -iv   [指定字串] [文件]
grep -v # /etc/ss.config	#排除掉文件中有#号的行
grep -v ^# /etc/ss.config	#排除掉开头有#号的行 

```

##### 5、文件压缩解压命令

```bash
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

```bash
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

```bash
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

```bash
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
| -------- | --------------- |
| 命令模式 | 默认进入，ESC键 |
| 编辑模式 | ：进入编辑模式  |
| 插入模式 | i a o           |

```bash
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

## 4、软件包管理



##### 2、rpm命令管理

###### 1、rpm手动安装

```bash
安装命令：
rpm -ivh 包全名	i install v verbose(显示详细信息) h hash (显示进度)

卸载命令：
rpm -e 包名

查询命令：
rpm -q [包名] #查询包是否安装
rpm -qa # 查询所有已经安装的rpm包
rpm -qi [包名] #查询软件包的信息	i infomation
rpm -qip [包全名] #查询未安装包的信息
rpm -ql [包名] #查询包中文件的安装位置 l list
rpm -qlp [包全名]	#查询未安装包的即将安装位置
rpm -qf [系统文件名]	#查询系统文件名属于哪个包 f file
rpm -qR [包名]	#查询软件包的依赖性
rpm -qRp [包全名]	#查询未安装软件包的依赖性
e.g. rpm -qf /bin/ls		#查询ls命令属于哪个包

文件校验：
rpm -v [文件]		文件校验

RPM包中文件提取：(可以在误删时最小化恢复)
rpm2cpio [包全名] | cpio -idv .[提取路径]	#从包中的提取路径提取文件 保存在.
	rpm2cpio	#将rpm格式转换为cpio格式
	e.g.： rpm2cpio /mnt/cdrom/packages/coreutils-8.22-23.el7.x86_64 | cpio -idv ./bin/ls
	

```

###### 2、rpm管理-yum在线安装

- Ip地址配置和网络yum源

```bash
进入网络配置界面：
setup	
nmtui	#centos 7下
	配置网络ip及网关等信息
	vi /etc/sysconfig/network-scripts/ifcfg-eth0
		把ONBOOT='no'改为yes ，表示开机启动网卡
	service network restart		#重启网络服务
	
yum所在位置：
/etc/yum.repos.d/
cat CentOS-Base.repo	#默认使用的网络yum源
	[base]		#容器名称
	name	#说明

```

- yum命令（服务区安装规则，最小化安装，尽量不卸载，或不使用yum卸载）

```bash
yum list #查询服务器上可用的软件列表
yum search [名称]	#查询包
yum -y install [包名]	#安装包  -y 自动回答yes
yum -y update [包名]	#升级安装包（不加包名时会升级包括内核在内的包，很有可能会出问题）
yum -y remove [包名]	#卸载

yum grouplist	#软件包组
yum groupinstall [包组名]	#安装软件包
yum groupremove [包组名]	#卸载包组

```

- yum光盘安装

```bash
挂载光盘：
	参照前面
使网络yum源失效：
	修改yum文件名称/在yum文件中添加 enabled=0   mv CentOS-Base.repo CentOS-Base.repo.bak
修改光盘yum源文件： CentOS-Media.repo
	enabled=1	#使之生效
	

```

##### 3、源码包与rpm包区别

rpm包安装在默认位置中

| 默认路径        | 说明                       |
| --------------- | -------------------------- |
| /etc/           | 配置文件                   |
| /usr/bin/       | 可执行的命令安装目录       |
| /usr/lib/       | 程序所使用的函数库所在位置 |
| /usr/share/doc/ | 基本的软件使用手册         |
| /usr/share/man/ | 帮助文件保存位置           |

rpm包安装后可以使用系统服务管理命令

```bash
/etc/rc.d/init.d/httpd start

service httpd start

```

##### 4、源码包安装与卸载

```bash
#软件配置与检查
./configure
#定义需要的功能选项，检测系统环境是否符合，把定义好的选项和环境信息 写入Makefile文件，用于后续编辑

e.g ./configure --prefix=/opt/s1		#定义安装位置

make	#编译(此时不会往安装路径下写信息，即不会安装)
	make clean #清空编译产生的临时文件
make install	#编译安装

rm -rf /opt/s1		#卸载

```

## 5、用户和用户组管理

### 1、用户配置文件

#### 1、用户信息文件/etc/passwd

- 第一字段： 用户名称

- 第二字段： 密码标志

- 第三字段： UID（用户ID）

    ​	0： 超级用户

    ​    1-499： 系统用户（伪用户）

    ​    500-65535： 普通用户

name:password:UID:GID:GECOS:directory:shell

#### 2、用户密码文件/etc/shadow

#### 3、组信息文件/etc/group

#### 4、组密码文件/etc/gshadow

#### 5、邮件目录	/var/spool/mail/user1

#### 6、初始模板文件



### 2、用户操作 

```bash
#用户操作
useradd	修改
usermod
userdel

su - use1 	#切换到user1用户，- 表示连环境一起切换
env	#可以查看用户所在的环境信息

```



## 6、权限管理

### 1、ACL权限

```bash
#查看分区ACL权限是否开启
dumpe2fs -h /dev/sda3  -h 仅显示超级块信息而不显示磁盘块组的详细信息
#临时开启分区ACL权限
mount -o remount,acl /	# -o,支持特殊挂载选项

#永久开启分区ACL
vi /etc/fstab		#系统开机自动挂载文件
mount -o remount /	#重新挂载使修改生效

getfacl	[文件或目录]	#查看文件或目录acl权限
setfacl [文件或目录]	#设置acl

#最大有效权限
mask	#制定最大有效权限，需要与赋予的权限“相与”之后才是真正用户得到的权限
setfacl -m m:rwx [文件名]	#修改最大有效权限

#删除acl权限
setfacl -x u：用户名/组名 [文件名]	

#递归acl权限与默认acl权限

```

### 2、文件特殊权限

```bash
setuid
	# 只有二进制程序才能设定suid权限
	# 命令的执行者要对该程序拥有x权限
	# 执行该程序时会获得该文件属主的身份
	# 身份改变只有在程序执行过程中有效
ll /usr/bin/passwd
chmod 4755 passwd	设置
chmod u+s passwd

setgid
	# 针对文件：
	# 只有二进制程序才能设定sgid权限
	# 命令的执行者要对该程序拥有x权限
	# 执行该程序时，组身份会升级为所属组
	# 身份改变只有在程序执行过程中有效
	# 针对目录：
	# 普通用户必须对此目录拥有rw权限
	# 普通用户在此目录中的有效组会变成此目录的所属组
	# 在此目录下新建的文件都会为此目录所属组
	
ll /usr/bin/locate
ll /var/lib/mlocate/mlocate.db
chmod 2755 abc	设置
	
sticky bit
	# 只针对目录
	# 普通用户对此目录拥有wx权限
	# 普通用户只能删除此目录下的自己建立的文件，就算拥有w权限也不能随意删除文件
chmod 1755 /abc


```

### 3、chattr 权限  文件系统属性权限

```bash
chattr [+-=] [选项] [文件或目录]	
	i	对文件设置i选项，不允许对文件进行删除和改名，添加和修改数据；对目录设置i，执行修改目录下的文件的内容，不允许删除和新建文件
	a	对文件设置a选项，只能在文件中追加数据；对目录设置，只能在目录中新建和修改文件
	
lsattr	[选项] [文件名]
	-a 	显示所有文件和目录
	-d	显示目录本身属性

touch abc
chattr +i abc	#增加i选项
lsattr abc	#查看attr权限


```

### 4、sudo权限

> root把本来只能超级用户执行的命令赋予普通用户执行
>
> sudo操作的对象是系统命令

```bash
visudo	#实际修改的是/etc/sudoers文件
root    ALL=(ALL)       ALL
#用户名 被管理主机的地址=（可使用的身份） 授权命令（绝对命令）
%wheel    ALL=(ALL)       ALL
#组名 被管理主机的地址=（可使用的身份） 授权命令（绝对命令）

#添加
user1 ALL= /sbin/shutdown -r now

su - user1

sudo -l #查看超级用户给user1赋予了哪些命令
sudo /sbin/shutdown -r now	#执行

man visudo	#查看visudo的帮助
man 5 viduso #查看 visudo操作的配置文件的帮助信息

```



## 7、文件系统管理

### 2、文件系统常用命令

#### 1、常用查询命令

```bash
#	文件系统查看命令
df [选项] [挂载点]	
	-a 显示所有文件系统信息
	-h	人性化显示文件容量
	-T	显示文件系统类型
	
# 统计目录或文件夹大小(会扫描文件系统，占用资源比较高)
du [选项] [文件名或目录]
	-a	显示所有文件，不仅仅是目录
	-h	人性化
	-s	只显示总和
	
df命令与du命令的区别：
	df是从文件系统考虑，不光考虑文件占用空间，还统计被命令或程序占用的空间（最常见的是已经被删除但程序并没有释放空间）
	du从文件考虑，只会计算文件及目录的大小
	
# 文件系统修复命令
fsck [选项] [分区设备文件名]
	
# 显示磁盘状态命令 dump ext2/ext3/ext4 filesystem information
dumpe2fs

```

#### 2、挂载命令

```bash
# 查询与自动挂载
mount [-l]	#查询系统中已挂载的设备，-l会显示卷标名称

mount -a	#依据配置文件 /etc/fstab 的内容，自动挂载

# 挂载
mount [-t 文件系统] [-L 卷标名] [-o 特殊选项] [设备文件名] [挂载点]
	-t 文件系统：加入文件系统类型来指定挂载的类型
	-L 卷标名： 挂载指定的卷标的分区，而不是安装设备的文件名
	
-o 特殊选项举例：
	exec/noexec	设定是否允许文件系统中执行可执行文件，默认允许
	remount	重新挂载
	rw/ro	读写/只读
```

```bash
cd /tmp
touch hello.sh
vi hello.sh
---
!# /bin/bash
echo "hello world!"
---
chmod 755 hello.sh
./hello.sh	
/tmp/hello.sh

mv hello.sh /home
mount -o remount,noexec /home
./hello.sh	#此时由于文件系统不允许，无法执行脚步
```

#### 3、挂载u盘与光盘

```bash
# 在虚拟机中链接光盘 
mount /dev/cdrom /media		#光盘默认为 /dev/cdrom 或 /dev/sr0

# 卸载命令
umount [挂载点]/[设备文件名]
umount	/media

# 挂载u盘（在虚拟机中挂载，鼠标在虚拟机中时插入u盘，虚拟机才会识别u盘）
fdisk -l	查询u盘设备号
mkdir /mnt/usb
mount -t vfat /dev/sdb1 /mnt/usb
	ps： linux默认不支持NTFS文件系统
```

