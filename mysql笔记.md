## 1、使用

查看数据库信息：

- status
- select version() from dual;

查看数据库引擎：

- show engines

#### 1、数据库连接

```bash
mysql -u root -h 192.168.0.1 -proot			//连接远程库

mysql5.6中：
 	set password for root@localhost = password('root');  	//修改密码
```

```sql
show full columns from pms_admin;  	-- mysql查看表的详细信息
desc pms_admin;	--查看表信息
```



#### 2、批量删除表

```sql
select concat(' ','drop table if exists 
',table_name,';') from information_schema.tables where table_schema = 'mall';

--将执行出来的结果再执行一次
```

#### 3、字段拼接

参考(<https://www.cnblogs.com/shuzf/p/9933761.html>)

###### 1、CONCAT（）函数 

CONCAT（）函数用于将多个字符串连接成一个字符串。

语法及使用特点：

```xml
CONCAT(str1,str2,…)    
```

返回结果为连接参数产生的字符串。如有任何一个参数为NULL ，则返回值为 NULL。可以有一个或多个参数。
eg：concat(id,'-',name,'-',pass)	#如果有一个为null，返回null

###### 2、CONCAT_WS（）。

使用语法为：

```sql
CONCAT_WS(separator,str1,str2,…) 
```

CONCAT_WS() 代表 CONCAT With Separator ，是CONCAT()的特殊形式。第一个参数是其它参数的分隔符。分隔符的位置放在要连接的两个字符串之间。分隔符可以是一个字符串，也可以是其它参数。如果分隔符为 NULL，则结果为 NULL。函数会忽略任何分隔符参数后的 NULL 值。但是CONCAT_WS()不会忽略任何空字符串。 (然而会忽略所有的 NULL）。

###### 3、GROUP_CONCAT（）函数 

GROUP_CONCAT函数返回一个字符串结果，该结果由分组中的值连接组合而成。

1、使用语法及特点：

```sql
 GROUP_CONCAT([DISTINCT] expr [,expr ...]

[ORDER BY {unsigned_integer | col_name | formula} [ASC | DESC][,col ...]]

[SEPARATOR str_val]) 
```

在 MySQL 中，你可以得到表达式结合体的连结值。通过使用 DISTINCT 可以排除重复值。如果希望对结果中的值进行排序，可以使用 ORDER BY 子句。 

SEPARATOR 是一个字符串值，它被用于插入到结果值中。缺省为一个逗号 (",")，可以通过指定 SEPARATOR "" 完全地移除这个分隔符。 

可以通过变量 group_concat_max_len 设置一个最大的长度。在运行时执行的句法如下： SET [SESSION | GLOBAL] group_concat_max_len = unsigned_integer; 

如果最大长度被设置，结果值被剪切到这个最大长度。如果分组的字符过长，可以对系统参数进行设置：SET @@global.group_concat_max_len=40000; 

#### 4、列的值用逗号拼接

```sql
select group_concat(字段名) from 表名 
```

#### 5、从逗号分割的字符串中查询是否存在

```sql
find_in_set(goal, original)
```





### end、bug

##### 1、导入乱码处理

###### 1、命令行导入处理

```sql
set names utf8;			//与.sql文件的编码格式保持一致
source xxx.sql;
```

###### 2、其它处理方式

```
<https://zhidao.baidu.com/question/625816413198731084.html>
```



##### 2、解决ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)

步骤一：关闭数据库服务端mysqld程序

②在命令行程序中；注意需要以管理员权限运行cmd程序，不然无法关闭mysqld进程

> > tasklist |findstr mysqld        这行命令可以用来查看mysqld是否在运行，在运行中则可以查到它的PID

> > taskkill /F /PID xxxx             xxxx是从前面一条命令得到的PID值
> > 步骤二：跳过权限登录MySQL 服务器端

在cmd中执行 mysqld --skip-grant-tables 

\>>mysqld --skip-grant-tables

此时cmd程序会阻塞，关闭cmd程序 然后重新以管理员权限运行cmd

然后在cmd命令行中输入 mysql 就能连接上MySQL 服务器端了

> > mysql

然后可以通过sql语句 ：SELECT * from mysql.user\G;  来查看服务器端所有的用户信息，重点查看User、Password、authentication_string这三项。这条语句非常关键。

步骤三：修改密码

```sql
update mysql.user set authentication_string=password('321') where user = 'root';
flush privileges;
```

接着执行

```sql
SELECT * from mysql.user\G;
```

去找到root用户的authentication_string这项，并把它的值记下来。

MySQL会给密码进行加密，你想要设置的密码进行加密后的值就等于此时authentication_string这项的值

所以接下来把Password这项的值也设置成此时authentication_string项的值就ok了；我设置的密码是321 ，其对应的密文是  *7297C3E22DEB91303FC493303A8158AD4231F486

执行下面两条sql语句：

```sql
update mysql.user set password = '*7297C3E22DEB91303FC493303A8158AD4231F486' where user = 'root';
flush privileges;
```

步骤四：

输入 quit 退出 mysql ；然后就可以直接登录了

\>>mysql -u root -p

cn.hutu.generator.CommentGenerator

## 2、普通jdbc执行代码

```java
Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;
List<PmsBrandVo> resultList = new ArrayList<>();

try {
    /**
    	不实例化驱动类也可以直接访问数据库
    	Loading class `com.mysql.jdbc.Driver'. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver'. The driver is automatically 			      	 registered via the SPI and manual loading of the driver class is generally unnecessary.
    	加载类`com.mysql.jdbc.Driver'。 这已被弃用。 新的驱动程序类是`com.mysql.cj.jdbc.Driver'。 驱动程序通过SPI自动注册，手动加载驱动程序类通常是不必要的。
    	
    	参考：  https://www.jianshu.com/p/e85a98517b4d		从一个简单的异常，读懂不简单的类加载机制
    **/
    //Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    
    //String driverName = Class.forName("com.mysql.cj.jdbc.Driver").getName();
    //this.getClass().getClassLoader().loadClass(driverName);
    
    
    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

    String sql = "select * from pms_brand limit ?";

    preparedStatement = connection.prepareStatement(sql);
    preparedStatement.setInt(1, 4);


    resultSet = preparedStatement.executeQuery();
    ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
    int columnCount = resultSetMetaData.getColumnCount();
    while (resultSet!=null && resultSet.next()){
        Map map = new HashMap();
        //PmsBrandVo p = new PmsBrandVo();
        /*for (int i = 0; i < columnCount; i++) {
            String columnName = resultSetMetaData.getColumnName(i+1);
            map.put(columnName, resultSet.getString(i+1));
        }*/
        PmsBrandVo p = ClassChangeUtil.map2Bean(map,PmsBrandVo.class);
        resultList.add(p);
    }
} catch (Exception e) {
    e.printStackTrace();
}finally {
    try {
        if (resultSet != null) {
            resultSet.close();
        }
        if(preparedStatement !=null){
            preparedStatement.close();
        }
        if (connection != null){
            connection.close();
        }
    } catch (SQLException e) {

    }
}
```



## 3、执行过程

1.在BaseExecutor类中读取数据库连接，Executor相关主要执行sql的解析，数据库连接，结果处理

```java
public class SimpleExecutor extends BaseExecutor {
    //获取connection对象，获取statement对象
    private Statement prepareStatement(StatementHandler handler, Log statementLog) throws SQLException {
        Statement stmt;
        Connection connection = getConnection(statementLog);
        stmt = handler.prepare(connection, transaction.getTimeout());		//加入了超时
        handler.parameterize(stmt);
        return stmt;
    }
}
```

sqlSession在Executor相关类的上方，主要通过statement的id调用executor层中对应的接口，获取查询到的结果。

参照地址：<https://www.cnblogs.com/atwanli/articles/4746349.html>





