1.java，write()方法后写flush()的作用 https://blog.csdn.net/AnneQiQi/article/details/51295218
2.图解 | 原来这就是 IO 多路复用 https://zhuanlan.zhihu.com/p/360878783
3.MinIO 文件存储服务快速入门 https://segmentfault.com/a/1190000038745864
4.史上第二全的 java 文件操作和数据读写 https://xie.infoq.cn/article/0882f298f16c3d9fa6133a950
5.建立IO要素 1.打开网络通信接口（sokect对象）绑定、监听 2.建立连接得到文件描述符（connfd 阻塞） 3.根据文件描述符读数据(阻塞) 4.dosomething 5.close(关闭连接资源)
   5.1 用户态多线程调用read 非阻塞IO
   5.2 OS提供非阻塞read 若文件描述符未就绪 立即返回错误值（-1）而不是阻塞等待 需用户循环调用read 切换到内核态（仍是多线程）
   5.3 用户态IO多路复用: 用户建立connfd数组 一个新的线程去不断遍历这个数组
   5.4 内核态IO多路复用： 1.select：用户传参connfd数组 os来遍历 返回带有标识的connfd 用户仍要遍历read(存在三个问题：1.connfd大文件复制 2.存在无效遍历 3.内核主动查询结果 可改为异步事件通知 即connfd状态改变主动通知)
                         2.poll: 解除select 只能监听 1024 个文件描述符的限制
                         3.epoll:1.保存一份connfd数组 只做修改 2.仅返回IO事件的connfd 3.内核不再轮询 通过异步事件通知唤醒
6. 1.IO多路复用就是os提供遍历文件描述符机制 一个线程处理多个文件描述符 2.connfd状态就绪：网卡到内核缓冲区 read:内核缓冲区到用户缓冲区 3.IO的演进：1.os提供非阻塞read函数 2.IO提供遍历connfd函数（1.select 2.poll 3.epool）
