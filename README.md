# Makedown
### linux命令

1. ```shell
   Shell开启扩展模式匹配shopt -s extglob
   shopt (shell option)
   extglob (extension global)
   
   搜索字符串
   grep  -str-  -path- 
   ```

2. 

### docker启动
1. ```python
   docker run --privileged #docker默认是伪root，以普通用户运行,加参数privileged(享有特权的)以超级管理员运行
   docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)   #查看容器ip
   ```

1. 
2.  
3.  
4.  
5. 

### 搭建Http代理

1. docker pull dannydirect/tinyproxy
2.  docker run -d --name='tinyproxy' -p 6666:8888 dannydirect/tinyproxy:latest ANY
3.  
4.  

### 搭建Socks5代理
1. docker pull xkuma/socks5
2. docker run -d -p 1080:1080 xkuma/socks5
3. docker run -d -p 1080:1080 -e PROXY_USER=user -e PROXY_PASSWORD=password -e PROXY_SERVER=0.0.0.0:1080 xkuma/socks5

