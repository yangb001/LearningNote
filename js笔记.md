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

# 2、websocket页面使用

```html
<script type="text/javascript">
    var cnt=0;
    var lockReconnect = false;  //避免ws重复连接
    var ws = null;          // 判断当前浏览器是否支持WebSocket
    var wsUrl=webSocketURL;
    createWebSocket(wsUrl);
    function createWebSocket(url) {
        try {
            if ('WebSocket' in window) {
                ws = new WebSocket(url);
            } else if ('MozWebSocket' in window) {
                ws = new MozWebSocket(url);
            } else {
                layer.open({
                    content: "当前浏览器不支持WebSocket",
                    type: 1,
                    // icon: 0,
                    time: 0, closeBtn: 1, btn: 0, title: "提示信息", isOutAnim:true,anim: 2,area: ['400px', '300px'],shade: 0.2,tipsMore: true
                });
            }
            initEventHandle();
        } catch (e) {
            reconnect(url);
        }
    }
   // var socketsend;
    function initEventHandle() {
        ws.onclose = function () {
            console.log("llws连接关闭!" + CurentTime());
            reconnect(wsUrl);
        };
        ws.onerror = function () {
            console.log("llws连接错误!");
            reconnect(wsUrl);
        };
        ws.onopen = function () {
            // heartCheck.reset().start();      //心跳检测重置
            console.info("llws连接成功!" + CurentTime());
        };
        ws.onmessage = function (evt) {    //如果获取到消息，心跳检测重置
            console.info("llws连接成功" + evt.data);
           var data = $.parseJSON(evt.data);
            if(data.order==0){
                addOpenRecord();//开门记录
            }
            if(data.order==1){
                addStranger(data.data);//推送陌生人
            }
            if(data.order==2){
                //推送命中内部人员实时照片
                addInsider(data.data);
            }
            if(data.order==3){//陌生人记录
                addStrangerRecord();
            }

        }
    }
// 监听窗口关闭事件，当窗口关闭时，
// 主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        ws.close();
    }
    function reconnect(url) {
        if (lockReconnect) return;
        lockReconnect = true;
        setTimeout(function () {
            //没连接上会一直重连，设置延迟避免请求过多
            createWebSocket(url);
            lockReconnect = false;
        }, 2000);
    }
    //心跳检测
    var heartCheck = {
        timeout: 3000,
        timeoutObj: null,
        serverTimeoutObj: null,
        reset: function () {
            clearTimeout(this.timeoutObj);
            clearTimeout(this.serverTimeoutObj);
            return this;
        },
        start: function () {
            var self = this;
            this.timeoutObj = setTimeout(function () {
                //这里发送一个心跳，后端收到后，返回一个心跳消息，
                //onmessage拿到返回的心跳就说明连接正常
                ws.send("ping");
                console.log("ping!")
                self.serverTimeoutObj = setTimeout(function () {
                    //如果超过一定时间还没重置，说明后端主动断开了
                    //如果onclose会执行reconnect，我们执行ws.close()就行了.如果直接执行reconnect 会触发onclose导致重连两次
                    ws.close();
                },self.timeout)
            },this.timeout)
        }
    }
    function CurentTime(){
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var ss=now.getSeconds();     // 获取当前秒数(0-59)
        if(month < 10)
            month = "0"+month;
        if(day < 10)
            day = "0"+day;
        if(hh < 10)
            hh = "0"+hh;
        if(mm < 10)
            mm = "0"+mm;
        if(ss < 10)
            ss = "0"+ss;
        clock=year+"-"+month+"-"+day+" "+hh+":"+mm+":"+ss;
        return(clock);
    }

</script>
```

## 2、websocket自动关闭解决

https://segmentfault.com/a/1190000014582485

https://blog.csdn.net/jintingbo/article/details/80864030

这篇有用：

​	https://sylvanassun.github.io/2017/11/30/2017-11-30-netty_introduction/

```
> 我们在了解ByteBuf时就已经知道了Netty使用了一套自己实现的引用计数算法来主动释放资源，假设你的ChannelHandler继承于ChannelInboundHandlerAdapter或ChannelOutboundHandlerAdapter，那么你就有责任去管理你所分配的ByteBuf，一般来说，一个消息对象（ByteBuf）已经被消费（或丢弃）了，并且不会传递给ChannelHandler链中的下一个处理器（如果该消息到达了实际的传输层，那么当它被写入或Channel关闭时，都会被自动释放），那么你就需要去手动释放它。通过一个简单的工具类ReferenceCountUtil的release方法，就可以做到这一点
```

