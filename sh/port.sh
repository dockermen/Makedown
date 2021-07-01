a=$1
b=$2
if [ "$a"x == "start"x ]
then
   firewall-cmd --zone=public --add-port=$b/tcp --permanent
   echo "开启端口:$b成功"
   firewall-cmd --reload
   echo '重启防火墙'
elif [ "$a"x == "stop"x ]
then
   firewall-cmd --zone=public --remove-port=$b/tcp --permanent
   echo "关闭端口:$b成功"
   firewall-cmd --reload
   echo '重启防火墙'
elif [ "$a"x == "ps"x ]
then
   echo "当前端口情况"
   firewall-cmd --zone=public --list-ports
elif [ "$a"x == "docker"x ]
then
   echo "docker容器ip情况"
   docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
else
   echo "没有传递参数"
fi
