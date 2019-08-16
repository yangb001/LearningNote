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

```
顾名思义，类加载器就是将类从硬盘（网络）加载到java虚拟机的内存中。一般情况下（特殊情况是啥？），java虚拟机从开始转换一个类的过程如下：

一个java源文件（.java）通过java编译器编译以后，生成java字节码文件(.class)，通过类加载器（ClassLoader）将字节码文件加载到虚拟机中，转化为java.lang.Class的一个实例（即我们平常说的Class对象），再通过此类的newInstance() 方法（或者 new XXX()）就可以创建无数个此类的实例（实例化）：）
```



- java.lang.ClassLoader介绍

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

- 引导/启动 类加载器（bootstrap class loader）: 引导类加载器是用本地代码（C++）代码实现的。它负责将<Java_Runtime_Home>/lib 下面的类库或者被-Xbootclasspath参数限定的类 加载进虚拟机内存中，开发者无法直接获取到引导类加载器
- 扩展类加载器（extension class loader）： 扩展类加载器是ClassLoader的一个子类，负责将 <Java_Runtime_Home>/lib/ext 下面的类库或者被java.ext.dirs系统变量指定的类加载进虚拟机内存中，开发者可以调用。其实现为 rt.jar中的sun.misc.Launcher$ExtClassLoader
- 系统类加载器（system class loader）： 系统类加载器负责将应用程序的类路径（classpath）中的类库加载到内存中。开发者可以调用，实现为 rt.jar中的sun.misc.Launcher$AppClassLoader

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
> ```java
> **protected** ClassLoader() {
>    
>     SecurityManager security = System.*getSecurityManager*();
>    
>     **if** (security != **null**) {
>    
>         security.checkCreateClassLoader();
>    
>     }
>    
>     **//****默认将父类加载器设置为系统类加载器，****getSystemClassLoader()****获取系统类加载器**
>    
>     **this**.parent = getSystemClassLoader();
>    
>     initialized = **true**;
>    
> }
>    
> **protected** ClassLoader(ClassLoader parent) {
>    
>     SecurityManager security = System.*getSecurityManager*();
>    
>     **if** (security != **null**) {
>    
>         security.checkCreateClassLoader();
>    
>     }
>    
>     **//****强制设置父类加载器**
>    
>     **this**.parent = parent;
>    
>     initialized = **true**;
>    
> } 
> ```
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

#### 4、获取javapath的方式

```java
/**
     *  在运行时获取 类加载器能够加载哪些路径下的类的方法
     */
public static void test03(){
    // 1. 系统类加载器与 扩展类加载器都继承自 URLClassLoader， getUrls方法
    URLClassLoader urlClassLoader = (URLClassLoader) ClassLoader.getSystemClassLoader();

    // 获取到扩展类加载器
    //URLClassLoader urlClassLoader = (URLClassLoader) ClassLoader.getSystemClassLoader().getParent();
    for (URL url : urlClassLoader.getURLs()) {
        System.out.println(url);
    }
    // 2. 获取系统属性 java.class.path来查看
    System.out.println(System.getProperty("java.class.path"));
    System.getProperty("sun.boot.class.path")；
        System.getProperty("java.ext.dirs") 
}
```



### 3、java程序动态扩展方式

```
Java的连接模型允许用户运行时扩展引用程序，既可以通过当前虚拟机中预定义的加载器加载编译时已知的类或者接口，又允许用户自行定义类装载器，在运行时动态扩展用户的程序。通过用户自定义的类装载器，你的程序可以装载在编译时并不知道或者尚未存在的类或者接口，并动态连接它们并进行有选择的解析。

运行时动态扩展java应用程序有如下两个途径：
```

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

```
**这里的initialize参数表示加载完class以后是否进行初始化，如若不指定，默认会完成初始化。**

有些场景下需要将initialize设置为true来强制加载同时完成初始化。例如典型的就是利用DriverManager进行JDBC驱动程序类注册的问题。因为每一个JDBC驱动程序类的静态初始化方法都用DriverManager注册驱动程序，这样才能被应用程序使用。这就要求驱动程序类必须被初始化，而不单单被加载。
```

#### 2、自定义类加载器

```
通过前面的分析我们知道，我们可以调用除了引导类加载器以外的所有加载器来加载我们指定的类。所有我们在程序运行时就可以利用这个特性来动态载入我们想要载入的类（唯一的区别是不会被虚拟机默认载入）。
```

```java
public Class<?> loadClass(String name) throws ClassNotFoundException {
    return loadClass(name, false);
}
```

```
需要注意的是，**使用此种方式加载的class不会被初始化**。这是与Class.forName()不用之处

```

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

```
了解了这一点之后，就可以理解代理模式的设计动机了。代理模式是为了保证 Java 核心库的类型安全。所有 Java 应用都至少需要引用 `java.lang.Object`类，也就是说在运行的时候，`java.lang.Object`这个类需要被加载到 Java 虚拟机中。如果这个加载过程由 Java 应用自己的类加载器来完成的话，很可能就存在多个版本的 `java.lang.Object`类，而且这些类之间是不兼容的。通过代理模式，对于 Java 核心库的类的加载工作由引导类加载器来统一完成，保证了 Java 应用所使用的都是同一个版本的 Java 核心库的类，是互相兼容的。

```

不同的类加载器为相同名称的类创建了额外的名称空间。相同名称的类可以并存在 Java 虚拟机中，只需要用不同的类加载器来加载它们即可。不同类加载器加载的类之间是不兼容的，这就相当于在 Java 虚拟机内部创建了一个个相互隔离的 Java 类空间。这种技术在许多框架中都被用到，后面会详细介绍。

1. **在代码中直接调用Class.forName（String name）方法，到底会触发那个类加载器进行类加载行为？**

```java
@CallerSensitive
public static Class<?> forName(String className)
    throws ClassNotFoundException {
    Class<?> caller = Reflection.getCallerClass();
    return forName0(className, true, ClassLoader.getClassLoader(caller), caller);
}
```

```
从forName的代码可以看出，Class.forName是使用调用者 caller的类加载器来加载要调用的类

```

1. **在编写自定义类加载器时，如果没有设定父加载器，那么父加载器是？**

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

1. **在编写自定义类加载器时，如果将父类加载器强制设置为null，那么会有什么影响？如果自定义的类加载器不能加载指定类，就肯定会加载失败吗？**

   JVM规范中规定如果用户自定义的类加载器将父类加载器强制设置为null，那么会自动将启动类加载器设置为当前用户自定义类加载器的父类加载器。

   **即时用户自定义类加载器不指定父类加载器，那么，同样可以加载到<Java_Runtime_Home>/lib下的类，但此时就不能够加载<Java_Runtime_Home>/lib/ext目录下的类了。**

   ```
   **说明：问题3和问题4的推断结论是基于用户自定义的类加载器本身延续了java.lang.ClassLoader.loadClass（...）默认委派逻辑，如果用户对这一默认委派逻辑进行了改变，以上推断结论就不一定成立了，详见问题5。**
   
   ```

2. **编写自定义类加载器时，一般有哪些注意点**

- 尽量不要重写loadClass方法里面的类加载委派关系

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

- 正确设置父类加载器
- 自定义的寻找类的方式都定义在findClass方法里，保证寻找的正确性，调用defineClass方法加载

1. 类加载器是在什么时候调用的，被谁调用的？

   在7.3中有回答

2. 比如说jdbc驱动类，为什么以前要class.forName硬编码加载，为什么现在的SPI机制能实现？为什么没法自动加载，各厂商实现的驱动类不都是在classpath下吗？

   暂时理解是：线程上下文类加载器要解决的问题是，在BootstrapClassLoader加载的类中，调用到了本来应该由AppClassLoader加载的A类，但由于BootstrapClassLoader比AppClassLoader先加载，这种情况下A类没有加载进来，BootstrapClassLoader有无法委派给AppClassLoader去加载（如果委派了会不会死循环~o~）.所以就出现了ThreadContextClassLoader来默认获取到AppCLassLoader来先把A类加载进来，然后继续执行BootstrapClassLoader的工作

> Context ClassLoader提供一个突破委托代理机制的后门。虚拟机通过父子层次关系组织管理ClassLoader，没有个ClassLoader都有一个Parent ClassLoader（BootStartp不在此范围之内），当要求一个ClassLoader装载一个类是，他首先请求Parent ClassLoader去装载，只有parent ClassLoader装载失败，才会尝试自己装载。  
>
> 某些时候这种顺序机制会造成困扰，特别是jvm需要动态载入有开发者提供的资源时。就以JNDI为例，JNDI的类是由bootstarp ClassLoader从rt.jar中间载入的，但是JNDI具体的核心驱动是由正式的实现提供的，并且通常会处于-cp参数之下（注：也就是默认的System ClassLoader管理），这就要求bootstartp ClassLoader去载入只有SystemClassLoader可见的类，正常的逻辑就没办法处理。怎么办呢？parent可以通过获得当前调用Thread的方法获得调用线程的Context ClassLoder 来载入类。

1. 由同一套双亲委派模型下的类加载器加载的类是放在同一个命名空间中吗？不在同一个命名空间中的类是不是无法使用

   <https://blog.csdn.net/shiziaishuijiao/article/details/40804161>

   Java虚拟机为每个类加载器维护了一个表，其中记录了将该类加载器作为初始类加载器的所有类型。在加载一个类时，虚拟机使用这些列表来决定是否一个类已经被特定的类加载器加载过了。

   根据Java虚拟机规范规定，在这个过程中涉及的所有类加载器--即从系统类加载器到根类加载器间，参与过加载的，都被标记为该类型的初始类加载器

   <https://www.cnblogs.com/linlf03/p/11028633.html>

   每个类加载器都有自己的命名空间，命名空间由该加载器及所有父加载器所加载的类组成。

   在同一个命名空间中，不会出现类的完整名字（包括类的包名）相同的两个类。

   在不同的命名空间中，有可能会出现类的完整名字（包括类的包名）相同的两个类。

   **不同类加载器的命名空间关系**

   同一个命名空间内的类是相互可见的

   子加载器的命名空间包含所有父加载器的命名空间。因此由子加载器加载的类能看见父加载器加载的类。例如系统类加载器加载的类能看见根类加载器加载的类。

   由父加载器加载的类不能看见子加载器加载的类。

   如果两个类加载器之间没有直接或间接的父子关系，那么他们各自加载的类相互不可见。

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

### 6、线程上下文类加载器



### 7、类加载过程

<https://www.cnblogs.com/aspirant/p/7200523.html>

```
**类从被加载到虚拟机内存中开始，到卸载出内存为止，它的整个生命周期包括：加载（Loading）、验证（Verification）、准备(Preparation)、解析(Resolution)、初始化(Initialization)、使用(Using)和卸载(Unloading)7个阶段。其中准备、验证、解析3个部分统称为连接（Linking）**

```





![](D:\filespaces\images\classloadprocess.png)

**类加载过程分为三步：加载，连接，初始化**

#### 1、加载

```
加载过程就是利用类加载器，根据类的全匹配名，读取二进制字节流到jvm内部的过程（并没有指明要从一个Class文件中获取，可以从其他渠道，譬如：网络、动态生成、数据库等）；

将字节流代表的静态存储结构转换为方法区的运行时数据结构（hotspot选择将Class对象存储在方法区中，Java虚拟机规范并没有明确要求一定要存储在方法区或堆区中）

将之转换为一个与目标对应的java.lang.Class对象,作为方法区这个类的各种数据的访问入口.

```

加载阶段和连接阶段（Linking）的部分内容（如一部分字节码文件格式验证动作）是交叉进行的，加载阶段尚未完成，连接阶段可能已经开始，但这些夹在加载阶段之中进行的动作，仍然属于连接阶段的内容，这两个阶段的开始时间仍然保持着固定的先后顺序。

#### 2、连接

- 验证

  这一阶段的目的是为了确保Class文件的字节流中包含的信息符合当前虚拟机的要求，并且不会危害虚拟机自身的安全。

  验证阶段大致会完成4个阶段的检验动作：

  1. 文件格式验证：验证字节流是否符合Class文件格式的规范；例如：是否以魔术0xCAFEBABE开头、主次版本号是否在当前虚拟机的处理范围之内、常量池中的常量是否有不被支持的类型。
  2. 元数据验证：对字节码描述的信息进行语义分析（注意：对比javac编译阶段的语义分析），以保证其描述的信息符合Java语言规范的要求；例如：这个类是否有父类，除了java.lang.Object之外。
  3. 字节码验证：通过数据流和控制流分析，确定程序语义是合法的、符合逻辑的。
  4. 符号引用验证：确保解析动作能正确执行。

  验证阶段是非常重要的，但不是必须的，它对程序运行期没有影响，如果所引用的类经过反复验证，那么可以考虑采用-Xverifynone参数来关闭大部分的类验证措施，以缩短虚拟机类加载的时间。

- 准备

  为类中的所有静态变量分配内存空间，并为其设置一个初始化值，这里所说的初始值“通常情况”下是数据类型的零值（由于还没有产生对象，实例变量将不再此操作范围内）

  **至于“特殊情况”是指：public static final int value=123，即当类字段的字段属性是ConstantValue时，会在准备阶段初始化为指定的值，所以标注为final之后，value的值在准备阶段初始化为123而非0.**

- 解析

  将常量池中的符号引用转化为直接引用（得到类或字段、方法在内存中的指针或者偏移量，一遍直接调用该方法）。此阶段可以在初始化之后进行

#### 3、初始化

```
在连接过程的准备阶段，类的静态变量已经被jvm赋过一次默认的初始值。而在初始化阶段，则是根据程序员的逻辑和赋值情况去初始化静态变量或资源。或者说：初始化阶段是执行类构造器`<clinit>()`方法的过程.

```

```java
public static int value1  = 5;
public static int value2  = 6;
static{
    value2 = 66;
}
```

```
如上段代码，在准备阶段后 value1 = 0,value2 = 0

在初始化阶段以后，value1 = 6,value2 = 66

由于父类的`<clinit>()`方法先执行，也就意味着父类中定义的静态语句块要优先于子类的变量赋值操作。

`<clinit>()`方法对于类或者接口来说并不是必需的，如果一个类中没有静态语句块，也没有对变量的赋值操作，那么编译器可以不为这个类生产`<clinit>()`方法。

接口中不能使用静态语句块，但仍然有变量初始化的赋值操作，因此接口与类一样都会生成`<clinit>()`方法。但接口与类不同的是，执行接口的`<clinit>()`方法不需要先执行父接口的`<clinit>()`方法。只有当父接口中定义的变量使用时，父接口才会初始化。另外，接口的实现类在初始化时也一样不会执行接口的`<clinit>()`方法。

```

- 所有类变量初始化语句和静态代码块都会在编译时被前端编译器放在收集器里头，存放到一个特殊的方法中，这个方法就是<clinit>方法，即类/接口初始化方法，该方法只能在类加载的过程中由JVM调用；
- 编译器收集的顺序是由语句在源文件中出现的顺序所决定的，静态语句块中只能访问到定义在静态语句块之前的变量；
- 如果超类还没有被初始化，那么优先对超类初始化，但在<clinit>方法内部不会显示调用超类的<clinit>方法，由JVM负责保证一个类的<clinit>方法执行之前，它的超类<clinit>方法已经被执行。
- JVM必须确保一个类在初始化的过程中，如果是多线程需要同时初始化它，仅仅只能允许其中一个线程对其执行初始化操作，其余线程必须等待，只有在活动线程执行完对类的初始化操作之后，才会通知正在等待的其他线程。(所以可以利用静态内部类实现线程安全的单例模式)
- 如果一个类没有声明任何的类变量，也没有静态代码块，那么可以没有类<clinit>方法；

虚拟机规范严格规定了有且只有5中情况（jdk1.7）必须对类进行“初始化”（而加载、验证、准备自然需要在此之前开始）：

1. **遇到new,getstatic,putstatic,invokestatic这失调字节码指令时，如果类没有进行过初始化，则需要先触发其初始化。生成这4条指令的最常见的Java代码场景是：使用new关键字实例化对象的时候、读取或设置一个类的静态字段（被final修饰、已在编译器把结果放入常量池的静态字段除外）的时候，以及调用一个类的静态方法的时候。**
2. **使用java.lang.reflect包的方法对类进行反射调用的时候，如果类没有进行过初始化，则需要先触发其初始化。**
3. **当初始化一个类的时候，如果发现其父类还没有进行过初始化，则需要先触发其父类的初始化。**
4. **当虚拟机启动时，用户需要指定一个要执行的主类（包含main()方法的那个类），虚拟机会先初始化这个主类。**
5. **当使用jdk1.7动态语言支持时，如果一个java.lang.invoke.MethodHandle实例最后的解析结果REF_getstatic,REF_putstatic,REF_invokeStatic的方法句柄，并且这个方法句柄所对应的类没有进行初始化，则需要先出触发其初始化。**

ps：

**通过子类引用父类的静态字段，不会导致子类初始化**

**通过数组定义来引用类，不会触发此类的初始化**

**常量在编译阶段会存入调用类的常量池中，本质上并没有直接引用到定义常量的类，因此不会触发定义常量的类的初始化**。如下：

```java
public class ConstClass {
    static
    {
        System.out.println("ConstClass init!");
    }
    public static  final String HELLOWORLD = "hello world";
}
public class NotInitialization {
    public static void main(String[] args)
    {
        System.out.println(ConstClass.HELLOWORLD);
    }
}
```



练习： 请问输出是啥

```java
public class SSClass{
    static {
        System.out.println("SSClass");
    }
}   
public class SuperClass extends SSClass{
    static {
        System.out.println("SuperClass init!");
    }
 
    public static int value = 123;
 
    public SuperClass() {
        System.out.println("init SuperClass");
    }
}
public class SubClass extends SuperClass {
    static {
        System.out.println("SubClass init");
    }
 
    static int a;
 
    public SubClass() {
        System.out.println("init SubClass");
    }
}
public class NotInitialization {
    public static void main(String[] args) {
        System.out.println(SubClass.value);
    }
}
```

> SSClass
> SuperClass init!
> 123
>
> 也许有人会疑问：为什么没有输出SubClass init。ok~解释一下：对于静态字段，只有直接定义这个字段的类才会被初始化，因此通过其子类来引用父类中定义的静态字段，只会触发父类的初始化而不会触发子类的初始化。





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

