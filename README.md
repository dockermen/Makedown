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

### 主题三

1. 
2.  
3.  
4.  
5. 
