#### 1、虚拟机信息

```bash
cat /proc/version
	#Linux version 3.10.0-327.62.59.83.h108.x86_64 (abuild@buildhost) (gcc version 4.8.5 20150623 (EulerOS 4.8.5-4) (GCC) ) #1 SMP Mon Jan 1 00:00:00 UTC 		#2018

fdisk -l		#需要将 /dev/vdb挂载在 /opt 目录下， /dev/vdb需要在100g以上方便后期数据存放
	#Disk /dev/vdb: 161.1 GB, 161061273600 bytes, 314572800 sectors
    #Units = sectors of 1 * 512 = 512 bytes
    #Sector size (logical/physical): 512 bytes / 512 bytes
    #I/O size (minimum/optimal): 512 bytes / 512 bytes
```

#### 2、挂载硬盘

```bash
mkdir /opt
sudo mkfs.ext4 /dev/vdb		#格式化硬盘
mount -r /dev/vdb /opt		#挂载
mount -o remount,rw /dev/vdb		#刷新重新挂载
echo "/dev/vdb /opt  ext4 defaults 1 1" >> /etc/fstab   # 写入文件自动启动挂载
df -H		#查看是否挂载成功
```

#### 3、配置网关，设置DNS

```bash
# 设置网关
vi /etc/sysconfig/network 
	GATEWAY=192.168.0.2			#将其中的GATEWAY设置为 192.168.0.2
	
#设置dns指向文件  域名服务器
vi /etc/resolv.conf
	#在文件中添加
	nameserver 10.189.32.59
	nameserver 10.72.55.103
	nameserver 10.98.48.39
```

#### 4、设置EulerOS镜像源

位置：/etc/yum.repos.d/

```bash
"cat EulerOS.repo
[base]
name=Euler-2.0SP3 base
baseurl=http://cmc-cd-mirror.rnd.huawei.com/euleros/2.3/os/x86-64/
enabled=1
gpgcheck=1
gpgkey=http://cmc-cd-mirror.rnd.huawei.com/euleros/2.3/os/RPM-GPG-KEY-EulerOS"
```

#### 5、配置docker及安装st2

```bash
yum list|grep docker	

#安装yum出来的这3个文件
yum -y install docker-compose.noarch
yum -y install docker-engine.x86_64
yum -y install docker-engine-selinux.noarch

#粘贴复制以下命令，规避一下docker的 BUG
#set the system linux nmap value from default value of 65535 to 262144
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf		#安装ElasticSearch会太小
awk '!a[$0]++' /etc/sysctl.conf > /etc/sysctl.conf_new	#去除文本中重复的行，https://www.jianshu.com/p/84074efd7199
mv /etc/sysctl.conf_new /etc/sysctl.conf

#或者参考：http://www.fecshop.com/topic/1172
#awk 去重	awk '!a[$0]++ {print $0}'

#创建路径
mkdir -p /etc/systemd/system/docker.service.d

`sudo docker info|grep "Docker Root Dir"		#查看docker的默认存放位置`
`修改docker默认存储的位置：
`在/etc/systemd/system/docker.service.d 目录下创建一个Drop-In文件“docker.conf”，默认 docker.service.d 文件夹不存在。所以你必须先创建它。
`创建Drop-In 文件的原因，是我们希望Docker 服务，使用docker.conf文件中提到的特定参数，将默认服务所使用的位于/lib/systemd/system/docker.service文件中的参数进行覆盖。如果你想深入了解Drop-In，请阅读system.unit文档
`定义新的存储位置现在打开docker.conf增加如下内容：
`# sudo vi /etc/systemd/system/docker.service.d/docker.conf
`[Service]
`ExecStart=
`ExecStart=/usr/bin/dockerd --graph="/mnt/new_volume" --storage-driver=devicemapper
`保存并退出VI编辑器，/mnt/new_volume 是新的存储位置，而devicemapper是当前docker所使用的存储驱动。如果你的存储驱动有所不同，请输入之前第一步查看并记下的值。Docker官方文档中提供了更多有关各种存储驱动器的信息。现在，你可以重新加载服务守护程序，并启动Docker服务了。这将改变新的镜像和容器的存储位置。
`# sudo systemctl daemon-reload
`# sudo systemctl start docker


#复制粘贴
mkdir -p /opt/docker/root
touch /etc/systemd/system/docker.service.d/docker.root.conf
echo [Service] > /etc/systemd/system/docker.service.d/docker.root.conf
echo ExecStart= >> /etc/systemd/system/docker.service.d/docker.root.conf
echo 'ExecStart=/usr/bin/dockerd --data-root /opt/docker/root' >> /etc/systemd/system/docker.service.d/docker.root.conf
systemctl daemon-reload
systemctl restart docker

#设置docker代理(将其中的username与password修改成自己的)
cd /etc/systemd/system/docker.service.d/
echo '[Service]' > http-proxy.conf
echo 'Environment="HTTP_PROXY=http://username:password@proxyhk.huawei.com:8080"' >> http-proxy.conf
echo '[Service]' > https-proxy.conf
echo 'Environment="HTTPS_PROXY=http://username:password@proxyhk.huawei.com:8080"' >> https-proxy.conf
systemctl daemon-reload
systemctl restart docker

mkdir /root/artifact		#创建目录
#复制  node-v8.12.0-linux-x64.tar.gz，st2-docker-3.0.1.tar.gz 至其中
tar -xzvf node-v8.12.0-linux-x64.tar.gz		#解压
tar -xzvf st2-docker-3.0.1.tar.gz

docker volume ls
	#将list出来的删掉		docker volume rm xxx
docker image ls
	#将list出来的删掉		docker image rm xxx
`volume 能让容器从宿主主机中读取文件或持久化数据到宿主主机内，让容器与容器产生的数据分离开来,即使容器删除了，volume也会被保留下来 
  
#修改 docker-compose.yml 文件
vi /root/artifact/st2-docker-3.0.1/docker-compose.yml
	#修改：
    version: '2'		#version改为2

    services:
      stackstorm:
        image: stackstorm/stackstorm:3.0.1		#此处改为3.0.1
        
#配置路由
ip route add unicast 172.18.32.221/32 via 192.168.0.2			#
        
#执行安装
cd /root/artifact/st2-docker-3.0.1
docker-compose up -d
```

- 错误解决

  1.执行docker-compose up -d 时报错

```
ERROR: Couldn't find env file: /root/artifact/st2-docker-3.0.1/conf/stackstorm.env
```

```
解决：再多执行一遍看/root/artifact/st2-docker-3.0.1/conf/stackstorm.env存在不

2.执行docker-compose up -d 时报错
```

```
ERROR: Get https://registry-1.docker.io/v2/: proxyconnect tcp: dial tcp 172.18.32.221:8080: getsockopt: no route to host
```

```
 解决： 按照倒数第二步配置一下路由
```

#### 6、webUI登陆st2

安装成功后访问地址

```
https://ip
```

用户名和密码在 /root/artifact/st2-docker-3.0.1/conf/stackstorm.env 中有

#### 7、使用（命令行）

##### 1、环境相关

- **进入docker**

```bash
docker ps -l 		#查找st2所在容器id
docker exec -it 4fcd9d851ee9 sh		# 4fcd9d851ee9 docker容器
docker exec -it 4fcd9d851ee9 bash	# 4fcd9d851ee9 docker容器
```

- **docker停止与启动**

```bash
docker start 4fcd9d851ee9	# 启动
docker stop 4fcd9d851ee9	# 停止
```

- 拷贝文件及赋权**

```bash
docker cp /opt/firstaction2 4fcd9d851ee9:/opt		#将宿主机文件拷贝到docker的4fcd9d851ee9容器中
chmod u+x test.py		#增加执行权限
./test.py		#执行python命令
```

- **st2信息查看**

```bash
st2 --version 		#查看st2版本
st2 -h 				#获取帮助
```

- **登陆st2**

```bash
st2 login username -p 'password' #登陆st2，用户名和密码在 /root/artifact/st2-docker-3.0.1/conf/stackstorm.env 中
st2 login username --password '*******'
		eg：st2 login st2admin -p 'wPoTtuNf'
		
#信息查看（必须登录）
st2 action list		#展示所有的action
st2 action list --pack=core				# List the actions from the 'core' pack
st2 trigger list					# List triggers
st2 rule list						# List rules

st2 execution list			# See the execution results，查看历史执行结果
st2 execution list -n 5		#只显示5条
st2 execution get <execution_id>		# Get execution by ID
```

- **配置及重启st2**

```bash
#配置文件路径(若安装在docker中，则在docker中的此路径下)
/etc/st2/st2.conf

#重启
sudo st2ctl restart

#重新加载所有文件
st2ctl reload --register-all
```

##### 停止服务

- Ubuntu系统：

  ```
  sudo st2ctl stop
  sudo service nginx stop
  sudo service postgresql stop
  sudo service mongod stop
  sudo service rabbitmq-server stop
  
  ```

- RHEL / CentOS 6.x：

  ```
  sudo st2ctl stop
  sudo service nginx stop
  sudo service postgresql-9.4 stop
  sudo service mongod stop
  
  ```

- RHEL / CentOS 7.x：

  ```
  sudo st2ctl stop
  sudo systemctl stop nginx
  sudo systemctl stop postgresql
  sudo systemctl stop mongod
  sudo systemctl stop rabbitmq-server
  
  ```

##### 2、st2 packs管理

```yaml
#目录结构如下（对应文件必须放在对应的包中，否则 st2ctl reload 时会报错，导致文件加载不了）
packs/
    actions/
    	workflows/
    rules/                   #
    sensors/                 #
    aliases/                 #
    policies/                #
    tests/                   #
    etc/                     # any additional things (e.g code generators, scripts...)
    config.schema.yaml       # configuration schema
    packname.yaml.example    # example of config, used in CI
    pack.yaml                # pack definition file
    requirements.txt         # requirements for Python packs
    requirements-tests.txt   # requirements for python tests
    icon.png    

```

相关配置文件及操作如下：

```bash
st2 pack list	#查看所有包

#创建pack目录结构及文件		 https://docs.stackstorm.com/reference/packs.html
mkdir /opt/stackstorm/packs/tests
cd /opt/stackstorm/packs/tests
mkdir actions rules sensors aliases policies 

#包配置文件，描述文件夹将其标识未包
touch pack.yaml
+-------------------------------
    ---
    name: tests
    description: tests pack
    keywords:
    version: 3.0.0
    author: Tests, Inc.
    email: tests@tests.com
+--------------------------------

#定义包使用的配置元素的模式
touch requirements.txt
+--------------------------------
	requests
    beautifulsoup4
    flask
+--------------------------------

#包含Python依赖项列表的文件，如果您需要任何特定的Python库，请在此处指定它们，它们将在包安装时自动安装
touch config.schema.yaml
+-----------------------------------------------
	---
	api_key:
      description: "API key"
      type: "string"
      secret: true
      required: true
    api_secret:
      description: "API secret"
      type: "string"
      secret: true
      required: true
    region:
      description: "API region to use"
      type: "string"
      required: true
      default: "us-east-1"
    private_key_path:
      description: "Path to the private key file to use"
      type: "string"
      required: false
+--------------------------------------------------

#重新加载st2信息，会将包加载进去
st2ctl reload

```

##### 3、st2 actions管理

- **创建并注册actions**

> actions  位于  /opt/stackstorm/packs
>
> actions一般包含两个部分： metadata-file,   script
>
> ```
> metadata-file一般为yaml文件
> 
> script可以是python或者 shell 文件
> 
> ```

```bash
#加载单个action
st2 action create my_action_metadata.yaml
#删除
st2 action delete default.test

#reload all action，加载所有actions
st2ctl reload --register-actions

#加载所有文件 actions,rules,targgers...
st2ctl reload --register-all

```

- 查看action需要的参数

```bash
st2 run examples.test1 -h

```

- **命令行执行action**

```bash
# If you want to add a trace tag to execution when you run it, you can use:
st2 run examples.test1 key=thisisakey  --trace-tag="simple-date-check-`date +%s`"

```

- **使用注意**

> #### For core.local and core.remote actions, we use -- to separate action parameters to ensure that options keys
>
> ###### Using `--` to separate arguments,      使用--区分命令
>
> ```bash
> st2 run core.local -- ls -al
> 
> ```
>
> ###### Equivalent using `cmd` parameter，	使用cmd区分
>
> ```bash
> st2 run core.local cmd="ls -al"
> 
> ```
>
> #### Variables are escaped using a backslash (\) - e.g. \$user，使用\转义 变量参数
>
> ```bash
> # Crazily complex command passed with `cmd`
> st2 run core.remote hosts='localhost' cmd="for u in bob phill luke; do echo \"Logins by \$u per day:\"; grep \$u /var/log/secure | grep opened | awk '{print \$1 \"-\" \$2}' | uniq -c | sort; done;"
> 
> ```

##### 4、st2 orquesta工作流

<https://docs.stackstorm.com/orquesta/context.html>

<https://docs.stackstorm.com/orquesta/languages/orquesta.html>

###### 1、orquesta注册文件

/tests/actions/task.yaml

```yaml
---
name: registertask
pack: tests
description: register a task
#orquesta 标注为一个orquesta 工作流
runner_type: orquesta

#指定task文件
entry_point: workflows/task.yaml
enabled: true
parameters:
 filename:
  type: string
  required: true
 script:
  type: string
  required: true

```

###### 2、orquesta-task文件：

  /tests/actions/workflows/task.yaml

```yaml
version: 1.0
description: 通过ctx的action间参数传递，聚合模式，循环遍历list参数，when条件判断,失败及无操作状态，<% %>是YAQL表达式，{{ xxx }} 是Jinja表达式

#输入参数
input:
 - messages		#输入的是一个list类型
 - hosts		#输入的是一个list类型
 - a: 0
 - b: 0
 - c: 0
 - x
 - y: <% ctx(x) %>
 - z: <% ctx(y) %>	#变量分配有顺序，可以立即使用
 - dynamic_action	#动态输入action名称
 - data
 - dynamic_input	#动态参数
 - task1out
 - task2out
 - path
 - filename

#设置变量（要注意变量名重叠时的覆盖，也可以不设置此vars）
# 此变量为键值对形式 ：）
# A list of key value pairs.
vars:
  - ab: 0
  - cd: 0
  - abcd: 0

#工作流
tasks:
  setup_task:
    #从ctx中获取messages，循环以 {"message": "value"} 格式存入item中，  <% ctx().foobar %>
    with: message in <% ctx(messages) %>
    action: core.echo message=<% item(message) %>
    next:
      - do:
          - parallel_task_1
          - parallel_task_2
          - parallel_task_3

  parallel_task_1:
    #多个列表时需要用zip压缩成各自的item
    with: message,host in <% zip(ctx(messages),ctx(hosts)) %>
    action: core.remote host=<% item(host) %> message=<% item(message) %>
    next:
      - do:
          - barrier_task

  parallel_task_2:
    ##1.第一种调用参数方式
        #action: math.add operand1=<% ctx(a) %> operand2=<% ctx(b) %>
        #input:
        #  operand1: <% ctx(a) %>
        #  operand2: <% ctx().b %>
    #2.第二种调用参数方式
    action: math.add operand1=<% ctx(a) %> operand2=<% ctx(b) %>
    next:
      - when: <% succeeded() %>
      	publish: ab=<% result() %>
      	do:
          - intermediate_task

  intermediate_task:
     action: tests.createfile filename=<% ctx(filename) %>
      next:
       - when: <% succeeded() %>
       	 # 将执行结果发布到 变量 task1out
         publish: msg=<% result() %>,path=<% result().stdout %>,task1out=<% result() %>
         do:
          - barrier_task
       - when: <% failed() %>
         publish: msg="createfile failure",task1out=<% result() %>

  barrier_task:
    #为并行分支设置屏障。类似 聚合模式，单例模式，如果不加的话会创建多个此task
    join: all
    action: math.add operand1=<% ctx(ab) %> operand2=<% ctx(c) %>
    next:
     #如果成功
     - when: <% succeeded() %>
       publish: msg="success add"
       do: parallel_task_3
     #如果失败
     - when: <% failed() %>
       publish: msg="failed add"
       do: intermediate_task

  parallel_task_3:
    # ...
    # Run immediately after setup_task, do NOT wait for barrier_task
    action: core.log message=<% ctx(msg) %>
    next:
      # The fail specified here tells the workflow to go into
      # failed state on completion of the notify_on_error task.
      - do: fail	# 进入失败状态
      - do: noop	# 什么都不执行 No operation or do not execute anything else
  dynamic_task:
    action: "{{ ctx().dynamic_action }}"
    input:
      x: "{{ ctx().data }}"
    #input: "{{ ctx().dynamic_input }}"  	动态参数的输入格式：
    			#st2 run default.dynamic_workflow dynamic_action='core.local' dynamic_input='{"cmd": "date"}'
 
#输出
output:
 #调用已经发布的变量组成输出
 - result: <% ctx().msg %>
 - task1: <% ctx(task1out) %>
 - task2: <% ctx(task2out) %>

```

- 没有前节点的都算工作流起点



- task文件中更多参数格式相关使用请访问：

  <https://docs.stackstorm.com/orquesta/languages/orquesta.html>

- action执行结果格式：

```json
{
  "output": {
    "result": {
      "succeeded": true,
      "failed": false,
      "return_code": 0,
      "stderr": "",
      "stdout": "/opt/stackstorm/packs/tests/actions/s.sh"
    }
  }
}
获取方式：
<% succeeded() %>
<% result().succeeded %>
<% result().stdout %>

```

- 备注：

> 在具有并行分支的工作流中，上下文字典的范围限定为每个分支，并在分支与join连接时合并。 因此，假设在工作流输入或变量中定义了变量，并且工作流执行分为多个分支。 如果每个分支的任务发布到同一个变量，则更改不是全局的，只会发送到本地分支。 因此，对于每个分支，变量将从分配时获得新值。 当两个分支汇合时，这些分支的本地上下文字典也将合并。 对于上下文字典之间具有相同名称的变量，最后写入的分支将覆盖合并的上下文字典中的值。

- YAQl

```bash
#类似于map
<% dict(a=>123, b=>true) %>		在ctx中的存储结构：	{'dict1'：{'a': 123, 'b': True}}
	#获取：	<% ctx(dict1).keys() %>		['a', 'b']
			  <% ctx(dict1).values() %>		[123, true]
<% dict(a=>123, b=>true) + dict(c=>xyz) %>	  {'dict1'：{'a': 123, 'b': True, 'c': 'xyz'}}

<% ctx(dict1).get(b) %>  设置默认值 <% ctx(dict1).get(b, false) %>	#如果b不存在，会返回false

#类似于list
<% list(1, 2, 3) %> 	returns 	[1, 2, 3]
	#获取：	<% ctx(list)[0] %>   1

#类型转换
`int(value)`  converts value to integer

```

更多yaql使用方法： https://docs.stackstorm.com/orquesta/yaql.html

###### 3、工作流注册、暂停取消

注册工作流:

```bash
#单个注册
st2 action create /opt/stackstorm/packs/examples/actions/task.yaml

#全部注册
st2ctl reload --register-actions

```

暂停工作流:

```st2 execution pause <execution-id>```

恢复工作流:

`st2 execution resume <execution-id>	`

> 暂停和恢复操作将级联到子工作流程。 Orquesta允许对具有多个分支的工作流程进行更精细的控制。 如果从子工作流请求暂停操作，则暂停将不会级联到父工作流并向下到其他对等方。 这支持用户希望仅暂停特定分支但继续工作流的其余部分的用例。 从子工作流程恢复时，此行为相同

取消工作流:

`st2 execution cancel <execution-id>`

> 可以通过运行st2 execution cancel <execution-id>来取消工作流程执行。 仍在运行的工作流任务将允许运行完成。 在取消期间，不会安排工作流程的新任务。 执行将保持取消状态，直到没有更多活动任务

re-running工作流:

`st2 execution re-run <execution-id>` 

> 失败的工作流重新执行一次工作流，会重新有一个新的id

###### 4、动态传递action及参数

动态action：

```yaml
version: 1.0
input:
  - dynamic_action
  - data
tasks:
  task1:
    action: "{{ ctx().dynamic_action }}"
    input:
      x: "{{ ctx().data }}"

```

```yaml
version: 1.0
input:
  - dynamic_action
  - dynamic_input

tasks:
  task1:
    action: "{{ ctx().dynamic_action }}"
    input: "{{ ctx().dynamic_input }}"

```

访问：

```bash
st2 run default.dynamic_workflow dynamic_action='core.local' dynamic_input='{"cmd": "date"}'

```



##### 5、web访问接口

###### 1、**通用接口调用**

可以直接调用StackStrom提供的通用Webhook接口，名称叫st2，URL是http://{$ST2_IP}/api/v1/webhooks/st2。通过调用通用Webhook就可以直接利用已有的Rule，不需要单独创建Rule

```bash
$ curl -X POST  http://127.0.0.1:9101/v1/webhooks/st2 -H  'St2-Api-Key: OTU0MjBiZDYxYjE2YmJiOTRiOGFiNGNjOTdjZjRmZWI1ZjkwNzJjYWY4YmE5ZTM4YmUzZTY3MjRmNDcwZGRkYQ' -H "Content-Type: application/json" --data '{"trigger": "mypack.mytrigger", "payload": {"attribute1": "value1"}}'

```

- **远程执行命令**

1. 使用token（token会过期）

```bash
#获取token
curl -k -X POST -u 'st2admin:wPoTtuNf' https://192.168.0.208/auth/v1/tokens

{
    "service": false,
    "expiry": "2019-07-20T07:39:53.690556Z",
    "token": "e3c7351f4f4244b4bde71bb7917d3010",
    "user": "st2admin",
    "id": "5d3173c952ef89036d08bff6",
    "metadata": {}
}

#远程调用webhook	# Post to the webhook
curl -k https://192.168.0.208/api/v1/webhooks/sample -d '{"foo": "bar", "name": "st2"}' -H 'Content-Type: application/json' -H 'X-Auth-Token: e3c7351f4f4244b4bde71bb7917d3010'

# Check if the action was executed (this shows the last action)
st2 execution list -n 1

# Check that the rule worked. By default, st2 runs as the stanley user.
sudo tail /home/stanley/st2.webhook_sample.out
# And for fun, same post with st2
st2 run core.http method=POST body='{"you": "too", "name": "st2"}' url=https://localhost/api/v1/webhooks/sample headers='x-auth-token=put_token_here,content-type=application/json' verify_ssl_cert=False
# And for even more fun, using basic authentication over https
st2 run core.http url=https://httpbin.org/basic-auth/st2/pwd username=st2 password=pwd
# Check that the rule worked. By default, st2 runs as the stanley user.
sudo tail /home/stanley/st2.webhook_sample.out

```

2. 使用apiKey（apiKey不会过期）

```bash
#创建api-key
st2 apikey create -k -m '{"st2admin":"wPoTtuNf"}'
OTU0MjBiZDYxYjE2YmJiOTRiOGFiNGNjOTdjZjRmZWI1ZjkwNzJjYWY4YmE5ZTM4YmUzZTY3MjRmNDcwZGRkYQ

#post to the webhook
curl -k https://192.168.0.208/api/v1/webhooks/sample -d '{"foo": "bar", "name": "st2"}' -H 'Content-Type: application/json' -H "St2-Api-Key: OTU0MjBiZDYxYjE2YmJiOTRiOGFiNGNjOTdjZjRmZWI1ZjkwNzJjYWY4YmE5ZTM4YmUzZTY3MjRmNDcwZGRkYQ"

```

###### 2、自定义rule接口

StackStorm提了一个Triggercore.st2.webhook用于注册Webhook

- 注册

/opt/stackstorm/packs/examples/rules/sample_rule_with_webhook.yaml

```bash
---
name: "sample_rule_with_webhook"
pack: "examples"
description: "Sample rule dumping webhook payload to a file."
enabled: true
trigger:
    type: "core.st2.webhook"
    parameters:
        url: "sample"			#此处定义访问路径:  http://{$ST2_IP}/api/v1/webhooks/sample
criteria:
    trigger.body.name:
        pattern: "st2"
        type: "equals"
action:
    ref: "core.local"
    parameters:
        #cmd: "echo \"{{trigger.body}}\" >> ~/st2.webhook_sample.out ; sync"
        filename: "{{ trigger.body.filename }}"
  		script: "{{ trigger.body.script }}"

```

注册rule：

```bash
 st2 rule create orquesta-test1-webhook.yaml

```

删除rule:

```bash
st2 rule delete examples.orquesta-test1-webhook

```

访问及参数：

https://192.168.0.208/api/v1/webhooks/sample

```bahs
Content-Type : application/json
St2-Api-Key : OTY1ZWRlMjQzY2YxMTI3MWZmNDU2ODY2ZDYyM2QyOGMzNTYyOWVlZmVkY2JkYWViZTQ3ODUzNjZhYTQ2Y2JkNw

```

```bash
{"filename": "bar", "script": "st2"}

```

e.g:

https://192.168.0.208/api/v1/webhooks/osquesta

```js
Content-Type : application/json
St2-Api-Key : OTY1ZWRlMjQzY2YxMTI3MWZmNDU2ODY2ZDYyM2QyOGMzNTYyOWVlZmVkY2JkYWViZTQ3ODUzNjZhYTQ2Y2JkNw


```

```bash
cmd:
	chmod o+w /opt/stackstorm/packs/examples/actions;
	touch /opt/stackstorm/packs/examples/actions/test1.sh;
	chmod o+wx 	/opt/stackstorm/packs/examples/actions/test1.sh
script:
    echo -e '#! /usr/bin/env bash
    date '+%Y%m%d'
    a=1
    b=2
    sum=$[$a+$b]
    echo "sum is $sum"'> /opt/stackstorm/packs/examples/actions/test1.sh			# 用单引号包含，双引号出错,用>表示覆盖文件，>>表示追加文件末尾，换行用\n
 
例如：
{"cmd": "chmod o+w /opt/stackstorm/packs/examples/actions;touch /opt/stackstorm/packs/examples/actions/test1.sh;chmod o+wx /opt/stackstorm/packs/examples/actions/test1.sh","script":"echo -e '#! /usr/bin/env bash \n date '+%Y%m%d' \n a=1 \n b=2 \n sum=$[$a+$b] \n echo \"sum is $sum\"'> /opt/stackstorm/packs/examples/actions/test1.sh"}

```

##### 6、获取执行结果接口

查询所有父类节点的接口： 

parent = null

<https://192.168.0.208/api/v1/executions?parent=null&limit=50&offset=0&include_attributes=id,status,start_timestamp,action.ref,action.name,action.runner_type,action.parameters,parameters,rule.ref,trigger.type,context.user>

```json
{
        "status": "succeeded",		#状态
        "start_timestamp": "2019-07-25T06:53:35.485141Z",		#开始时间
        "log": [
            {
                "status": "requested",
                "timestamp": "2019-07-25T06:53:35.000000Z"
            },
            {
                "status": "scheduled",
                "timestamp": "2019-07-25T06:53:35.000000Z"
            },
            {
                "status": "running",
                "timestamp": "2019-07-25T06:53:35.000000Z"
            },
            {
                "status": "succeeded",
                "timestamp": "2019-07-25T06:53:41.000000Z"
            }
        ],
        "parameters": {
            "filename": "test.sh",
            "script": "#! /usr/bin/env bash \ndate '+%Y%m%d' \na=1 \nb=2 \nsum=$[$a+$b] \necho \"sum is $sum\""
        },
        "trigger_type": {
            "description": "Trigger type for registering webhooks that can consume arbitrary payload.",
            "tags": [],
            "parameters_schema": {
                "additionalProperties": false,
                "type": "object",
                "properties": {
                    "url": {
                        "required": true,
                        "type": "string"
                    }
                }
            },
            "name": "st2.webhook",
            "payload_schema": {
                "type": "object",
                "properties": {
                    "body": {
                        "anyOf": [
                            {
                                "type": "array"
                            },
                            {
                                "type": "object"
                            }
                        ]
                    },
                    "headers": {
                        "type": "object"
                    }
                }
            },
            "pack": "core",
            "ref": "core.st2.webhook",
            "id": "5d2d24c552ef890105e6857e",
            "uid": "trigger_type:core:st2.webhook"
        },
        "runner": {
            "runner_module": "orquesta_runner",
            "uid": "runner_type:orquesta",
            "runner_package": "orquesta_runner",
            "description": "A runner for executing orquesta workflow.",
            "enabled": true,
            "output_key": "output",
            "output_schema": {
                "output": {
                    "anyOf": [
                        {
                            "type": "object"
                        },
                        {
                            "type": "string"
                        },
                        {
                            "type": "integer"
                        },
                        {
                            "type": "number"
                        },
                        {
                            "type": "boolean"
                        },
                        {
                            "type": "array"
                        },
                        {
                            "type": "null"
                        }
                    ]
                },
                "errors": {
                    "anyOf": [
                        {
                            "type": "object"
                        },
                        {
                            "type": "array"
                        }
                    ]
                }
            },
            "runner_parameters": {
                "notify": {
                    "uniqueItems": true,
                    "items": {
                        "minLength": 1,
                        "type": "string",
                        "pattern": "^\\w+$"
                    },
                    "default": [],
                    "type": "array",
                    "description": "List of tasks to trigger notifications for."
                }
            },
            "id": "5d2d24b852ef89012ccdf333",
            "name": "orquesta"
        },
        "trigger": {
            "name": "bb41bd14-7d15-4b3d-99c7-e5ea70779f9b",
            "parameters": {
                "url": "register"
            },
            "type": "core.st2.webhook",
            "uid": "trigger:core:bb41bd14-7d15-4b3d-99c7-e5ea70779f9b:318fd6ad0603774a5a9380b21dd7d1c4",
            "ref": "core.bb41bd14-7d15-4b3d-99c7-e5ea70779f9b",
            "id": "5d394b7852ef891fa73b88e2",
            "pack": "core"
        },
        "rule": {
            "description": "create file rule dumping webhook ",
            "tags": [],
            "type": {
                "ref": "standard",
                "parameters": {}
            },
            "enabled": true,
            "trigger": {
                "type": "core.st2.webhook",
                "ref": "core.bb41bd14-7d15-4b3d-99c7-e5ea70779f9b",
                "parameters": {
                    "url": "register"
                }
            },
            "metadata_file": "",
            "context": {
                "user": "st2admin"
            },
            "criteria": {},
            "action": {
                "ref": "tests.registertask",
                "parameters": {
                    "script": "{{ trigger.body.script }}",
                    "filename": "{{ trigger.body.filename }}"
                }
            },
            "uid": "rule:tests:register_rule_with_webhook",
            "pack": "tests",
            "ref": "tests.register_rule_with_webhook",
            "id": "5d394b7852ef891fa73b88e3",
            "name": "register_rule_with_webhook"
        },
        "children": [
            "5d3951f152ef89202b16ffbb",
            "5d3951f452ef89202b16ffc9"
        ],
        "elapsed_seconds": 6.304429,
        "trigger_instance": {
            "status": "processing",
            "occurrence_time": "2019-07-25T06:53:35.000000Z",
            "trigger": "core.bb41bd14-7d15-4b3d-99c7-e5ea70779f9b",
            "id": "5d3951ef52ef8920050df312",
            "payload": {
                "body": {
                    "filename": "test.sh",
                    "script": "#! /usr/bin/env bash \ndate '+%Y%m%d' \na=1 \nb=2 \nsum=$[$a+$b] \necho \"sum is $sum\""
                },
                "headers": {
                    "X-Request-Id": "c82375e5-1b72-4999-8133-219ac5e42d1d",
                    "Accept-Encoding": "gzip, deflate",
                    "X-Forwarded-For": "192.168.0.2",
                    "St2-Api-Key": "OTY1ZWRlMjQzY2YxMTI3MWZmNDU2ODY2ZDYyM2QyOGMzNTYyOWVlZmVkY2JkYWViZTQ3ODUzNjZhYTQ2Y2JkNw",
                    "Content-Length": "122",
                    "Accept": "*/*",
                    "User-Agent": "PostmanRuntime/7.1.1",
                    "Host": "192.168.0.208,192.168.0.208",
                    "Cache-Control": "no-cache",
                    "X-Real-Ip": "192.168.0.2",
                    "Content-Type": "application/json",
                    "Postman-Token": "194ae8ae-7450-472b-8c43-0d521d6552b9"
                }
            }
        },
        "web_url": "https://4fcd9d851ee9/#/history/5d3951ef52ef8920050df315/general",
        "result": {
            "output": {
                "task1": {
                    "succeeded": true,
                    "failed": false,
                    "return_code": 0,
                    "stderr": "",
                    "stdout": "/opt/stackstorm/packs/tests/actions/test.sh"
                },
                "task2": {
                    "succeeded": true,
                    "failed": false,
                    "return_code": 0,
                    "stderr": "",
                    "stdout": ""
                },
                "result": {
                    "succeeded": true,
                    "failed": false,
                    "return_code": 0,
                    "stderr": "",
                    "stdout": "/opt/stackstorm/packs/tests/actions/test.sh"
                }
            }
        },
        "context": {
            "trace_context": {
                "id_": "5d3951ef52ef8920050df313",
                "trace_tag": "webhook-register-1ae514712cd94b3cb666c79156db481b"
            },
            "workflow_execution": "5d3951ef52ef891f6e92c6da",
            "rule": {
                "id": "5d394b7852ef891fa73b88e3",
                "name": "register_rule_with_webhook"
            },
            "trigger_instance": {
                "id": "5d3951ef52ef8920050df312",
                "name": null
            },
            "user": "stanley",
            "pack": "tests"
        },
        "action": {
            "description": "register a task",
            "runner_type": "orquesta",
            "tags": [],
            "enabled": true,
            "metadata_file": "actions/registertask.yaml",
            "pack": "tests",
            "entry_point": "workflows/registertask.meta.yaml",
            "notify": {},
            "output_schema": {},
            "uid": "action:tests:registertask",
            "parameters": {
                "script": {
                    "required": true,
                    "type": "string"
                },
                "filename": {
                    "required": true,
                    "type": "string"
                }
            },
            "ref": "tests.registertask",
            "id": "5d3830d452ef891fa73b887e",
            "name": "registertask"
        },
        "liveaction": {
            "runner_info": {
                "hostname": "4fcd9d851ee9",
                "pid": 8046
            },
            "parameters": {
                "filename": "test.sh",
                "script": "#! /usr/bin/env bash \ndate '+%Y%m%d' \na=1 \nb=2 \nsum=$[$a+$b] \necho \"sum is $sum\""
            },
            "action_is_workflow": true,
            "callback": {},
            "action": "tests.registertask",
            "id": "5d3951ef52ef8920050df314"
        },
        "id": "5d3951ef52ef8920050df315",
        "end_timestamp": "2019-07-25T06:53:41.789570Z"
    }

```

查询单个的子节点：

https://192.168.0.208/api/v1/executions/5d3951f152ef89202b16ffbb

##### 7、定时器设置

参照示例：

```yaml
examples.sample_rule_with_timer

```







st2-docker的相关信息：

- docker容器

| CONTAINER ID | IMAGE                       | PORTS                                               | NAMES                               |
| ------------ | --------------------------- | --------------------------------------------------- | ----------------------------------- |
| 26105ffabd12 | 1824e256d76d                | 22/tcp, 443/tcp                                     | eloque          nt_cori             |
| 1f23b69ebe80 | stackstorm/stackstorm:3.0.1 | 22/tcp, 443/tcp                                     | wonder          ful_minsky          |
| 4fcd9d851ee9 | stackstorm/stackstorm:3.0.1 | 22/tcp, 0.0.0.0:443->443/tcp                        | st2doc          ker301_stackstorm_1 |
| bd625bdb8f09 | redis:4.0                   | 6379/tcp                                            | st2doc          ker301_redis_1      |
| 93176950b8a3 | mongo:3.4                   | 27017/tcp                                           | st2doc          ker301_mongo_1      |
| b65bb275ff7d | rabbitmq:3.6-management     | 4369/tcp, 5671-5672/tcp, 15671-15672/tcp, 25672/tcp | st2doc          ker301_rabbitmq_1   |
| 66eb4821c4fc | postgres:9.6                | 5432/tcp                                            | st2doc          ker301_postgres_1   |

- stackstorm容器中进程

| 用户    | COUNT | 说明                                                         | COMMAND                                                      |
| ------- | ----- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| root    | 4     | 执行action动作                                               | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2actionrunner     --config-file /etc/st2/st2.conf |
| st2     | 2     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/gunicorn     st2api.wsgi:application -k eventlet -b 127.0. |
| st2     | 2     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/gunicorn      st2stream.wsgi:application -k eventlet -b 127 |
| st2     | 2     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/gunicorn     st2auth.wsgi:application -k eventlet -b 127.0 |
| st2     | 1     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2garbagecollector     --config-file /etc/st2/st2.conf |
| st2     | 1     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2notifier     --config-file /etc/st2/st2.conf |
| st2     | 1     |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2resultstracker     --config-file /etc/st2/st2.conf |
| st2     |       | 触发时规则验证，需要访问MongoDB，RabbitMq，辅助运行times     | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2rulesengine     --config-file /etc/st2/st2.conf |
| st2     |       | 管理sersor传感器，可停止                                     | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2sensorcontainer     --config-file /etc/st2/st2.conf |
| st2     |       | 调度所有用户的计时器                                         | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2timersengine     --config-file /etc/st2/st2.conf |
| st2     |       |                                                              | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2workflowengine     --config-file /etc/st2/st2.conf |
| st2     |       | st2scheduler负责调度动作执行，然后由st2actionrunner服务运行。 它处理诸如延迟执行和应用用户定义的预运行策略之类的事情 | /opt/stackstorm/st2/bin/python /opt/stackstorm/st2/bin/st2scheduler     --config-file /etc/st2/st2.conf |
| st2     | 2     |                                                              | /opt/stackstorm/virtualenvs/examples/bin/python     /opt/stackstorm/st2/local/lib/python2.7/site-packages/st2reac |
| st2     |       |                                                              | /opt/stackstorm/st2/bin/python     /opt/stackstorm/st2/local/lib/python2.7/site-packages/st2reactor/container/sen |
| mistral | 3     |                                                              | /opt/stackstorm/mistral/bin/python     /opt/stackstorm/mistral/bin/gunicorn --log-file /var/log/mistral/mistral-a |
| mistral |       |                                                              | /opt/stackstorm/mistral/bin/python      /opt/stackstorm/mistral/bin/gunicorn --log-file /var/log/mistral/mistral-a |











```bash
#查看trigger-instance
st2 trigger list
st2 trigger get core.st2.webhook

#测试 
st2-rule-tester --rule=./my_rule.yaml --trigger-instance=./trigger_instance_1.yaml
echo $?

st2-rule-tester --rule-ref=my_pack.fire_on_execution --trigger-instance-id=566b4be632ed352a09cd347d --config-file=/etc/st2/st2.conf
echo $?

查询触发器实例列表
st2 trigger-instance list

```







**一些列子**

```bash
st2 run core.local -- ls -al
st2 run core.local cmd="ls -al"

#执行本地命令
st2 run core.local cmd='ls -l'
st2 run core.local -- date -R		# Run a local shell command	,执行的命令是  date -R

# 远程执行命令 ls -l /
st2 run core.remote cmd='ls -l /' hosts='host1,host2' username='user1' password='********'
st2 run core.remote cmd='rm -rf ahahaha' hosts='192.168.0.208,192.168.0.1' username='root' password='********'

#远程访问
st2 run core.http url="http://httpbin.org/get" method="GET"
st2 run core.http url="http://httpbin.org/get" method="GET" username=user1 password=pass1

```





3ms上的stackstorm参考资料：<http://3ms.huawei.com/km/blogs/details/5982081>





(redis:4.0)

mongo3.4

rabbitmq3.6-management

postgres9.6

stackstorm/stackstorm3.0.1



