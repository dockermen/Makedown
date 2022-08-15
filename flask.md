

# Flask

## 重要知识

1. [修改Host和端口](#修改Host和端口)
2. url后面要加斜杠
3. [GET和POST请求](#GET和POST请求)
4. [暂时性重定向](#暂时性重定向)

## 基础

- 介绍
  
- 互联网三大基石：HTML,URL,HTTP
  
- web服务器

  - 负责处理http请求，响应静态文件
  - 常见有Apache、Nginx、微软的IIS

- 应用服务器

  - 负责处理逻辑的服务器，比如php、python的代码，不能直接通过nginx处理
  - python可以使用uwsgi、java使用tomcat

- web应用框架

  - 使用某种语言封装常用的web功能的框架
  - Python有flask、Django和Java的SSM

- Content-type和Mime-type的区别

  - 都是服务器和客户端之间传输数据的类型

  - Content-type：既可以指定传输数据类型，也可以指定编码

    ```http
    text/html charset=utf-8
    ```

  - Mime-type：不能指定传输的数据编码类型，例如text/html

## Flask简介

- flask依赖
  - jinja：数据渲染模板引擎
  - werkzeug：网站和python功能模块映射

安装

```shell
pip install flask
```

## Flask使用

### 第一个Flask案例

```python
#app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    print("访问成功")
    return 'Hello World!'

if __name__ == '__main__':
    app.run()
```

- 修改端口

  ```python
  app.run(port=8000)	#修改端口
  ```

- <span name="修改Host和端口">修改Host和端口</span>

  ```python
  app.run(host='0.0.0.0'，port=9000)	#默认不允许局域网访问
  ```

- 开启debug模式

  ```python
  app.run(debug=True)	#debug运行时开启开启-方式1
  ```

  ```python
  app.debug=True #变量声明-方式2
  ```

  ```python
  #修改app配置信息实现debug-方式3
  app.config.update(DEBUG=True) 
  #配置文件修改1-项目目录下新建config.py写入DEBUG=True
  import config
  app.config.from_object(config)
  #配置文件修改2
  app.config.from_pyfile("config.ini")
  ```

<a name="本地环境">本地环境</a>

某些对象在 Flask 中是全局对象，但不是通常意义下的全局对象。这些对象实际上是 特定环境下本地对象的代理。真拗口！但还是很容易理解的。

设想现在处于处理线程的环境中。一个请求进来了，服务器决定生成一个新线程（或者 叫其他什么名称的东西，这个下层的东西能够处理包括线程在内的并发系统）。当 Flask 开始其内部请求处理时会把当前线程作为活动环境，并把当前应用和 WSGI 环境绑定到 这个环境（线程）。它以一种聪明的方式使得一个应用可以在不中断的情况下调用另一个 应用。

这对您有什么用？基本上您可以完全不必理会。这个只有在做单元测试时才有用。在测试 时会遇到由于没有请求对象而导致依赖于请求的代码会突然崩溃的情况。对策是自己创建 一个请求对象并绑定到环境。最简单的单元测试解决方案是使用 [`test_request_context()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.test_request_context) 环境管理器。通过使用 `with` 语句 可以绑定一个测试请求，以便于交互。例如:

```python
from flask import request

with app.test_request_context('/hello', method='POST'):
    # now you can do something with the request until the
    # end of the with block, such as basic assertions:
    assert request.path == '/hello'
    assert request.method == 'POST'
```

## URL与函数的映射

```python
@app.route('/login/<id>/')
def hello_login(id):
    return "登录界面 用户:%s" % id
```

指定参数类型

```python
@app.route('/login/<int:id>/')
#float,path,uuid,any(user,blog)

@app.route('/<any(user,blog):url_path>/<id>/')
def user_blog(url_path,id):
    if url_path=="user":
        return "用户详情:%s" % id
    else:
        return "博客详情:%s" % id
```

<span name="GET和POST请求">GET和POST请求</span>

```python
@app.route('/api',methods=['GET','POST'])
def api_post():
    if request.method=="GET":
        return render_template('index.html')
    elif request.method=="POST":
        uname=request.form.get('uname')
        pwd=request.form.get('pwd')
        return 'post接收到的参数为：%s  %s' % (uname,pwd)
    else:
        return "未知错误"
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
    </style>
</head>
<body>
    <div>
        <form action="/api" method="post">
            <p>用户名<input type="text" name="uname"></p>
            <p>密&nbsp;码<input type="password" name="pwd"></p>
            <p>用户名<input type="submit" value="登录"></p>
        </form>
    </div>
</body>
</html>
```

## url_for函数构建

[`url_for()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.url_for) 函数用于构建指定函数的 URL。它把函数名称作为第一个 参数。它可以接受任意个关键字参数，每个关键字参数对应 URL 中的变量。未知变量 将添加到 URL 中作为查询参数。

1. 反转通常比硬编码 URL 的描述性更好。
2. 您可以只在一个地方改变 URL ，而不用到处乱找。
3. URL 创建会为您处理特殊字符的转义，比较直观。
4. 生产的路径总是绝对路径，可以避免相对路径产生副作用。
5. 如果您的应用是放在 URL 根路径之外的地方（如在 `/myapplication` 中，不在 `/` 中）， [`url_for()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.url_for) 会为您妥善处理。

例如，这里我们使用 [`test_request_context()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.test_request_context) 方法来尝试使用 [`url_for()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.url_for) 。 [`test_request_context()`](https://dormousehole.readthedocs.io/en/latest/api.html#flask.Flask.test_request_context) 告诉 Flask 正在处理一个请求，而实际上也许我们正处在交互 Python shell 之中， 并没有真正的请求，参见[本地环境](#本地环境)

```python
from flask import Flask,url_for

app = Flask(__name__)

@app.route('/')
def index():
    return 'index'

@app.route('/login')
def login():
    return 'login'

@app.route('/user/<username>')
def profile(username):
    return f'{username}\'s profile'

with app.test_request_context():
    print(url_for('index'))
    print(url_for('login'))
    print(url_for('login', next='/'))
    print(url_for('profile', username='John Doe'))
'''
/
/login
/login?next=/
/user/John%20Doe
'''
```

## 自定义URL转换器

```python
from werkzeug.routing import BaseConverter 
```

url转换器父类BaseConverter 

自定义URL转换器的步骤：

转换器是一个类，且必须继承自werkzeug.routing.BaseConverter。

1. 实现一个类，继承自`BaseConverter`。

2. 在自定义的类中，重写`regex`，也就是这个变量的正则表达式。

3. 将自定义的类，映射到`app.url_map.converters`上。理解为加入字典DEFAULT_CONVERTERS中

```python
###需求 自定义路径可以匹配电话号码的参数
class TelephoneConveter(BaseConverter):
    regex = r"1[345789]\d{9}"

app.url_map.converters['tel']=TelephoneConveter

@app.route('/telephone/<tel:phone>/')
def my_telephone(phone):
    return "提交的电话号码：%s" % phone
```

自定义to_python和to_url

```python
class LiConverter(BaseConverter):
    ###自定义传参
    ##查询多个模块的数据 例如  host+name
    def to_python(self, value):
        return value.split("+")
	###调用for_url时生成符合要求的url格式
    def to_url(self, value):
        return "+".join(value)

app.url_map.converters['li'] = LiConverter

@app.route('/li/<li:modules>/')
def my_modules(modules):
    return '查询的模块是 %s ' % modules

@app.route('/hello/')
def hello():
    args = url_for('my_modules',modules=['host','enter'])
    return "构建出url并返回:%s" % args
```

## 页面跳转和重定向

<h2 style="font-size:30px;">HELLO</h2>

```python
from flask import Flask,url_for,redirect
@app.route('/profile/')
def profile():
    return redirect('/login/',code=302) #code默认302可不写
	return redirect(url_for('login'),code=302)
```

- 永久性重定向

  http状态码301

- <span name="暂时性重定向">暂时性重定向</span>

  http状态码302

## 视图函数Response返回值详解

Response可以返回三种类型值，其他类型会发送错误给前端

- Response对象和子对象 

  好处是：可以加工resp后进行返回  如设置cookie等

  ```python
  resp=Response("返回的是一个Response对象")
  return resp
  ```

  

- 字符串

- 元组(响应体，状态码，头部信息)  不一定全写

  ```python
  return ("hello",200,{"sid":"zhi","nameid":"12345"})
  ```

## add_url_rule和app.route

#### app.route装饰器底层就是add_url_rule

- add_url_rule

  ```html
  @app.route('/')
  def hello_world():
      print(url_for('mli'))
      return "Hello World"
  
  def my_list():
      return "我是列表页"
  
  ##endpoint相当于起别名加了之后直接使用my_list无法访问
  app.add_url_rule('/list/',endpoint='mli',view_func=my_list)
  ```

## 类视图

```python
from flask import Flask, render_template, url_for,views
app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('test.html')

#定义一个类视图
class ListView(views.View):
    def dispatch_request(self):
        return "这是List列表"

#注册类视图
app.add_url_rule('/list/',endpoint="mlist",view_func=ListView.as_view("my_list"))
```

类试图继承

```python
from flask import Flask, render_template, url_for,views,jsonify
app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('test.html')

#存放公共广告
class ADSView(views.View):
    def __init__(self):
        super(ADSView, self).__init__()
        self.context={
            'ads':'华为   5G',
        }

#登录功能
class LoginView(ADSView):
    def dispatch_request(self):
        self.context.update({'pid':'好牛的一本书'})
        return render_template('login.html',**self.context)

#注册功能
class RegisterView(ADSView):
    def dispatch_request(self):
        self.context.update({'pid':'好吃的水果'})
        return render_template('register.html',**self.context)

#注册类视图
app.add_url_rule('/login/',view_func=LoginView.as_view('login'))
app.add_url_rule('/register/',view_func=RegisterView.as_view('register'))

if __name__ == '__main__':
    app.run()
```

### 基于请求方式调度类视图

```html
<!--login.html-->
<div>
    <form action="/login/" method="post">
        <p>账号：<input type="text" name="uname"></p>
        <p>密码：<input type="password" name="pwd"></p>
        <p><input type="submit" value="立即登录"></p>
    </form>
        {% if error %}
            <span style="color: red;">{{ error }}</span>
        {% endif %}

</div>
```

```html
<!--index.html-->
<body>
    <h3>这是系统主界面</h3>
    <p>欢迎登录成功</p>
</body>
```



```python
#app.py
from flask import Flask, render_template, url_for,views,jsonify,request
app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('test.html')


#定义一个基于请求方式调度的类视图
class LoginView(views.MethodView):
    def __common(self,error=None):
        return render_template('login.html',error=error)

    def get(self):
        return render_template("login.html")
    def post(self):
        uname=request.form['uname']
        pwd=request.form['pwd']
        if uname=="momo" and pwd=="123":
            return render_template('index.html')
        else:
            return self.__common(error="用户名或密码错误")

app.add_url_rule("/login/",view_func=LoginView.as_view("mylogin"))

if __name__ == '__main__':
    app.run()

```

## 类视图装饰器

```python
from flask import Flask,request,views
from functools import wraps
app = Flask(__name__)


@app.route('/')
def hello_world():
    return "Hello World"

def login_requierd(func):
    @wraps(func)
    def wrapper(*args,**kwargs):
        username=request.args.get("username")
        if username and username =="momo":
            return func(*args,*kwargs)
        else:
            return "请先登录"
    return wrapper


@app.route('/settings/')
@login_requierd
def settings():
    return "这是设置页面"


class ProfileView(views.View):
    decorators = [login_requierd,]
    def dispatch_request(self):
        return "这是个人中心界面"

app.add_url_rule("/profile/",view_func=ProfileView.as_view("profile"))

if __name__ == '__main__':
    app.run()

```



# 蓝图

```python
#user.py用户模块
from flask import Blueprint
user_bp=Blueprint('user',__name__)

#访问的话需要添加/user   
user_bp=Blueprint('user',__name__,url_prefix="/user")
#查看用户信息   /user/profile/
@user_bp.route('/profile/')
def profile():
    return "返回用户详情"
#修改用户信息     /user/settings/
@user_bp.route('/settings/')
def settings():
    return "个人设置中心"
```

```python
#app.py入口文件
from flask import Flask, render_template, url_for
from blueprints.user import user_bp	#导入蓝图

app = Flask(__name__)

# 注册蓝图
app.register_blueprint(user_bp)

@app.route('/')
def hello_world():
    return "Hello World"
```

## 蓝图模板查找规则

```python
#先从默认templates查找，找不到再从蓝图template_folder指定路径查找
user_bp=Blueprint('user',__name__,url_prefix="/user",template_folder="newtmp")
```

## 蓝图静态文件查找规则

如果在加载静态文件的时候，指定蓝图名字，比如news.static，那么就会到这个蓝图指定的static_folder下查找

```python
user_bp=Blueprint('user',__name__,static_folder="news_static")
```

```html
#
<link rel="stylesheet" href="{{ url_for('news.static',filename='news_list.css') }}">
```

## url_for反转蓝图注意事项

如果在蓝图中使用url_for就需要指定这个蓝图，app类、模板中、同一蓝图类中都需要指定

```python
print(url_for('news.news_list'))
```

```html
<a href="{{ url_for('news.hello_login') }}">Hello World</a>
```

## 子域名设置

```shell
C:\Windows\System32\drivers\etc\hosts
```

```python
#子域名蓝图
from flask import Blueprint,render_template
cms_bp=Blueprint('cms',__name__,subdomain='cms')

#子域名的首页
@cms_bp.route('/')
def hello():
    return render_template('cms_index.html')

#子域名
@cms_bp.route('/ok/')
def hello_ok():
    return "ok"
```

```python
#主app入口
from flask import Flask,request,render_template
from blueprints.url_hosts import cms_bp
app = Flask(__name__)
app.register_blueprint(cms_bp)

#app.config.from_pyfile("config.ini")
app.config['SERVER_NAME']='momo.com:5000'

@app.route('/')
def hello_world():
    return render_template('index.html')
```





# Jinja2模板

## 查找路径

默认是根目录templates下

```python
app=Flask(__name__,template_folder="D:\\demo")	#指定模板路径
```

## 模板传参

#### 普通传参

```html
<p>{{ msg }}</p>
```

```python
return render_template("login.html",msg="哈喽酷狗")
```

#### 字典传参

```html
<h1>模板传参</h1>
<p>{{ uname }}</p>
<p>{{ age }}</p>
<p>{{ country }}</p>
<p>{{ childrens.name }}</p>
<p>{{ childrens['height'] }}</p>
```

```python
@app.route('/msg2/')
def hello_msg2():
    context={
        'uname':'momo',
        'age':18,
        'country':'china',
        'childrens':{
            'name':'mjz',
            'height':'62cm'
        }
    }
    return render_template("login.html",**context)
```

### 模板url_for

#### 基本使用

```html
<a href="{{ url_for('login') }}">登录页面</a>
```

```python
@app.route('/user/')
def user():
    return render_template('login.html')
```

#### 路径传参

```html
<a href="{{ url_for('login',name='tantan') }}">登录页面</a>
```

```python
@app.route('/')
def hello_world():
    return render_template('login.html')
```

## 过滤器

```html
{{postion | abs}}	#绝对值 
{{postion | default("此人很懒，暂无前面")}}  #默认值
```

 abs(value)：返回一个数值的绝对值。 例如：-1|abs。

 default(value,default_value,boolean=false)：如果当前变量没有值，则会使用参数中的值来代替。name|default('xiaotuo')——如果name不存在，则会使用xiaotuo来替代。boolean=False默认是在只有这个变量为undefined的时候才会使用default中的值，如果想使用python的形式判断是否为false，则可以传递boolean=true。也可以使用or来替换。

 escape(value)或e：转义字符，会将<、>等符号转义成HTML中的符号。例如：content|escape或content|e。

 first(value)：返回一个序列的第一个元素。names|first。

 format(value,*arags,**kwargs)：格式化字符串。例如以下代码：

 {{ "%s" - "%s"|format('Hello?',"Foo!") }}将输出：Helloo? - Foo!

 last(value)：返回一个序列的最后一个元素。示例：names|last。

 length(value)：返回一个序列或者字典的长度。示例：names|length。

 join(value,d='+')：将一个序列用d这个参数的值拼接成字符串。

 safe(value)：如果开启了全局转义，那么safe过滤器会将变量关掉转义。示例：content_html|safe。

 int(value)：将值转换为int类型。

 float(value)：将值转换为float类型。

 lower(value)：将字符串转换为小写。

 upper(value)：将字符串转换为小写。

 replace(value,old,new)： 替换将old替换为new的字符串。

 truncate(value,length=255,killwords=False)：截取length长度的字符串。

 striptags(value)：删除字符串中所有的HTML标签，如果出现多个空格，将替换成一个空格。

 trim：截取字符串前面和后面的空白字符。

 string(value)：将变量转换成字符串。

 wordcount(s)：计算一个长字符串中单词的个数。

### 自定义过滤器

只有当系统提供的过滤器不符合需求后，才须自定义过滤器

过滤器本质上就是一个函数。

如果在模版中调用这个过滤器，那么就会将这个变量的值作为第一个参数传给过滤器这个函数，

然后函数的返回值会作为这个过滤器的返回值。

需要使用到一个装饰器：`@app.template_filter('过滤器名称')`

例如：将新闻中出现的 所有“十大酷刑” 删除掉

```python
#将模版设置为自动加载模式
app.config['TEMPLATES_AUTO_RELOAD']=True
@app.template_filter('cut')
def cut(value):
    value=value.replace("十大酷刑",'')
    return value
```

使用：

```html
<p>使用自定义过滤器：{{新闻内容值|cut}}</p>
```

### 自定义时间处理过滤器

操作发布新闻 与现在的时间间隔

```html
<p>发布时间：{{新闻创建时间|handle_time}}</p>
```

```python
from datetime import datetime
#需求：操作发布新闻 与现在的时间间隔
@app.template_filter('handle_time')
def handle_time(time):
      """
       time距离现在的时间间隔
       1. 如果时间间隔小于1分钟以内，那么就显示“刚刚”
       2. 如果是大于1分钟小于1小时，那么就显示“xx分钟前”
       3. 如果是大于1小时小于24小时，那么就显示“xx小时前”
       4. 如果是大于24小时小于30天以内，那么就显示“xx天前”
       5. 否则就是显示具体的时间 2018/10/20 16:15
       """
      if isinstance(time, datetime):
          now = datetime.now()
          timestamp = (now - time).total_seconds()
          if timestamp < 60:
              return "刚刚"
          elif timestamp >= 60 and timestamp < 60 * 60:
              minutes = timestamp / 60
              return "%s分钟前" % int(minutes)
          elif timestamp >= 60 * 60 and timestamp < 60 * 60 * 24:
              hours = timestamp / (60 * 60)
              return '%s小时前' % int(hours)
          elif timestamp >= 60 * 60 * 24 and timestamp < 60 * 60 * 24 * 30:
              days = timestamp / (60 * 60 * 24)
              return "%s天前" % int(days)
          else:
              return time.strftime('%Y/%m/%d %H:%M')
      else:
          return time
```

## 控制语句

### if语句

```html
{% if flag==True %}
    <p>孙悟空</p>
{% elif flag==False %}
    <p>六耳猕猴</p>
{% else %}
    <p>如来也不知道</p>
{% endif %}
```

```python
@app.route('/test/')
def condition_if():
    messages = {
        'flag':True,
    }
    return render_template('index.html',**messages)
```

### for语句

数据

```python
    datas = {
        'users': ['momo', 'lulu', 'tantan'],
        'person': {
            'name': '莫莫',
            'age': 18,
            'gender': '男',
            'nick': '莫帅'
        },
        'books': [
            {
                'name': '鸟哥的linux私房菜',
                'price': 89,
                'author': '鸟哥'
            },
            {
                'name': '墨菲定律',
                'price': 100,
                'author': '墨菲'
            },
            {
                'name': 'Web之Flask1',
                'price': 89,
                'author': '李辉'
            },
            {
                'name': 'Web之Flask2',
                'price': 89,
                'author': '李辉'
            },
            {
                'name': 'Web之Flask3',
                'price': 89,
                'author': '李辉'
            }
        ]
    }
```

#### 遍历列表

```html
<h2>遍历列表</h2>
{% for name in users %}
<p>名字：{{ name }}</p>
{% endfor %}
```

### 遍历键值对

```html
<h2>遍历个人信息</h2>
<table border="1px">
    <tr>
        <th>姓名</th>
        <th>年龄</th>
        <th>性别</th>
        <th>昵称</th>
    </tr>
    <tr>
        {% for msg in person.values() %}
        <td>{{ msg }}</td>
        {% endfor %}
    </tr>
</table>
```

#### 遍历嵌套字典

```html
<table>
    <tr>
        <th>书名</th>
        <th>价格</th>
        <th>作者</th>
    </tr>
    {% for book in books %}
    <tr>
        {% for value in book.values() %}
        <td>{{ value }}</td>
        {% endfor %}
    </tr>
    {% endfor %}
</table>
```

#### 99乘法表

```html
<div>
    <table border="1px">
        {% for i in range(1,10) %}
            <tr>
                 {% for n in range(1,i + 1) %}
                    <td>{{ n }}*{{ i }}={{ i*n }}</td>
                 {% endfor %}
            </tr>
        {% endfor %}
    </table>
</div>
```

## 宏

和函数相似，但没有返回值

```html
{% macro inp(uname,type="text",value="") %}
<input type="{{ type }}" name="{{ uname }}" value="{{ value }}">
{% endmacro %}
{{ inp('pwd',type='password',value='123') }}
```

宏的导入

```html
{% import 'macros.html' as f %}
{% from 'macros.html' import f_input %}
{#如果在导入宏的时候，需要把当前模板的一些参数传给宏所在的模板 就需要使用with context#}
{% import 'macros.html' as f with context %}
{{ f.f_input('pwd',type='password',value='123') }}
```

## include标签

模板块的复用，将指定模板中的代码复制到当前位置

```html
<div>
    底部：被复用的HTML模板块
</div>
```

```html
{% include 'top.html' %} #导入HTML模板块
```

include网页HTML模板传参

```html
<!--top.html-->
<div id="log">
     <nav>
         <ul class="nav">
             <li>尚学堂集团旗下品牌</li>
             <li>云数学院</li>
             <li>速学堂</li>
             <li>百战程序员</li>
             <li> 优效学院线上培训- 优效聚名师，学习更有效</li>
             <li style="color: red"> {{ major }}</li>
         </ul>
     </nav>
</div>
```

```python
#app.py
@app.route('/')
def hello_world():
    return render_template('index.html',major="Python学院")
```

### set和with语句使用

- #### set定义全局变量-在后面代码都可以使用

  ```html
  {#set全局变量#}
  {% set uname="momo" %}
  <p>用户名：{{ uname }}</p>
  ```

- #### with定义局部变量-只能在with语句块使用

  ```html
  {#with局部变量#}
  {% with user="admin",age="18" %}
  	{#组合使用-涉及变量区域有效性#}
      {% set school="尚学堂" %}
      <p>管理员：{{ user }}</p>
      <p>年龄：{{ age }}</p>
      <p>学校：{{ school }}</p>
  {% endwith %}
  ```

## 加载静态文件

```html
<!--加载CSS文件-->
<link rel="stylesheet" type="text/css" 
href="{{ url_for('static',filename='icon/iconfont.css') }}"/>
<!--加载JS文件-->
<script type="text/javascript" src="{{ url_for('static',filename='js/jd.js') }}"></script>
<!--加载图片-->
<img src="{{ url_for('static',filename='img/logo.jpg') }}" alt="logo加载错误">
```

## 模板继承

### 理论

在include的基础上，使用模板继承替换include,可以继续进行代码优化，include和模板继承基本是一样功能

- 公用的代码抽取出来放到一个父模板中，以后子模版直接继承使用

### 实战

#### 创建模板

给模板网页开接口

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>
        {% block block_title %}
            模板Title
        {% endblock %}
    </title>
    <style>
        div{
            background-color: antiquewhite;
        }
    </style>
</head>
<body>
    <div>
        {% block block_top %}
        我是模板头部
        {% endblock %}
    </div>
    <div>
        {% block block_body %}
            <p>我是模板中的内容</p>
        {% endblock %}
    </div>
    <div>
        <p>
            {%  block block_bottom %}
            <p>我是模板中的底部</p>
            {% endblock %}
        </p>
    </div>
</body>
</html>
```

#### 使用模板

```html
{% extends 'parents.html' %}
    {% block block_title %}
        我是修改后的标题
    {% endblock %}
    {% block block_top %}
        修改后的头部
    {% endblock %}
    {% block block_body %}
        <h3>修改后的内容</h3>
    {% endblock %}
    {% block block_bottom %}
        修改后的底部
    {% endblock %}
<p>block外的代码块</p>
<p>不会被渲染</p>
<p>不会显示</p>
```

- #### 子模版如果实现了父模板定义的block，那么子模版block中的代码会覆盖的父模板中的代码

- #### 如果想要在子模版中保留父模板代码可以使用{{super()}}实现

  ```html
  {% block block_bottom %}
      {{ super() }}
      修改后的底部
  {% endblock %}
  ```

- #### 调用另一个block中的代码

  ```html
  {% block block_bottom %}
      修改后的底部
      <h3>调用另一个block中的代码</h3>
      {{ self.block_top() }}
  {% endblock %}
  ```

- #### 要使用模板的网页必须以extends

- #### 实现自己的代码需要放到block外的代码块

- 不需要修改模板中内容的话可直接引入

  ```html
  {% extends 'parents.html' %}
  ```

- 不使用单个接口模板可以直接导入不填内容

  ```html
  {% block block_bottom %}
  {% endblock %}
  ```

# Flask高级

## Cookie

flask设置cookie

```python
def flask_cookie():
    resp = Response('服务器创建的cookie信息')
    resp.set_cookie('uname', 'momo')
    resp.set_cookie('pwd', '123456', max_age=60)
    return resp
```

删除cookie

```python
resp.delete_cookie('uname')
```

cookie设置过期时间

- max_age：以秒为单位，距离现在多少秒后过期

- expires：为datetime类型，这个时间需要设置为格林尼治时间，相对北京时间+8小时

  ```python
  from datetime import datetime
  ex=datetime(year=2012,month=9,day=10,hour=4,minute=0,second=0)
  resp = Response(render_template("京东购物车.html"))
  resp.set_cookie('pwd','123',expires=ex)
  return resp
  ```

- #### 两者同时出现以max_age为准

- #### 没有设置过期时间，浏览器关闭就清除，存放在内存中

- #### 设置过期时间，存放在硬盘中

- max_age不支持ie8以下

设置cookie有效域名

```python
resp.set_cookie('pwd','123456') #默认只有主域名使用
resp.set_cookie('uname','lulu',domain='.momo.com') #子域名可以使用
```

## Session

- 服务器
  - 把用户相关信息储存到服务端的session中
  - 通过盐的机制加密随机生成唯一的session_id，用来标识用户相关信息并将session_id也存入session中
  - 把session作为cookie的key，session_id作为cookie的value创建cookie信息并且返回客户端
  - 客户端发生二次请求时，获取cookie信息，与服务器端session容器中session_id对比，得出指定用户信息
- 客户端功能
  - 通过cookie储存session加密后的session_id信息
  - 以后浏览器再次请求服务器的时候，就会自动把cookie信息(包含session_id)发给服务器

设置session

```python
from flask import Flask,session
import os
app = Flask(__name__)
#设置SECRET_KEY
app.config['SECRET_KEY']=os.urandom(24)

@app.route('/')
def hello_world():
    session['uname']='momo'
    session['pwd']='123'
    return "hello"
```

获取session

```python
uname=session.get('uname')
```

删除session值

```python
session.pop('uname')	#删除指定key
session.clear()		#删除session所有值
```

设置session存储时间

```python
session.permanent=True  #默认三十一天后过期
```

```python
app.config['PERMANENT_SESSION_LIFETIME']=timedelta(hours=2) #两小时后过期
```

模板获取session对象

```html
{{session.get(key)}}
```

ThreadLocal隔离线程间的对象  线程内外数据不共享

```python
from threading import Thread,local

local=local()
local.request="具体用户的请求对象"
class MyThread(Thread):
    def run(self):
        local.request = "haha"
        print("子线程",local.request)

mythread=MyThread()
mythread.start()
mythread.join()
print("主线程",local.request)
```

## 未会--Flask_app上下文

#### app上下文也叫应用上下文

- ##### 应用上下文底层：是存放到一个'LocalStack'的栈中，和应用app相关的操作就必须用到应用上下文，比如通过'current_app'获取当前的这个'app'名字

- 栈先进后出

- current app永远指向所在栈最顶端，指向栈内存的时候，栈里必须有内容

注意：

1. 在视图函数中，不用担心应用上下文的问题，因为视图函数要执行，肯定是通过访问url的方式执行的，那么这种情况下，Flask底层已经自动的帮我们把应用上下文都推入到相应栈

   ```python
   from flask import Flask,current_app
   app=Flask(__name__)
   
   @app.route('/')
   def hello_world():
       print(current_app.name) #获取应用上下文名字，方式一
       return 'Hello World!'
   ```

2. 如果想要在视图函数外面执行相关操作，比如获取当前app名称，那么就必须手动推入应用上下文

   1. ```python
      from flask import Flask,current_app
      app=Flask(__name__)
      
      app_context_obj = app.app_context() #手动创建应用上下文
      app_context_obj.push()  #手动将应用上下文对象推入栈的顶部
      print(current_app.name) #获取应用上下文
      ```

   2. ```python
      with app.app_context():
          print(current_app.name)
      ```

## g全局对象

```python
#定义
from flask import g
g.name=name
#使用
print(g.name)
```

## 钩子函数HOOK

before_first_request   项目部署好以后，第一次请求之前执行的某些操作

```python
@app.route('/')
def hello_world():
    print("hello")
    return 'Hello World!'

#项目部署好以后，第一次请求之前执行的某些操作
@app.before_first_request
def first_request():
    print("我想在第一次请求之前执行")
>>>我想在第一次请求之前执行
>>>hello
```

before_request 每次请求之前都会执行,通常可以用这个装饰器来给视图函数增加一些变量

```python
from flask import Flask, session, g
import os

app = Flask(__name__)
app.config.from_pyfile('config.ini')
app.config['SECRET_KEY'] = os.urandom(24)

@app.route('/')
def hello_world():
    print("hi")
    session['uname'] = 'momo'
    return 'Hello World!'

def mylist():
    print('mylist')
    if hasattr(g, 'user'):
        print("条件取出", g.user)
    return "hello world"

# before_request 每次请求之前都会执行,通常可以用这个装饰器来给视图函数增加一些变量
@app.before_request
def befor_request():
    print("我想在每次次请求之前执行")
    uname = session.get("uname")
    print(uname)
    if uname:
        g.user = uname

if __name__ == '__main__':
    app.run()
```

钩子函数context_processor:上下文处理器，必须返回一个字典，这个字典中的值在所有模板中都可以使用。如果在一些很多模板中都要用到的变量，那么就可以使用钩子函数返回，而不用在视图函数render_template中去写，这样可以使代码更加简洁和好维护

```python
# 那么就可以使用这个钩子函数来返回，而不用在每个视图函数中的`render_template`中去写，这样可以让代码更加简洁和好维护。
@app.context_processor
def context_processor():
    if hasattr(g,"user"):
        return {"current_user":g.user}
    else:
        return {}
<p>当前用户：{{current_user}}</p>
```



钩子函数errorhandler详解

1.errorhandler: errorhandler接收状态码，可以自定义返回这种状态码的响应的处理方法。在发生一些异常的时候，比如404错误，比如500错误,那么如果想要优雅的处理这些错误，就可以使用`errorhandler`来出来。

需要注意几点：

  在errorhandler装饰的钩子函数下，记得要返回相应的状态码。

   在errorhandler装饰的钩子函数中，必须要写一个参数，来接收错误的信息，如果没有参数，就会直接报错。

   使用`flask.abort`可以手动的抛出相应的错误，比如开发者在发现参数不正确的时候可以自己手动的抛出一个400错误。

errorhandler：errorhandler接收状态码，可以自定义返回这种状态码的响应的处理方法。

```python
# 4.errorhandler：errorhandler接收状态码，可以自定义返回这种状态码的响应的处理方法。
# 在发生一些异常的时候，比如404错误，比如500错误,那么如果想要优雅的处理这些错误，就可以使用`errorhandler`来出来
@app.errorhandler(500)
def server_error(error):
    print(error)
    return render_template("500.html"), 500
    # return  render_template("500.html")  #此写法少一个状态码  不推荐

@app.errorhandler(404)
def request_error(error):
    return render_template('404.html'), 404

@app.errorhandler(400)
def data_error(error):
    return "您的参数不正确", 400

# 该功能需要先登录才能访问
@app.route('/setting/')
def setting():
    uname = session.get("uname")
    if uname:
        return '欢迎来到设置页面'
    else:
        # 如果没有登录，这时候我就让他跳转到400错误
        abort(400)
    return render_template('list.html')
```

## Flask信号机制

1.信号机制-blinker插件：

   大白话来说，类似于两方属于敌对关系时，某人在敌对方阵营进行交谈，一旦遇到特殊情况，某人便会发送信号，他的同伙接收（监听）到他发的信号后，同伙便会做出一系列的应对策略(杀进去|撤退)。

  flask中的信号使用的是一个第三方插件，叫做**blinker**。通过pip list看一下，如果没有安装，通过以下命令即可安装blinker：

```shell
pip install blinker
```

定义三步走

1. 创建信号--定义信号
2. 监听信号-订阅信号
3. 发送一个信号

```python
from flask import Flask
from blinker import Namespace
app=Flask(__name__)
app.config.from_pyfile('config.ini')
#Namespace:命名空间
#1.创建信号--定义信号
sSpace=Namespace()
fire_signal=sSpace.signal("发送信号火箭")

#2.监听信号-订阅信号
def fire_play(sender):
    print(sender)
    print("start play")
fire_signal.connect(fire_play)

#发送一个信号
fire_signal.send()
```

登录日志功能

```python
from blinker import Namespace
from datetime import  datetime
from flask  import  request,g

#创建一个登录信号
momoSpace = Namespace()
login_signal = momoSpace.signal("创建一个登录信号")

#监听信号
def  login_log(sender):
    #用户名   时间   ip
    uname = g.uname
    now = datetime.now()
    ip =request.remote_addr
    log_data="{uname}*{now}*{ip}".format(uname=uname,now=now,ip=ip)
    with  open('login_log.txt','a') as f:
        f.write(log_data+"\n")
        f.close()

login_signal.connect(login_log)
```

```python
from flask import Flask,request,g,template_rendered,flash,render_template,got_request_exception
from blinker import  Namespace
app = Flask(__name__)
from signals  import login_signal
#自定义信号

#1.创建信号
sSpace = Namespace()
mysignal = sSpace.signal("发送一个火箭信号")
#2监听信号
def  fire_play(sender):
    print(sender)
    print("开火")

mysignal.connect(fire_play)

#3.发送信号
mysignal.send()
```

## Flask内置信号

##### flask内置了10个常用的信号。

 

1. ##### template_rendered：模版渲染完成后的信号。

2. before_render_template：模版渲染之前的信号。

3. request_started：请求开始之前，在到达视图函数之前发送信号。

4. request_finished：请求结束时，在响应发送给客户端之前发送信号。

5. request_tearing_down：请求对象被销毁时发送的信号，即使在请求过程中发生异常也会发送信号。

6. got_request_exception：在请求过程中抛出异常时发送信号，异常本身会通过exception传递到订阅（监听）的函数中。一般可以监听这个信号，来记录网站异常信息。

7. appcontext_tearing_down：应用上下文被销毁时发送的信号。

8. appcontext_pushed：应用上下文被推入到栈上时发送的信号。

9. appcontext_popped：应用上下文被推出栈时发送的信号。

10. message_flashed：调用了Flask的`flash`方法时发送的信号。

##### template_rendered的使用--模版渲染完成后的信号

```python
from flask import Flask,template_rendered,render_template
app=Flask(__name__)
app.config.from_pyfile('config.ini')


def template_rendered_func(sender,template,context):
    print(sender)   #发送者
    print(template) #跳转到的模板名
    print(context)  #跳转到模板页面带过去的参数
template_rendered.connect(template_rendered_func)


@app.route('/')
def hello_world():
    return render_template('index.html',msg="momo")
```

 

got_request_exception：在请求过程中抛出异常时发送信号，异常本身会通过exception传递到订阅（监听）的函数中。一般可以监听这个信号，来记录网站异常信息。

```python
from flask import Flask, render_template, got_request_exception

app = Flask(__name__)
app.config.from_pyfile('config.ini')

def request_error(sender,*args,**kwargs):
    print(sender)
    print(args)
    print(kwargs)
got_request_exception.connect(request_error)

@app.route('/')
def hello_world():
    a=1/0	#报错后直接执行request_error方法，不会执行下一步
    return render_template('index.html', msg="momo")	#不会执行
```

## WTforms

- 服务器端表单验证，将用户提交上来的数据进行验证是否符号系统要求
- 模板渲染（了解即可）

### 安装Flask-WTF(WTforms升级版)

flask-wtf还包括其他功能，CSRF保护和文件上传等

安装flask-wtf也会安装WTForms

```shell
pip install flask-wtf
```

WTForms常用验证器：

  页面把数据提交上来，需要经过表单验证，进而需要借助验证器来进行验证，以下是常用的内置验证器：

 

1. Length：字符串长度限制，有min和max两个值进行限制。
2. EqualTo：验证数据是否和另外一个字段相等，常用的就是密码和确认密码两个字段是否相等。
3. Email：验证上传的数据是否为邮箱数据格式  如：223333@qq.com。
4. InputRequired：验证该项数据为必填项，即要求该项非空。
5. NumberRange：数值的区间，有min和max两个值限制，如果处在这两个数字之间则满足。
6. Regexp：定义正则表达式进行验证，如验证手机号码。
7. URL：必须是URL的形式 如http://www.bjsxt.com。
8. UUID：验证数据是UUID类型。

index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册页面2</title>
</head>
<body>
  <form action="/reg/" method="post">
    <table>
            <tr>
                <th>邮箱：</th>
                <td><input type="email" name="email"></td>
            </tr>
            <tr>
                <th>用户名：</th>
                <td><input type="text" name="uname"></td>
            </tr>
            <tr>
                        <th>年龄：</th>
                <td><input type="number" name="age"></td>
            </tr>
            <tr>
                <th>手机号码：</th>
                <td><input type="text" name="phone"></td>
            </tr>
            <tr>
                <th>个人主页：</th>
                <td><input type="text" name="phomepage"></td>
            </tr>
            <tr>
                <th>uuid：</th>
                <td><input type="text" name="uuid"></td>
            </tr>
            <tr>
                <th></th>
                <td><input type="submit" value="注册"></td>
            </tr>
    </table>
</form>
</body>
</html>
```

WTForm表单工具类--formscheck.py

```python
from wtforms import Form, StringField, IntegerField, RadioField, BooleanField, SelectField, TextField, DateField
from wtforms.validators import Length, EqualTo, Email, InputRequired, NumberRange, Regexp, URL, UUID


# 定义一个表单验证类
class RegisterForm(Form):
    uname = StringField(validators=[Length(min=2, max=15, message="用户名的长度必须是2-15之间")])
    pwd = StringField(validators=[Length(min=6, max=12)])
    pwd2 = StringField(validators=[Length(min=6, max=12), EqualTo('pwd', message="两次密码不一样")])


# 定义一个表单验证类2
class RegisterForm2(Form):
    email = StringField(validators=[Email()])
    uname=StringField(validators=[InputRequired()])
    age=IntegerField(validators=[NumberRange(min=18,max=40)])
    phone=StringField(validators=[Regexp(r'1[34578]\d{9}')])
    phomepage=StringField(validators=[URL()])
    uuid = StringField(validators=[UUID()])
```

app.py

```python
from flask import Flask, render_template, got_request_exception,request
from formscheck import RegisterForm,RegisterForm2

app = Flask(__name__)
app.config.from_pyfile('config.ini')


@app.route('/')
def hello_world():
    return "hello"

@app.route('/reg/',methods=['GET','POST'])
def login():
    if request.method == "GET":
        return render_template('index.html')
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"

if __name__ == '__main__':
    app.run()
```

自定义验证器-验证码实现

```python
from flask import Flask, render_template, got_request_exception,request,session
from formscheck import RegisterForm,RegisterForm2
import os
import  random
app = Flask(__name__)
app.config.from_pyfile('config.ini')
app.config['SECRET_KEY']=os.urandom(24)

@app.route('/')
def hello_world():
    return "hello"

#wtforms常用验证器使用
@app.route('/register2/',methods=['GET','POST'])
def login():
    if request.method == 'GET':
        #自定义验证器     实现验证码验证
        code = random.randint(1000,9999)  #生成一个随机4位整数值的验证码
        session['code'] = str(code)
        return render_template("index.html")
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"

if __name__ == '__main__':
    app.run()
```

### 自定义表单验证类

register2.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册页面2</title>
</head>
<body>
  <form action="/register2/" method="post">
    <table>
            <tr>
                <th>邮箱：</th>
                <td><input type="email" name="email"></td>
            </tr>
            <tr>
                <th>用户名：</th>
                <td><input type="text" name="uname"></td>
            </tr>
            <tr>
                <th>年龄：</th>
                <td><input type="number" name="age"></td>
            </tr>
            <tr>
                <th>手机号码：</th>
                <td><input type="text" name="phone"></td>
            </tr>
            <tr>
                <th>个人主页：</th>
                <td><input type="text" name="phomepage"></td>
            </tr>
            <tr>
                <th>uuid：</th>
                <td><input type="text" name="uuid"></td>
            </tr>
            <tr>
                <th>验证码：</th>
                <td><input type="text" name="code" size="4" maxlength="4"><span style="background-color: red">{{ session.get('code')}}</span></td>
            </tr>
            <tr>
                <th></th>
                <td><input type="submit" value="注册"></td>
            </tr>
    </table>
</form>
</body>
</html>
```

formscheck.py

```python
from wtforms import Form, StringField, IntegerField, RadioField, BooleanField, SelectField, TextAreaField, \
    DateTimeField, FileField
from wtforms.validators import Length, EqualTo, Email, InputRequired, NumberRange, Regexp, URL, UUID, ValidationError
from flask import session

# 定义一个表单验证类
class RegisterForm(Form):
    uname = StringField(validators=[Length(min=2, max=15, message="用户名长度必须是2-15")])
    pwd = StringField(validators=[Length(min=6, max=12)])
    pwd2 = StringField(validators=[Length(min=6, max=12), EqualTo("pwd", message="两次输入密码不一致")])
```

app.py

```python
from flask import Flask,request,render_template,session,send_from_directory
from formscheck import  RegisterForm,RegisterForm2
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  CombinedMultiDict
import os,random

app = Flask(__name__)
app.config['SECRET_KEY']= os.urandom(24)

@app.route('/register/',methods=['GET','POST'])
def register():
    if request.method == "GET":
        return render_template("checkform.html")
    else:
    #使用表单验证对象验证
        form = RegisterForm(request.form)
        if form.validate(): #验证要么ok要么no
            return "验证通过"
        else:
            print(form.errors)
            return "数据验证通不过"

@app.route('/register2/',methods=['GET','POST'])
def login():
    if request.method == "GET":
        code = random.randint(1000,9999)
        session['code']=str(code)
        return render_template('checkform.html')
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"

if __name__ == '__main__':
    app.run()
```

### 自定义验证码器_验证码实现

```python
#formcheck.py
from flask import Flask,request,render_template,session,send_from_directory
from formscheck import  RegisterForm,RegisterForm2
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  CombinedMultiDict
import os,random
# 定义一个表单验证类2
class RegisterForm2(Form):
    email = StringField(validators=[Email()])
    uname = StringField(validators=[InputRequired()])
    age = IntegerField(validators=[NumberRange(min=18, max=40)])
    phone = StringField(validators=[Regexp(r'1[34578]\d{9}')])
    phomepage = StringField(validators=[URL()])
    uuid = StringField(validators=[UUID()])
    code = StringField(validators=[Length(min=4, max=4)])

    # 光有长度验证  不能满足验证码验证需求，此时需要自定义验证器来对 某字段验证进行强化
    def validate_code(self, field):
        # 去字段field对象上的值来做验证
        print(field.data, session.get('code'))
        scode = session.get('code')
        if field.data != scode:
            raise ValidationError(message='输入的验证码不一致！！')
```

```python
#app.py
@app.route('/register2/',methods=['GET','POST'])
def login():
    if request.method == "GET":
        code = random.randint(1000,9999)
        session['code']=str(code)
        return render_template('checkform.html')
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"
```



### 上传文件

upload.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
</head>
<body>
<form action="" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>头像：</td>
            <td><input type="file" name="pichead"></td>
        </tr>
        <tr>
            <td>描述：</td>
            <td><input type="text" name="desc"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="提交"></td>
        </tr>
    </table>
</form>
</body>
</html>
```

注意：enctype="multipart/form-data"

```python
from flask import Flask,request,render_template
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config.from_pyfile("config.ini")

UPLOAD_PATH = os.path.join(os.path.dirname(__file__),"images")


@app.route('/upload/',methods=["GET",'POST'])
def upload():
    if request.method == "GET":
        return render_template('upload.html')
    else:
        desc = request.form.get("desc")
        pichead = request.files.get("pichead")
        filename = secure_filename(pichead.filename)
        pichead.save(os.path.join(UPLOAD_PATH,filename))
        print(desc)
        return "文件上传成功"
if __name__ == '__main__':
    app.run()
```

### 访问已上传文件

```python
#访问已上传文件
from flask import send_from_directory
@app.route('/images/<filename>/')
def get_image(filename):
    return send_from_directory(UPLOAD_PATH,filename)
```



### 问题

```shell
#报错
Exception: Install 'email_validator' for email validation support
#解决方法一
pip install email_validator
#解决方法二 自定义表单验证类

register2.html

​```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册页面2</title>
</head>
<body>
  <form action="/register2/" method="post">
    <table>
            <tr>
                <th>邮箱：</th>
                <td><input type="email" name="email"></td>
            </tr>
            <tr>
                <th>用户名：</th>
                <td><input type="text" name="uname"></td>
            </tr>
            <tr>
                <th>年龄：</th>
                <td><input type="number" name="age"></td>
            </tr>
            <tr>
                <th>手机号码：</th>
                <td><input type="text" name="phone"></td>
            </tr>
            <tr>
                <th>个人主页：</th>
                <td><input type="text" name="phomepage"></td>
            </tr>
            <tr>
                <th>uuid：</th>
                <td><input type="text" name="uuid"></td>
            </tr>
            <tr>
                <th>验证码：</th>
                <td><input type="text" name="code" size="4" maxlength="4"><span style="background-color: red">{{ session.get('code')}}</span></td>
            </tr>
            <tr>
                <th></th>
                <td><input type="submit" value="注册"></td>
            </tr>
    </table>
</form>
</body>
</html>
​```

formscheck.py

​```python
from wtforms import Form, StringField, IntegerField, RadioField, BooleanField, SelectField, TextAreaField, \
    DateTimeField, FileField
from wtforms.validators import Length, EqualTo, Email, InputRequired, NumberRange, Regexp, URL, UUID, ValidationError
from flask import session

# 定义一个表单验证类
class RegisterForm(Form):
    uname = StringField(validators=[Length(min=2, max=15, message="用户名长度必须是2-15")])
    pwd = StringField(validators=[Length(min=6, max=12)])
    pwd2 = StringField(validators=[Length(min=6, max=12), EqualTo("pwd", message="两次输入密码不一致")])
​```

app.py

​```python
from flask import Flask,request,render_template,session,send_from_directory
from formscheck import  RegisterForm,RegisterForm2
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  CombinedMultiDict
import os,random

app = Flask(__name__)
app.config['SECRET_KEY']= os.urandom(24)

@app.route('/register/',methods=['GET','POST'])
def register():
    if request.method == "GET":
        return render_template("checkform.html")
    else:
    #使用表单验证对象验证
        form = RegisterForm(request.form)
        if form.validate(): #验证要么ok要么no
            return "验证通过"
        else:
            print(form.errors)
            return "数据验证通不过"

@app.route('/register2/',methods=['GET','POST'])
def login():
    if request.method == "GET":
        code = random.randint(1000,9999)
        session['code']=str(code)
        return render_template('checkform.html')
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"

if __name__ == '__main__':
    app.run()
​```

自定义验证码器_验证码实现

​```python
#formcheck.py
from flask import Flask,request,render_template,session,send_from_directory
from formscheck import  RegisterForm,RegisterForm2
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  CombinedMultiDict
import os,random
# 定义一个表单验证类2
class RegisterForm2(Form):
    email = StringField(validators=[Email()])
    uname = StringField(validators=[InputRequired()])
    age = IntegerField(validators=[NumberRange(min=18, max=40)])
    phone = StringField(validators=[Regexp(r'1[34578]\d{9}')])
    phomepage = StringField(validators=[URL()])
    uuid = StringField(validators=[UUID()])
    code = StringField(validators=[Length(min=4, max=4)])

    # 光有长度验证  不能满足验证码验证需求，此时需要自定义验证器来对 某字段验证进行强化
    def validate_code(self, field):
        # 去字段field对象上的值来做验证
        print(field.data, session.get('code'))
        scode = session.get('code')
        if field.data != scode:
            raise ValidationError(message='输入的验证码不一致！！')
​```

​```python
#app.py
@app.route('/register2/',methods=['GET','POST'])
def login():
    if request.method == "GET":
        code = random.randint(1000,9999)
        session['code']=str(code)
        return render_template('checkform.html')
    else:
        form = RegisterForm2(request.form)
        if form.validate():
            return "验证OK"
        else:
            print(form.errors)
            return "验证失败"
​```



#### 上传文件

upload.html

​```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
</head>
<body>
<form action="" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>头像：</td>
            <td><input type="file" name="pichead"></td>
        </tr>
        <tr>
            <td>描述：</td>
            <td><input type="text" name="desc"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="提交"></td>
        </tr>
    </table>
</form>
</body>
</html>
​```

注意：enctype="multipart/form-data"

​```python
from flask import Flask,request,render_template
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config.from_pyfile("config.ini")

UPLOAD_PATH = os.path.join(os.path.dirname(__file__),"images")


@app.route('/upload/',methods=["GET",'POST'])
def upload():
    if request.method == "GET":
        return render_template('upload.html')
    else:
        desc = request.form.get("desc")
        pichead = request.files.get("pichead")
        filename = secure_filename(pichead.filename)
        pichead.save(os.path.join(UPLOAD_PATH,filename))
        print(desc)
        return "文件上传成功"
if __name__ == '__main__':
    app.run()
​```

### 访问已上传文件

​```python
#访问已上传文件
from flask import send_from_directory
@app.route('/images/<filename>/')
def get_image(filename):
    return send_from_directory(UPLOAD_PATH,filename)
​```


pip install WTForms==2.2.1
```

## Restful接口规范



### 安装

```shell
pip install flask-restful
```

### 基本使用

```python
from flask import Flask
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)


@app.route('/')
def hello_world():
    return "Hello World"


# Flask_RESTful的基本使用
# 定义一个类试图
class LoginView(Resource):
    def get(self):
        return {"flag": "no"}

    def post(self):
        return {"flag": "yes"}

#映射url
api.add_resource(LoginView,"/login/","/login2/",endpoint="login")

with app.test_request_context():
    # print(url_for('loginview')) 
    print(url_for('login')) 

if __name__ == '__main__':
    app.run(debug=True)
```

- endpoint指定url_for视图函数别名

- 如果不写endpoint，那么将会使用视图的名字的小写来作为endpoint。
- 如果指定了endpoint，就必须使用endpoint的值来构建url

# Flask数据库

## SQLAlchemy安装

```shell
pip install SQLAlchemy
```

```python
from sqlalchemy import create_engine

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"


DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)
engine = create_engine(DB_URL)


conn = engine.connect()
result = conn.execute("select * from emp")
print(result)
print(result.fetchone())
```

## ORM

对象模型与数据库的映射

```python
from sqlalchemy import create_engine,Column,Integer,String
from sqlalchemy.ext.declarative import declarative_base


HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"


DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)

#创建数据库引擎
engine = create_engine(DB_URL)

#用declarative_base根据engine创建一个ORM基类
Base = declarative_base(engine)

class Person(Base):
    __tablename__="t_person"
    #在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer,primary_key=True,autoincrement=True)    #主键primary_key  递增autoincrement
    name = Column(String(50),nullable=True)
    age = Column(Integer)
    county = Column(String(50))
    nick = Column(String(20))

Base.metadata.drop_all()    #将Base上的ORM类模型对应数据中的表都删除
Base.metadata.create_all()  #创建Base上的ORM类映射到数据库中成为表
```

## 增删改查CRUD

增加数据

```python
session = sessionmaker(engine)()	#获取到数据库会话对象
#对表添加数据
p = Person(name="momo",age=18,county="china",nick="莫莫")
p1 = Person(name="tantan",age=21,county="china",nick="探探")
p2 = Person(name="lulu",age=23,county="china",nick="露露")
#session.add(p)  #一次添加一条数据
session.add_all([p1,p2])    #一次添加多条数据
session.commit()
```

查找数据

```python
#全表查询
ps = session.query(Person).all()
print(ps)
#filter_by条件查询
ps = session.query(Person).filter_by(name="momo").all()
print(ps)
#filter条件查询
ps = session.query(Person).filter(Person.name=="momo").all()
print(ps)
#id查询get--超出返回None
ps = session.query(Person).get(2)
print(ps)
#获取第一条数据
ps = session.query(Person).first()
print(ps)
```

修改数据

```python
#修改数据
ps = session.query(Person).first()
print(ps)
ps.name="haha"
session.commit()
```

删除数据

```python
person = session.query(Person).get(3)
print(person)
session.delete(person)
session.commit()
```

## 常用数据类型

Integer 整形

Float 浮点类型

String 可变字符类型  varchar

Boolean布尔类型   tinvint

DECINAL 定点类型  解决浮点类型精度丢失  传两个参数：数字总长，小数点后几个数字

```python
#定义一个枚举类
import enum
class TagEnum(enum.Enum):
    python ="Python"
    flask="Flask"
    django="Django"

#Enum 枚举类型 指定某个字段只能是枚举中的指定几个值
tag1 = Column(Enum("PYTHON","FLASK","DJANGO"))  #sqlalchemy枚举
tag2 = Column(Enum(TagEnum))    #使用
```

Data 储存时间 只能储存年月日，映射到数据库是data类型

```python
datatime.data	#python
```

DataTime 存储时间，可以储存时分秒，映射到数据库data类型

```python
datatime.datatime	#python
```

Time 储存时间，可以储存时分秒，映射数据库是time类型

Text 储存长字符串-6万字符，超出使用LONGTEXT

LONGTEXT	长文本类型

## Column常用参数

primary_key True设置某个字段为主键

autoincrement	True设置这个字段为自动增长

default	设置某个字段的默认值，在发表时间这些字段上面经常用

nullable	指定字段是否为空，默认值是True,就是可以为空

unique	指定某个字段是否唯一,默认False

onupdate	在数据更新的时候会调用这个参数指定的值或者函数，在第一次插入这条数据的时候，不会用onupdate的值，只会使用default的值，常用于是'update_time'字段(每次更新数据的时候都会更新该字段)

name	指定orm模型中某个属性映射到表中的字段名，如果不指定，那么会使用这个属性的名字来作为字段名，如果指定了，那么使用指定的这个值作为字段名，这个参数也可以作为位置参数，在第一位指定

```python
from sqlalchemy import create_engine,Column,Integer,DateTime,Time,String,Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from datetime import datetime


HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test01"
USERNAME = "root"
PASSWORD = "root"


DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()
class Person(Base):
    __tablename__="testdata"
    #在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer,primary_key=True,autoincrement=True)    #主键primary_key  递增autoincrement
    create_time = Column(DateTime,default=datetime.now)
    raad_count=Column(Integer,default=1000)
    title=Column(String(50),nullable=False)
    telephone = Column(String(50),unique=True,nullable=False)
    title = Column(String(50),name="my_title1") #写法一orm类属性，与表字段名不想一样的使用name参数指定---命名参数
    title1 = Column("my_title2",String(50)) #写法一orm类属性，与表字段名不想一样的使用name参数指定---位置参数
    updata_time = Column(DateTime,onupdate=datetime.now)    #在数据更新的时候起作用，插入数据不起作用
Base.metadata.drop_all()
Base.metadata.create_all()


p=Person(title="哈哈",telephone="15578080111")
p1=Person(title="哈哈",telephone="15578080118")
session.add(p)  #一次添加一条数据
session.add(p1)
session.commit()
```

## query查询函数参数

1. 模型名	指定查找这个模型中所有的属性(对应查询表为全表查询)
2. 模型中的属性	可以指定只查找某个模型的其中几个属性
3. 聚合函数
   1. func.count	统计行数量
   2. func.avg	求平均值
   3. func.max	求最大值
   4. func.min	求最小值
   5. func.num	求和

```python
from sqlalchemy import create_engine,Column,Integer,String
from sqlalchemy import func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import random

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test01"
USERNAME = "root"
PASSWORD = "root"


DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()
class News(Base):
    __tablename__="news"
    #在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer,primary_key=True,autoincrement=True)    #主键primary_key  递增autoincrement
    title=Column(String(50),nullable=False)
    price = Column(Integer)

    def __repr__(self):
        return "<title:{},price:{}>".format(self.title,self.price)

'''创建Base上的ORM类映射到数据库中成为表'''
# Base.metadata.drop_all()
# Base.metadata.create_all()

'''新增测试数据'''
# for i in range(1,6):
#     a = News(title = "标题：%s" % i,price = random.randint(1,100))
#     session.add(a)
# session.commit()

r=session.query(func.count(News.id)).first()    #求行数量
print(r)
r=session.query(func.max(News.price)).first()   #最大值
print(r)
r=session.query(func.min(News.price)).first()   #最小值
print(r)
r=session.query(func.avg(News.price)).first()   #平均值
print(r)
r=session.query(func.sum(News.price)).first()   #求和
print(r)
```

filter方法常用过滤条件

```python
from sqlalchemy import create_engine, Column, Integer, String,and_,or_
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test01"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()


class News(Base):
    __tablename__ = "news"
    # 在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer, primary_key=True, autoincrement=True)  # 主键primary_key  递增autoincrement
    title = Column(String(50), nullable=False)
    price = Column(Integer)

    def __repr__(self):
        return "<title:{},price:{}>".format(self.title, self.price)


'''创建Base上的ORM类映射到数据库中成为表'''
# Base.metadata.drop_all()
# Base.metadata.create_all()

'''新增测试数据'''
# for i in range(1,6):
#     a = News(title = "title%s" % i,price = random.randint(1,100))
#     session.add(a)
# session.commit()

#过滤title是/不是"title1"的数据
news = session.query(News).filter(News.title == "title1").first()
print(news)
news = session.query(News).filter(News.title != "title2").all()
print(news)

# 模糊查询like区分大小写，ilike不区分大小写
news = session.query(News).filter(News.title.like("%tl%")).all()
print(news)

# 查询在/不在指定列表里的
news = session.query(News).filter(News.title.in_(["title1","title2"])).all()
print(news)
news = session.query(News).filter(~News.title.in_(["title1","title2"])).all()
print(news)

# 查询值为 空/非空
news = session.query(News).filter(News.title.is_(None)).all()
print(news)
news = session.query(News).filter(News.title.isnot(None)).all()
print(news)

# and_查询多个条件
news = session.query(News).filter(and_(News.title == "title1",News.price == "91",)).all()
print(news)
news = session.query(News).filter(News.title == "title1",News.price == "91",).all()
print(news)
news = session.query(News).filter(News.title == "title1").filter(News.price == "91").all()
print(news)

#or_或查询
news = session.query(News).filter(or_(News.title == "title1",News.price == "17",)).all()
print(news)
```

## SQLALchemy实现外键及其四种约束

RESTRICT	若子表中有父表对应的关联数据，删除父表对应数据，会阻止删除---默认项

NO ACTION	在MySQL中，同RESTRIC

CASCADE	级联删除

SET NULL	父表对应数据被删除，子表对应数据项会设置为NULL

```python
from sqlalchemy import create_engine, Column, Integer, String,Text,ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()
class User(Base):
    __tablename__ = "user"
    id = Column(Integer,primary_key=True,autoincrement=True)
    uname = Column(String(50),nullable=False)

    def __repr__(self):
        return "<User(uname:%s)>" %self.uname

class News(Base):
    __tablename__ = "news"
    # 在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer, primary_key=True, autoincrement=True)  # 主键primary_key  递增autoincrement
    title = Column(String(50), nullable=False)
    content = Column(Text,nullable=False)
    uid = Column(Integer,ForeignKey("user.id")) #RESTRICT
    uid = Column(Integer, ForeignKey("user.id",ondelete="NO ACTION"))    #NO ACTION
    uid = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))  # CASCADE
    uid = Column(Integer, ForeignKey("user.id", ondelete="SET NULL"))  # SET NULL

    def __repr__(self):
        return "<News(title:%s,content=%s" % (self.title,self.context)


'''创建Base上的ORM类映射到数据库中成为表'''
Base.metadata.drop_all()
Base.metadata.create_all()

'''新增测试数据'''
user = User(uname="moom")
session.add(user)
session.commit()

news1 = News(title="AAA",content="123",uid=1)
news2 = News(title="BBB",content="456",uid=1)
session.add_all([news1,news2])
session.commit()
```

## ORM层面外键和一对多关系

### relationship

```python
from sqlalchemy import create_engine, Column, Integer, String,Text,ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker,relationship

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()
class User(Base):
    __tablename__ = "user"
    id = Column(Integer,primary_key=True,autoincrement=True)
    uname = Column(String(50),nullable=False)
    #newss = relationship("News")   #这种写法不是最优的，通常会把他通过反向声明的方式写在"多"的那一方
    def __repr__(self):
        return "<User(uname:%s)>" %self.uname

class News(Base):
    __tablename__ = "news"
    # 在这个ORM模型中创建一些属性，来跟表中的字段进行映射，这些属性必须是sqlalchemy给我们提供的数据类型
    id = Column(Integer, primary_key=True, autoincrement=True)  # 主键primary_key  递增autoincrement
    title = Column(String(50), nullable=False)
    content = Column(Text,nullable=False)
    uid = Column(Integer,ForeignKey("user.id")) #RESTRICT

    #添加属性  引入relationship优化表的操作   需求一
    #最终会把正反向写在一起
    author = relationship("User",backref="newss")
    def __repr__(self):
        return "<News(title:%s,content=%s" % (self.title,self.content)


'''创建Base上的ORM类映射到数据库中成为表'''
# Base.metadata.drop_all()
# Base.metadata.create_all()

'''新增测试数据'''
# user = User(uname="momo")
# user1 = User(uname="tantan")
# session.add_all([user,user1])
# session.commit()
#
# news1 = News(title="AAA",content="123",uid=1)
# news2 = News(title="BBB",content="456",uid=1)
# news3 = News(title="CCC",content="789",uid=2)
# session.add_all([news1,news2])
# session.commit()
'''需求一  查询某篇新闻的作者
#方式一   操作麻烦
news = session.query(News).first()
print(news)
print(news.uid)
user = session.query(User).get(news.uid)
print(user)
print(user.uname)
#方式二   快速高效
news = session.query(News).first()
print(news.author)
'''
'''需求二  查询作者的所有新闻'''
user = session.query(User).first()
print(user.newss)
```

### 重点

```python
#newss = relationship("News")   #这种写法不是最优的，通常会把他通过反向声明的方式写在"多"的那一方
#最终会把正反向写在一起
author = relationship("User",backref="newss")
```

### 好处

1. ### 查询数据更简单

2. ### 添加数据更便捷

   ```python
   class User(Base):
       ······
   class News(Base):
       ······
   #通过添加【用户】来添加【新闻】
   user = User(uname="lulu")
   news1 = News(title="CCC",content="8888")
   news2 = News(title="DDD",content="9999")
   user.newss.append(news1)
   user.newss.append(news2)
   session.add(user)
   session.commit()
   #通过添加【新闻】来添加【用户】
   news3 = News(title="EEE",content="6666")
   user = User(uname="weixin")
   news3.author = user
   session.add(news3)
   session.commit()
   ```

## ORM层面一对一操作

在sqlalchemy中，如果想要两个模型映射成一对一的关系，那么应该在父模型中指定引用时传递一个uselis=False这个参数，告诉父模型，以后引用这个模型的时候，不再是一个列表，而是一个对象

```python
from sqlalchemy import create_engine, Column, Integer, String,Text,ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker,relationship,backref

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)

session = sessionmaker(engine)()
class User(Base):
    __tablename__ = "user"
    id = Column(Integer,primary_key=True,autoincrement=True)
    uname = Column(String(50),nullable=False)

    #extend = relationship("UserExtend",uselist=False)
    def __repr__(self):
        return "<User(uname:%s)>" %self.uname

class UserExtend(Base):
    __tablename__ = "user_extend"
    id = Column(Integer,primary_key=True,autoincrement=True)
    school = Column(String(50))
    #外键
    uid = Column(Integer,ForeignKey("user.id"))
    user=relationship("User",backref=backref("extend",uselist=False))

# Base.metadata.drop_all()
# Base.metadata.create_all()
'''ORM层面 一对一关系实现
#好处一  添加数据
user = User(uname="zhangsan")
ux = UserExtend(school="山东大学")
user.extend = ux
session.add(user)
session.commit()
'''-----------'''
user2 = User(uname="李四")
ux1 = UserExtend(school = "上海大学")
ux1.user = user2
session.add(ux1)
session.commit()'''
#好处二  查询数据
user3=session.query(User).first()
print(user3.uname)
print(user3.extend.school)
```

```python
#正反向写在一起
user=relationship("User",backref=backref("extend",uselist=False))
```

## ORM层面多对多

1. 多对多的关系需要通过一张中间表来绑定
2. 先把两个需要多对多的模型定义出来
3. 使用Table定义一个中间表，中间表一般包括两个模型的外键字段就可以了，并且让他们连个作为一个”复合主键“
4. 在两个需要多对多的模型中随便选择一个模型，定义一个relationship属性，来绑定三者之间的关系，使用relationship时需要传入一个secondary=中间表对象名

```python
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Table
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
engine = create_engine(DB_URL)
Base = declarative_base(engine)
session = sessionmaker(engine)()

# 表三  中间表

news_tag = Table(
    "news_tag",
    Base.metadata,
    Column("news_id", Integer, ForeignKey("news.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("tag.id"), primary_key=True)
)


# 表一
class News(Base):
    __tablename__ = "news"
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50), nullable=False)
    #产生关系写法二
    #tags = relationship("News",backref="newss",secondary=news_tag)
    def __repr__(self):
        return "<News(title:%s)>" % self.title


# 表二
class Tag(Base):
    __tablename__ = "tag"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    #产生关系写法二
    newss = relationship("News",backref="tags",secondary=news_tag)
    def __repr__(self):
        return "<Tag(name:%s)>" % self.name

# Base.metadata.drop_all()
# Base.metadata.create_all()

#添加数据
news1 = News(title="世间第一")
news2 = News(title="世间第二")

tag1 = Tag(name="要闻")
tag2 = Tag(name="娱乐")

news1.tags.append(tag1)
news1.tags.append(tag2)

news2.tags.append(tag1)
news2.tags.append(tag2)

session.add(news1)
session.add(news2)

session.commit()
```

## ORM层面删除数据注意事项

ORM层面删除数据，会无视mysql级别的外键约束

之间会将对应的数据删除，然后将从表中的那个外键设置为NULL(先判断从表里是否有id引用，如果有就置为空，然后再把主表对应数据删除)

如果避免这种情况，应该将从表中的外键的nullable=False

```python
Column("tag_id", Integer, ForeignKey("tag.id"), nullable=False)
```

## ORM高级

### ORM层面的relationship方法中的cascadel

  在SQLAlchemy，只要将一个数据添加到session中，和他相关联的数据都可以一起存入到数据库中了。

这些是怎么设置的呢？其实是通过relationship的时候，有一个关键字参数cascade可以设置这些属性，

cascade属性值为：

1.  save-update：默认选项。在添加一条数据的时候，会把其他和他相关联的数据都添加到数据库中。这种行为就是save-update属性影响的。
2. delete：表示当删除某一个模型中的数据的时候，是否也删掉使用relationship和他关联的数据。
3. delete-orphan：表示当对一个ORM对象解除了父表中的关联对象的时候，自己便会被删除掉。当然如果父表中的数据被删除，自己也会被删除。这个选项只能用在一对多上，并且还需要在子模型中的relationship中，增加一个single_parent=True的参数。
4. merge：默认选项。当在使用session.merge，合并一个对象的时候，会将使用了relationship相关联的对象也进行merge操作。
5. expunge：移除操作的时候，会将相关联的对象也进行移除。这个操作只是从session中移除，并不会真正的从数据库中删除。
6. all：是对save-update, merge, refresh-expire, expunge, delete几种的缩写。

```python
from sqlalchemy import create_engine,Column,Integer,Float,Boolean,DECIMAL,Enum,\
    Date,DateTime,Time,String,Text,func,or_,and_,ForeignKey,Table
from sqlalchemy.dialects.mysql import LONGTEXT
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker,relationship,backref
import random

HOSTNAME = '127.0.0.1'
PORT = '3306'
DATABASE = 'first_sqlalchemy'
USERNAME = 'root'
PASSWORD = 'root'

DB_URI ="mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)

engine = create_engine(DB_URI)
Base = declarative_base(engine)

session = sessionmaker(engine)()

class User(Base):
    __tablename__ = 'user'
    id = Column(Integer,primary_key=True,autoincrement=True)
    uname = Column(String(50),nullable=False)

    # articles =relationship("Article",cascade="save-update,delete") #放入Article中去优化

class Article(Base):
    __tablename__ = 'article'
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50), nullable=False)
    uid = Column(Integer,ForeignKey("user.id"))

    # author = relationship("User",backref="articles") #cascade默认为save-update
    # author = relationship("User",backref="articles",cascade="")
    # author = relationship("User",backref="articles",cascade="save-update") #明文指定 cascade的值
    # author = relationship("User",cascade="save-update,delete")
    author = relationship("User", backref = backref("articles",cascade="save-update,delete"),cascade="save-update,delete") #双向关系优化写法

class Comment(Base):
    __tablename__ = 'comment'
    id = Column(Integer, primary_key=True, autoincrement=True)
    content = Column(Text,nullable=False)
    uid = Column(Integer,ForeignKey("user.id"))

    # 优化写法
    author = relationship("User",backref=backref("comments"))

def add_data():
    Base.metadata.drop_all()
    Base.metadata.create_all()
    user = User(uname="momo")
    article = Article(title="华为5G")
    article.author = user
    session.add(article)
    session.commit()

    comment = Comment(content='你少说风凉话')
    comment.author = user
    session.add(comment)
    session.commit()

def oper_data():
    #relationship里边的cascade  可通过Article影响User
    # article = session.query(Article).first()
    # session.delete(article)
    # session.commit()

    # 反过来通过User也能影响Article
    user = session.query(User).first()
    session.delete(user)
    session.commit()

#总结1：relationship里边的cascade  可通过Article影响User，反过来通过User也能影响Article
#总结2：relationship里边的cascade 只会影响当前类User中relationship的模型Article，不会影响别的模型Comment
if __name__ == '__main__':
    # add_data()
    oper_data()

#ORM层面的relationship方法中cascade使用1
```

### 排序

### 方法一 order_by

```python
def oper():
    # 正序排序
    articles1 = session.query(Article).order_by(Article.create_time).all()
    print(articles1)

    # 倒序排序
    articles2 = session.query(Article).order_by(Article.create_time.desc()).all()
    print(articles2)
```

### 方法二 定义模型时指定排序方式

```python
class Article(Base):
    __tablename__ = 'article'
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50), nullable=False)
    create_time = Column(DateTime, nullable=False, default=datetime.now)
    __mapper_args__ = {
        # "order_by": create_time #正序
        "order_by": create_time.desc() #倒序
    }
    def __repr__(self):
        return "<Article(title:%s,create_time:%s)>" % (self.title,self.create_time)
```

### 方法三 涉及两表时，定义模型时，用relationship方法中的order_by属性指定排序方式

```python
class Article(Base):
    __tablename__ = 'article'
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50), nullable=False)
    create_time = Column(DateTime, nullable=False, default=datetime.now)
    uid = Column(Integer,ForeignKey("user.id"))

    # author = relationship("User", backref=backref("articles",order_by=create_time)) #正序
    author = relationship("User", backref=backref("articles",order_by=create_time.desc())) #倒序

    def __repr__(self):
        return "<Article(title:%s,create_time:%s)>" % (self.title,self.create_time)
```

## 分页

- limit
- offset
- slice

```python
#limit：可以限制每次查询的时候只查询前几条数据。 属top-N查询
articles = session.query(Article).limit(15).all()
print(articles)
#offset：可以限制查找数据的时候过滤掉前面多少条。可指定开始查询时的偏移量。
# articles = session.query(Article).offset(10).limit(10).all()

#场景选型：查看最新的10条新闻
# articles = session.query(Article).order_by(Article.id.desc()).limit(10).all()
#查询最新的第10-第20条之间的新闻
articles = session.query(Article).order_by(Article.id.desc()).offset(10).limit(10).all()
print(articles)
articles = session.query(Article).order_by(Article.id.desc()).slice(0,10).all()
print(articles)
articles = session.query(Article).order_by(Article.id.desc())[0:10]
print(articles)
```

## 懒加载

在一对多，或者多对多关系的时候，如果想要获取多的一方这一部分的数据的时候，往往能通过一个属性就可以全部获取了。

如有一个作者，想要这个作者的所有文章，通过user.articles就可以获取所有的。

   但有时候我们不想获取所有的数据，如只想获取这个作者今天发表的文章，那么这时候我们可以给relationship方法添加属性lazy='dynamic'，以后通过user.articles获取到的就不是一个列表，而是一个AppenderQuery对象了。这样就可以对这个对象再进行一层过滤和排序等操作。

   通过`lazy='dynamic'`，获取出来的多的那一部分的数据，就是一个`AppenderQuery`对象了。这种对象既可以添加新数据，也可以跟`Query`一样，可以再进行一层过滤。

 

lazy可用的选项：

1. `select`：这个是默认选项。还是拿`user.articles`的例子来讲。如果你没有访问`user.articles`这个属性，那么sqlalchemy就不会从数据库中查找文章。一旦你访问了这个属性，那么sqlalchemy就会立马从数据库中查找所有的文章，并把查找出来的数据组装成一个列表返回。这也是懒加载。

 

2. `dynamic`：这个也是懒加载。就是在访问`user.articles`的时候返回来的不是一个列表，而是`AppenderQuery`对象。



总结：如果你在获取数据的时候，想要对多的那一边的数据再进行一层过滤，那么这时候就可以使用`lazy='dynamic'`。

```python
#懒加载
author = relationship("User",backref=backref("articles",lazy="dynamic"))
```

```python
from sqlalchemy import create_engine,Column,Integer,Float,Boolean,DECIMAL,Enum,\
    Date,DateTime,Time,String,Text,func,or_,and_,ForeignKey,Table
from sqlalchemy.dialects.mysql import LONGTEXT
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker,relationship,backref
import random,time
from datetime import datetime
HOSTNAME = '127.0.0.1'
PORT = '3306'
DATABASE = 'test'
USERNAME = 'root'
PASSWORD = 'root'

DB_URI ="mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)

engine = create_engine(DB_URI)
Base = declarative_base(engine)

session = sessionmaker(engine)()


class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True, autoincrement=True)
    uname = Column(String(50),nullable=False)

class Article(Base):
    __tablename__ = 'article'
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50), nullable=False)
    create_time = Column(DateTime, nullable=False, default=datetime.now)
    uid = Column(Integer,ForeignKey("user.id"))

    # author = relationship("User", backref=backref("articles"))
    #懒加载
    author = relationship("User", backref=backref("articles",lazy="dynamic"))

    def __repr__(self):
        return "<Article(title:%s,create_time:%s)>" % (self.title,self.create_time)

def  add_data():
    Base.metadata.drop_all()
    Base.metadata.create_all()

    user = User(uname='莫莫')
    for x in range(100):
        article = Article(title="title %s" % x)
        article.author = user
        session.add(article)
    session.commit()

#from sqlalchemy.orm.collections import InstrumentedList
def oper1():
    user = session.query(User).first()
    print(type(user.articles)) #<class 'sqlalchemy.orm.collections.InstrumentedList'>
    print(user.articles)

#懒加载
#from sqlalchemy.orm.dynamic import AppenderQuery
def oper2():
    user = session.query(User).first()
    print(type(user.articles)) #<class 'sqlalchemy.orm.dynamic.AppenderQuery'>
    print(user.articles)

#辨析 AppenderQuery  和  Query
#from sqlalchemy.orm.query import Query
def oper3():
    user = session.query(User)
    print(type(user)) #<class 'sqlalchemy.orm.query.Query'>
    print(user) #sql语句

#有2层意思
#1.是一个Query对象。可以调用Query对象的方法
#2.是一个AppenderQuery对象。可以继续追加数据进去
def oper4():
    user = session.query(User).first()#可以调用Query对象的方法
    print(type(user))
    print(user.articles.filter(Article.id>=50).all())

    # article = Article(title='title 100')
    # user.articles.append(article)#2.是一个AppenderQuery对象。可以继续追加数据进去
    # session.commit()

if __name__ == '__main__':
    #add_data()
    # oper1()
    #oper2()
    # oper3()
    oper4()
```

## Flask-SQLAlchemy介绍和安装

```python
pip install flask-sqlalchemy
```

2.Flask-SQLAlchemy的使用要点：

  2.1 数据库连接

​    数据库初始化不再是通过create_engine。

​    1. 跟sqlalchemy一样，定义好数据库连接字符串DB_URI。

​    2. 将这个定义好的数据库连接字符串DB_URI，通过`SQLALCHEMY_DATABASE_URI`这个key名配置到`app.config`中。

​     代码：app.config["SQLALCHEMY_DATABASE_URI"] = DB_URI

​    3. 使用`flask_sqlalchemy.SQLAlchemy`这个类定义一个对象，并将`app`传入进去。

​     代码：db = SQLAlchemy(app)

  2.2 创建ORM模型类

​    之前都是通过Base = declarative_base()来初始化一个基类，然后再继承，在Flask-SQLAlchemy中更加简单了。

​    1. 还是跟使用sqlalchemy一样，定义模型。现在不再是需要使用`delarative_base`来创建一个基类。而是使用`db.Model`来作为基类。

​    2. 在模型类中，`Column`、`String`、`Integer`以及`relationship`等，都不需要导入了，直接使用`db`下面相应的属性名就可以了。

​    3. 在定义模型的时候，可以不写`__tablename__`，那么`flask_sqlalchemy`会默认使用当前的模型的名字转换成小写来作为表的名字，

​      并且如果这个模型的名字用到了多个单词并且使用了驼峰命名法，那么会在多个单词之间使用下划线来进行连接，

​      虽然flask_sqlalchemy给我们提供了这个特性，但是不推荐使用。（增强代码可读性，提高团队合作效率）

  2.3 将ORM模型映射到数据库表

​    写完模型类后，要将模型映射到数据库的表中，使用以下代码即可

​    1. 删除数据库表：db.drop_all()

​    2. 创建数据库表：db.create_all()

  2.4 session的使用

​    以后session也不需要使用`sessionmaker`来创建了，

​    直接使用`db.session`就可以了，

​    操作这个session的时候就跟之前的`sqlalchemy`的`session`是一样一样的。

  2.5 添加数据

​    这时候就可以在数据库中看到已经生成了对应表了

​    添加数据和之前的没有区别，只是session成为了一个db的属性

  2.6 查询数据：

​    1.单表查询

​     查询数据不再是之前的session.query方法了，而是将query属性放在了db.Model上，

​     所以查询就是通过“模型名.query”的方式进行查询了，`query`就跟之前的sqlalchemy中的query方法是一样用的。

​    2.多表查询   

​     如果查找数据涉及多个模型，只能使用db.session.query(模型名).all() 这种方式

  2.7 修改数据：

​    修改数据和之前的没有区别，只是session成为了一个db的属性

  2.8 删除数据：

​    删除数据跟添加数据和修改数据类似，只不过session是db的一个属性而已

```python
from flask import Flask
from  flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)

HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"

DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,password=PASSWORD,host=HOSTNAME,port=PORT,db=DATABASE)
app.config["SQLALCHEMY_DATABASE_URI"]=DB_URL
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"]=False

db = SQLAlchemy(app)    #创建数据库连接对象

#创建ORM模型
class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer,primary_key=True,autoincrement=True)
    uname = db.Column(db.String(50),nullable=False)

    def __repr__(self):
        return "<User(uname: %s)>" % self.uname

class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(50), nullable=False)
    uid = db.Column(db.Integer, db.ForeignKey("user.id"))

    author = db.relationship("User", backref="articles") #默认cascade等于save-update
    # author = db.relationship("User", backref="articles",cascade="save-update")
#3 将ORM模型映射到数据库表
# db.drop_all()  #删除表
# db.create_all() #创建表

# 4 session的使用
#   以后session也不需要使用`sessionmaker`来创建了，直接使用`db.session`就可以了，

#映射到数据库
# db.drop_all()
# db.create_all()

#5.添加数据
# user = User(uname='莫莫')
# article = Article(title='华为5G  算法突破了，俄罗斯小伙突破的')
# article.author = user
#
# db.session.add(article)
# db.session.commit()

#6.查询数据
users = User.query.all()  #等价于 db.session.query(User).all()
print(users)
#在query属性之后  可以用 order_by 、 filter、filter_by、group_by、having等方法进行更复杂的单表查询
#若要进行更复杂的多表查询，只能使用db.session.query(User).all() 这种方式
#如 order_by
# users = User.query.order_by(User.id.desc()).all()
#上述写法等价于下边写法
# users = db.session.query(User).order_by(User.id.desc()).all()
# print(users)

#7.修改数据
# user = User.query.filter(User.uname=='露露').first()
# user.uname = '探探'
# db.session.commit()

#8.删除数据
# user = User.query.filter(User.uname=='探探').first()
# db.session.delete(user)
# db.session.commit()

@app.route('/')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
```

# 数据库迁移工具alembic

安装

```shell
pip install alembic
```

1. 创建数据库配置文件models.py

   ```python
   from sqlalchemy import Column,String,Integer,create_engine
   from sqlalchemy.ext.declarative import declarative_base
   
   HOSTNAME = "127.0.0.1"
   PORT = '3306'
   DATABASE = "test"
   USERNAME = "root"
   PASSWORD = "root"
   DB_URI = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                           password=PASSWORD,
                                                                                           host=HOSTNAME, port=PORT,
                                                                                           db=DATABASE)
   engine = create_engine(DB_URI)
   Base = declarative_base(engine)
   
   class User(Base):
       __tablename__ = "user"
       id = Column(Integer,primary_key=True,autoincrement=True)
       uname = Column(String(50),nullable=False)
       country = Column(String(50))
   
   #ORM -> 迁移文件-> 映射到数据库
   ```

2. 初始化仓库

   ```shell
   alembic init [仓库名]
   ```

3. 修改配置文件alembic.ini

   ```python
   sqlalchemy.url = mysql+pymysql://root:root@localhost/test?charset=utf8mb4
   ```

   修改env.py

   ```python
   #导入模块
   import sys,os
   sys.path.append(os.path.dirname(os.path.dirname(__file__)))
   import models
   #设置target_metadata
   target_metadata = models.Base.metadata
   ```

4. 自动生成迁移文件

   ```shell
   alembic revision --autogenerate -m "first commit"
   ```

5. 生成的迁移系统文件映射到数据库

   ```shell
   alembic upgrade head
   ```

   降级

   ```shell
   alembic downgrade head
   ```

6. 以后如果修改了模型，重复4、5步骤即可

## 常用命令和参数解释

4.常用alembic命令和参数解释：

  \1. init：创建一个alembic仓库。

  \2. revision：创建一个新的版本文件。

  \3. --autogenerate：自动将当前模型的修改，生成迁移脚本。

  \4. -m：本次迁移做了哪些修改，用户可以指定这个参数，方便回顾。

  \5. upgrade：将指定版本的迁移文件映射到数据库中，会执行版本文件中的upgrade函数。

​         如果有多个迁移脚本没有被映射到数据库中，那么会执行多个迁移脚本。

  \6. [head]：代表最新的迁移脚本的版本号。

  \7. downgrade：会执行指定版本的迁移文件中的downgrade函数。

  \8. heads：展示head指向的脚本文件版本号。

  \9. history：列出所有的迁移版本及其信息。

  \10. current：展示当前数据库中的版本号。

 

另外，在你第一次执行upgrade的时候，就会在数据库中创建一个名叫alembic_version表，这个表只会有一条数据，记录当前数据库映射的是哪个版本的迁移文件。

 

5.常见错误及解决办法：

  \1. 创建新版本时报错 FAILED: Target database is not up to date.

  原因：主要是heads和current不相同。current落后于heads的版本。

  解决办法：将current移动到head上。alembic upgrade head

 

  \2. 创建新版本时报错 KeyError: 'bb747b02cda0' 或者 FAILED: Can't locate revision identified by 'a65ff5195bc0'

  原因：数据库中存的版本号不在迁移脚本文件中

  解决办法：删除versions中所有的迁移文件，删除数据库所有表。4.常用alembic命令和参数解释：

1. init：创建一个alembic仓库。

2. revision：创建一个新的版本文件。

3. --autogenerate：自动将当前模型的修改，生成迁移脚本。

4. -m：本次迁移做了哪些修改，用户可以指定这个参数，方便回顾。

5. upgrade：将指定版本的迁移文件映射到数据库中，会执行版本文件中的upgrade函数。

​         如果有多个迁移脚本没有被映射到数据库中，那么会执行多个迁移脚本。

6. [head]：代表最新的迁移脚本的版本号。

7. downgrade：会执行指定版本的迁移文件中的downgrade函数。

8. heads：展示head指向的脚本文件版本号。

9. history：列出所有的迁移版本及其信息。

10. current：展示当前数据库中的版本号。

 

另外，在你第一次执行upgrade的时候，就会在数据库中创建一个名叫alembic_version表，这个表只会有一条数据，记录当前数据库映射的是哪个版本的迁移文件。

 

5.常见错误及解决办法：

1. 创建新版本时报错 FAILED: Target database is not up to date.

  原因：主要是heads和current不相同。current落后于heads的版本。

  解决办法：将current移动到head上。alembic upgrade head

 

2. 创建新版本时报错 KeyError: 'bb747b02cda0' 或者 FAILED: Can't locate revision identified by 'a65ff5195bc0'

  原因：数据库中存的版本号不在迁移脚本文件中

  解决办法：删除versions中所有的迁移文件，删除数据库所有表。

# Flask-Script

 Flask-Script的作用是可以通过命令行的形式来操作Flask。

 例如通过命令跑一个开发版本的服务器、设置数据库，定时任务等。

案例一

```python
#momo.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return "你好·hello"

if __name__ == '__main__':
    app.run()
```

```python
#manage.py
from flask_script import Manager
from momo import app

manager = Manager(app)

#通过命令行执行
@manager.command
def hello():
    print("你好，DOS")

#通过命令行传参
@manager.option("-p","--province",dest="province")
@manager.option("-m","--month",dest="month")
def get_pm_data(province,month):
    print(f'您请求的省份是{province},月份是{month}')


if __name__ == '__main__':
    manager.run()
```

```shell
#命令行执行
python manage.py hello
python manage.py get_pm_data -p 山西 -m 7	#传参
#如果报错 降低flask版本
```

## Flask-script实战场景和写脚本技巧

案例  快速给员工添加账号

```python
#momo.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import config

app = Flask(__name__)
app.config.from_object(config)

db = SQLAlchemy(app)

class BackendUser(db.Model):
    __tablename__ = "backend_user"
    id = db.Column(db.Integer,primary_key=True,autoincrement=True)
    uname = db.Column(db.String(50),nullable=False)
    email = db.Column(db.String(50),nullable=False)

db.create_all()


@app.route('/')
def hello_world():
    return "你好·hello"

if __name__ == '__main__':
    app.run()
```

```python
#manage.py
from flask_script import Manager
from momo import app,BackendUser,db

manager = Manager(app)

#通过命令行执行
@manager.command
def hello():
    print("你好，DOS")

#通过命令行传参
@manager.option("-p","--province",dest="province")
@manager.option("-m","--month",dest="month")
def get_pm_data(province,month):
    print(f'您请求的省份是{province},月份是{month}')


#命令传参快速给员工创建账号
@manager.option("-u","--uname",dest="uname")
@manager.option("-e","--email",dest="email")
def add_user(uname,email):
    user = BackendUser(uname=uname,email=email)
    db.session.add(user)
    db.session.commit()
    print("添加成功")

if __name__ == '__main__':
    manager.run()
```

```python
#config.py
# import os
HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"
DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
SQLALCHEMY_DATABASE_URI = DB_URL
SQLALCHEMY_TRACK_MODIFICATIONS = True

# SECRET_KEY = os.urandom(16)  # cookie加盐
DEBUG = True
```

命令行执行

```shell
python manage.py add_user -u "陌陌" -e "2038800300@qq.com"
```

### 写命令脚本技巧

如果有一些命令是针对某个功能的。

 如有一堆命令是针对ORM与表映射的，那么可以将这些命令单独放在一个文件中方便管理。

 然后到主脚本文件manage.py中，通过`Manager`的对象名.add_command`方法来添加。

如创建一个db_script.py文件  管理跟操作数据库表相关的东西，代码如：

```python
from flask_script import Manager

db_manager = Manager()

@db_manager.command
def init():
    print('迁移仓库创建OK！')

@db_manager.command
def revision():
    print('迁移脚本文件生成OK！')

@db_manager.command
def upgrade():
    print('迁移脚本文件映射到数据库OK！')
```

存放命令的脚本文件manage.py代码为：

```python
from flask_script import Manager
from  momo  import app,BackendUser,db

manager = Manager(app)


#4.如果有一些命令是针对某个功能的。
# 比如有一堆命令是针对ORM与表映射的，那么可以将这些命令单独放在一个文件中方便管理。
# 也是使用`Manager`的对象来添加。然后到主manage文件中，通过`manager.add_command`来添加。
from db_script import db_manager
manager.add_command("db",db_manager)

if __name__ == '__main__':
    manager.run()
```

# Flask项目重构-专业性

```python
#app.py
from flask import Flask

from models import User
app = Flask(__name__)
import  config
app.config.from_object(config)

from exts import db
db.init_app(app)

@app.route('/')
def hello_world():
    return 'Hello World!'


#场景：查看用户个人信息时，会使用到User模型  ，而User模型 已经放到了models.py中
@app.route("/profile/")
def  profile():
    pass


if __name__ == '__main__':
    app.run()
```

```python
#config.py
# import os
HOSTNAME = "127.0.0.1"
PORT = '3306'
DATABASE = "test"
USERNAME = "root"
PASSWORD = "root"
DB_URL = "mysql+pymysql://{username}:{password}@{host}:{port}/{db}?charset=utf8".format(username=USERNAME,
                                                                                        password=PASSWORD,
                                                                                        host=HOSTNAME, port=PORT,
                                                                                        db=DATABASE)
SQLALCHEMY_DATABASE_URI = DB_URL
SQLALCHEMY_TRACK_MODIFICATIONS = True

# SECRET_KEY = os.urandom(16)  # cookie加盐
DEBUG = True
```

```python
#exts.py
from flask_sqlalchemy  import  SQLAlchemy
db = SQLAlchemy()  #注意：此时没有把app对象传递进来，db无法获取数据库的配置信息
```

```python
#manage.py
from flask_script import Manager
from app  import app
from exts import db

from flask_migrate import Migrate,MigrateCommand

#需要把映射到数据库中的模型导入到manage.py文件中
from models import User
manager = Manager(app)

#用来绑定app和db到flask-migrate的
Migrate(app,db)

#添加Migrate的所有子命令到db下
manager.add_command("db",MigrateCommand)

if __name__ == '__main__':
    manager.run()
```

```python
#models.py
# from app import db
#去掉app文件的引用，变成引用exts
from exts import db

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    uname = db.Column(db.String(50), nullable=False)
    age =db.Column(db.Integer) #修改表
```



# Flask-Migrate介绍

在实际的开发环境中，经常会发生数据库修改的行为。一般我们修改数据库不会直接手动的去修改，而是去修改ORM对应的模型，然后再把模型映射到数据库中。这时候如果有一个工具能专门做这种事情，就显得非常有用了。

  flask-migrate插件就是做这个事情的。flask-migrate是基于Alembic进行的一个封装，并集成到Flask中，所有的迁移操作其实都是Alembic做的，他能跟踪模型的变化，并将变化映射到数据库中。

```shell
pip install flask-migrate
```





# GraphQL规范语言



