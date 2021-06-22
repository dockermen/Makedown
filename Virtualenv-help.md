<center><font size=28><b>Python常用命令</b></font></center>

venv虚拟环境Virtualenv 

```shell
pip install virtualenv

pip install virtualenvwrapper  # 这是对virtualenv的封装版本，一定要在virtualenv后安装 
cd E:python3  # 进入该文件
virtualenv envname   # 创建一个名字为envname的虚拟环境
dir     # 查看当前目录可以知道一个envname的文件已经被创建

virtualenv -p python2 envname  # 如果安装了多个python版本，如py2和py3，需要指定使用哪个创建虚拟环境
# 进入虚拟环境文件
cd envname
# 进入相关的启动文件夹
cd Scripts

activate  # 启动虚拟环境
deactivate # 退出虚拟环境
```


