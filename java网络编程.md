https://www.cnblogs.com/imstudy/p/9908791.html

# java网络编程

## 1、概念

### 1、同步和异步

> 同步和异步是针对应用程序和内核的交互而言的，关注的是消息通信机制

**同步：** 指应用程序触发IO操作并一直等待会轮询的去查看IO操作是否已经完成。由调用者主动等待这次调用的结果

**异步：** 指应用程序触发IO操作以后会干自己的事情，IO操作完成以后会通知。调用者不会等待这次结果，而是由被调用者通过状态、通知或者回调函数来返回结果

### 2、阻塞和非阻塞

> 阻塞和非阻塞是针对调用者在等待结果时的状态而言

**阻塞：** 等待结果时应用线程会被挂起，只有返回结果时才会继续线程

**非阻塞：** 等待结果时不会挂起当前线程

### 3、BIO（Blocking IO）

**同步阻塞时IO编程**

	编程的基础是进程间的通信。服务端提供IP和监听端口，客户端向服务端连接的地址发起请求，通过3个握手建立，如果连接成功建立，双方就可以通过套接字通信。	

	传统的同步阻塞模型开发中，ServerSocket负责绑定IP地址，启动监听端口；Socket负责发起连接操作。连接成功后，双方通过输入和输出流进行同步阻塞式通信。

	采用BIO通信模型的服务端，通常由一个独立的Acceptor线程负责监听客户端的连接，它接收到客户端连接请求之后为每个客户端创建一个新的线程进行链路处理没处理完成后，通过输出流返回应答给客户端，线程销毁。即典型的一请求一应答通信模型。

**服务端代码：**

```java
public class ChatServer {
    private static List<CharThread> charThreads = new LinkedList<>();
    private static Persion[] persons = new Persion[10];
    //{"郭小虎","猪小牛","丑小鸭","闫二妮","张大彪"}

    JTextArea textArea;

    public ChatServer(JTextArea textArea) {
        this.textArea = textArea;
    }

    public ChatServer() {
    }

    public static void main(String[] args) {
        ChatServer server = new ChatServer();
        server.paint();
        server.startServer();
    }

    public void paint(){
        JFrame main = new JFrame("服务器日志记录");
        main.setBounds(1550,150,300,650);
        main.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        ImageIcon  icon = new ImageIcon("head.png");
        main.setIconImage(icon.getImage());

        JPanel panel = new JPanel();
        JTextArea allText = new JTextArea(20,38);
        allText.setFont(new Font("宋体",Font.BOLD,12));
        allText.setLineWrap(true);
        panel.add(new JScrollPane(allText));

        this.textArea = allText;

        main.add(panel);
        main.setVisible(true);
    }

    public void startServer() {
        try {
            textArea.append("启动一个服务器..." + "\r\n");
            System.out.println("启动一个服务器...");

            ServerSocket server = new ServerSocket(8888);
            while (true) {
                Socket socket = server.accept();
                textArea.append("已连接一个客户端：" + socket.getClass() + "\r\n");
                System.out.println("已连接一个客户端：" + socket.getInetAddress());

                CharThread charThread = new CharThread(socket);
                charThreads.add(charThread);
                new Thread(charThread).start();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    class CharThread implements Runnable {
        private Socket socket;
        DataOutputStream dataOutputStream = null;
        DataInputStream dataInputStream = null;

        public CharThread(Socket socket) {
            this.socket = socket;
        }

        @Override
        public void run() {
            try {
                dataInputStream = new DataInputStream(socket.getInputStream());
                dataOutputStream = new DataOutputStream(socket.getOutputStream());

                while (true) {
                    String readUTF = dataInputStream.readUTF();
                    System.out.println("接收到客户端消息： " + readUTF);
                    textArea.append("接收到"+socket.getClass()+"客户端消息： " + readUTF + "\r\n");

                    for (int i = 0; i < charThreads.size(); i++) {

                        CharThread charThread = charThreads.get(i);
                        charThread.getDataOutputStream().writeUTF(readUTF);

                        System.out.println("向客户端 " + charThread + " 发送消息： " + readUTF);
                        textArea.append("向客户端"+charThread.getSocket().getClass()+"发送消息： " + readUTF + "\r\n");
                    }
                }

            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    dataOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                try {
                    dataInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        public Socket getSocket() {
            return socket;
        }

        public DataOutputStream getDataOutputStream() {
            return dataOutputStream;
        }

        public DataInputStream getDataInputStream() {
            return dataInputStream;
        }
    }
}
```

**客户端代码：**

```java
public class ChatClient implements Runnable {

    DataInputStream dataInputStream = null;
    DataOutputStream dataOutputStream = null;
    Socket socket = null;
    JTextArea textArea = null;
    String FromName = null;

    public ChatClient(Socket socket, String fromName) {
        this.socket = socket;
        FromName = fromName;
    }

    @Override
    public void run() {
        init(FromName);
    }

    /**
     * 绘制聊天界面
     *
     * @param
     */
    public void init(String title) {
        JFrame window1 = new JFrame(title);
        window1.setBounds(500, 300, 700, 450);
        window1.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);

        JPanel panel = new JPanel();

        //聊天记录区域
        textArea = new JTextArea(11, 60);
        textArea.setFont(new Font("楷体", Font.BOLD, 20));
        textArea.setLineWrap(true);
        textArea.setEditable(false);
        panel.add(new JScrollPane(textArea));

        //输入区域


        JTextArea textArea1 = new JTextArea(4, 60);
        textArea1.setFont(new Font("楷体", Font.BOLD, 20));
        textArea1.setLineWrap(true);
        panel.add(new JScrollPane(textArea1));

        FSListener fsListener = new FSListener(textArea, textArea1);


        //发送按钮
        JButton button = new JButton("发送");
        button.addActionListener(fsListener);


        panel.add(button);

        window1.add(panel);
        window1.setVisible(true);

        //创建socket连接
        try {

            dataInputStream = new DataInputStream(socket.getInputStream());
            dataOutputStream = new DataOutputStream(socket.getOutputStream());

            while (true) {
                String s = dataInputStream.readUTF();
                System.out.println("接收到服务器发过来的消息：" + s);
                textArea.append("\r\n");
                textArea.append("接收到服务器发过来的消息：" + s);
            }
            //socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                dataOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                dataInputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    //发送事件
    class FSListener implements ActionListener {

        JTextArea textArea;
        JTextArea textArea1;

        public FSListener(JTextArea textArea, JTextArea textArea1) {
            this.textArea = textArea;
            this.textArea1 = textArea1;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            String text = textArea1.getText();

            textArea1.setText(null);
            textArea.append("\r\n");
            textArea.append("发送消息：" + text);
            textArea.setAlignmentX(1);

            try {
                System.out.println("当前线程：" + Thread.currentThread().getName() + ",发送消息为：" + text);
                //输出字符到服务器
                dataOutputStream.writeUTF(text);
                dataOutputStream.flush();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    public DataInputStream getDataInputStream() {
        return dataInputStream;
    }

    public void setDataInputStream(DataInputStream dataInputStream) {
        this.dataInputStream = dataInputStream;
    }

    public DataOutputStream getDataOutputStream() {
        return dataOutputStream;
    }

    public void setDataOutputStream(DataOutputStream dataOutputStream) {
        this.dataOutputStream = dataOutputStream;
    }

    public Socket getSocket() {
        return socket;
    }

    public void setSocket(Socket socket) {
        this.socket = socket;
    }

    public JTextArea getTextArea() {
        return textArea;
    }

    public void setTextArea(JTextArea textArea) {
        this.textArea = textArea;
    }

    public String getFromName() {
        return FromName;
    }

    public void setFromName(String fromName) {
        FromName = fromName;
    }
}
public class ChatClientMain {
    ServerSocket serverSocket = null;
    Socket socket = null;

    public static void main(String[] args) {
        ChatClientMain chatClientMain = new ChatClientMain();
        chatClientMain.login();
    }

    public void login() {
        JFrame main = new JFrame("张三");
        main.setBounds(1550,150,300,650);
        main.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        ImageIcon  icon = new ImageIcon("head.png");
        main.setIconImage(icon.getImage());

        JPanel panel = new JPanel();
        JButton button = new JButton("随机找个人聊天");
        button.addActionListener(new AddChatWin());
        panel.add(button);


        JTextArea allText = new JTextArea(20,38);
        allText.setFont(new Font("宋体",Font.BOLD,12));
        allText.setLineWrap(true);
        panel.add(new JScrollPane(allText));

        main.add(panel);
        main.setVisible(true);

        startLocalServer();
    }

    //打开一个聊天窗口
    static class AddChatWin implements ActionListener{
        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                Socket socket = new Socket("127.0.0.1", 8888);
                ChatClient chatClient = new ChatClient(socket,"我");
                new Thread(chatClient).start();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    private void startLocalServer(){
        try {
            //启动一个本地服务
            serverSocket = new ServerSocket(0);
            InetAddress inetAddress = serverSocket.getInetAddress();
            int localPort = serverSocket.getLocalPort();

            Random random = new Random();
            int id = random.nextInt(100);
            String name = "机器人"+id+"号";
            String host = inetAddress.getHostAddress();

            //启动一个本地客户端注册自己
            Persion persion = new Persion(id, name, host, localPort);
            registerSelf(persion);

            while (true) {
                Socket socket = serverSocket.accept();
                //textArea.append("已连接一个客户端：" + socket.getClass() + "\r\n");
                System.out.println("已连接一个客户端：" + socket.getInetAddress());

                //弹出一个聊天框
                ChatClient chatClient = new ChatClient(socket, "nihao");
                JTextArea textArea = chatClient.getTextArea();

                //创建一个线程，处理这次socket
                ChatThread charThread = new ChatThread(socket);
                charThread.setTextArea(textArea);
                new Thread(charThread).start();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void registerSelf(Persion persion){
        try {
            socket = new Socket("127.0.0.1",8888);
            OutputStream outputStream = socket.getOutputStream();

//            byte[] bytes = ByteUtils.toByteArray(persion);
            byte[] bytes = JSON.toJSONString(persion).getBytes();
            outputStream.write(bytes);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }
}
```

### 4、NIO

**同步非阻塞IO**

参照：<https://segmentfault.com/a/1190000017040893>

> 对于I/O操作，根据Oracle官网的文档，同步异步的划分标准是“调用者是否需要等待I/O操作完成”，这个“等待I/O操作完成”的意思不是指一定要读取到数据或者说写入所有数据，而是指真正进行I/O操作时，比如数据在TCP/IP协议栈缓冲区和JVM缓冲区之间传输的这段时间，调用者是否要等待。
>
> Java中实际上只有 同步阻塞I/O、同步非阻塞I/O 与 异步I/O 三种机制，我们下文所说的是前两种，JDK 1.7才开始引入异步 I/O，那称之为NIO.2。

#### 1、简介

	NIO一般被称为New IO，since jdk1.4引入，在java.nio.*下面

#### 2、Channel

	Channel对应io包中的Stream类，表示和某一实体的连接，即数据通道。不同的是，Stream是半双工通信，Channel是全双工通信，可同时实现write和read。

Java NIO中最常用的通道实现是如下几个，可以看出跟传统的 I/O 操作类是一一对应的。

- FileChannel：读写文件
- DatagramChannel: UDP协议网络通信
- SocketChannel：TCP协议网络通信
- ServerSocketChannel：监听TCP连接

#### 3、Buffer

	NIO中所使用的缓冲区不是一个简单的byte数组，而是封装过的Buffer类。

Buffer中有3个很重要的变量，它们是理解Buffer工作机制的关键，分别是：

- capacity （总容量）
- position （指针当前位置）
- limit （读/写边界位置）

下面是一个使用 FileChannel 读写文本文件，通过这个例子验证通道可读可写的特性以及Buffer的基本用法（注意 FileChannel 不能设置为非阻塞模式）

```java
public static void main(String[] args) {

        try {
            FileChannel channel = new RandomAccessFile("D:\\temp/test.txt","rw").getChannel();

            // 1. 写入数据
            // 移动文件指针到末尾（追加写入）
            channel.position(channel.size());

            // 创建一个20长度的buffer
            ByteBuffer byteBuffer = ByteBuffer.allocate(400);
            byteBuffer.put("你好吗，世界！".getBytes(StandardCharsets.UTF_8));

            // 设置limit为position的值，然后将position设置为0.对buffer读取前调用
            byteBuffer.flip();
            // 写入通道
            while (byteBuffer.hasRemaining()) {
                channel.write(byteBuffer);
            }

            // 2. 读取数据
            // channel的指针移动到文件开头，从头读取
            channel.position(0);
            CharBuffer charBuffer = CharBuffer.allocate(100);
            CharsetDecoder decoder = StandardCharsets.UTF_8.newDecoder();

            // clear: 回到初始状态，即 limit 等于 capacity，position 置0。重新对Buffer进行写入操作前调用。
            byteBuffer.clear();
            while ((channel.read(byteBuffer)) != -1 || byteBuffer.position()>0){
                byteBuffer.flip();

                // 使用UTF-8解码器解码
                charBuffer.clear();
                decoder.decode(byteBuffer, charBuffer, false);
                System.out.println(charBuffer.flip().toString());

                // 将未读取完的数据（position 与 limit 之间的数据）移动到缓冲区开头，并将 position
                // 设置为这段数据末尾的下一个位置。其实就等价于重新向缓冲区中写入了这么一段数据。
                byteBuffer.compact();
            }
            channel.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

```

	需要注意的是最后那个 compact() 方法，即使 charBuffer 的大小完全足以容纳 byteBuffer 解码后的数据，这个 compact() 也必不可少，这是因为常用中文字符的UTF-8编码占3个字节，因此有很大概率出现在中间截断的情况

##### 1、缓存区的分配和包装

```java
ByteBuffer buffer = ByteBuffer.allocate( 1024 );

// 将一个现有数组转换为缓冲区
byte array[] = new byte[1024];
ByteBuffer buffer = ByteBuffer.wrap( array );
```

##### 2、缓冲区分片

	`slice()` 方法根据现有的缓冲区创建一种 *子缓冲区* 。也就是说，它创建一个新的缓冲区，新缓冲区与原来的缓冲区的一部分共享数据。

```java
// 原buffer
ByteBuffer buffer = ByteBuffer.allocate( 10 );

buffer.position( 3 );
buffer.limit( 7 );
// 分片后的buffer
ByteBuffer slice = buffer.slice();
```

##### 3、只读缓冲区

	只读缓冲区非常简单 ― 您可以读取它们，但是不能向它们写入。可以通过调用缓冲区的 `asReadOnlyBuffer()` 方法，将任何常规缓冲区转换为只读缓冲区，这个方法返回一个与原缓冲区完全相同的缓冲区(并与其共享数据)，只不过它是只读的。

	不能将只读的缓冲区转换为可写的缓冲区。

##### 4、直接和间接缓冲区

> 实际上，直接缓冲区的准确定义是与实现相关的。Sun 的文档是这样描述直接缓冲区的：
>
> 	*给定一个直接字节缓冲区，Java 虚拟机将尽最大努力直接对它执行本机 I/O 操作。也就是说，它会在每一次调用底层操作系统的本机 I/O 操作之前(或之后)，尝试避免将缓冲区的内容拷贝到一个中间缓冲区中(或者从一个中间缓冲区中拷贝数据)。*

```java
//创建直接缓冲区
ByteBuffer buffer = ByteBuffer.allocateDirect(10);
```

##### 5、内存映射文件 I/O

	内存映射文件 I/O 是一种读和写文件数据的方法，它可以比常规的基于流或者基于通道的 I/O 快得多。

	内存映射文件 I/O 是通过使文件中的数据神奇般地出现为内存数组的内容来完成的。这其初听起来似乎不过就是将整个文件读到内存中，但是事实上并不是这样。一般来说，只有文件中实际读取或者写入的部分才会送入（或者 *映射* ）到内存中。

	内存映射并不真的神奇或者多么不寻常。现代操作系统一般根据需要将文件的部分映射为内存的部分，从而实现文件系统。Java 内存映射机制不过是在底层操作系统中可以采用这种机制时，提供了对该机制的访问。

	尽管创建内存映射文件相当简单，但是向它写入可能是危险的。仅只是改变数组的单个元素这样的简单操作，就可能会直接修改磁盘上的文件。修改数据与将数据保存到磁盘是没有分开的。

```java
//下面代码行将文件的前 1024 个字节映射到内存中
MappedByteBuffer mbb = fc.map( FileChannel.MapMode.READ_WRITE, 0, 1024 );

//map() 方法返回一个 MappedByteBuffer，它是 ByteBuffer 的子类。因此，您可以像使用其他任何 ByteBuffer 一样使用新映射的缓冲区，操作系统会在需要时负责执行行映射。
```

#### 4、Selector

	Selector是用于采集各个Channel的状态（或事件）。有如下4个方法可以供我们监听：（在返回的SelectorKey中）

- OP_ACCEPT：	有可以接受的连接
- OP_CONNECT：    连接成功
- OP_READ:  有数据可读、
- OP_WRITE： 可以写入数据了

```java
// 服务器
public class TestFull {

    public static void main(String[] args) {
        NioServer server = new NioServer();
        server.startServer();
    }

    static class NioServer {
        public void startServer() {
            try {
                // 创建一个Selector
                Selector selector = SelectorProvider.provider().openSelector();
                ServerSocketChannel serverSocketChannel = ServerSocketChannel.open();

                // 设置端口
                serverSocketChannel.bind(new InetSocketAddress(9999));
                // 设置为非阻塞模式
                serverSocketChannel.configureBlocking(false);
                // 注册到selector，监听其 accept事件
                serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);

                // 创建一个缓冲区
                ByteBuffer byteBuffer = ByteBuffer.allocate(100);
                CharsetDecoder decoder = StandardCharsets.UTF_8.newDecoder();
                CharBuffer charBuffer = CharBuffer.allocate(100);

                while (true) {
                    // 阻塞，直到有监听事件出现
                    selector.select();
                    Iterator<SelectionKey> iterator = selector.selectedKeys().iterator();
                    while (iterator.hasNext()) {
                        SelectionKey selectionKey = iterator.next();

                        if (selectionKey.isAcceptable()) {
                            // 如果有连接可以接收
                            SocketChannel socketChannel = ((ServerSocketChannel) selectionKey.channel()).accept();
                            socketChannel.configureBlocking(false);

                            // 注册了一个连接
                            socketChannel.register(selector, SelectionKey.OP_READ);
                            System.out.println("与" + socketChannel.getRemoteAddress()+ "-------- 建立了连接");
                        } else if (selectionKey.isReadable()){
                            // 如果由数据可以读取
                            byteBuffer.clear();

                            // 如果读取到流的末尾了，说明TCP连接已经断开，
                            // 因此需要关闭通道或取消监听READ事件，否则会无线循环
                            if(((SocketChannel)selectionKey.channel()).read(byteBuffer) ==-1){
                                selectionKey.channel().close();
                            }

                            while (byteBuffer.hasRemaining()) {
                                byteBuffer.flip();
                                decoder.decode(byteBuffer, charBuffer, false);
                                System.out.println(charBuffer.flip().toString());
                            }

                            byteBuffer.clear();
                            byteBuffer.put("你好，世界！".getBytes());
                            byteBuffer.flip();

                            // 应答消息的发送，SocketChannel也是异步非阻塞的，所以不能保证一次能吧需要发送的数据发送完，此时就会出现写半包的问题。
                            // 我们需要注册写操作，不断轮询Selector将没有发送完的消息发送完毕，然后通过Buffer的hasRemain()方法判断消息是否发送完成
                            while (byteBuffer.hasRemaining()) {
                                ((SocketChannel) selectionKey.channel()).write(byteBuffer);
                            }
                        }
                    }
                    /**
                     * 及时清除掉已经处理的key
                     */
                    iterator.remove();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

}

// 客户端
public class NioClient {
    public static void main(String[] args) {
        startClient();
    }

    public static void startClient() {
        Selector selector = null;
        try {
            // 创建一个选择器
            selector = Selector.open();
            // 创建一个Channel
            SocketChannel socketChannel = SocketChannel.open();
            // 设置为非阻塞模式
            socketChannel.configureBlocking(false);

            // 注册Channel到Selector
//            socketChannel.register(selector, Star)

            // 连接远程服务器
            socketChannel.connect(new InetSocketAddress("127.0.0.1", 9999));

            //
            while (true) {
                selector.select(1000);
                System.out.println("隔一秒被唤醒一次");
                Set<SelectionKey> selectionKeys = selector.selectedKeys();
                Iterator<SelectionKey> iterator = selectionKeys.iterator();
                while (iterator.hasNext()) {
                    SelectionKey selectionKey = iterator.next();
                    iterator.remove();

                    handleInput(selectionKey);

                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                selector.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    public static void handleInput(SelectionKey selectionKey) {
        if (selectionKey.isValid()) {
            SocketChannel channel = (SocketChannel) selectionKey.channel();

            if (selectionKey.isReadable()) {
                ByteBuffer byteBuffer = ByteBuffer.allocateDirect(10);
                try {
                    int read = channel.read(byteBuffer);
                    while (byteBuffer.hasRemaining()) {
                        byteBuffer.flip();
                        byte[] bytes = new byte[byteBuffer.remaining()];
                        byteBuffer.get(bytes);
                        String string = new String(bytes);
                        System.out.println("客户端收到消息：" + string);

                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }

        }
    }

}
```







## 其它

### 1、网络编程基础

<https://mp.weixin.qq.com/s/XXMz5uAFSsPdg38bth2jAA>

#### 1、ISO七层模型

- 物理层：物理连接，网线接口，电压
- 数据链路层：逻辑连接，硬件地址寻址，差错检查
- 网络层：逻辑地址寻址，网络路由
- 传输层：定义数据传输协议、端口号，流控与差错校验
- 会话层：建立、终止、管理会话
- 表示层：数据的表示，安全，压缩
- 应用层：应用程序层

#### 2、TCP/IP协议模型

<https://www.cnblogs.com/newwy/archive/2013/08/02/3232503.html>

- 物理层
- 数据链路层
- 网络层
- 传输层
- 应用层



## 一些操作

### 1、socketserver中获取空闲的本地端口

<https://blog.csdn.net/zqftisson/article/details/7704803>

```java
在初始化ServerSocket的时候指定其端口为0（不指定时使用默认值-1），这样就会返回系统分配的空闲端口了。

   ServerSocket serverSocket =  new ServerSocket(0); //读取空闲的可用端口
   int port = serverSocket.getLocalPort();
   System.out.println("系统分配的端口号 port="+port);
```

