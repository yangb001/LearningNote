# 1、jdk各版本

<https://blog.csdn.net/fuhanghang/article/details/84073401>

JDK Version 1.0

**1996-01-23 Oak(橡树)**

初代版本，伟大的一个里程碑，但是是纯解释运行，使用外挂JIT，性能比较差，运行速度慢。

### JDK Version 1.1
**1997-02-19**

+ JDBC(Java DataBase Connectivity);
+ 支持内部类;
+ RMI(Remote Method Invocation) ;
+ 反射;
+ Java Bean;

### JDK Version 1.2

**1998-12-08 Playground(操场)**

+ 集合框架；
+ JIT(Just In Time)编译器；
+ 对打包的Java文件进行数字签名；
+ JFC(Java Foundation Classes)，包括Swing 1.0，拖放和Java2D类库；
+ Java插件;
+ JDBC中引入可滚动结果集，BLOB，CLOB，批量更新和用户自定义类型;
+ Applet中添加声音支持.

### JDK Version 1.3

**2000-05-08 Kestrel(红隼)**

+ Java Sound API;
+ jar文件索引;
+ 对Java的各个方面都做了大量优化和增强;

### JDK Version 1.4
**2004-02-06 Merlin(隼)**

+ XML处理;
+ Java打印服务;
+ Logging API;
+ Java Web Start;
+ JDBC 3.0 API;
+ 断言;
+ Preferences API;
+ 链式异常处理;
+ 支持IPV6;
+ 支持正则表达式;
+ 引入Imgae I/O API.

### JAVA 5
**2004-09-30 Tiger(老虎)**

+ 泛型;

+ 增强循环,可以使用迭代方式;

  ```java
  for(Object o : c)
  ```

+ 自动装箱与自动拆箱;

+ 类型安全的枚举;

+ 可变参数;

+ 静态引入;

```java
import static org.yyy.pkg.Increment;
```

+ 元数据(注解);
+ Instrumentation;

### JAVA 6
**2006-12-11 Mustang(野马)**

+ 支持脚本语言;
+ JDBC 4.0API;
+ Java Compiler API;

> 动态编译Java源文件，CompilerAPI结合反射功能就可以实现动态的产生Java代码并编译执行这些代码,有点动态语言的特征

+ 可插拔注解;
+ 增加对Native PKI(Public Key Infrastructure), Java GSS(Generic Security Service),Kerberos和LDAP(Lightweight Directory Access Protocol)支持;
+ 继承Web Services;

### JAVA 7
**2011-07-28 Dolphin(海豚)**

+ switch语句块中允许以字符串作为分支条件;
+ 在创建泛型对象时应用类型推断;
+ 在一个语句块中捕获多种异常;
+ 支持动态语言;
+ 支持try-with-resources(在一个语句块中捕获多种异常);

> 所有可关闭的类将被修改为可以实现一个Closable（可关闭的）接口

```java
try (
         InputStreamin = new FileInputStream(src);
         OutputStreamout = new FileOutputStream(dest))
 {
 //code
 }
```

+ 引入Java NIO.2开发包;
+ 数值类型可以用二进制字符串表示,并且可以在字符串表示中添加下划线;

```java
int binary = 0b1001_1001;	//	你现在可以使用0b前缀创建二进制字面量：
int one_million = 1_000_000;
```

+ 钻石型语法(在创建泛型对象时应用类型推断);

```java
Map<String, List<String>> anagrams= new HashMap<>();	//  <>被叫做diamond（钻石）运算符，这个运算符从引用的声明中推断类型。
```

+ null值得自动处理;

### JAVA 8
**2014-03-18** 

+ Lambda 表达式 − Lambda允许把函数作为一个方法的参数（函数作为参数传递进方法中）。
+ 方法引用 − 方法引用提供了非常有用的语法，可以直接引用已有Java类或对象（实例）的方法或构造器。与lambda联合使用，方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
+ 默认方法+静态方法 − 默认方法就是一个在接口里面有了一个实现的方法。

> 当一个实例实现的多个接口有相同的默认方法时，如不重写就无法判断使用哪个，编译器就会报错
>
> 	cn.hutu.Instan inherits unrelated defaults for hello() from types cn.hutu.Inter1 and cn.hutu.Inter2

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



+ 新工具 − 新的编译工具，如：Nashorn引擎 jjs、 类依赖分析器jdeps。
+ Stream API −新添加的Stream API（java.util.stream） 把真正的函数式编程风格引入到Java中。
+ Date Time API − 加强对日期与时间的处理。
+ Optional 类 − Optional 类已经成为 Java 8 类库的一部分，用来解决空指针异常。
+ Nashorn, JavaScript 引擎 − Java 8提供了一个新的Nashorn javascript引擎，它允许我们在JVM上运行特定的javascript应用。

### JAVA 9
**2017-09-22**

+ 模块系统：模块是一个包的容器，Java 9 最大的变化之一是引入了模块系统（Jigsaw 项目）。
+ REPL (JShell)：交互式编程环境。
+ HTTP 2 客户端：HTTP/2标准是HTTP协议的最新版本，新的 HTTPClient API 支持 WebSocket 和 HTTP2 流以及服务器推送特性。
+ 改进的 Javadoc：Javadoc 现在支持在 API 文档中的进行搜索。另外，Javadoc 的输出现在符合兼容 HTML5 标准。
+ 多版本兼容 JAR 包：多版本兼容 JAR 功能能让你创建仅在特定版本的 Java 环境中运行库程序时选择使用的 class 版本。
+ 集合工厂方法：List，Set 和 Map 接口中，新的静态工厂方法可以创建这些集合的不可变实例。
+ 私有接口方法：在接口中使用private私有方法。我们可以使用 private 访问修饰符在接口中编写私有方法。
+ 进程 API: 改进的 API 来控制和管理操作系统进程。引进 java.lang.ProcessHandle 及其嵌套接口 Info 来让开发者逃离时常因为要获取一个本地进程的 PID 而不得不使用本地代码的窘境。
+ 改进的 Stream API：改进的 Stream API 添加了一些便利的方法，使流处理更容易，并使用收集器编写复杂的查询。
+ 改进 try-with-resources：如果你已经有一个资源是 final 或等效于 final 变量,您可以在 try-with-resources 语句中使用该变量，而无需在 try-with-resources 语句中声明一个新变量。
+ 改进的弃用注解 @Deprecated：注解 @Deprecated 可以标记 Java API 状态，可以表示被标记的 API 将会被移除，或者已经破坏。
+ 改进钻石操作符(Diamond Operator) ：匿名类可以使用钻石操作符(Diamond Operator)。
+ 改进 Optional 类：java.util.Optional 添加了很多新的有用方法，Optional 可以直接转为 stream。
+ 多分辨率图像 API：定义多分辨率图像API，开发者可以很容易的操作和展示不同分辨率的图像了。
+ 改进的 CompletableFuture API ： CompletableFuture 类的异步机制可以在 ProcessHandle.onExit 方法退出时执行操作。
+ 轻量级的 JSON API：内置了一个轻量级的JSON API
+ 响应式流（Reactive Streams) API: Java 9中引入了新的响应式流 API 来支持 Java 9 中的响应式编程。
+ 详细参考:http://www.runoob.com/java/java9-new-features.html

### JAVA 10
**2018-03-21**

根据官网的公开资料，共有12个重要特性，如下：

+ JEP286，var 局部变量类型推断。
+ JEP296，将原来用 Mercurial 管理的众多 JDK 仓库代码，合并到一个仓库中，简化开发和管理过程。
+ JEP304，统一的垃圾回收接口。
+ JEP307，G1 垃圾回收器的并行完整垃圾回收，实现并行性来改善最坏情况下的延迟。
+ JEP310，应用程序类数据 (AppCDS) 共享，通过跨进程共享通用类元数据来减少内存占用空间，和减少启动时间。
+ JEP312，ThreadLocal 握手交互。在不进入到全局 JVM 安全点 (Safepoint) 的情况下，对线程执行回调。优化可以只停止单个线程，而不是停全部线程或一个都不停。
+ JEP313，移除 JDK 中附带的 javah 工具。可以使用 javac -h 代替。
+ JEP314，使用附加的 Unicode 语言标记扩展。
+ JEP317，能将堆内存占用分配给用户指定的备用内存设备。
+ JEP317，使用 Graal 基于 Java 的编译器，可以预先把 Java 代码编译成本地代码来提升效能。
+ JEP318，在 OpenJDK 中提供一组默认的根证书颁发机构证书。开源目前 Oracle 提供的的 Java SE 的根证书，这样 OpenJDK 对开发人员使用起来更方便。
+ JEP322，基于时间定义的发布版本，即上述提到的发布周期。版本号为\$FEATURE.\$INTERIM.\$UPDATE.\$PATCH，分别是大版本，中间版本，升级包和补丁版本。

### JAVA 11
**2018-09-25** 

翻译后的新特性有：

+ 181:Nest-Based访问控制
+ 309:动态类文件常量
+ 315:改善Aarch64 intrinsic
+ 318:无操作垃圾收集器
+ 320:消除Java EE和CORBA模块
+ 321:HTTP客户端(标准)
+ 323:局部变量的语法λ参数
+ 324:Curve25519和Curve448关键协议
+ 327:Unicode 10
+ 328:飞行记录器
+ 329:ChaCha20和Poly1305加密算法
+ 330:发射一列纵队源代码程序
+ 331:低开销堆分析
+ 332:传输层安全性(Transport Layer Security,TLS)1.3
+ 333:动作:一个可伸缩的低延迟垃圾收集器 (实验)
+ 335:反对Nashorn JavaScript引擎
+ 336:反对Pack200工具和API



# 2、Java配置及系统信息



## 1、java配置

+ java环境变量设置

  建JAVA_HOME：	C:\Program Files\Java\jdk1.8.0_66

  建CLASSPATH：	.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar

  辑path：	%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin

+ java打包编译

```java
javac -d .  test1.java		//打包编译
javac hello.test1			//运行
```

+ java打jar包方式

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

+ 基本变量调用时 值传递
+ 引用变量调用时 地址传递

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

+ connect需要设置自动提交为false	connection.setAutoCommit(false)

+ > JDBC Savepoint帮我们在事务中创建检查点（checkpoint），这样就可以回滚到指定点。当事务提交或者整个事务回滚后，为事务产生的任何保存点都会自动释放并变为无效。把事务回滚到一个保存点，会使其他所有保存点自动释放并变为无效。

+ 事务结束时，需要用connection.commit() 提交事务

+ 事务失败需要回滚时，只能将数据回滚到最近一个savepoint并且将savepoint前的事务自动提交

+ 缺点：

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

+ XA规范

> XA规范是由X/Open组织提出的分布式事务规范，只要定义了全局事务管理器(Transaction Manager) 和局部资源管理器(Resource Manager)之间的接口。事务管理器负责管理事务周期，协调资源管理器。资源管理器负责控制和管理实际的资源

+ 两段式提交

> **准备阶段**：事务管理器询问所有参与者（资源管理器）是否已做好准备提交，参与者如果已经准备好提交则回复`Prepared`，否则回复`Non-Prepared`。
>
> **提交阶段** ：协调者如果在上一阶段收到所有参与者回复的`Prepared`，则在此阶段向所有参与者发送`commit`指令，所有参与者立即执行`commit`操作；否则协调者向所有参与者发送`rollback`指令，参与者立即执行`rollback`操作



#### 1、使用atomikios实现

+ **直接使用TransactionEssentials的API**

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

+ transient	：当对象序列化时，transient关键字修饰的变量不参与序列化过程

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



## 4、java动态生成class方式

<https://www.cnblogs.com/yanjie-java/p/7940929.html>

## 5、类加载器

<https://www.cnblogs.com/yixianyixian/p/8145506.html>

<http://www.blogjava.net/zhuxing/archive/2008/08/08/220841.html>

<https://www.ibm.com/developerworks/cn/java/j-lo-classloader/>

> 第一篇：java类加载原理解析
>
> 第二篇：插件环境下类加载原理解析
>
> 第三篇：线程上下文类加载器

### 1、类加载器基本概念

> A class loader is an object that is responsible for loading classes. The class ClassLoader is an abstract class. Given the binary name of a class, a class loader should attempt to locate or generate data that constitutes a definition for the class. A typical strategy is to transform the name into a file name and then read a "class file" of that name from a file system.
>
> 类加载器是一个能够加载类的对象，ClassLoader类是一个抽象类。给一个类的二进制名称，一个类加载器应该尝试去定位或者生成这个类定义的结构数据。典型的策略是将name转换为文件名，然后从文件系统中读取该name对应的“类文件”。

	顾名思义，类加载器就是将类从硬盘（网络）加载到java虚拟机的内存中。一般情况下（特殊情况是啥？），java虚拟机从开始转换一个类的过程如下：
	
	一个java源文件（.java）通过java编译器编译以后，生成java字节码文件(.class)，通过类加载器（ClassLoader）将字节码文件加载到虚拟机中，转化为java.lang.Class的一个实例（即我们平常说的Class对象），再通过此类的newInstance() 方法（或者 new XXX()）就可以创建无数个此类的实例（实例化）：）



+ java.lang.ClassLoader介绍

	除了启动类加载器（bootstrap classloader）是由C++编写以外（先得有一个可以加载初始化java类的加载器），所有的类加载器都是java.lang.ClassLoader的实例。类加载器的工作就是找到.class的字节码文件，读取文件byte生成该类对应的Class实例。除此之外，`ClassLoader`还负责加载 Java 应用所需的资源，如图像文件和配置文件等。不过只讨论其加载类的功能。

| 部分方法                                             | 说明                                                         |
| :--------------------------------------------------- | :----------------------------------------------------------- |
| defineClass(String name, byte[] b, int off, int len) | Converts an array of bytes into an instance of class `Class`（5、若parent加载失败，在findClass方法中调用此方法自己加载） |
| findClass(String name)                               | Finds the class with the specified binary name.（2、查找class） |
| getParent()                                          | Returns the parent class loader for delegation.（4、尝试让parent classloader去加载） |
| findLoadedClass(String name)                         | Returns the class with the given binary name if this loader has been recorded by the Java virtual machine as an initiating loader of a class with that binary name（3、查看是否已经被加载） |
| loadClass(String name)                               | Loads the class with the specified binary name.（1、加载类的起点位置，供用户调用） |

### 2、类加载器结构

#### 1、jvm预定义的三种类加载器

java虚拟机（JVM）定义的类加载器主要分为两类，一类是系统预定义的，另一类是由开发人员自己实现的，系统预定义的加载器有三类：

+ 引导/启动 类加载器（bootstrap class loader）: 引导类加载器是用本地代码（C++）代码实现的。它负责将<Java_Runtime_Home>/lib 下面的类库加载进虚拟机内存中，开发者无法直接获取到引导类加载器
+ 扩展类加载器（extension class loader）： 扩展类加载器是ClassLoader的一个子类，负责将 <Java_Runtime_Home>/lib/ext 下面的类库加载进虚拟机内存中，开发者可以调用。其实现为 rt.jar中的sun.misc.Launcher$ExtClassLoader
+ 系统类加载器（system class loader）： 系统类加载器负责将应用程序的类路径（classpath）中的类库加载到内存中。开发者可以调用，实现为 rt.jar中的sun.misc.Launcher$AppClassLoader

除以上加载器外，还有特殊的线程上下文类加载器，将在以后介绍

#### 2、双亲委派机制

> 双亲委派机制指的是类加载器在加载类时，并不会直接加载，而是先委托给其parent类加载器，依次递归，如果parent加载器能够加载成功，就返回；否则就自己加载

![继承关系](D:\filespaces\images\classloader.png)

类加载器都是继承自ClassLoader的类，包括我们后面要实现的自定义类加载器，也要继承ClassLoader。下面是主要的一些方法

| 部分方法                                             | 说明                                                         |
| :--------------------------------------------------- | :----------------------------------------------------------- |
| defineClass(String name, byte[] b, int off, int len) | Converts an array of bytes into an instance of class `Class`（5、若parent加载失败，在findClass方法中调用此方法自己加载）不可继承，只需调用 |
| findClass(String name)                               | Finds the class with the specified binary name.（2、查找class） |
| getParent()                                          | Returns the parent class loader for delegation.（4、尝试让parent classloader去加载） |
| findLoadedClass(String name)                         | Returns the class with the given binary name if this loader has been recorded by the Java virtual machine as an initiating loader of a class with that binary name（3、查看是否已经被加载） |
| loadClass(String name，boolean resolve)              | Loads the class with the specified binary name.（1、加载类的起点位置，供用户调用）resolve表示是否解析 |

分析ExtClassLoader与AppClassLoader看出，这些类都没有重写loadClass的方法，因此我们可以查看ClassLoader中的loadClass方法来分析双亲委派机制

```java
protected Class<?> loadClass(String name, boolean resolve)
    throws ClassNotFoundException
    {
        synchronized (getClassLoadingLock(name)) {
            // First, check if the class has already been loaded
            Class<?> c = findLoadedClass(name);
            if (c == null) {
                long t0 = System.nanoTime();
                try {
                    if (parent != null) {
                        c = parent.loadClass(name, false);
                    } else {
                        c = findBootstrapClassOrNull(name);
                    }
                } catch (ClassNotFoundException e) {
                    // ClassNotFoundException thrown if class not found
                    // from the non-null parent class loader
                }

                if (c == null) {
                    // If still not found, then invoke findClass in order
                    // to find the class.
                    long t1 = System.nanoTime();
                    c = findClass(name);

                    // this is the defining class loader; record the stats
                    sun.misc.PerfCounter.getParentDelegationTime().addTime(t1 - t0);
                    sun.misc.PerfCounter.getFindClassTime().addElapsedTimeFrom(t1);
                    sun.misc.PerfCounter.getFindClasses().increment();
                }
            }
            if (resolve) {
                resolveClass(c);
            }
            return c;
        }
    }
```

当我们自定义一个类加载器以后，其调用规则为：

![](D:\filespaces\images\classLoader-parent.png)



> 每个classLoader和其parent classLoader并不是继承关系，而是在classLoader内部有个parent变量，该变量指向了parent classLoader，通过getParent()方法就可以获取到其parent 加载器
>
> System.out.println(ClassLoader.getSystemClassLoader()); 
>
> System.out.println(ClassLoader.getSystemClassLoader().getParent();
>
> System.out.println(ClassLoader.getSystemClassLoader().getParent().getParent());
>
> 输出：
>
> **sun.misc.Launcher$AppClassLoader@197d257**
>
> **sun.misc.Launcher$ExtClassLoader@7259da**
>
> **null**

**为什么获取扩展类加载器能获取到，获取引导类加载器为null？**

> 我们首先看一下java.lang.ClassLoader抽象类中默认实现的两个构造函数：
>
>     **protected** ClassLoader() {
>    
>         SecurityManager security = System.*getSecurityManager*();
>    
>         **if** (security != **null**) {
>    
>             security.checkCreateClassLoader();
>    
>         }
>    
>         **//****默认将父类加载器设置为系统类加载器，****getSystemClassLoader()****获取系统类加载器**
>    
>         **this**.parent = getSystemClassLoader();
>    
>         initialized = **true**;
>    
>     }
>    
>     **protected** ClassLoader(ClassLoader parent) {
>    
>         SecurityManager security = System.*getSecurityManager*();
>    
>         **if** (security != **null**) {
>    
>             security.checkCreateClassLoader();
>    
>         }
>    
>         **//****强制设置父类加载器**
>    
>         **this**.parent = parent;
>    
>         initialized = **true**;
>    
>     } 
>
>
>
> 我们看一下ClassLoader抽象类中parent成员的声明：
>
>
>
> // The parent class loader for delegation
>
>  **private** ClassLoader parent;

声明为私有变量的同时并没有对外提供可供派生类访问的public或者protected设置器接口（对应的setter方法），结合前面的测试代码的输出，我们可以推断出：

1. 系统类加载器（AppClassLoader）调用ClassLoader(ClassLoader parent)构造函数将父类加载器设置为标准扩展类加载器(ExtClassLoader)。（因为如果不强制设置，默认会通过调用getSystemClassLoader()方法获取并设置成系统类加载器，这显然和测试输出结果不符。）
2. 扩展类加载器（ExtClassLoader）调用ClassLoader(ClassLoader parent)构造函数将父类加载器设置为null。（因为如果不强制设置，默认会通过调用getSystemClassLoader()方法获取并设置成系统类加载器，这显然和测试输出结果不符。）

	**有关java.lang.ClassLoader中默认的加载委派规则前面已经分析过，如果父加载器为null，则会调用本地方法进行启动类加载尝试。所以启动类加载器、标准扩展类加载器和系统类加载器之间的委派关系事实上是仍就成立的。**



#### 3、双亲委派示例

在项目中创建一个类 GeClass，编译打包为jar文件。拷入到 <java_runtime_home>/bin/ext下，此时在扩展类的路径下与项目的classpath下都存在GeClass这个类，执行以下代码查看输出：

```java
public static void main(String[] args) throws Exception {
	test01();
} 
/**
  * 测试移动类的位置以后，是否会被不同的类加载器加载：
  *
  * 当项目classpath 与 /JAVA_HOME/jre/lib/ext下同时存在一个完全匹配类名（Fully Qualified Class Name）相同的类时，就会委托给 ExtClassLoader 加载 /lib/ext下的类
  * 删掉/bin/ext下的类时，AppClassLoader 才会加载本地项目指定的classpath中的类
  */
public static void test01() throws Exception {
    //System.out.println(System.getProperty("java.class.path"));
    //      Class<?> mouse = null;
    //      mouse = Class.forName("com.huawei.omplatform.common.GenClass");
    GenClass mouse = new GenClass();
    //System.out.println(mouse.getClass());
    System.out.println(mouse.getClass().getClassLoader());
}

--------------------
sun.misc.Launcher$ExtClassLoader@14dad5dc
```

当我们把拷入到 <java_runtime_home>/bin/ext下的jar包移除时，重新执行代码

```java
--------------------
sun.misc.Launcher$AppClassLoader@14dad5dc
```

当我们把包拷入到 <java_runtime_home>/bin下时，重新执行代码

```java
--------------------
sun.misc.Launcher$AppClassLoader@14dad5dc
```

这说明：放置在<java_runtime_home>/bin/ext下的代码会被先加载，然后不会再去加载项目classpath下的类；当放置在<java_runtime_home>/bin下时，并不会被加载，而是由AppClassLoader来加载，这是因为**虚拟机出于安全等因素考虑，不会加载< Java_Runtime_Home >/lib存在的陌生类，开发者通过将要加载的非JDK自身的类放置到此目录下期待启动类加载器加载是不可能的。**



### 3、java程序动态扩展方式

	Java的连接模型允许用户运行时扩展引用程序，既可以通过当前虚拟机中预定义的加载器加载编译时已知的类或者接口，又允许用户自行定义类装载器，在运行时动态扩展用户的程序。通过用户自定义的类装载器，你的程序可以装载在编译时并不知道或者尚未存在的类或者接口，并动态连接它们并进行有选择的解析。
	
	运行时动态扩展java应用程序有如下两个途径：

#### 1、Class.forName(...)

```java
@CallerSensitive
public static Class<?> forName(String className)
    throws ClassNotFoundException {
    Class<?> caller = Reflection.getCallerClass();
    return forName0(className, true, ClassLoader.getClassLoader(caller), caller);
}
public static Class<?> forName(String name, boolean initialize,
                                   ClassLoader loader)
	throws ClassNotFoundException{
    ...
}
```

	**这里的initialize参数表示加载完class以后是否进行初始化，如若不指定，默认会完成初始化。**
	
	有些场景下需要将initialize设置为true来强制加载同时完成初始化。例如典型的就是利用DriverManager进行JDBC驱动程序类注册的问题。因为每一个JDBC驱动程序类的静态初始化方法都用DriverManager注册驱动程序，这样才能被应用程序使用。这就要求驱动程序类必须被初始化，而不单单被加载。

#### 2、自定义类加载器

	通过前面的分析我们知道，我们可以调用除了引导类加载器以外的所有加载器来加载我们指定的类。所有我们在程序运行时就可以利用这个特性来动态载入我们想要载入的类（唯一的区别是不会被虚拟机默认载入）。

```java
public Class<?> loadClass(String name) throws ClassNotFoundException {
    return loadClass(name, false);
}
```

	需要注意的是，**使用此种方式加载的class不会被初始化**。这是与Class.forName()不用之处

### 4、常见问题分析

1. **由不同的类加载器加载的同一个class还是同一类型吗**

	在java中，一个类是由其全匹配名称（Full Qualified Class Name）来标识的，表示为包名+类名。但在jvm中，由不同类加载器加载的全匹配名称一样的类，被放置在不同的命名空间中
	
	要看是否是同一个类型，其实就是defineClass()这个方法是不是同一个，而不是通过loadClass()来判断的，defineClass()是由native方法实现的。

```java
 /**
     *  测试当两个不同的类加载器加载同一个类时，是否还是同一种类型：
     *  测试到用 AppClassLoader 同一个加载器加载出来的是同一个类
     *  其它测试结果都为false
     *  这里的不同的类加载器也包括类加载器的不同实例，如下面的 1中代码也算不同类加载器
     */
    public static void test02() throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        // 1. 以下代码也表示不同的类加载器
//        Class t1 = new TClassLoader().loadClass("C:\\temp\\test1.class");
//        Class t2 = new TClassLoader().loadClass("C:\\temp\\test1.class");
        // 2.相同的类加载器测试
        TClassLoader classLoader = new TClassLoader();
        Class t1 = classLoader.loadClass("C:\\temp\\test1.class");
        Class t2 = classLoader.loadClass("C:\\temp\\test1.class");

//        Class t1 = new TClassLoader().loadClass("com.huawei.omplatform.common.GenClass");
//        Class t2 = new T2ClassLoader().loadClass("com.huawei.omplatform.common.GenClass");
        System.out.println(t1 == t2);
        System.out.println(t1.equals(t2));
    }
1.-----------
    false
    false
2.-----------
    true
    true
```

	了解了这一点之后，就可以理解代理模式的设计动机了。代理模式是为了保证 Java 核心库的类型安全。所有 Java 应用都至少需要引用 `java.lang.Object`类，也就是说在运行的时候，`java.lang.Object`这个类需要被加载到 Java 虚拟机中。如果这个加载过程由 Java 应用自己的类加载器来完成的话，很可能就存在多个版本的 `java.lang.Object`类，而且这些类之间是不兼容的。通过代理模式，对于 Java 核心库的类的加载工作由引导类加载器来统一完成，保证了 Java 应用所使用的都是同一个版本的 Java 核心库的类，是互相兼容的。

不同的类加载器为相同名称的类创建了额外的名称空间。相同名称的类可以并存在 Java 虚拟机中，只需要用不同的类加载器来加载它们即可。不同类加载器加载的类之间是不兼容的，这就相当于在 Java 虚拟机内部创建了一个个相互隔离的 Java 类空间。这种技术在许多框架中都被用到，后面会详细介绍。

2. **在代码中直接调用Class.forName（String name）方法，到底会触发那个类加载器进行类加载行为？**

```java
@CallerSensitive
public static Class<?> forName(String className)
    throws ClassNotFoundException {
    Class<?> caller = Reflection.getCallerClass();
    return forName0(className, true, ClassLoader.getClassLoader(caller), caller);
}
```

	从forName的代码可以看出，Class.forName是使用调用者 caller的类加载器来加载要调用的类

3. **在编写自定义类加载器时，如果没有设定父加载器，那么父加载器是？**

	前面已经说了，是系统类加载器 AppClassLoader

```java
protected ClassLoader() {
    this(checkCreateClassLoader(), getSystemClassLoader());
}
@CallerSensitive
public static ClassLoader getSystemClassLoader() {
    initSystemClassLoader();
    if (scl == null) {
        return null;
    }
    SecurityManager sm = System.getSecurityManager();
    if (sm != null) {
        checkClassLoaderPermission(scl, Reflection.getCallerClass());
    }
    return scl;
}
private static synchronized void initSystemClassLoader() {
    ...
    sun.misc.Launcher l = sun.misc.Launcher.getLauncher();
    if (l != null) {
        Throwable oops = null;
        scl = l.getClassLoader();
        try {
            scl = AccessController.doPrivileged(
                new SystemClassLoaderAction(scl));
            ...
        }
        sclSet = true;
    }
}

```

4. **在编写自定义类加载器时，如果将父类加载器强制设置为null，那么会有什么影响？如果自定义的类加载器不能加载指定类，就肯定会加载失败吗？**

	JVM规范中规定如果用户自定义的类加载器将父类加载器强制设置为null，那么会自动将启动类加载器设置为当前用户自定义类加载器的父类加载器。
	
	**即时用户自定义类加载器不指定父类加载器，那么，同样可以加载到<Java_Runtime_Home>/lib下的类，但此时就不能够加载<Java_Runtime_Home>/lib/ext目录下的类了。**

  	**说明：问题3和问题4的推断结论是基于用户自定义的类加载器本身延续了java.lang.ClassLoader.loadClass（...）默认委派逻辑，如果用户对这一默认委派逻辑进行了改变，以上推断结论就不一定成立了，详见问题5。**

5. **编写自定义类加载器时，一般有哪些注意点**

+ 尽量不要重写loadClass方法里面的类加载委派关系

```java
/**
 * 测试覆写loadclass，并且破坏双亲原则时出的问题：
 * return this.findClass(name);
 * 将内容改为以上代码后，jvm启动时，会调用此方法加载指定的类
 * 但是由于没有向上追溯，所有的bootClassLoader与 ExtClassLoader 要加载的类都不会加载进来，
 * 直接报错   java.lang.NoClassDefFoundError:java/lang/Object
 *
 * @param name
 * @return
 * @throws ClassNotFoundException
 */
@Override
public Class<?> loadClass(String name) throws ClassNotFoundException {
    return super.loadClass(name);
}
```

+ 正确设置父类加载器

+ 自定义的寻找类的方式都定义在findClass方法里，保证寻找的正确性，调用defineClass方法加载

### 5、自定义类加载器

```java
/**
 * 自定义类加载器，加载绝对路径下的class文件
 */
public class TClassLoader extends ClassLoader {

    /**
     * 测试覆写loadclass，并且破坏双亲原则时出的问题：
     * return this.findClass(name);
     * 将内容改为以上代码后，jvm启动时，会调用此方法加载指定的类
     * 但是由于没有向上追溯，所有的bootClassLoader与 ExtClassLoader 要加载的类都不会加载进来，
     * 直接报错   java.lang.NoClassDefFoundError:java/lang/Object
     *
     * @param name
     * @return
     * @throws ClassNotFoundException
     */
    @Override
    public Class<?> loadClass(String name) throws ClassNotFoundException {
        return super.loadClass(name);
    }

    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        File file = new File(name);
        Class clazz = null;

        if (!file.exists() && !file.isFile()) {
            return null;
        }
        try {
            clazz = findLoadedClass("test1");   //暂时无法从file里把包名和类名提取出来，故查看情况写死
            if (clazz != null) {
                return clazz;
            }
            String file_name = file.getName().substring(0, file.getName().lastIndexOf("."));
            byte[] bytes = Files.readAllBytes(file.toPath());
            clazz = defineClass(file_name, bytes, 0, bytes.length);
            return clazz;
//            return super.findClass(name);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return clazz;
//        return super.findClass(name);
    }

}
```

## 6、类卸载





```java
/**
 * 自定义类加载器
 */
public class OmClassLoader extends ClassLoader {
    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        File file = new File(name);
        if (!file.exists() && !file.isFile()) {
            return null;
        }
        try {
            byte[] bytes = Files.readAllBytes(file.toPath());
            Class clazz = defineClass("test1", bytes, 0, bytes.length);
            return clazz;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return super.findClass(name);
    }
    public Class<?> pathFindClass(String name, String path) throws ClassNotFoundException {
        String url = path + File.separator + name;
        return findClass(url);
    }
}
public static void main(String[] args){
	OmClassLoader classLoader = new OmClassLoader();
    Class test1 = classLoader.loadClass(classpath);
    Method[] ms =  test1.getMethods();
    Method[] dms = test1.getDeclaredMethods();
    Object t = test1.newInstance();
    for (int i = 0; i < ms.length ; i++) {
        if(ms[i].getName().equals("sayHello")){
            ms[i].invoke(t,null);
        }
    }
}
```



# 7、java特性

## 1、lambda表达式

- lambda表达式修改局部变量出错

> Local variable result defined in an enclosing scope must be final or effectively final
>
> Error:(17, 91) java: 从lambda 表达式引用的本地变量必须是最终变量或实际上的最终变量

**lambda表达式相当于一个内部类**

因为生命周期的原因。方法中的局部变量，方法结束后这个变量就要释放掉，final保证这个变量始终指向一个对象。首先，内部类和外部类其实是处于同一个级别，内部类不会因为定义在方法中就会随着方法的执行完毕而跟随者被销毁。问题就来了，如果外部类的方法中的变量不定义final，那么当外部类方法执行完毕的时候，这个局部变量肯定也就被GC了，然而内部类的某个方法还没有执行完，这个时候他所引用的外部变量已经找不到了。如果定义为final，java会将这个变量复制一份作为成员变量内置于内部类中，这样的话，由于final所修饰的值始终无法改变，所以这个变量所指向的内存区域就不会变。 **为了解决：局部变量的生命周期与局部内部类的对象的生命周期的不一致性问题**

java1.8的编译变得更加智能了，在局部变量没有重新赋值的情况下，它默认局部变量为final型，认为你只是忘记加final声明了而已。如果你重新给局部变量改变了值或引用，那就无法默认为final了，所以报错

当然啦，你要是一定要在Lambda表达式里面修改外部变量的值也是可以的，可以将变量定义为实例变量或者将变量定义为数组。

原文：<https://blog.csdn.net/u010393325/article/details/80643636>

