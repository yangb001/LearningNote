# 1、redis

## 1、Redis简介

### 什么是redis

> Redis 是一个使用 C 语言写成的，开源的 key-value 数据库。。和Memcached类似，它支持存储的value类型相对更多，包括string(字符串)、list(链表)、set(集合)、zset(sorted set –有序集合)和hash（哈希类型）。这些数据类型都支持push/pop、add/remove及取交集并集和差集及更丰富的操作，而且这些操作都是原子性的。在此基础上，redis支持各种不同方式的排序。与memcached一样，为了保证效率，数据都是缓存在内存中。区别的是redis会周期性的把更新的数据写入磁盘或者把修改操作写入追加的记录文件，并且在此基础上实现了master-slave(主从)同步。目前，Vmware在资助着redis项目的开发和维护。

### 特性

1. 不仅仅支持简单的key/value类型的数据，还支持list、set、zset、hash等数据结构
2. 支持数据备份，master-slave数据备份
3. 支持数据持久化
4. redis使用单线程的io复用模型





## 2、安装及使用

参考：<https://blog.csdn.net/wxwzy738/article/details/16847303>



```cmd
config set requirepass hello	#设置密码

auth hello	#验证密码密码

keys *		#查看所有key值
flushall	#清空所有key
```



```cmd
redis-benchmark.exe -n 100000 -c 60			## benchmark工具测试 : 向redis服务器发送10万个请求，每个请求附带60个并发客户端
redis-server.exe  redis.conf				## 启动redis服务

在另外一个窗口下，打开redis客户端
redis-cli.exe -h 127.0.0.1 -p 6379

```

#### 1、基础使用

```cmd
#键值对
set hello 123 				
get hello
del hello	#删除 hello
http://www.runoob.com/redis/redis-strings.html

# hash
hmset hash1 a 123  b 456
hget hash1 a

#list
lpush list a	#左插入
lpush list b
rpush list c	#右插入
lrange list 0 10		#查看


SELECT index 	#切换到指定的数据库
```

| 序号 | 命令及描述                                                   |
| ---- | ------------------------------------------------------------ |
| 1    | [DEL key](http://www.runoob.com/redis/keys-del.html) 该命令用于在 key 存在时删除 key。 |
| 2    | [DUMP key](http://www.runoob.com/redis/keys-dump.html)  序列化给定 key ，并返回被序列化的值。 |
| 3    | [EXISTS key](http://www.runoob.com/redis/keys-exists.html)  检查给定 key 是否存在。 |
| 4    | [EXPIRE key](http://www.runoob.com/redis/keys-expire.html) seconds 为给定 key 设置过期时间，以秒计。 |
| 5    | [EXPIREAT key timestamp](http://www.runoob.com/redis/keys-expireat.html)  EXPIREAT 的作用和 EXPIRE 类似，都用于为 key 设置过期时间。 不同在于 EXPIREAT 命令接受的时间参数是 UNIX 时间戳(unix timestamp)。 |
| 6    | [PEXPIRE key milliseconds](http://www.runoob.com/redis/keys-pexpire.html)  设置 key 的过期时间以毫秒计。 |
| 7    | [PEXPIREAT key milliseconds-timestamp](http://www.runoob.com/redis/keys-pexpireat.html)  设置 key 过期时间的时间戳(unix timestamp) 以毫秒计 |
| 8    | [KEYS pattern](http://www.runoob.com/redis/keys-keys.html)  查找所有符合给定模式( pattern)的 key 。 |
| 9    | [MOVE key db](http://www.runoob.com/redis/keys-move.html)  将当前数据库的 key 移动到给定的数据库 db 当中。 |
| 10   | [PERSIST key](http://www.runoob.com/redis/keys-persist.html)  移除 key 的过期时间，key 将持久保持。 |
| 11   | [PTTL key](http://www.runoob.com/redis/keys-pttl.html)  以毫秒为单位返回 key 的剩余的过期时间。 |
| 12   | [TTL key](http://www.runoob.com/redis/keys-ttl.html)  以秒为单位，返回给定 key 的剩余生存时间(TTL, time to live)。 |
| 13   | [RANDOMKEY](http://www.runoob.com/redis/keys-randomkey.html)  从当前数据库中随机返回一个 key 。 |
| 14   | [RENAME key newkey](http://www.runoob.com/redis/keys-rename.html)  修改 key 的名称 |
| 15   | [RENAMENX key newkey](http://www.runoob.com/redis/keys-renamenx.html)  仅当 newkey 不存在时，将 key 改名为 newkey 。 |
| 16   | [TYPE key](http://www.runoob.com/redis/keys-type.html)  返回 key 所储存的值的类型。 |

#### 2、redis命令

```cmd
redis-cli	#连接本地数据库
redis-cli -h 192.168.12.12 -p 6379 -a password	#连接远程数据库

```

#### 3、发布订阅	<http://www.runoob.com/redis/redis-pub-sub.html>

```cmd
SUBSCRIBE redisChat

PUBLISH redisChat "Learn redis by runoob.com"

```



## 3、redis内存回收算法LRU

> redis使用两种算法回收内存，引用计数法与LRU算法（最近最久未使用算法）

<https://www.cnblogs.com/WJ5888/p/4371647.html>





## redis需要注意的地方

### 1、使用jedis存储数据

使用jedis的 redisTemplate下的opsForHash方法存储hash类型的值时，若不指定序列化方式，则会使用默认的序列化方式生成字符串，如下：

```cmd
 "\xac\xed\x00\x05t\x00\x04yang"  
```

解决方式：自定义序列化使用方式

```java
@Configuration
public class RedisConfig {

    @Bean
    public RedisTemplate<String, Object> redisTemplate(JedisConnectionFactory redisConnectionFactory){
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashValueSerializer(new GenericJackson2JsonRedisSerializer());
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        return redisTemplate;
    }
}
//其中参数 ConnectionFactory注入那种类型的factory需要在application.yaml中配置
	jedis:
      pool:
        max-active: 8 # 连接池最大连接数（使用负值表示没有限制）
        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）
        max-idle: 8 # 连接池中的最大空闲连接
        min-idle: 0 # 连接池中的最小空闲连接
//比如 LettuceConnectionFactory时
	lettuce:
      pool:
         # 连接池中的最大空闲连接 默认8      
        max-idle: 8
        # 连接池中的最小空闲连接 默认0
        min-idle: 0
        # 连接池最大连接数 默认8 ，负数表示没有限制
        max-active: 8
        # 连接池最大阻塞等待时间（使用负值表示没有限制） 默认-1
        max-wait: -1
```



# 2、zookeeper

## 1、简介

## 2、安装及使用

<https://blog.csdn.net/wenqisun/article/details/51122692>

- D:\zookeeper-3.3.6\conf下的zoo_sample.cfg重新命名为zoo.cfg。

  默认加载zoo.cfg这个文件

- **启动zookeeper服务端：** 执行D:\zookeeper-3.3.6\bin下的zkServer.cmd

- **启动客户端：** 启动D:\zookeeper-3.3.6\bin下的zkCli.cmd或在cmd下进入D:\zookeeper-3.3.6\bin执行命令zkCli.cmd -server 127.0.0.1:2181  启动zkCli.cmd

```bash
一些简单的测试命令

#ls命令：
[zk: 127.0.0.1:2181(CONNECTED) 0] ls /
[javaer, root-ktv, zookeeper]

#create命令：
[zk: 127.0.0.1:2181(CONNECTED) 4] create /javaer www.javaer.com.cn
Created /javaer

#get命令：
[zk: 127.0.0.1:2181(CONNECTED) 6] get /javaer
www.javaer.com.cn

#set命令：
[zk: 127.0.0.1:2182(CONNECTED) 5] set /javaer sunwenqi
```



# 3、kafka

## 1、命令行

```bash
#首先要进入zookeeper根目录
bin/zkServer.sh start

#接着要进入kafka根目录
bin/kafka-server-start.sh config/server.properties

# 创建topic, 名称为testTopic
    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic testTopic

    # 查看topic(会发现除了testTopic，还有KafkaPushsTopic
    bin/kafka-topics.sh --list --zookeeper localhost:2181

    # 启动消费者（Consumer, 发现“卡住了”，其实它是在等消息，不要关这个窗口）
    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic testTopic --from-beginning

    # 启动生产者(Producer, 新窗口启动)
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic testTopic

```



## 2、kafka集成

> 版本一定要注意，若springboot是2.1版本的，则spring-kafka的版本为2.2，使用2.3会报错

```java
<dependency>
	<groupId>org.springframework.kafka</groupId>
	<artifactId>spring-kafka</artifactId>
    <version>2.2.10.RELEASE</version>
</dependency>
```

