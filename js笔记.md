# 1、jQuery 事件方法

https://www.runoob.com/jquery/jquery-ref-events.html

## 1、jQuery on() 方法

```javascript
$(document).ready(function(){
  $("p").on("click",function(){
    alert("段落被点击了。");
  });
});
```

### 定义和用法

on() 方法在被选元素及子元素上添加一个或多个事件处理程序。

自 jQuery 版本 1.7 起，on() 方法是 bind()、live() 和 delegate() 方法的新的替代品。该方法给 API 带来很多便利，我们推荐使用该方法，它简化了 jQuery 代码库。

**注意：**使用 on() 方法添加的事件处理程序适用于当前及未来的元素（比如由脚本创建的新元素）。

**提示：**如需移除事件处理程序，请使用 [off()](https://www.runoob.com/jquery/event-off.html) 方法。

**提示：**如需添加只运行一次的事件然后移除，请使用 [one()](https://www.runoob.com/jquery/event-one.html) 方法。

### 语法

$(*selector*).on(*event,childSelector,data,function*)

| 参数            | 描述                                                         |
| :-------------- | :----------------------------------------------------------- |
| *event*         | 必需。规定要从被选元素移除的一个或多个事件或命名空间。  由空格分隔多个事件值，也可以是数组。必须是有效的事件。 |
| *childSelector* | 可选。规定只能添加到指定的子元素上的事件处理程序（且不是选择器本身，比如已废弃的 delegate() 方法）。 |
| *data*          | 可选。规定传递到函数的额外数据。                             |
| *function*      | 可选。规定当事件发生时运行的函数。                           |

## 2、javascript中的define用法

https://blog.csdn.net/qq_16633405/article/details/77961539
