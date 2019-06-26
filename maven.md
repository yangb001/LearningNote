## Maven父子工程依赖jar传递方式
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
