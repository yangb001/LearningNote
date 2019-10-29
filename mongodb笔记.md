# 1、安装配置

linux下：

```bash
下载压缩包至linux服务器
tar -zxvf mongodb-linux-x86_64-rhel70-3.2.18.tgz

env 	#查看环境变量
vi /etc/profile
	export PATH=/opt/mongodb/mongodb-linux-x86_64-rhel70-3.2.18/bin$PATH	#将mongo命令加入到环境变量中
mkdir -p /

#修改数据库目录
mongod -dbpath /opt/mongodb/data

#第二种情况
#例如D盘根目录下创建一个名为mongo.cfg的文件，
#内容为 dbpath=d:\data
mongod –config d:\mongo.cfg

#启动
mongod --dbpath  /home/user1/mongodb/data  --logpath  /home/user1/mongodb/log/logs  --fork
#mongo服务启动必须要指定文件存放的目录dbpath,--fork以守护进程运行，如果带—fork参数则必须要指定—logpath即日志存放的位置（指定文件不是文件夹）
	
	mongod --dbpath  /opt/mongodb/data  --logpath  /opt/mongodb/log/logs  --fork

#停止
ps aux|grep mongod      
kill -9 pid		#请不要用这个

#按照文档粗暴的杀掉它，它内部应该有KILL信号处理程序。
killall mongod

#停止 - 在数据库中
use admin      
db.shutdownServer()


```

# 2、创建数据库、表、插入数据

```bash
#查询数据库
show dbs

#进入数据库
use om

#查看集合
show tables

#创建 
use om
db
#刚创建的数据库 om 并不在数据库的列表中,要显示它，我们需要向 om 数据库插入一些数据
db.om.insert({"name":"hello world"})

#删除集合
db.collection.drop()

#删除数据库
use om
db.dropDatabase()
	 
#创建 collection
db.createCollection(name, options)
options 可以是如下参数：
字段			类型			描述
capped			布尔		（可选）如果为 true，则创建固定集合。固定集合是指有着固定大小的集合，当达到最大值时，它会自动覆盖最早的文档。当该值为 true 时，必须指定 size 参数。
autoIndexId		布尔		（可选）如为 true，自动在 _id 字段创建索引。默认为 false。
size			数值		（可选）为固定集合指定一个最大值（以字节计）。如果 capped 为 true，也需要指定该字段。
max				数值		（可选）指定固定集合中包含文档的最大数量。

#创建固定集合 mycol，整个集合空间大小 6142800 KB, 文档最大个数为 10000 个。
e.g.	> db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )
#在 MongoDB 中，你不需要创建集合。当你插入一些文档时，MongoDB 会自动创建集合

#删除文档
db.collection.remove(
   <query>,
   {
     justOne: <boolean>,
     writeConcern: <document>
   }
)

#删除所有数据
>db.col.remove({})
```

# 3、条件查询

<https://www.runoob.com/mongodb/mongodb-query.html>

```bash
#查询所有数据
>db.action_d_b.find()
#查询单条数据
>db.action_d_b.findOne()
#以易读性显示
> db.action_d_b.findOne().pretty()

#大于
>db.action_d_b.findOne({key:{$gt:value}})
#大于等于						#小于  $lt	不等于  &ne
>db.action_d_b.findOne({key:{$gte:value}})
#等于
>db.action_d_b.findOne({key:value})

# and
>db.col.find({key1:value1, key2:value2})

# or
>db.col.find(
   {
      $or: [
         {key1: value1}, {key2:value2}
      ]
   }
)

e.g.	db.action_d_b.find({$or:[{"ref":"tests.testaction"},{"id":"11"}]})

# and 和or 联合使用

#类似常规 SQL 语句为： 'where likes>50 AND (by = 'nihao' OR title = 'MongoDB')'
>db.col.find({"likes": {$gt:50}, $or: [{"by": "nihao"},{"title": "MongoDB"}]}).pretty()

```

# 4、java -mongodb

<https://blog.csdn.net/congcong68/article/details/47183209>

```java
// 单个查询
Query query = new Query(Criteria.where(field_name).is(field_value));
Object one = mongoTemplate.findOne(query, Object.class, collectionName);

// or条件查询
Query query = new Query(new Criteria().orOperator(Criteria.where("id").is(field_value),Criteria.where("ref").is(field_value)));
return mongoTemplate.findOne(query, Object.class, collectionName);
```

