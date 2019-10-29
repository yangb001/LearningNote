## 1、prototype与singleton的区别

```java
@Scope("prototype")
@Controller
```

添加多例模式后，spring会给每次请求创建一个处理类



```
@Autowire
HttpServletRequest request;
```

首先，Controller的确是单实例的，如果请求并发高会不会导致多个线程用到同一个请求的HttpServletRequest对象？答案是不会的。

实际上Autowire进来的并不是原始的HttpServletRequest对象，而是HttpServletRequest的一个代理类。实际上它会通过

```
((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest()
```

这样的方式来获取真正的Request对象。而RequestContextHolder是通过ThreadLocal来实现的，可以保证每个线程获取得到的Request对象一定是当前请求的Request对象，从而保证线程安全。

```
prototype是多例，

singleton是单例模式，单例模式下，
```

参考：：

#### SpringMVC是单例的，高并发情况下，如何保证性能的？

2017年12月08日 16:20:24 [wei55255555](https://me.csdn.net/wei55255555) 阅读数 863

<https://blog.csdn.net/wei55255555/article/details/78752858>

首先在大家的思考中，肯定有影响的，你想想，单例顾名思义：一个个排队过...  高访问量的时候，你能想象服务器的压力了... 而且用户体验也不怎么好，等待太久~



实质上这种理解是错误的，Java里有个API叫做ThreadLocal，spring单例模式下用它来切换不同线程之间的参数。用ThreadLocal是为了保证线程安全，实际上ThreadLoacal的key就是当前线程的Thread实例。单例模式下，spring把每个线程可能存在线程安全问题的参数值放进了ThreadLocal。这样虽然是一个实例在操作，但是不同线程下的数据互相之间都是隔离的，因为运行时创建和销毁的bean大大减少了，所以大多数场景下这种方式对内存资源的消耗较少，而且并发越高优势越明显。

总的来说就是，单利模式因为大大节省了实例的创建和销毁，有利于提高性能，而ThreadLocal用来保证线程安全性。
另外补充说一句，单例模式是spring推荐的配置，它在高并发下能极大的节省资源，提高服务抗压能力。spring IOC的bean管理器是“绝对的线程安全”。

## 2、打印日志

```yaml
logging:
  file: d:\log.txt
  root:
    level: debug
  level:
    cn.masic.tmall.mapper: debug
```

## 3、mybatis-generator	(mybatis自动生成mapper及xml文件)

配置文件如下：

```
generator.properties
```

```pr
jdbc.driverClass=com.mysql.jdbc.Driver
jdbc.connectionURL=jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
jdbc.userId=root
jdbc.password=root
```

```
generatorConfig.xml
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <properties resource="generator.properties"/>
    <context id="MySqlContext" targetRuntime="MyBatis3" defaultModelType="flat">
        <property name="beginningDelimiter" value="`"/>
        <property name="endingDelimiter" value="`"/>
        <property name="javaFileEncoding" value="UTF-8"/>
        <!-- 为模型生成序列化方法-->
        <plugin type="org.mybatis.generator.plugins.SerializablePlugin"/>
        <!-- 为生成的Java模型创建一个toString方法 -->
        <plugin type="org.mybatis.generator.plugins.ToStringPlugin"/>
        <!--可以自定义生成model的代码注释-->
        <commentGenerator type="cn.hutu.generator.CommentGenerator">
            <!-- 是否去除自动生成的注释 true：是 ： false:否 -->
            <property name="suppressAllComments" value="true"/>
            <property name="suppressDate" value="true"/>
            <property name="addRemarkComments" value="true"/>
        </commentGenerator>
        <!--配置数据库连接-->
        <jdbcConnection driverClass="${jdbc.driverClass}"
                        connectionURL="${jdbc.connectionURL}"
                        userId="${jdbc.userId}"
                        password="${jdbc.password}">
            <!--解决mysql驱动升级到8.0后不生成指定数据库代码的问题-->
            <property name="nullCatalogMeansCurrent" value="true" />
        </jdbcConnection>
        <!--指定生成model的路径-->
        <javaModelGenerator targetPackage="cn.hutu.model" targetProject="src\main\java"/>
        <!--指定生成mapper.xml的路径-->
        <sqlMapGenerator targetPackage="cn.hutu.mapper" targetProject="src\main\resources"/>
        <!--指定生成mapper接口的的路径-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="cn.hutu.mapper"
                             targetProject="src\main\java"/>
        <!--生成全部表tableName设为%-->
        <table tableName="pms_brand">
            <generatedKey column="id" sqlStatement="MySql" identity="true"/>
        </table>
    </context>
</generatorConfiguration>
```

自定义注解生成器：

```java
package cn.hutu.generator;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.CompilationUnit;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.FullyQualifiedJavaType;
import org.mybatis.generator.internal.DefaultCommentGenerator;
import org.mybatis.generator.internal.util.StringUtility;

import java.util.Properties;

/**
 * 自定义注释生成器
 * Created by macro on 2018/4/26.
 */
public class CommentGenerator extends DefaultCommentGenerator {
    private boolean addRemarkComments = false;
    private static final String EXAMPLE_SUFFIX="Example";
    private static final String API_MODEL_PROPERTY_FULL_CLASS_NAME="io.swagger.annotations.ApiModelProperty";

    /**
     * 设置用户配置的参数
     */
    @Override
    public void addConfigurationProperties(Properties properties) {
        super.addConfigurationProperties(properties);
        this.addRemarkComments = StringUtility.isTrue(properties.getProperty("addRemarkComments"));
    }

    /**
     * 给字段添加注释
     */
    @Override
    public void addFieldComment(Field field, IntrospectedTable introspectedTable,
                                IntrospectedColumn introspectedColumn) {
        String remarks = introspectedColumn.getRemarks();
        //根据参数和备注信息判断是否添加备注信息
        if(addRemarkComments&&StringUtility.stringHasValue(remarks)){
//            addFieldJavaDoc(field, remarks);
            //数据库中特殊字符需要转义
            if(remarks.contains("\"")){
                remarks = remarks.replace("\"","'");
            }
            //给model的字段添加swagger注解
            field.addJavaDocLine("@ApiModelProperty(value = \""+remarks+"\")");
        }
    }

    /**
     * 给model的字段添加注释
     */
    private void addFieldJavaDoc(Field field, String remarks) {
        //文档注释开始
        field.addJavaDocLine("/**");
        //获取数据库字段的备注信息
        String[] remarkLines = remarks.split(System.getProperty("line.separator"));
        for(String remarkLine:remarkLines){
            field.addJavaDocLine(" * "+remarkLine);
        }
        addJavadocTag(field, false);
        field.addJavaDocLine(" */");
    }

    @Override
    public void addJavaFileComment(CompilationUnit compilationUnit) {
        super.addJavaFileComment(compilationUnit);
        //只在model中添加swagger注解类的导入
        if(!compilationUnit.isJavaInterface()&&!compilationUnit.getType().getFullyQualifiedName().contains(EXAMPLE_SUFFIX)){
            compilationUnit.addImportedType(new FullyQualifiedJavaType(API_MODEL_PROPERTY_FULL_CLASS_NAME));
        }
    }
}

```

生成代码main：

```java
package cn.hutu.generator;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 用于生产MBG的代码
 * Created by macro on 2018/4/26.
 */
public class Generator {
    public static void main(String[] args) throws Exception {
        //MBG 执行过程中的警告信息
        List<String> warnings = new ArrayList<String>();
        //当生成的代码重复时，覆盖原代码
        boolean overwrite = true;
        //读取我们的 MBG 配置文件
        InputStream is = Generator.class.getResourceAsStream("/generatorConfig.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(is);
        is.close();

        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        //创建 MBG
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        //执行生成代码
        myBatisGenerator.generate(null);
        //输出警告信息
        for (String warning : warnings) {
            System.out.println(warning);
        }
    }
}

```

## 4、mybatis配置扫描mapper

```java
package cn.hutu.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * mybatis配置类
 *
 */
@Configuration
@MapperScan({"cn.hutu.mapper"})
public class MybatisConfig {
}
```

## 5、Springboot：jar中没有主清单属性

情况： 在项目在idea中正常启动，但是打包成jar后，用java -jar命令启动时报：xxx.jar中没有主清单属性

原因：jar中的META-INF文件夹下有一个MANIFEST.MF的文件夹，指明了程序的入口及版本信息等内容

```
Main-Class代表了Spring Boot中启动jar包的程序

Start-Class属性就代表了Spring Boot程序的入口类，这个类中应该有一个main方法 

Spring-Boot-Classes代表了类的路径，所有编译后的class文件，以及配置文件，都存储在该路径下

Spring-Boot-Lib表示依赖的jar包存储的位置

如果没有这些属性，就会报错
```

解决办法：在pom中添加一个SpringBoot的构建的插件，然后重新运行 mvn install（仍报错，将语句移动到<repositories>上方）

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

## 6、springboot-security配置过滤器的几种方式

1.方式一 ： 代码注册bean

```java
//实现filter接口
public class VolidateTokenFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        Enumeration<String> attributes = servletRequest.getAttributeNames();
        System.out.println(attributes);
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
//
@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean tokenVolidateBean(){
        FilterRegistrationBean registrationBean = new FilterRegistrationBean();
        registrationBean.setFilter(
            new VolidateTokenFilter()		//here :)
        );
        registrationBean.addUrlPatterns("/*");
        registrationBean.setName("tokenVolidateBean");
        return registrationBean;
    }
}
```

2.方式二：自动扫描注册

```java
@Order(1)   //越小越先执行
@WebFilter(filterName = "tokenFilter",urlPatterns = {"/*"})
public class TokenFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("这是自动扫描注册的filter");
        SecurityContext context = SecurityContextHolder.getContext();
    }

    @Override
    public void destroy() {

    }
}

@ServletComponentScan({"cn.hutu.filter"})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

## 7、@Value给静态变量赋值

把@Value("${path.url}")放在静态变量的set方法上面即可，需要注意的是set方法要去掉static，有些朋友习惯性的快捷键生成set方法而没有去掉static，导致还是赋值失败。还有就是当前类要交给spring来管理。

```java
private static String url;
 
// 记得去掉static
@Value("${mysql.url}")
public void setDriver(String url) {
     JdbcUtils.url= url;
}

```

## 8、springboot配置多数据源

<https://docs.spring.io/spring-boot/docs/2.1.6.RELEASE/reference/html/howto-data-access.html#howto-two-datasources>



## 9、java接口添加跨域访问

```java
response.setHeader("Access-Control-Allow-Origin", "*");

```

## 10、路径中有 点 符号

spring与springboot中的  @有点时，spring会把点后面的当做后缀忽略掉

> SpringMVC对PathVariable标注的路径的参数的处理上默认.后面的是文件后缀

解决办法为:	

@RequestMapping(value = "/user/{username:.*}", method = {RequestMethod.GET})

在url声明上使用:.*来表示获取整个参数，不将.后的内容做文件后缀处理。

## 11、获取spring.factories的方法

```java
 try {
            Enumeration<URL> urls = classLoader != null ? classLoader.getResources("META-INF/spring.factories") : ClassLoader.getSystemResources("META-INF/spring.factories");
            ArrayList result = new ArrayList();

            while(urls.hasMoreElements()) {
                URL url = (URL)urls.nextElement();
                Properties properties = PropertiesLoaderUtils.loadProperties(new UrlResource(url));
                String factoryClassNames = properties.getProperty(factoryClassName);
                result.addAll(Arrays.asList(StringUtils.commaDelimitedListToStringArray(factoryClassNames)));
            }

            return result;
        } catch (IOException var8) {
            throw new IllegalArgumentException("Unable to load [" + factoryClass.getName() + "] factories from location [" + "META-INF/spring.factories" + "]", var8);
        }
```

## 12、springboot初始化操作

<https://blog.csdn.net/qq_28804275/article/details/80891941>

- - 实现 `CommandLineRunner` 接口，并实现它的 `run()` 方法，在该方法中编写初始化逻辑
  - 注册成Bean，添加 `@Component`注解即可
- - 定义初始化类 `MyApplicationRunner`
  - 实现 `ApplicationRunner` 接口，并实现它的 `run()` 方法，在该方法中编写初始化逻辑
  - 注册成Bean，添加 `@Component`注解即可
- 使用 `@PostConstruct` 注解同样可以帮助我们完成资源的初始化操作，前提是这些初始化操作不需要依赖于其它Spring beans的初始化**工作**
- **@Order** 可以解决初始化时顺序的问题

#### 销毁时执行: 继承自DisposableBean,并将其注册为bean即可.

```java
@Component
public class MyDisposableBean implements DisposableBean{
	@Override
	public void destroy() throws Exception {
		System.out.println("结束");
	}
}
```



## 13、springboot配置文件读取顺序

**springboot 有读取外部配置文件的方法，如下优先级：**

- 第一种是在jar包的同一目录下建一个config文件夹，然后把配置文件放到这个文件夹下。

- 第二种是直接把配置文件放到jar包的同级目录。

- 第三种在classpath下建一个config文件夹，然后把配置文件放进去。

- 第四种是在classpath下直接放配置文件。

  原文链接：https://blog.csdn.net/wohaqiyi/article/details/79940380

