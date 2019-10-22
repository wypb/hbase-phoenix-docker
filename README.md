# 介绍

Docker Images for Apache Phoenix 5.x, this image will start an hbase pseudo-distributed mode, and we can use Apache Phoenix 5.x, primarily for testing purposes.


Apache Phoenix 5.x Docker 镜像，这个镜像会启动一个 HBase 伪分布式模式，然后我们可以在里面启动一个 Phoenix 客户端，主要用于测试使用。

# 如何使用
先安装好 Docker，然后在命令行里面使用命令获取本镜像：
```
docker pull iteblog/hbase-phoenix-docker
```
运行 Phoenix 容器：
```
docker run iteblog/hbase-phoenix-docker
```
查看运行状态
```
iteblog@www.iteblog.com:~|⇒  ps -ef|grep hbase-phoenix-docker
  502 12307 11892   0 10:15上午 ttys000    0:00.05 docker run iteblog/hbase-phoenix-docker
```
查看 hbase-phoenix-docker 容器运行的id
```
iteblog@www.iteblog.com:~|⇒  docker ps -a
CONTAINER ID        IMAGE                          COMMAND                   CREATED              STATUS                      PORTS                                                            NAMES
afd317c6985e        iteblog/hbase-phoenix-docker   "/usr/bin/supervisord"    About a minute ago   Up About a minute           2181/tcp, 8765/tcp, 60000/tcp, 60010/tcp, 60020/tcp, 60030/tcp   strange_mirzakhani
```
可以看到 iteblog/hbase-phoenix-docker 镜像运行的容器id（CONTAINER ID）为 `afd317c6985e`。进入容器的 shell 模式：
```
iteblog@www.iteblog.com:~|⇒  docker exec -it afd317c6985e bash
root@afd317c6985e:/opt/hbase-2.0.6/conf#
```
在里面我们就可以操作 Phoenix 终端了
```
root@afd317c6985e:/opt/hbase-2.0.6/conf# cd /opt/phoenix/bin && ./sqlline.py
Setting property: [incremental, false]
Setting property: [isolation, TRANSACTION_READ_COMMITTED]
issuing: !connect jdbc:phoenix: none none org.apache.phoenix.jdbc.PhoenixDriver
Connecting to jdbc:phoenix:
19/10/22 02:18:32 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Connected to: Phoenix (version 5.0)
Driver: PhoenixEmbeddedDriver (version 5.0)
Autocommit status: true
Transaction isolation: TRANSACTION_READ_COMMITTED
Building list of tables and columns for tab-completion (set fastconnect to true to skip)...
133/133 (100%) Done
Done
sqlline version 1.2.0
0: jdbc:phoenix:>0: jdbc:phoenix:> CREATE TABLE IF NOT EXISTS iteblog (
. . . . . . . . >   id BIGINT NOT NULL PRIMARY KEY,
. . . . . . . . >   blog VARCHAR(100)
. . . . . . . . > );
No rows affected (0.774 seconds)
0: jdbc:phoenix:> UPSERT INTO iteblog VALUES(1, 'https://www.iteblog.com');
1 row affected (0.129 seconds)
0: jdbc:phoenix:> UPSERT INTO iteblog VALUES(2, 'http://books.iteblog.com');
1 row affected (0.013 seconds)
0: jdbc:phoenix:> select * from iteblog;
+-----+---------------------------+
| ID  |           BLOG            |
+-----+---------------------------+
| 1   | https://www.iteblog.com   |
| 2   | http://books.iteblog.com  |
+-----+---------------------------+
2 rows selected (0.054 seconds)
0: jdbc:phoenix:>
```

指定主机端口和容器端口映射
```
docker run -it -p 8765:8765 iteblog/hbase-phoenix-docker
```
`-p 8765:8765` 第一个8765是我们主机的端口，第二个8765是容器里面的端口，使用上面命令之后我们就可以直接用 shell 链接到 Phoenix 了。
