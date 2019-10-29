# Maven 
## 1、Maven简介

Maven官网： <https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html>



## 2、Maven的依赖体系

- 依赖参照： <https://www.cnblogs.com/WJ5888/p/4348506.html>

但是我按时测试有点问题

- 依赖优化： <https://www.cnblogs.com/WJ5888/p/4354064.html>


## 3、Maven父子工程依赖jar传递方式
#### 1、如果父项目pom中使用的是：

<dependencies>
 
     ....
 
</dependencies>
方式，

则子项目pom会自动使用pom中的jar包。

 

如果你需要子类工程直接自动引用父类的jar包，可以使用这种管理方法

#### 2、如果父项目pom使用

<dependencyManagement>
 
     <dependencies>
 
          ....
 
     </dependencies>
 
</dependencyManagement>
方式，

则子项目pom不会自动使用父pom中的jar包，

如果需要使用，就要给出groupId和artifactId，无需给出version

使用<dependencyManagement>是为了统一管理版本信息

在子工程中使用时，还是需要引入坐标的，但是不需要给出version

在我们项目顶层的POM文件中，<dependencyManagement>元素。

通过它元素来管理jar包的版本，

让子项目中引用一个依赖而不用显示的列出版本号。

Maven会沿着父子层次向上找，

直到找到一个拥有dependencyManagement元素的项目，

然后它就会使用在这个dependencyManagement元素中指定的版本号。

## 4、其它
### 1.问题： springboot中引入 zookeeper时日志包冲突报错

```java
// springboot中引入 zookeeper时报错
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/D:/apache-maven-3.3.9/repository/org/slf4j/slf4j-log4j12/1.7.28/slf4j-log4j12-1.7.28.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/D:/apache-maven-3.3.9/repository/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar!/org/slf4j/impl/StaticLoggerBinder.class]
```

- 解决：

```bash
mvn dependency:tree	# 查看maven依赖那些包冲突

在 pom/xml中排除掉就ok
```


