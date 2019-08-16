# 1、jdk各版本

<https://blog.csdn.net/fuhanghang/article/details/84073401>

JDK Version 1.0

**1996-01-23 Oak(橡树)**

初代版本，伟大的一个里程碑，但是是纯解释运行，使用外挂JIT，性能比较差，运行速度慢。

### JDK Version 1.1

**1997-02-19**

- JDBC(Java DataBase Connectivity);
- 支持内部类;
- RMI(Remote Method Invocation) ;
- 反射;
- Java Bean;

### JDK Version 1.2

**1998-12-08 Playground(操场)**

- 集合框架；
- JIT(Just In Time)编译器；
- 对打包的Java文件进行数字签名；
- JFC(Java Foundation Classes)，包括Swing 1.0，拖放和Java2D类库；
- Java插件;
- JDBC中引入可滚动结果集，BLOB，CLOB，批量更新和用户自定义类型;
- Applet中添加声音支持.

### JDK Version 1.3

**2000-05-08 Kestrel(红隼)**

- Java Sound API;
- jar文件索引;
- 对Java的各个方面都做了大量优化和增强;

### JDK Version 1.4

**2004-02-06 Merlin(隼)**

- XML处理;
- Java打印服务;
- Logging API;
- Java Web Start;
- JDBC 3.0 API;
- 断言;
- Preferences API;
- 链式异常处理;
- 支持IPV6;
- 支持正则表达式;
- 引入Imgae I/O API.

### JAVA 5

**2004-09-30 Tiger(老虎)**

- 泛型;

- 增强循环,可以使用迭代方式;

  ```java
  for(Object o : c)
  ```

- 自动装箱与自动拆箱;

- 类型安全的枚举;

- 可变参数;

- 静态引入;

```java
import static org.yyy.pkg.Increment;
```

- 元数据(注解);
- Instrumentation;

### JAVA 6

**2006-12-11 Mustang(野马)**

- 支持脚本语言;
- JDBC 4.0API;
- Java Compiler API;

> 动态编译Java源文件，CompilerAPI结合反射功能就可以实现动态的产生Java代码并编译执行这些代码,有点动态语言的特征

- 可插拔注解;
- 增加对Native PKI(Public Key Infrastructure), Java GSS(Generic Security Service),Kerberos和LDAP(Lightweight Directory Access Protocol)支持;
- 继承Web Services;

### JAVA 7

**2011-07-28 Dolphin(海豚)**

- switch语句块中允许以字符串作为分支条件;
- 在创建泛型对象时应用类型推断;
- 在一个语句块中捕获多种异常;
- 支持动态语言;
- 支持try-with-resources(在一个语句块中捕获多种异常);

> 所有可关闭的类将被修改为可以实现一个Closable（可关闭的）接口

```java
try (
         InputStreamin = new FileInputStream(src);
         OutputStreamout = new FileOutputStream(dest))
 {
 //code
 }
```

- 引入Java NIO.2开发包;
- 数值类型可以用二进制字符串表示,并且可以在字符串表示中添加下划线;

```java
int binary = 0b1001_1001;	//	你现在可以使用0b前缀创建二进制字面量：
int one_million = 1_000_000;
```

- 钻石型语法(在创建泛型对象时应用类型推断);

```java
Map<String, List<String>> anagrams= new HashMap<>();	//  <>被叫做diamond（钻石）运算符，这个运算符从引用的声明中推断类型。
```

- null值得自动处理;

### JAVA 8

**2014-03-18** 

- Lambda 表达式 − Lambda允许把函数作为一个方法的参数（函数作为参数传递进方法中）。
- 方法引用 − 方法引用提供了非常有用的语法，可以直接引用已有Java类或对象（实例）的方法或构造器。与lambda联合使用，方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
- 默认方法+静态方法 − 默认方法就是一个在接口里面有了一个实现的方法。

> 当一个实例实现的多个接口有相同的默认方法时，如不重写就无法判断使用哪个，编译器就会报错
>
> ```
> cn.hutu.Instan inherits unrelated defaults for hello() from types cn.hutu.Inter1 and cn.hutu.Inter2
> ```

```java
public interface SellService {
    static void onceAddSpring(){
        System.out.println("ssssssssss");
    }

    default void hello(){
        System.out.println("ssssssssss");
    }
}
```



- 新工具 − 新的编译工具，如：Nashorn引擎 jjs、 类依赖分析器jdeps。
- Stream API −新添加的Stream API（java.util.stream） 把真正的函数式编程风格引入到Java中。
- Date Time API − 加强对日期与时间的处理。
- Optional 类 − Optional 类已经成为 Java 8 类库的一部分，用来解决空指针异常。
- Nashorn, JavaScript 引擎 − Java 8提供了一个新的Nashorn javascript引擎，它允许我们在JVM上运行特定的javascript应用。

### JAVA 9

**2017-09-22**

- 模块系统：模块是一个包的容器，Java 9 最大的变化之一是引入了模块系统（Jigsaw 项目）。
- REPL (JShell)：交互式编程环境。
- HTTP 2 客户端：HTTP/2标准是HTTP协议的最新版本，新的 HTTPClient API 支持 WebSocket 和 HTTP2 流以及服务器推送特性。
- 改进的 Javadoc：Javadoc 现在支持在 API 文档中的进行搜索。另外，Javadoc 的输出现在符合兼容 HTML5 标准。
- 多版本兼容 JAR 包：多版本兼容 JAR 功能能让你创建仅在特定版本的 Java 环境中运行库程序时选择使用的 class 版本。
- 集合工厂方法：List，Set 和 Map 接口中，新的静态工厂方法可以创建这些集合的不可变实例。
- 私有接口方法：在接口中使用private私有方法。我们可以使用 private 访问修饰符在接口中编写私有方法。
- 进程 API: 改进的 API 来控制和管理操作系统进程。引进 java.lang.ProcessHandle 及其嵌套接口 Info 来让开发者逃离时常因为要获取一个本地进程的 PID 而不得不使用本地代码的窘境。
- 改进的 Stream API：改进的 Stream API 添加了一些便利的方法，使流处理更容易，并使用收集器编写复杂的查询。
- 改进 try-with-resources：如果你已经有一个资源是 final 或等效于 final 变量,您可以在 try-with-resources 语句中使用该变量，而无需在 try-with-resources 语句中声明一个新变量。
- 改进的弃用注解 @Deprecated：注解 @Deprecated 可以标记 Java API 状态，可以表示被标记的 API 将会被移除，或者已经破坏。
- 改进钻石操作符(Diamond Operator) ：匿名类可以使用钻石操作符(Diamond Operator)。
- 改进 Optional 类：java.util.Optional 添加了很多新的有用方法，Optional 可以直接转为 stream。
- 多分辨率图像 API：定义多分辨率图像API，开发者可以很容易的操作和展示不同分辨率的图像了。
- 改进的 CompletableFuture API ： CompletableFuture 类的异步机制可以在 ProcessHandle.onExit 方法退出时执行操作。
- 轻量级的 JSON API：内置了一个轻量级的JSON API
- 响应式流（Reactive Streams) API: Java 9中引入了新的响应式流 API 来支持 Java 9 中的响应式编程。
- 详细参考:http://www.runoob.com/java/java9-new-features.html

### JAVA 10

**2018-03-21**

根据官网的公开资料，共有12个重要特性，如下：

- JEP286，var 局部变量类型推断。
- JEP296，将原来用 Mercurial 管理的众多 JDK 仓库代码，合并到一个仓库中，简化开发和管理过程。
- JEP304，统一的垃圾回收接口。
- JEP307，G1 垃圾回收器的并行完整垃圾回收，实现并行性来改善最坏情况下的延迟。
- JEP310，应用程序类数据 (AppCDS) 共享，通过跨进程共享通用类元数据来减少内存占用空间，和减少启动时间。
- JEP312，ThreadLocal 握手交互。在不进入到全局 JVM 安全点 (Safepoint) 的情况下，对线程执行回调。优化可以只停止单个线程，而不是停全部线程或一个都不停。
- JEP313，移除 JDK 中附带的 javah 工具。可以使用 javac -h 代替。
- JEP314，使用附加的 Unicode 语言标记扩展。
- JEP317，能将堆内存占用分配给用户指定的备用内存设备。
- JEP317，使用 Graal 基于 Java 的编译器，可以预先把 Java 代码编译成本地代码来提升效能。
- JEP318，在 OpenJDK 中提供一组默认的根证书颁发机构证书。开源目前 Oracle 提供的的 Java SE 的根证书，这样 OpenJDK 对开发人员使用起来更方便。
- JEP322，基于时间定义的发布版本，即上述提到的发布周期。版本号为\$FEATURE.\$INTERIM.\$UPDATE.\$PATCH，分别是大版本，中间版本，升级包和补丁版本。

### JAVA 11

**2018-09-25** 

翻译后的新特性有：

- 181:Nest-Based访问控制
- 309:动态类文件常量
- 315:改善Aarch64 intrinsic
- 318:无操作垃圾收集器
- 320:消除Java EE和CORBA模块
- 321:HTTP客户端(标准)
- 323:局部变量的语法λ参数
- 324:Curve25519和Curve448关键协议
- 327:Unicode 10
- 328:飞行记录器
- 329:ChaCha20和Poly1305加密算法
- 330:发射一列纵队源代码程序
- 331:低开销堆分析
- 332:传输层安全性(Transport Layer Security,TLS)1.3
- 333:动作:一个可伸缩的低延迟垃圾收集器 (实验)
- 335:反对Nashorn JavaScript引擎
- 336:反对Pack200工具和API



# 2、Java配置及系统信息



## 1、java配置

- java环境变量设置

  建JAVA_HOME：	C:\Program Files\Java\jdk1.8.0_66

  建CLASSPATH：	.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar

  辑path：	%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin

- java打包编译

```java
javac -d .  test1.java		//打包编译
javac hello.test1			//运行
```

- java打jar包方式

<https://www.cnblogs.com/mq0036/p/8566427.html>

## 2、系统信息

```java
System.out.println(System.getProperty("java.class.path")) 	//查看java classpath的所有路径

```





静态代码块 > 代码块 > 构造函数

静态代码块之间顺序  前 > 后



# 3、java一些概念

### 1 、方法的重写（override）

- **<u>参数列表必须完全与被重写方法的相同</u>**。
- **<u>返回类型与被重写方法的返回类型可以不相同，但是必须是父类返回值的派生类</u>**（java5 及更早版本返回类型要一样，java7 及更高版本可以不同）。
- **<u>访问权限不能比父类中被重写的方法的访问权限更低</u>**。例如：如果父类的一个方法被声明为 public，那么在子类中重写该方法就不能声明为 protected。
- 父类的成员方法只能被它的子类重写。
- **<u>声明为 final 的方法不能被重写</u>**。
- **<u>声明为 static 的方法不能被重写，但是能够被再次声明</u>**。
- 子类和父类在同一个包中，那么子类可以重写父类所有方法，除了声明为 private 和 final 的方法。
- 子类和父类不在同一个包中，那么子类只能够重写父类的声明为 public 和 protected 的非 final 方法。
- 重写的方法能够抛出任何非强制异常，无论被重写的方法是否抛出异常。但是，重写的方法不能抛出新的强制性异常，或者比被重写方法声明的更广泛的强制性异常，反之则可以。
- 构造方法不能被重写。
- 如果不能继承一个方法，则不能重写这个方法

- 基本变量调用时 值传递
- 引用变量调用时 地址传递

### 2、重载(Overload)

重载(overloading) 是在一个类里面，方法名字相同，而参数不同。返回类型可以相同也可以不同。

每个重载的方法（或者构造函数）都必须有一个独一无二的参数类型列表。

最常用的地方就是构造器的重载。

**重载规则:**

- 被重载的方法必须改变参数列表(参数个数或类型不一样)；
- 被重载的方法可以改变返回类型；
- 被重载的方法可以改变访问修饰符；
- 被重载的方法可以声明新的或更广的检查异常；
- 方法能够在同一个类中或者在一个子类中被重载。
- 无法以返回值类型作为重载函数的区分标准。

# 4、事务处理

### 1、jdbc事务

- connect需要设置自动提交为false	connection.setAutoCommit(false)

- > JDBC Savepoint帮我们在事务中创建检查点（checkpoint），这样就可以回滚到指定点。当事务提交或者整个事务回滚后，为事务产生的任何保存点都会自动释放并变为无效。把事务回滚到一个保存点，会使其他所有保存点自动释放并变为无效。

- 事务结束时，需要用connection.commit() 提交事务

- 事务失败需要回滚时，只能将数据回滚到最近一个savepoint并且将savepoint前的事务自动提交

- 缺点：

  缺点是事务的范围局限于一个数据库连接。一个 JDBC 事务不能跨越多个数据库

```java
public void onceAdd() throws SQLException {
    Connection connection = null;
    Savepoint sp = null;
    try {
        connection = jdbcUtils.getConn();
        connection.setAutoCommit(false);

        sp = connection.setSavepoint("first");
        addjdbc(connection, 1);
        decreasejdbc(connection, 1);

        connection.commit();
    } catch (SQLException e) {
        connection.rollback(sp);
    } finally {
        connection.setAutoCommit(true);
        connection.close();
    }
    System.out.println("ddddd");
}

public void addjdbc(Connection connection, int i) throws SQLException {
    String sql = "update test_add set num = num + ? where id = 1";
    System.out.println(executeNoResult(connection, sql, new Integer[]{1}));
}

public void decreasejdbc(Connection connection, int i) throws SQLException {
    String sql = "update test_decrease set numnow = numnow - ? where id = 1";
    System.out.println(executeNoResult(connection, sql, new Integer[]{1}));
}

public String executeNoResult(Connection conn, String sql, Object[] params) throws SQLException {
    PreparedStatement ps = null;
    try {
        ps = conn.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            Object o = params[i];
            if (o instanceof Integer) {
                ps.setInt(i + 1, Integer.valueOf((Integer) o));
            } else if (o instanceof String) {
                ps.setString(i + 1, (String) o);
            } else {
                ps.setObject(i + 1, o);
            }
        }
        ps.execute();
        int count = ps.getUpdateCount();
        if (count<=0) {
            throw new RuntimeException("查询搓搓啦");
        }
        //ResultSet set = ps.getResultSet();


        //conn.rollback();
        return "修改完成:"+count + " 行";
    } catch (SQLException e) {
        throw new SQLException("查询搓搓啦");
    } finally {
        ps.close();
    }
}

public Connection getConn() throws SQLException {
    Connection conn = null;
    try {
        return conn = DriverManager.getConnection(url, username, password);
    } catch (SQLException e) {
        throw new SQLException("连接数据库异常");
    }
}

```

### 2、JTA事务

- XA规范

> XA规范是由X/Open组织提出的分布式事务规范，只要定义了全局事务管理器(Transaction Manager) 和局部资源管理器(Resource Manager)之间的接口。事务管理器负责管理事务周期，协调资源管理器。资源管理器负责控制和管理实际的资源

- 两段式提交

> **准备阶段**：事务管理器询问所有参与者（资源管理器）是否已做好准备提交，参与者如果已经准备好提交则回复`Prepared`，否则回复`Non-Prepared`。
>
> **提交阶段** ：协调者如果在上一阶段收到所有参与者回复的`Prepared`，则在此阶段向所有参与者发送`commit`指令，所有参与者立即执行`commit`操作；否则协调者向所有参与者发送`rollback`指令，参与者立即执行`rollback`操作



#### 1、使用atomikios实现

- **直接使用TransactionEssentials的API**

```xml
<dependency>
    <groupId>javax.transaction</groupId>
    <artifactId>jta</artifactId>
    <version>1.1</version>
</dependency>


<dependency>
    <groupId>com.atomikos</groupId>
    <artifactId>transactions-jta</artifactId>
    <version>5.0.1</version>
</dependency>

<dependency>
    <groupId>com.atomikos</groupId>
    <artifactId>transactions-jdbc</artifactId>
    <version>5.0.1</version>
</dependency>

```

```java
public void onceAddJTA() throws SQLException {

    UserTransaction userT = new UserTransactionImp();
    AtomikosDataSourceBean ds1 = createAtomikosDataSourceBean("ds1", "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai");
    AtomikosDataSourceBean ds2 = createAtomikosDataSourceBean("ds2", "jdbc:mysql://localhost:3306/admin?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai");

    Connection conn1 = ds1.getConnection();
    Connection conn2 = ds2.getConnection();
    try {
        userT.begin();
        addjdbc(conn1, 1);
        decreasejdbc(conn2, 1);
        userT.commit();

    } catch (Exception e) {
        e.printStackTrace();
        try {
            userT.rollback();
        } catch (SystemException e1) {
            e1.printStackTrace();
        }
    }
}
```

```java
public void addjdbc(Connection connection, int i) throws SQLException {
    String sql = "update test_add set num = num + ? where id = 1";
    System.out.println(jdbcUtils.executeNoResult(connection, sql, new Integer[]{1}));
}

public void decreasejdbc(Connection connection, int i) throws SQLException {
    String sql = "update test_decrease set numnow = numnow - ? where id = 1";
    System.out.println(jdbcUtils.executeNoResult(connection, sql, new Integer[]{1}));
}

public String executeNoResult(Connection conn, String sql, Object[] params) throws SQLException {
    PreparedStatement ps = null;
    try {
        ps = conn.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            Object o = params[i];
            if (o instanceof Integer) {
                ps.setInt(i + 1, Integer.valueOf((Integer) o));
            } else if (o instanceof String) {
                ps.setString(i + 1, (String) o);
            } else {
                ps.setObject(i + 1, o);
            }
        }
        ps.execute();
        int count = ps.getUpdateCount();
        if (count<=0) {
            throw new RuntimeException("查询搓搓啦");
        }
        return "修改完成:"+count + " 行";
    } catch (SQLException e) {
        e.printStackTrace();
        throw new SQLException("查询搓搓啦");
    } finally {
        ps.close();
    }
}
```

#### 2、直接管理mysql事务

```java
@Override
public void onceAddMysqlJTA() throws SQLException {
    MysqlXADataSource xaDataSource1 = new MysqlXADataSource();
    xaDataSource1.setUrl("jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai");
    xaDataSource1.setUser("root");
    xaDataSource1.setPassword("root");

    MysqlXADataSource xaDataSource2 = new MysqlXADataSource();
    xaDataSource2.setUrl("jdbc:mysql://localhost:3306/admin?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai");
    xaDataSource2.setUser("root");
    xaDataSource2.setPassword("root");

    Xid xid1 = new MysqlXid("hello".getBytes(), "first".getBytes(),1);
    Xid xid2 = new MysqlXid("hello".getBytes(), "second".getBytes(),2);

    XAConnection xaConnection1 = xaDataSource1.getXAConnection();
    XAConnection xaConnection2 = xaDataSource2.getXAConnection();

    XAResource xaResource1 = xaConnection1.getXAResource();
    XAResource xaResource2 = xaConnection2.getXAResource();


    try {
        xaResource1.start(xid1,XAResource.TMNOFLAGS);
        PreparedStatement ps1 = xaConnection1.getConnection().prepareStatement("update test_add set num = num + 1 where id = 1");
        ps1.executeUpdate();
        xaResource1.end(xid1,XAResource.TMSUCCESS);

        xaResource2.start(xid2,XAResource.TMNOFLAGS);
        PreparedStatement ps2 = xaConnection2.getConnection().prepareStatement("update test_decrease set numnow = numnow - 1 where id = 1");
        ps2.executeUpdate();
        xaResource2.end(xid2,XAResource.TMSUCCESS);

        int isok1 = xaResource1.prepare(xid1);
        int isok2 = xaResource2.prepare(xid2);

        if(isok1 == XAResource.XA_OK && isok2 == XAResource.XA_OK){
            xaResource1.commit(xid1, false);
            xaResource2.commit(xid2, false);
        }
    } catch (XAException e) {
        try {
            xaResource1.rollback(xid1);
            xaResource2.rollback(xid2);
            System.out.println("rollback");
        } catch (XAException e1) {
            e1.printStackTrace();
        }
        e.printStackTrace();
    }
}
```





# 5、java关键字

- transient	：当对象序列化时，transient关键字修饰的变量不参与序列化过程

# 6、java动态特性

> JDK原生动态代理是Java原生支持的，不需要任何外部依赖，但是它只能基于接口进行代理；CGLIB通过继承的方式进行代理，无论目标对象有没有实现接口都可以代理，但是无法处理final的情况。

## 1、反射

```java
public static void reflectClass(){
    // 1. 	已知实例
    Test01 test01 = new Test01();
    Class c = test01.getClass();
    System.out.println("1---"+c.getName());
    // 2.	已知class
    Class c2 = Test01.class;
    System.out.println("2---"+c2.getName());
    // 3.	已知类全路径名
    try {
        Class c3 = Class.forName("com.huawei.omplatform.common.GenClass$Test01");
        System.out.println("3---"+c3.getName());
        Method[] methods = c3.getMethods();
        Test01 t = (Test01) c3.newInstance();

        for (Method method: methods){
            String s = (String) method.invoke(t,"String");
            System.out.println(s);
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (IllegalAccessException e) {
        e.printStackTrace();
    } catch (InvocationTargetException e) {
        e.printStackTrace();
    } catch (InstantiationException e) {
        e.printStackTrace();
    }
}
static class Test01{
}
getDeclaredMethods() 		 //including public, protected, default (package) access, and private methods, but excluding inherited methods.
getMethods()		//public methods of the class or interface represented by this Class object, including those declared by the class or interface and 							those inherited from superclasses and superinterfaces

    
 
```

## 2、动态代理

[Java Proxy和CGLIB动态代理原理](https://www.cnblogs.com/CarpenterLee/p/8241042.html)

> JDK Proxy会把`hashCode()`、`equals()`、`toString()`这三个非接口方法转发给`InvocationHandler`，其余的Object方法则不会转发
>
> `newProxyInstance()`会返回一个实现了指定接口的代理对象，对该对象的所有方法调用都会转发给`InvocationHandler.invoke()`方法。理解上述代码需要对Java反射机制有一定了解

```java
public class DynamicProxy<T> implements InvocationHandler {
    Person hello;
    public static  <T> T getInstance(Person person){
        return (T) Proxy.newProxyInstance(DynamicProxy.class.getClassLoader(), new Class[]{Person.class}, new DynamicProxy<>(person));
    }
    public DynamicProxy(Person hello) {
        this.hello = hello;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println(method.getDeclaringClass()+"----"+method.getName()+"---??????????????");
        return method.invoke(hello, args);
    }
    public static void main(String[] args) {
        //Person p = DynamicProxy.getInstance(new Zhangsan());
        Zhangsan zhangsan = new Zhangsan();
        Person p = (Person) Proxy.newProxyInstance(zhangsan.getClass().getClassLoader(), new Class[]{Person.class}, new DProxy(new Zhangsan()));
        p.sayHello();
    }
}
interface Person{
    void sayHello();
}
class Zhangsan implements Person{
    @Override
    public void sayHello() {
        System.out.println("hello");
    }
}
class DProxy implements InvocationHandler{

    Person person;

    public DProxy(Person person) {
        this.person = person;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println(method.getDeclaringClass()+"----"+method.getName()+"---??????????????");
        return method.invoke(person, args);
    }
}
```

## 3、cglib

> 如果对CGLIB代理之后的对象类型进行深挖，可以看到如下信息：
>
> ```
> # HelloConcrete代理对象的类型信息
> class=class cglib.HelloConcrete$$EnhancerByCGLIB$$e3734e52
> superClass=class lh.HelloConcrete
> interfaces: 
> interface net.sf.cglib.proxy.Factory
> invocationHandler=not java proxy class
> ```
>
> 我们看到使用CGLIB代理之后的对象类型是`cglib.HelloConcrete$$EnhancerByCGLIB$$e3734e52`，这是CGLIB动态生成的类型；父类是`HelloConcrete`，印证了CGLIB是通过继承实现代理；同时实现了`net.sf.cglib.proxy.Factory`接口，这个接口是CGLIB自己加入的，包含一些工具方法。
>
> 注意，既然是继承就不得不考虑final的问题。我们知道final类型不能有子类，所以CGLIB不能代理final类型，遇到这种情况会抛出类似如下异常：
>
> ```
> java.lang.IllegalArgumentException: Cannot subclass final class cglib.HelloConcrete
> ```
>
> 同样的，final方法是不能重载的，所以也不能通过CGLIB代理，遇到这种情况不会抛异常，而是会跳过final方法只代理其他方法。

