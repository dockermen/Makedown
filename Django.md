# Django

- B/S和C/S

  Django用于开发B/S架构软件的，软件主要分为B/S架构和C/S架构

  - B/S全称Browser/server(浏览器/服务器)
  - C/S全称Client/Server(客户端/服务器)

- MVC

  Model  View  Contriller  (模型 视图 控制器)  ，一种软件设计典范，用一种业务逻辑、数据、界面显示分离的方法组织代码，将业务逻辑聚集到一个部件里面，再改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑

  - M： 管理应用程序的状态（通常存储到数据库中），并约束改变状态的行为（或者叫做“业务规则”）。
  - V： 负责把数据格式化后呈现给用户。

  - C： 接受外部用户的操作，根据操作访问模型获取数据，并调用“视图”显示这些数据。控制器是将“模型”和“视图”隔离，并成为二者之间的联系纽带。

- MTV

  Django也是一个MVC框架。但是在Django中，控制器接受用户输入的部分由框架自行处理，所以 Django 里更关注的是模型（Model）、模板(Template)和视图（Views），称为 MTV模式：

  - M： 代表模型（Model），即数据存取层。 该层处理与数据相关的所有事务： 如何存取、如何验证有效性、包含哪些行为以及数据之间的关系等。

  - T： 代表模板(Template)，即表现层。 该层处理与表现相关的决定： 如何在页面或其他类型文档中进行显示。

  - V： 代表视图（View），即业务逻辑层。 该层包含存取模型及调取恰当模板的相关逻辑。 你可以把它看作模型与模板之间的桥梁。

4. **ORM**

   ORM 就是通过实例对象的语法，完成关系型数据库的操作的技术，是"对象-关系映射"（Object/Relational Mapping） 的缩写。

   ![img](.\imgs\bg2019021802.png)

   **ORM 把数据库映射成对象。**

   ```
   数据库的表（table） --> 类（class）
   记录（record，行数据）--> 对象（object）
   字段（field）--> 对象的属性（attribute）
   ```
```
举例来说，下面是一行 SQL 语句。
    SELECT id, first_name, last_name, phone, birth_date, sex
    FROM persons 
    WHERE id = 10
```

   ```
   程序直接运行 SQL，操作数据库的写法如下。
      res = db.execSql(sql);
      name = res[0]["FIRST_NAME"];
   ```
   ```
   改成 ORM 的写法如下。
      p = Person.get(10);
      name = p.first_name;
   ```
   ```
   
   一比较就可以发现，ORM 使用对象，封装了数据库操作，因此可以不碰 SQL 语言。开发者只使用面向对象编程，与数据对象直接交互，不用关心底层数据库。
   
   **ORM 有下面这些优点**
   
   - 数据模型都在一个地方定义，更容易更新和维护，也利于重用代码。
   - ORM 有现成的工具，很多功能都可以自动完成，比如数据消毒、预处理、事务等等。
   - 它迫使你使用 MVC 架构，ORM 就是天然的 Model，最终使代码更清晰。
   - 基于 ORM 的业务代码比较简单，代码量少，语义性好，容易理解。
   - 你不必编写性能不佳的 SQL。
   
   **ORM 也有很突出的缺点**
   
   - ORM 库不是轻量级工具，需要花很多精力学习和设置。
   - 对于复杂的查询，ORM 要么是无法表达，要么是性能不如原生的 SQL。
   - ORM 抽象掉了数据库层，开发者无法了解底层的数据库操作，也无法定制一些特殊的 SQL。
   ```

## 使用

```shell
#安装
pip install django
#创建项目
django-admin startproject mysite
#创建子应用
python manage.py startapp myapp01
#启动项目
python manage.py runserver
python manage.py runserver 8081
python manage.py runserver 127.0.0.1:8082
```

```python
def my_first_reqquest(request):
    return HttpResponse('我的第一个Django请求成功')
	return HttpResponse('''<html><h1>代码</h1></html>''')
def my_first_login(request):#返回模板网页-app目录新建templates
    return render(request,'login.html')
```

# django配置

## 1、整体介绍

django项目创建后，在主应用中，会有一个settings.py文件，这个就是该项目的配置文件

- settings文件包含Django安装的所有配置
- settings文件是一个包含模块级变量的python模块，所以该模块本身必须符合python规则，并且可以使用python的语法
- settings中的所有配置项的key必须全部大写
- settings中每一个配置项都有默认值，默认配置内容在django/conf/global_settings.py中可以查看到，项目中不需要导入该模块，django框架会自动获取
- settings中可以添加自定义的配置项



## 2、应用settings文件

1. manage.py启动

   默认在manage.py中配置：

   ```python
   if __name__ == "__main__":
       os.environ.setdefault("DJANGO_SETTINGS_MODULE", "firstdjango.settings")
   
   ```

   

2. 手动指定配置文件位置

   cmd命令启动如下：

   ```
   python manage.py runserver 0.0.0.0:8000 --settings=firstdjango.settings
   ```

   

3. 服务器部署启动

   在wsgi.py中配置：

   ```python
   os.environ.setdefault("DJANGO_SETTINGS_MODULE", "firstdjango.settings")
   ```

   

## 3、常用配置项

```python
import os


"""
    当前文件所在文件夹的上一级目录的绝对路径
    切记2个 os.path.dirname
"""
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

"""
    用于加密session，一个随机的字符串
    这样生成：
    from django.core.management import utils
    utils.get_random_secret_key()
"""
SECRET_KEY = '=*f&bx760nyar7@8lb8!w$9h(3ea6p3apl$iua!td1q%-u5r4='

# 调试模式，可以看到错误的所有相信信息，部署时一定要修改为False
DEBUG = True

"""
    允许访问的域名设置
    开发环境不用理会
    运行环境，配置 DEBUG = False后，
    如果允许所有域名访问，则设置 ALLOW_HOSTS = ['*']
    如果指定某些域名可以访问，则设置 ALLOW_HOSTS = ['*.baidu.com']
"""
ALLOWED_HOSTS = []


"""
    应用的配置，
    如：'polls.apps.PollsConfig'
    如果没有 PollsConfig ，那么可以配置为  'polls'
"""
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles', # 只有 DEBUG = Ture 才有效
    
    'polls'  # 子应用必须配置，否则不起作用
]

"""
    中间层配置
    自己编写的 中间层 需要配置在最后
    譬如：
    mymidlle.md.TestMiddleware
"""
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',

]

# 配置基础的urls
ROOT_URLCONF = 'firstdjangopy.urls'

# 配置模板
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')]
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# 服务器部署的WSGI配置
WSGI_APPLICATION = 'firstdjango.wsgi.application'


"""
    数据库配置
    mysql在python3的使用，需要在 __init__.py 中加入以下代码：
    import pymysql

    pymysql.install_as_MySQLdb()
"""
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#     }
# }
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django_test1',
        'USER': 'root',
        'PASSWORD': '123456',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}


"""
    用户密码验证
"""
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# 语言选择 ， zh-Hans 为中文
LANGUAGE_CODE = 'en-us'

# 时区 Asia/Shanghai 是中国时区
TIME_ZONE = 'UTC'

# 国际化
USE_I18N = True

# 本地化
USE_L10N = True

# 使用时区，配套TIME_ZONE使用，必须设置为 False
USE_TZ = False

"""
    静态文件的路径，默认是 static
    如果在各自项目的static目录以外，还有目录存放静态文件，需要添加如下属性：
    STATICFILES_DIRS = (
        os.path.join(BASE_DIR, "common_static1"),
        '/var/www/static/',
    )
"""
STATIC_URL = '/static/'

```



## 4、程序中获取settings中的配置项

​	如果在项目代码中需要获取settings中的配置项，这样获取：

```python
# 切记不要导入具体的settings模块的路径，会形成高耦合
# 这样的方式是不可取的：from mysite import settings
from django.conf import settings

d = settings.DEBUG

```
# URL调度器

## 1、工作原理

​	django通过urlconf来映射视图函数，只区分路径，不区分http方法

- Django确定要使用的根URLconf模块，一般是在settings中的ROOT_URLCONF设置的值，但是如果传入 HttpRequest 对象具有一个urlconf 属性（由中间件设置），则其值将用于代替 ROOT_URLCONF设置。
- Django加载该URLconf模块并查找变量 urlpatterns，它是一个列表django.urls.path() 和 / 或django.urls.re_path()实例。
- Django按顺序遍历每个URL模式，并停在与请求的URL匹配的第一个URL模式，需要特别注意编写的顺序
- 一旦某个URL模式匹配，Django就会导入并调用给定的视图，该视图是一个简单的Python函数（或基于类的视图方法）。该视图通过以下参数传递：
  - 一个HttpRequest实例。
  - 如果匹配的URL模式没有返回任何命名组，则来自正则表达式的匹配作为位置参数提供。
  - 关键字参数由路径表达式匹配的任何命名部分组成，并由可选的kwargs参数传给 django.urls.path()或django.urls.re_path()。
- 如果没有URL模式匹配，或者在此过程中的任何点发生异常，Django将调用适当的错误处理视图



## 2、简单示例

1. 在子应用下创建urls.py,内容如下

   ```python
   urlpatterns = [
       
   ]
   ```

2. 在项目的应用中添加子应用urls.py配置

   ```python
   path('url_app/',include('url_app.urls'))
   ```
   
3. 配置子应用urls.py

```python
from django.urls import path

from . import views

urlpatterns = [
    path('articles/2003/', views.special_case_2003),
    path('articles/<int:year>/', views.year_archive),
    path('articles/<int:year>/<int:month>/', views.month_archive),
    path('articles/<int:year>/<int:month>/<slug:slug>/', views.article_detail),
    path('articles/<str:string>/', views.str_archive),
    path('articles/<path:path>/', views.path_archive),
]

```

笔记：

- 从URL中捕获值，请使用尖括号
- 捕获的值可以选择包含转换器类型。例如，用于 \<int:name>捕获，前面的int指整数参数，name是参数的名称

- 没有必要添加一个前导斜杠，因为每个URL都有，例如，使用articles而不是/articles。
- 示例请求说明：
  - **/articles/2005/03/** 匹配列表中的第三个条目。Django会调用这个函数，views.month_archive(request, year=2005, month=3)
  - **/articles/2003/** 会匹配列表中的第一个模式，而不是第二个模式，因为模式是按顺序测试的，而第一个模式是第一个要传递的测试。看看利用匹配顺序插入像这样的特殊情况。在这里，Django会调用这个函数 views.special_case_2003(request)
  - **/articles/2003** 不匹配任何这些模式，因为每种模式都要求URL以斜线结尾，不过在浏览器访问时，会自动添加 / 。
  - **/articles/2003/03/building-a-django-site/ **将匹配最终模式。Django会调用这个函数 。views.article_detail(request, year=2003, month=3, slug="building-a-django-site")



## 3、路径转换器

- str：匹配任何非空字符串，不包括路径分隔符'/'。如果转换器不包含在表达式中，这是默认值。
- int：匹配零或任何正整数。返回一个int。
- slug：匹配由ASCII字母或数字组成的字符串，以及横线和下划线字符。例如， building-your-1st-django_site可以匹配，django_@site是不可以匹配的。
- uuid：匹配格式化的UUID。为防止多个URL映射到同一页面，必须包含破折号，并且字母必须是小写。例如，075194d3-6885-417e-a8a8-6c931e272f00。返回一个 UUID实例。
- path：匹配任何非空字符串，包括路径分隔符 '/'，可以匹配完整的URL路径，而不仅仅是URL路径的一部分str，使用时要谨慎，因为可能造成后续的所有url匹配都失效。

```python
path('articles/<uuid:uuid>/',views.article_uuid),
```

```python
#获取uuid
import uuid
print(uuid.uuid1())
```



## 4、自定义路径转换器

转换器是一个包含以下内容的类：

- 一个regex类属性，作为一个re匹配字符串。
- to_python(self, value)方法，它处理匹配的字符串转换成要传递到视图函数的类型。
- to_url(self, value)方法，用于处理将Python类型转换为URL中使用的字符串。



定义方式如下：

1. 新建一个converters.py文件，在文件中定义一个FourDigitYearConverter类：

   ```python
   class FourDigitYearConverter(object):
       regex = '[0-9]{4}'
   
       def to_python(self, value):
           return int(value)
   
       def to_url(self, value):
           return '%04d' % value
   ```

   

2. 使用register_converter()方法在URLconf中注册自定义转换器类 ：

   ```python
   from django.urls import register_converter, path
   
   from . import converters, views
   
   register_converter(converters.FourDigitYearConverter, 'yyyy')
   
   urlpatterns = [
       path('articles/2003/', views.special_case_2003),
       path('articles/<yyyy:year>/', views.year_archive)
   ]
   ```

   

## 5、使用正则表达式 

​	使用正则表达式匹配路径，请使用 re_path()而不是path()

​	在Python正则表达式中，命名正则表达式组的语法是(?P\<name>pattern)，其中name是组的名称，并且 pattern是一些要匹配的模式

​	示例：

```python
from django.urls import path, re_path

from . import views

# url() 是 re_path 的别名，不推荐使用
urlpatterns = [
    path('articles/2003/', views.special_case_2003),
path('articles/<int:year>/', views.year_archive),
re_path(r'^articles/(?P<year>[0-9]{4})/$', views.year_archive),
    re_path(r'^articles/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/$', views.month_archive),
    re_path(r'^articles/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<slug>[\w-]+)/$', views.article_detail),
]

```

​	注意事项：

- 匹配的URL会受到一些限制。例如，年份10000将不再匹配，因为年份整数限制为四位数字
- 无论正则表达式匹配什么类型，每个捕获的参数都以字符串的形式发送到视图
- 除了命名的组语法，例如(?P\<year>[0-9]{4})，也可以使用较短的未命名组，例如([0-9]{4})，但是不建议这样使用，会引起未知的匹配

 

嵌套参数：

```python
from django.urls import re_path

urlpatterns = [
    # 不推荐, 匹配 blog/page-3/
    re_path(r'^blog/(page-(\d+)/)?$', blog_articles),
    # 推荐 ，匹配：comments/page-2/  路径到 comments(request, page_numer)
    re_path(r'^comments/(?:page-(?P<page_number>\d+)/)?$', comments),
]

```



## 6、使用默认值

​	URLConf中：

```python
from django.urls import path

from . import views

urlpatterns = [
    # http://127.0.0.1:8000/polls/blog/ 等同于 http://127.0.0.1:8000/polls/blog/1/
    path('blog/', views.page),
    # http://127.0.0.1:8000/polls/blog/1/
    # http://127.0.0.1:8000/polls/blog/10/
    # http://127.0.0.1:8000/polls/blog/99/
    path('blog/<int:num>/', views.page),
]


```

​	views中：

```python
def page(request, num=1):
    # 编写对应的业务逻辑
```



## 7、错误处理

- handler400- 状态码400
- handler403- 状态码403
- handler404- 状态码404
- handler500- 状态码500



1. 在 settings中修改配置：

   ```python
   DEBUG = False
   
   ALLOWED_HOSTS = ['*', ]
   ```

   

2. 在主应用的urls中配置：

   ```python
   # polls是子应用
   handler404 = "polls.views.page_not_found"
   ```

   

3. 在polls应用的views中添加函数page_not_found：

   ```python
   def page_not_found(request, exception):
       return HttpResponse('自定义的404错误页面')
   ```

   
   
4. 浏览器测试访问，找不到匹配的路由

   ![image-20210705154513931](.\imgs\image-20210705154513931.png)

##  8、引用其他URL调度器

1. 多个 patterns

   ```python
   from django.urls import include, path
   
   extra_patterns = [
       path('reports/', credit_views.report),
       path('reports/<int:id>/', credit_views.report),
       path('charge/', credit_views.charge),
   ]
   
   urlpatterns = [
       path('', main_views.homepage),
       path('help/', include('apps.help.urls')),
       path('credit/', include(extra_patterns)),
   ]
   
   ```

   

2. 使用include消除重复前缀

   ```python
   from django.urls import path
   from . import views
   
   urlpatterns = [
       path('<page_slug>-<page_id>/history/', views.history),
       path('<page_slug>-<page_id>/edit/', views.edit),
       path('<page_slug>-<page_id>/discuss/', views.discuss),
       path('<page_slug>-<page_id>/permissions/', views.permissions),
   ]
   
   # 修改为：
   from django.urls import include, path
   from . import views
   
   urlpatterns = [
       path('<page_slug>-<page_id>/', include([
           path('history/', views.history),
           path('edit/', views.edit),
           path('discuss/', views.discuss),
           path('permissions/', views.permissions),
       ])),
   ]
   
   ```

   

3. 传递捕获的参数

   在主urls中配置：

   ```python
   urlpatterns = [
       path('admin/', admin.site.urls),
       # 这里捕获username参数，类型为字符串
       path('<username>/polls/', include('polls.urls'))
   ]
   ```

   

   对应的 polls 应用下的urls中配置：

   ```python
   urlpatterns = [
       path('arg_test/', views.arg_test),
   ]
   ```

   

   对应的 polls 应用下的views中编写函数：

   ```python
   def arg_test(request, username):
       # 编写对应的业务逻辑
       return HttpResponse(f'username {username}')
   ```



## 9、额外的参数

```python
from django.urls import path
from . import views

urlpatterns = [
    # 会传递给 views.year_archive(request, year=2005, foo='bar')
    path('blog/<int:year>/', views.year_archive, {'foo': 'bar'}),
]

```



## 10、URL反向解析 

url调度器除了从用户发起请求，到匹配对应的view，还能在python程序中调用进行匹配，通过 path或re_path 中 的name属性进行解析

- 在模板中，使用url模板标签
- 在Python代码中（主要是views），使用 reverse() 函数
- 在模型实例中，使用 get_absolute_url() 方法

 

示例：

urls中配置：

```python
from django.urls import path

from . import views

urlpatterns = [
    #...
    path('articles/<int:year>/', views.year_archive, name='news-year-archive'),
    #...
]
```



1. 在模板中测试

   1.views.py跳转到页面

   ```python
   def do_html(request):
       return render(request,'redirect_test.html')
   
   def year_archive(request,year):
       return HttpResponse(f'重定向成功{year}')
   ```

   2.模板中代码

   ```python
   # 模板中：
   <a href="{% url 'news-year-archive' 2012 %}">2012 Archive</a>
   ```

2. 在python代码

```python
from django.urls import reverse
from django.http import HttpResponseRedirect

def redirect_to_year(request):
    # ...
    year = 2006
    # ...
    return HttpResponseRedirect(reverse('news-year-archive', args=(year,)))

```



3. 在模型中：

```python
"""
    在模型中实现方法：
    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('news-year-archive', args=[str(self.id)])

    然后在 模板 中如下使用：
"""
<a href="{{ object.get_absolute_url }}">{{ object.name }}</a>

```



## 11、命名空间

​	主要用于配合第 10 点 url反向解析 使用，多个不同的urls文件中可能配置同名的 name，那么为了进行区分，给不同的urls进行不同的命名，切记同一个项目下命名空间不能重复！

​	通过在 url调度器的模块中，定义 app_name = 'polls' 来命名

```python
from django.urls import path

from . import views
# 定义，一般命名空间和子应用名相同，便于记忆
app_name = 'polls'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    ...
]

# 调用，一旦有了命名空间，调用时就必须使用 polls： 前缀
reverse('polls:index', current_app=self.request.resolver_match.namespace)

```

 

​	命名空间可以进行嵌套：

```python
# 在 urls 中配置如下：
from django.urls import path

from . import views
# 定义命名空间，一般命名空间名和子应用名相同，便于记忆
app_name = 'polls'

extra_patterns = (
    [
        path('app_name/', views.app_name, name='app_name'),
    ],
    # 此处就是嵌套的命名空间
    'extra'
)

urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    path('extra/', include(extra_patterns)),
    ...
]


# 在模板中使用：
<a href="{% url 'polls:extra:app_name' %}">点击链接</a>
```

# django模型

​	  模型，就是python中的类对应数据库中的表

​      ORM 就是通过实例对象的语法，完成关系型数据库的操作的技术，是"对象-关系映射"（Object/Relational Mapping） 的缩写。



## 1、简单示例

模型：

```python
class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField()

```



对应mysql数据库中的表：

```python
CREATE TABLE `polls_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_text` varchar(200) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
)

```



笔记：

1. 模型类必须继承models.Model
2. 每个属性对应数据库中的一个字段
3. 表名自动使用 mysite_类名 的小写（如：polls_question），可以覆盖
4. 如果模型类中没有指定 primary_key ，那么会自动创建一个 id 字段，自增，主键



## 2、应用模型

​	当编写了模型之后，需要将模型应用到数据库中： 



### 1、创建项目model_study,及子应用model_app

```python
#创建项目
django-admin startproject model_study
#进入项目目录创建子应用
python manage.py startapp model_app
```



### 2、配置应用

1. 将模型对应的应用程序添加到项目的settings中：

```python
INSTALLED_APPS = [
    'model_app'
]

```

2. 在settings中配置正确的数据库连接：

```python
# sqlite3
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

# mysql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'model_study',
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```

3. 安装对应数据库的驱动

   PS： 

   如果是 mysql ，django2.2 请安装 mysqlclient  库

   如果是sqlite3，是不需要额外安装，python自带驱动库

   
   

笔记：需要在mysql数据库中创建数据库model_study



### 2、预备迁移

​	在项目根目录的cmd中运行：

```
python manage.py makemigrations model_app
```

​	笔记：

1. model_app是子应用的名称，如果不指定，那么就是对所有 INSTALLED_APPS 中的应用都进行预备迁移
2. 指定该命令后，在对应的子应用下的 migrations 中会生成一个对应的迁移文件



### 3、正式迁移

​	在根目录的cmd中运行：

```
python manage.py migrate
```

​	PS：没有添加子应用名，那么就会把django项目中所有的应用都迁移到数据库中



### 4、模型修改后重新应用

​	不管是新增模型，还是修改已有模型后，只需要重复执行第2步和第3步，即可自动实现数据库中的表结构、表关系等信息的修改



### 5、逆向从数据库表生成模型类

1. settings中设置好 DATABASES 配置

2. 在对一个数据库中建立好表、约束和表关系等

3. 在根目录的cmd中运行：

   ```
   python manage.py inspectdb > model_app/models.py
   ```

   PS：model_app是子应用名

4. 第3步执行后会在models中生成对应的模型类

   譬如：

   ```python
   class DjangoSession(models.Model):
       session_key = models.CharField(primary_key=True, max_length=40)
       session_data = models.TextField()
       expire_date = models.DateTimeField()
   
       class Meta:
           managed = False   # 这个属性是通知django，不需要进行从模型到数据库的迁移管理
           db_table = 'django_session'  # 对应的数据库中的表名
   ```


## 3、字段Field

​	模型类的属性对应数据库中表的字段，都是对应的Field类的实例



### 1、字段命名限制

- 字母，数字，下划线，首字母不能是数字

- 字段名称不能是Python保留字

- 由于Django查询查找语法的工作方式，字段名称不能在一行中包含多个下划线，譬如“abc__123”就是不允许的，一个下划线是可以的，如：'first_name'

  

### 2、AutoField、ID、PRIMARY_KEY

​	默认会自动创建一个自增，主键的id列

​	如果指定了 primary_key 为其它列，那么不会自动创建id列

 

​	可以在模型中指定：

```python
id = models.AutoField(primary_key=True)
```



### 3、常见Field

​	所有的Field类型，见 https://docs.djangoproject.com/en/2.2/ref/models/fields/#model-field-types

 	**常用的Field**：

​	AutoField

​	BooleanField

​	CharField

​	DateField

​	DateTimeField

​	FloatField

​	SmallIntegerField

​	IntegerField

​	TextField



​	示例，UUIDField 这样使用：

```python
import uuid
from django.db import models

class MyUUIDModel(models.Model):
    # uuid.uuid4 千万别写成 uuid.uuid4() ，不要写 ()
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

```



### 4、Field常见参数

- max_length：字段最大长度，用于字符串等，字符串类型CharField必须设置该值
- null：如果True，Django将在数据库中存储NULL空值。默认是False
- blank：如果True，该字段被允许为空白("")。默认是False。请注意，这不同于null。null纯粹是与数据库相关的，而blank与验证相关。如果一个字段有blank=True，表单验证将允许输入一个空值。如果一个字段有blank=False，该字段将是必需的。
- choices：示例：YEAR_IN_SCHOOL_CHOICES = (('FR', 'Freshman'),('SO', 'Sophomore'),('JR', 'Junior'),('SR', 'Senior'),('GR', 'Graduate')) ,中文示例：SEX_CHOICES=((1, '男'),(2, '女'))，元组中的第一个元素是将存储在数据库中的值，第二个元素是将在页面中显示的值，最常见用于下拉选择框select
- default：字段的默认值
- help_text：用于显示额外的“帮助”文本
- primary_key：如果True，这个字段是模型的主键，默认是False
- unique：如果True，该字段在整个表格中必须是唯一的
- verbose_name：详细字段名，不指定则是属性名的小写，并且用 空格 替换 '_'



### 5、模型之间的关系

- 主外关系中，关联操作最常用的是： models.CASCADE 级联删除 和 models.SET_NULL 设置为null

- 一对多关系中，ForeignKey 写在一对多关系中，多的那个模型中

  


#### 1、一对多

​	使用django.db.models.ForeignKey，例如，如果一个Car模型有一个Manufacturer， 也就是说，一个 Manufacturer可以对应多个汽车，但Car只有一个汽车生产商Manufacturer，那么使用以下定义：

```python
from django.db import models

class Manufacturer(models.Model):
    name = models.CharField(max_length=20)

class Car(models.Model):
    # 外键名是 对应类名的小写 
    # on_delete 是必须属性
    manufacturer = models.ForeignKey(Manufacturer, on_delete=models.CASCADE)
    
    name = models.CharField(max_length=20)

```



#### 2、一对一

​	使用django.db.models.OneToOneField，例如：地址Place和餐馆Restaurant是一对一的关系，而餐馆Restaurant和服务员Waiter是一对多的关系

```python
from django.db import models

class Place(models.Model):
    name = models.CharField(max_length=50)
    address = models.CharField(max_length=80)

    def __str__(self):
        return "%s the place" % self.name

class Restaurant(models.Model):
    place = models.OneToOneField(
        Place,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    # BooleanField 在数据库使用 tinyint 类型
    serves_hot_dogs = models.BooleanField(default=False)
    serves_pizza = models.BooleanField(default=False)

    def __str__(self):
        return "%s the restaurant" % self.place.name

class Waiter(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)

    def __str__(self):
        return "%s the waiter at %s" % (self.name, self.restaurant)

```



#### 3、多对多

1. 自关联：

```python
from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=20)
    friends = models.ManyToManyField("self")
```

笔记：

- 会生成一个中间表，如下

  ```
  CREATE TABLE `test_app_student_friends` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `from_student_id` int(11) NOT NULL,
    `to_student_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `test_app_student_friends_from_student_id_to_stude_7ef9880e_uniq` (`from_student_id`,`to_student_id`),
    KEY `test_app_student_fri_to_student_id_154a4deb_fk_test_app_` (`to_student_id`),
    CONSTRAINT `test_app_student_fri_from_student_id_c400b5d4_fk_test_app_` FOREIGN KEY (`from_student_id`) REFERENCES `test_app_student` (`id`),
    CONSTRAINT `test_app_student_fri_to_student_id_154a4deb_fk_test_app_` FOREIGN KEY (`to_student_id`) REFERENCES `test_app_student` (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
  ```



2. 简易多对多

```python
class SchoolClass(models.Model):
    name = models.CharField(max_length=20)

class Teacher(models.Model):
    name = models.CharField(max_length=10)
    school_class = models.ManyToManyField(SchoolClass)
```

笔记：

- 会自动生成一个中间表，DDL语句如下：

  ```
  CREATE TABLE `test_app_teacher_school_class` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `teacher_id` int(11) NOT NULL,
    `schoolclass_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `test_app_teacher_school__teacher_id_schoolclass_i_f52c7361_uniq` (`teacher_id`,`schoolclass_id`),
    KEY `test_app_teacher_sch_schoolclass_id_7ac34d1e_fk_test_app_` (`schoolclass_id`),
    CONSTRAINT `test_app_teacher_sch_schoolclass_id_7ac34d1e_fk_test_app_` FOREIGN KEY (`schoolclass_id`) REFERENCES `test_app_schoolclass` (`id`),
    CONSTRAINT `test_app_teacher_sch_teacher_id_8c52afbd_fk_test_app_` FOREIGN KEY (`teacher_id`) REFERENCES `test_app_teacher` (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
  ```

  其中：

  test_app_teacher_school_class是表名: test_app是应用名， teacher是第一个模型名，school_class是第二个模型名



3. 自定义中间表

```python
from django.db import models

class Person(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)

class Group(models.Model):
    name = models.CharField(max_length=128)
    members = models.ManyToManyField(
        Person,
        through='Membership', # 必须是 类名的字符串 ，用 '' 包裹
        through_fields=('group', 'person'),
    )

class Membership(models.Model):
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    level = models.IntegerField(default=1)
```

笔记：

- 通过 through='Membership' 指定Membership作为中间表 
- 通过 through_fields=('group', 'person') 指定中间模型的属性
- 一般需要自定义中间表时，都是有额外的字段，譬如 level = models.IntegerField(default=1)



## 4、方法

​	除了运行程序时，可以测试模型，还可以在根目录的cmd执行：

```
python manage.py shell
```

​	打开django脚本控制台，测试执行模型的方法，会比启动项目更方便



模型对象中有一个objects属性，该属性是管理器Manager类型的对象，几乎所有的方法都是通过该对象执行的，具体见下面的代码：

### 1、新增

save 或 create

```python
#运行之前导入模块
from moremore_app.models import *  #其中moremore_app是子应用名
p = Person.objects.create(first_name="Bruce", last_name="Springsteen")

或
p1 = Person(first_name="Bruce", last_name="Springsteen")
p1.save()

```

```python
#一对多关系新增  方式一
#先新增一方
models.Account.objects.create(user_name='lili',email='234453@qq.com',password='123',signature='li')
#再创建多方对象
article = models.Article(title='对象关系映射',content='对象关系映射内容',pub_date='2021-7-6')
#设置外键的值
article.account_id=2  #其中account_id是数据库的字段   2是account表的主键值
#保存对象
article.save()
```

```python
#一对多关系新增多方  方式二
account =  models.Account.objects.get(pk=3)  #查询account表主键为3的Account实体
models.Article.objects.create(title='暑假安排',content='好好学习',account=account,pub_date='2021-7-9')
```

```python
#多对多关系新增
#先新增实体
models.Tag.objects.create(name='电影')
models.Tag.objects.create(name='科技') 
models.Tag.objects.create(name='教育')
#再创建关联
article.tags.set([1,2]) #执行后中间表中有数据
article.tags.set([3,])
```

![image-20210706110305713](.\imgs\image-20210706110305713.png)

```
#set是直接赋值  如果想在原有基础上新增则使用add
article.tags.add(1,2,3)
```

![image-20210706110424301](.\imgs\image-20210706110424301.png)

### 2、查询

- 大部分检索是懒惰执行的，只在真实获取值的时候，才会去连接数据库获取数据
- 查询集通过过滤器进行查询，允许链式调用
- pk是主键的别名(primary key)，如果真实主键是id，那么 pk 和 id 使用是一样的效果

1. 过滤器

```python
# get 获取一个对象
# 查询主键等于 1 的 ， 如果主键是ID，也可以使用 id=1
# 如果条件找不到对应的记录，会抛出 DoesNotExist 错误
# 如果条件找到多个记录，会抛出 MultipleObjectsReturned 错误
person = Person.objects.get(pk=1)

# all 获取所有对象
# 查询所有，得到的QuerySets对象
all_persons = Person.objects.all()

#过滤使用filter
#查询user_name='lili'的Account
Account.objects.filter(user_name='lili') 

```

2. 字段查找

   - 字段检索，是在字段名后加 '\_\_' 双下划线，再加关键字，类似 SQL 语句中的 where 后面的部分， 如： 字段名\_\_关键字

   - 在查找中指定的字段必须是模型字段的名称，但有一个例外，如果是ForeignKey字段，则是属性名+ ‘_id’：  Entry.objects.filter(blog_id=4) ， 定义的 ForeignKey是 blog

   - 完整的字段检索文档：

     <https://docs.djangoproject.com/en/2.2/ref/models/querysets/#field-lookups>

     常见的字段检索：

     exact ：判断是否等于value，一般不使用，而直接使用 '='

     contains：是否包含,大小写敏感，如果需要不敏感的话，使用icontains

     startswith：以value开头,大小写敏感

     endwith：以value结尾,大小写敏感  

     in：是否包含在范围内 

     isnull：是否为null， 如：filter(name__isnull=Flase) 

     gt：大于，如：filter(sage__gt=30) ， 年龄大于30

     gte：大于等于 

     lt：小于 

     lte：小于等于 

     

     ```python
     
     ```
# 确定的搜索 ，SQL： where id = 14
     Blog.objects.get(id__exact=14)
     # 等同于
     Blog.objects.get(id=14)
     
     # 不区分大小写的确定搜索，匹配 beatles blog 、Beatles blog等
     Blog.objects.get(name__iexact="beatles blog")
     
     # 包含，contains ，SQL：WHERE headline LIKE '%Lennon%'
     Entry.objects.get(headline__contains='Lennon')
     # 不区分大小写的包含
     Entry.objects.get(headline__icontains='Lennon')
     
     # 以什么开头， SQL： WHERE headline LIKE 'Lennon%'
     # 还有 不区分大小写的 istartwith
     Entry.objects.get(headline__startswith='Lennon')
     
     # 同样有 endswith ，SQL ： WHERE headline LIKE '%Lennon'
     # 还有 不区分大小写的 iendswith
     Entry.objects.get(headline__endswith='Lennon')
     
     # in
     Entry.objects.get(headline__in=['Lennon', 'Terry'])
     
     #isnull
     Account.objects.filter(signature__isnull=True)

   #gt gte
     Account.objects.filter(id__gt=1)
     Account.objects.filter(id__gte=1)
     
     #lt lte
     Account.objects.filter(id__lte=5)
     ```

   






3. 日期时间的过滤

   year/month/day/week_day/hour/minute/second：时间查询，如：		filter(pub_date\_\_year=2015)  年份是2015的， filter(pub_date__day=15)  天数是15的

   ```python
   #时间可以直接使用gt gte lt lte
   Account.objects.filter(register_date__gt='2021-7-1')
   
   #__range查询某个时间段
   Account.objects.filter(register_date__range=('2021-7-1','2021-7-7'))
   
   #查询某年某月某日 __date
   Account.objects.filter(register_date__date='2021-7-6')
   <QuerySet [<Account: Account object (2)>, <Account: Account object (3)>]>
   
   #查询某年 __year
   # exclude 例外
   # 查询 日期年份 不是2006的
   persons = Person.objects.exclude(pub_date__year=2006)
   
   # filter 获取对象列表
   # 查询 日期年份 是 2006 的
   persons = Person.objects.filter(pub_date__year=2006)
   
   # filter 获取对象列表，支持切片，但是不支持负数切片
   # limit  5 ：前5个
   persons = Person.objects.filter(pub_date__year=2006)[:5]
   # limit  5,5 ： 第6个到10个
   persons = Person.objects.filter(pub_date__year=2006)[5:10]
   # Entry.objects.all()[-1] 不支持
   
   # 返回前10个记录的， 0 ，2 ， 4， 6， 8， 10 ，并且会立刻执行，而不是懒惰执行
   Entry.objects.all()[:10:2]
   
   #查询某月 __month
   Account.objects.filter(register_date__month=7)
   
   #查询某天 __day
   Account.objects.filter(register_date__year=2021,register_date__day=6)
   Account.objects.filter(register_date__year=2021).filter(register_date__day=6)
   
   #查询星期几__week_day  注意 from 1（sunday）to 7(saturday)
   Account.objects.filter(register_date__week_day=3)
   ```
   
   
   
4. 排序

   ```python
   # order_by() 对结果集排序
   person_li = Person.objects.filter(pub_date__year=2006).order_by('pub_date')
   # 支持多个字段， 类似 SQL：  order by pub_date, headline
   person_li = Person.objects.filter(pub_date__year=2006).order_by('pub_date', 'headline')
   #降序排序
   person_li = Person.objects.filter(pub_date__year=2006).order_by('-pub_date')
   ```

   

5. 其它方法

   ```python
   # count() 对结果集统计
   count = Person.objects.filter(pub_date__year=2006).count()
   
   #reverse() 对结果集进行反转 注意使用reverse必须先排序
   #比如要取数据的最后10条，可以先反转再切片
   Account.objects.all().order_by('id').reverse()[:1]
   
   
   
   # first() 返回结果集的第一个对象
   person = Person.objects.filter(pub_date__year=2006).first()
   person = Person.objects.first()
   # last() 返回结果集的最后一个对象
   person = Person.objects.filter(pub_date__year=2006).last()
   
   # values() 返回一个 字典对象 列表
   person_dict_li = Person.objects.filter(pub_date__year=2006).values()
   
   #values()传入字段
   Account.objects.all().values('user_name')
   <QuerySet [{'user_name': 'lili'}, {'user_name': 'tom'}, {'user_name': '李四'}]>
   
   Account.objects.all().values('user_name','register_date')
   <QuerySet [{'user_name': '李四', 'register_date': datetime.datetime(2021, 7, 1, 3, 18, 18, tzinfo=<UTC>)}, {'user_name': 'tom', 'register_date': datetime.datetime(2021, 7, 6, 1, 52, 54, 5896, tzinfo=<UTC>)}, {'user_name': 'lili', 'register_date': datetime.datetime(2021, 7, 6, 2, 10, 42, 927481, tzinfo=<UTC>)}]>
   ```

   

   大部分检索是懒惰的，只在真实获取值的时候，才会真正去连接数据库获取数据： 

   ```python
   # 懒惰执行
   q = Entry.objects.filter(headline__startswith="What")
   q = q.filter(pub_date__lte=datetime.date.today())
   q = q.exclude(body_text__icontains="food")
   print(q)   # 此处才会真的去连接数据库获取记录
   
   # 返回前10个记录的， 0 ，2 ， 4， 6， 8， 10 ，并且会马上执行，而不是懒惰执行
   q = Entry.objects.all()[:10:2]  # 已经获取到数据了
   print(q)
   ```

6. 多对象关联查询

   通过Blog模型中，关联的另一个模型对象entry的属性进行过滤：

   PS： entry\__headline__contains ，即使是访问模型对象entry的属性 headline，也必须使用 '\_\_'

```python
# 检索所有Blog具有至少一个对象Entry ，其headline包含'Lennon'
Blog.objects.filter(entry__headline__contains='Lennon')

# Blog中 有一个对象 entry  的 headline 中包含“Lennon”并且 是 2008年发布的
Blog.objects.filter(entry__headline__contains='Lennon').filter(entry__pub_date__year=2008)
# 通过 , 分割多个条件， 相当于数据库中的 'and'
Blog.objects.filter(entry__headline__contains='Lennon', entry__pub_date__year=2008)

# 取上面相反的值
Blog.objects.exclude(entry__in=Entry.objects.filter(headline__contains='Lennon', pub_date__year=2008, ))

```

​	一对一关系中，通过一个模型获取另一个模型：

```python
class Place(models.Model):
    name = models.CharField(max_length=50)
    address = models.CharField(max_length=80)

class Restaurant(models.Model):
    place = models.OneToOneField(
        Place,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    # BooleanField 在数据库使用 tinyint 类型
    serves_hot_dogs = models.BooleanField(default=False)
    serves_pizza = models.BooleanField(default=False)
    
    
# 通过 Place 查找 Restaurant
place = Place.objects.first()
restaurant = place.restaurant

# 通过 定义了 OneToOneField 的模型 Restaurant 查找 Place
restaurant = Restaurant.objects.first()
place = restaurant.place
```

​	一对多关系中，通过一个模型获取另一个模型：

```python
from django.db import models

class Manufacturer(models.Model):
    name = models.CharField(max_length=20)

class Car(models.Model):
    manufacturer = models.ForeignKey(Manufacturer, on_delete=models.CASCADE)
    
    name = models.CharField(max_length=20)
    
# 从 一的模型 查找 多的模型
# 通过 '多的模型小写名_set' 查找
manufacturer = Manufacturer.objects.first()
cars = manufacturer.car_set.all()

# 从 多的模型 查找 一的模型
car = Car.objects.first()
manufacturer = car.manufacturer
```

​	多对多关系中，通过一个模型获取另一个模型：

```python
class SchoolClass(models.Model):
    name = models.CharField(max_length=20)

class Teacher(models.Model):
    name = models.CharField(max_length=10)
    school_class = models.ManyToManyField(SchoolClass)
    
# 从 没有写 ManyToManyField 的模型查找另一 写了 ManyToManyField 的模型
# 需要在 查询的模型名的小写后 加 _set
schoolClass = SchoolClass.objects.first()
teachers = schoolClass.teacher_set.all()

# 从 写了 ManyToManyField 的模型查找另一个模型
teacher = Teacher.objects.first()
schoolClasses = teacher.school_class.all()
```

​	

4. 聚合函数

   使用aggregate()函数返回聚合函数的值 

   常用的聚合函数有：Avg、Count、Max、Min、Sum 

   ```python
   # Max 找出最大的
   from django.db.models import Max
   Person.objects.aggregate(Max('age'))
   # 结果是一个字典 {'age__max': 30}
   # 可以使用 max=Max('age') 指定 别名为 max，而不使用  age__max
   Person.objects.aggregate(max=Max('age'))
   
   # 多个聚合函数一起使用
   Person.objects.aggregate(Max('age'), Min('age'), Avg('age'))
   ```

5. 分组查询

   使用annotate()函数实现分组查询，得配合其他函数：

   - annotate：用于分组，配合 Avg，Count等聚合函数，如：annotate(max=Max('age'))
   - filter： 用于过滤，在 annotate之前使用表示 where 条件，在annotate之后使用表示having条件
   - values：在annotate之前使用表示分组字段，在annotate之后使用表示取值

   ```python
   # 基本应用
   # 以 group_id 分组，找出level的最大值，最小值，和平均值
   Membership.objects.values('group_id').annotate(max=Max('level'), min=Min('level'), avg=Avg('level'))
   
   # 以 group_id 分组 并且 group_id 大于 2 ，找出level的最大值，最小值，和平均值
   Membership.objects.values('group_id').annotate(max=Max('level'), min=Min('level'), avg=Avg('level')).filter(group_id__gt=2)
   # 和下面这句等效
   # 推荐使用下面这种方式
   Membership.objects.filter(group_id__gt=2).values('group_id').annotate(max=Max('level'), min=Min('level'), avg=Avg('level'))
   ```

### 3、修改

```python
#单条记录修改 save
p = Person.objects.get(pk=1)
p.first_name = 'James'
p.save()

obj = MyModel.objects.create(val=1)
# 需要使用F来保证不会出现并发冲突
from django.db.models import F
MyModel.objects.filter(pk=obj.pk).update(age=F('age') + 1)

# 更新多个值  update
Entry.objects.filter(pub_date__year='2007').update(headline='Everything is the same')

```



### 4、删除

​	delete方法

```python
person = Person.objects.get(pk=1)
person.delete()
```



### 5、刷新对象

​	通过 refresh_from_db 从数据库中重新获取对象的内容

```python
person = Person.objects.get(pk=1)
person.refresh_from_db()
```



### 6、Q对象

​	filter() 等方法中的关键字参数查询都是并且('AND')的， 如果你需要执行更复杂的查询（例如or语句），那么可以使用Q 对象。

​	Q 对象 (django.db.models.Q) 对象用于封装一组关键字参数，可以使用 & 和 | 操作符组合起来，当一个操作符在两个Q 对象上使用时，它产生一个新的Q 对象。

```python
from django.db.models import Q

# 等同于 select * from poll where question like 'Who%' or question like 'What%'
poll = Poll.objects.filter(Q(question__startswith='Who') | Q(question__startswith='What'))

# 等同于 select * from poll WHERE question like 'Who%' and (pub_date = '2005-05-02' or pub_date = '2005-05-06')
poll = Poll.objects.filter(
    Q(question__startswith='Who'),
    Q(pub_date=date(2005, 5, 2)) | Q(pub_date=date(2005, 5, 6))
)

# Q对象可以使用 ~ 操作符取反， 相当于SQL中 not 
poll = Poll.objects.filter(
    Q(question__startswith='Who'),
    ~Q(pub_date__year=2005)
)

# Q对象可以和一般的关键字参数混用， 但是Q对象必须在一般关键字参数的前面
Poll.objects.filter(
    Q(pub_date=date(2005, 5, 2)) | Q(pub_date=date(2005, 5, 6)), 	 		             question__startswith='Who'
)

```



### 7、F对象

​	简单记忆：模型的属性名出现在操作符的右边，就使用F对象进行包裹



- 可以使用模型的A属性与B属性进行比较 

  ```python
  # 找出女生数量大于男生数量的年级
  # 对应sql：select * from grade where girlnum > boynum
  grades = Grade.objects.filter(girlnum__gt=F('boynum'))
  ```

- 支持算数运算

  ```python
  # 找出女生数量大于 男生数量+10 的年级
  # 对应的sql： select * from grade where girlnum > boynum + 10
  Grade.objects.filter(girlnum__gt=F('boynum') + 10)
  
  # 所有书籍的价格 +1
  # 对应的 sql： update book set price = price + 1 
  Book.objects.update(price=F("price")+1)
  ```



## 5、使用SQL语句

### 1、通过模型使用SQL

​	通过raw函数执行原始SQL语句进行查询，主键字段必须包含在查询的字段中，不然会引发错误 ：

```python
# 定义个 person 模型
class Person(models.Model):
    first_name = models.CharField()
    last_name = models.CharField()
    birth_date = models.DateField()

# 执行 原始 SQL
# 表名前面必须加 应用名myapp，即在数据库中的真实表名，否则会抛出异常
for p in Person.objects.raw('SELECT * FROM myapp_person'):
    print(p)

# 字段先后顺序没关系
Person.objects.raw('SELECT id, first_name, last_name, birth_date FROM myapp_person')
# 等同于
Person.objects.raw('SELECT last_name, birth_date, first_name, id FROM myapp_person')

# 可以从其他表格中查询出匹配 person 模型的记录集
# 总之最终的数据集的结构必须和 Person一样
Person.objects.raw('SELECT first AS first_name, last AS last_name,bd AS birth_date,pk AS id,FROM some_other_table')

# 返回的结果集一样可以执行切片
first_person = Person.objects.raw('SELECT * FROM myapp_person')[0]
# 但是上述语句会返回所有结果，基于节省传输的需要，在数据库缩小结果集范围更正确
first_person = Person.objects.raw('SELECT * FROM myapp_person LIMIT 1')[0]


# 传递参数
lname = 'Doe'
Person.objects.raw('SELECT * FROM myapp_person WHERE last_name = %s', [lname])

```



### 2、避开模型使用SQL

​	不应用模型，直接使用SQL语句进行增删改查

```python
from django.db import connection

def my_custom_sql(obj):
    with connection.cursor() as cursor:
        cursor.execute("UPDATE bar SET foo = 1 WHERE baz = %s", [obj.baz])
        cursor.execute("SELECT foo FROM bar WHERE baz = %s", [obj.baz])
        row = cursor.fetchone()

    return row

```

## django视图

## 1、简单应用

1. FBV（function base views）

   就是在视图里使用函数处理请求

```python
# urlconf 中
urlpatterns = [
	path('fbv/', views.current_datetime),
]

# views 中
from django.http import HttpResponse
import datetime

def current_datetime(request):
    now = datetime.datetime.now()
    html = "<html><body>It is now %s.</body></html>" % now
    return HttpResponse(html)

```

笔记：

- 视图函数 current_datetime，每个视图函数都将一个HttpRequest 对象作为其第一个参数，该参数通常被命名request
- 视图函数的名称无关紧要，它不必以某种方式命名，以便Django能够识别它，但是函数命名一定要能够清晰的描述它的功能
- 视图函数返回一个HttpResponse响应的对象，每个视图函数负责返回一个HttpResponse对象（有例外，但我们在稍后讨论）



2、CBV（class base views） 

​	就是在视图里使用类处理请求

```python
# urlconf 中
urlpatterns = [
    # 一定要使用 as_view() ，记住 小括号
	path('cbv/', views.MyView.as_view()),
]

# views中
from django.http import HttpResponse
from django.views import View
  
class MyView(View):

    def get(self, request):
        return HttpResponse('get OK')

    def post(self, request):
        return HttpResponse('post OK')
        
```

笔记：

- CBV提供了一个as_view()静态方法（也就是类方法），调用这个方法，会创建一个类的实例，然后通过实例调用dispatch()方法，dispatch()方法会根据request的method的不同调用相应的方法来处理request（如get()，post()等） 
- 提高了代码的复用性，可以使用面向对象的技术，比如Mixin（多继承）
- 可以用不同的函数针对不同的HTTP方法处理，而不是通过很多 if 判断，可以提高代码可读性





## 2、返回错误响应

```python
# 使用 HttpResponseNotFound
def my_view(request):
    # ...
    if foo:
        return HttpResponseNotFound('<h1>Page not found</h1>')
    else:
        return HttpResponse('<h1>Page was found</h1>')


# 还可以直接返回状态码
from django.http import HttpResponse

def my_view(request):
    # ...
    # Return a "created" (201) response code.
    return HttpResponse(status=201)


# 特殊的 404  错误
from django.http import Http404
from django.shortcuts import render
from polls.models import Poll

def detail(request, poll_id):
    try:
        p = Poll.objects.get(pk=poll_id)
    except Poll.DoesNotExist:
        raise Http404("Poll does not exist")
    return render(request, 'polls/detail.html', {'poll': p})

```



## 3、视图装饰器

@require_http_methods，要求视图只接收指定的http方法

@require_GET()：仅仅允许GET方法

@require_POST()：仅仅允许POST方法.

@require_safe()：仅仅允许GET和HEAD方法

```python
from django.views.decorators.http import require_http_methods

# 允许 GET和POST方法， 默认就是所有方法都支持
@require_http_methods(["GET", "POST"])
def my_view(request):
    # I can assume now that only GET or POST requests make it this far
    # ...
    pass

```



@login_required 

必须登录才能访问装饰的视图函数，

用户未登录，则重定向到settings.LOGIN_URL，除非指定了login_url参数，例如：@login_required(login_url='/polls/login/') 

```python
@login_required
def my_view(request):
    # I can assume now that only GET or POST requests make it this far
    # ...
    pass
```



## 4、请求和响应

### 1.HttpRequest

每一个用户请求在到达视图函数的同时，django会自动创建一个HttpRequest对象并把这个对象当做第一个参数传给要调用的views方法。HttpRequest对象里封装了本次请求所涉及的用户浏览器端数据、服务器端数据等，在views里可以通过request对象来调用相应的属性。

所有视图函数的第一个参数都是HttpRequest实例



属性（除非另有说明，否则所有属性均应视为只读）：

- HttpRequest.scheme：

  表示请求使用的协议（http或https）

 

- HttpRequest.body：

  原始HTTP请求主体，类型是字节串。处理数据一些非html表单的数据类型很有用，譬如：二进制图像，XML等；

  - 取form表单数据，请使用 HttpRequest.POST

  - 取url中的参数，用HttpRequest.GET

 

- HttpRequest.path：

  表示请求页面的完整路径的字符串，不包括scheme和域名。

  例： "/music/bands/the_beatles/"

 

- HttpRequest.path_info：

  在某些Web服务器配置下，主机名后的URL部分被分成脚本前缀部分和路径信息部分。path_info无论使用什么Web服务器，该属性始终包含路径的路径信息部分。使用此代替path可以使代码更容易在测试和部署服务器之间移动。

  例如，如果WSGIScriptAlias你的应用程序设置为 "/minfo"，则path可能是"/minfo/music/bands/the_beatles/" ， path_info 会是 "/music/bands/the_beatles/"。

 

- HttpRequest.method：

  表示请求中使用的HTTP方法的字符串，是大写的。例如：

  ```python
  if request.method == 'GET':
      do_something()
  elif request.method == 'POST':
      do_something_else()
  ```
  

  
- HttpRequest.encoding：

  表示当前编码的字符串，用于解码表单提交数据（或者None，表示使用该DEFAULT_CHARSET设置）。

  可以设置此属性来更改访问表单数据时使用的编码，修改后，后续的属性访问（例如读取GET或POST）将使用新encoding值。

 

- HttpRequest.content_type：

  表示请求的MIME类型的字符串，从CONTENT_TYPE解析 。

 

- HttpRequest.content_params：

  包含在CONTENT_TYPE 标题中的键/值参数字典。

 

- HttpRequest.GET：

  包含所有给定的HTTP GET参数的类似字典的对象。请参阅QueryDict下面的文档。

 

- HttpRequest.POST：

  包含所有给定HTTP POST参数的类似字典的对象，前提是请求包含表单数据。请参阅QueryDict文档。POST不包含文件信息，文件信息请见FILES。

 

- HttpRequest.COOKIES：

  包含所有Cookie的字典，键和值是字符串。

 

- HttpRequest.FILES：

  包含所有上传文件的类似字典的对象

 

- HttpRequest.META：

  包含所有可用HTTP meta的字典

 

中间件设置的属性：

​	Django的contrib应用程序中包含的一些中间件在请求中设置了属性。如果在请求中看不到该属性，请确保使用了相应的中间件类MIDDLEWARE。

 

- HttpRequest.session：

  来自SessionMiddleware：代表当前会话的可读写字典对象。

 

- HttpRequest.site：

  来自CurrentSiteMiddleware： 代表当前网站的实例Site或 RequestSite返回get_current_site()

 

- HttpRequest.user：

  来自AuthenticationMiddleware：AUTH_USER_MODEL代表当前登录用户的实例



### 2.QueryDict

​	在一个 HttpRequest对象中，GET和 POST属性是django.http.QueryDict实例，该对象定义为相同的键的多个值的字典状类，继承自MultiValueDict， 而MultiValueDict则继承自dict

```python
qd = request.GET

# QueryDict('a=1&a=2&c=3')
#<QueryDict: {'a': ['1', '2'], 'c': ['3']}>

# 获取属性c
print(qd['c'])

# 有多个值的key，会获取最后一个值
print(qd['a'])  # 打印 2

# 获取key a 对应的所有value：['1', '2']
print(qd.getlist('a'))
```



​	QueryDict.items()

​	等同于 Dict的items，但是同一个key，多个值时，最后一个值起作用

```python
qd = QueryDict('a=1&a=2&a=3&b=4')
print(list(qd.items()))  # 打印 [('a', '3'), ('b', '4')]
```



### 3.HttpResponse 

返回给浏览器端的响应对象

属性：

- HttpResponse.content:

  表示响应的字符串

  

- HttpResponse.charset:

  表示响应将被编码的字符集，如果在HttpResponse实例化时没有给出，则会从中提取 content_type，如果没有设置content_type，则使用settings.DEFAULT_CHARSET

  

- HttpResponse.status_code:

  该响应的 HTTP 状态码

  

- HttpResponse.reason_phrase:

  响应的HTTP原因描述语，使用HTTP标准的默认原因描述语
  除非明确设置，否则reason_phrase由 status_code 决定。

  

- HttpResponse.streaming:

  总是False，中间件通过此属性可以区分流式响应与常规响应

  

- HttpResponse.closed:

  如果response已经结束，则返回True，否则返回False



### 4.JsonResponse

​	包含json格式内容的响应

```python
from django.http import JsonResponse

response = JsonResponse({'foo': 'bar'})

print(response.content)  # 打印  b'{"foo": "bar"}'

```



### 5.FileResponse

​	文件内容的响应

```python
from django.http import FileResponse

path = os.getcwd() + '/' + 'myfile.png'  # os.getcwd() 得到的是django项目根目录
response = FileResponse(open(path, 'rb'))
```



## 5、快捷方式

### 1.render 方法：

​	必需的参数：

​		request：用于生成此响应的请求对象。

​		template_name：要使用的模板的全名或模板名称的列表。

​	可选参数：

​		context：要添加到模板上下文的值的字典。默认情况下，这是一个空字典。如果字典中的值是可调用的，视图将在渲染模板之前调用它。

​		content_type：用于生成文档的MIME类型。默认为DEFAULT_CONTENT_TYPE设置的值。

​		status：响应的状态码。默认为200。

​		using：用于加载模板的模板引擎名。

```python
from django.shortcuts import render

def my_view(request):
    # View code here...
    return render(request, 'myapp/index.html', {
        'foo': 'bar',
    }, content_type='application/xhtml+xml')

# 等同于
from django.http import HttpResponse
from django.template import loader

def my_view(request):
    # View code here...
    t = loader.get_template('myapp/index.html')
    c = {'foo': 'bar'}
    return HttpResponse(t.render(c, request), content_type='application/xhtml+xml')

```



### 2.redirect  方法

1. 通过传递一些对象， 该对象的 get_absolute_url()方法将被调用以找出重定向URL： 

   ```python
   from django.shortcuts import redirect
   
   def my_view(request):
       ...
       object = MyModel.objects.get(...)
       return redirect(object)
   ```

   

2. 通过传递一个URLConf调度器中配置path或re_path的名称，以及可选的一些位置或关键字参数，该URL将使用reverse()方法反向解析 ：

   ```python
   def my_view(request):
       ...
       return redirect('polls:index', foo='bar')
   
   ```

   

3. 通过传递硬编码的URL重定向：

   ```python
   # 使用绝对路径
   def my_view(request):
       ...
       return redirect('/some/url/')
   
   # 可以使用 ./ 和 ../ 的相对路径
   def my_view(request):
       return redirect('../../blog/')
   
   ```

   

4. 默认情况下，redirect()返回一个临时重定向（302）。所有上述形式都接受permanent参数; 如果设置为True永久重定向（301）将被返回：

   ```python
   def my_view(request):
       ...
       object = MyModel.objects.get(...)
       return redirect(object, permanent=True)
   
   ```

   

### 3.get_object_or_404，get_list_or_404

​	必需的参数：

​		klass：一Model类或一个Manager或QuerySet从哪个实例来获取对象

​		**kwargs：查找参数，应该采用get()或filter()的参数。

```python
from django.shortcuts import get_object_or_404

def my_view(request):
    poll = get_object_or_404(MyModel, pk=1)

#等同于
def my_view(request):
    try:
        poll = Poll.objects.get(pk=1)
    except Poll.DoesNotExist:
        raise Http404()

```



## 6、内置通用视图

​	包含在 from django.views import generic 中

​	具体视图类型有：

```python
__all__ = [
    'View', 'TemplateView', 'RedirectView', 'ArchiveIndexView',
    'YearArchiveView', 'MonthArchiveView', 'WeekArchiveView', 'DayArchiveView',
    'TodayArchiveView', 'DateDetailView', 'DetailView', 'FormView',
    'CreateView', 'UpdateView', 'DeleteView', 'ListView', 'GenericViewError',
]

```

​	比较常用的：RedirectView、DetailView、ListView

​	用法：

DetailView：

```python
# urls中：
path('<int:pk>/', views.MyDetailView.as_view(), name='detail'),

# views：
class MyDetailView(generic.DetailView):
    """
        使用通用的详情视图
    """
    # 对应的模型对象
    model = Question
    # 使用的模板名
    template_name = 'detail.html'

# template（detail.html）：   
<h1>{{ object.question_text }}</h1>
```
# Django模板

​	作为一个Web框架，Django需要一种方便的方式来动态生成HTML。最常用的方法依赖于模板。模板包含所需HTML输出的静态部分以及描述如何插入动态内容的特殊语法。

​	对模板引擎的一般支持和Django模板语言的实现都存在于 django.template 命名空间中



## 1、django默认模板

### 1、配置

​	在settings中配置：

```python
# 配置模板
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')]
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

```

笔记：

- BACKEND：是实现Django模板后端API的模板引擎类的路径。内置是django.template.backends.django.DjangoTemplates和 django.template.backends.jinja2.Jinja2（使用这个需要额外安装jinja2库）
- DIRS ：按搜索顺序定义引擎应该查找模板源文件的目录列表
- APP_DIRS：告诉引擎是否应该在已安装的应用程序中查找模板，每个后端为其模板应存储在的应用程序内的子目录定义一个常规名称。
- OPTIONS：包含后端特定的设置



### 2、用法

​	假如settings中配置如下：

```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            '/home/html/example.com',
            '/home/html/default',
        ],
    },
    {
        'BACKEND': 'django.template.backends.jinja2.Jinja2',
        'DIRS': [
            '/home/html/jinja2',
        ],
    },
]

```

1. get_template 

   该函数使用给定名称加载模板并返回一个 Template对象，找到第一个匹配的模板即返回

   ```python
   template = get_template('story_detail.html')
   ```

   Django将要查找的文件，依次为：

   - /home/html/example.com/story_detail.html（'django'引擎）
   - /home/html/default/story_detail.html（'django'引擎）
   - /home/html/jinja2/story_detail.html（'jinja2'引擎）

   

   示例：

   ```python
   # 最常用的render
   from django.shortcuts import render
   
   def my_view(request):
       # View code here...
       return render(request, 'myapp/index.html', {
           'foo': 'bar',
       }, content_type='application/xhtml+xml')
   
   
   # 相当于基础的get_template：
   from django.http import HttpResponse
   from django.template import loader
   
   def my_view(request):
       # View code here...
       template = loader.get_template('myapp/index.html')
       context = {'foo': 'bar'}
       # 注意，这个 render 和 快捷键 render 不是一个对象
       return HttpResponse(template.render(context, request), content_type='application/xhtml+xml')
   
   ```

   

2. select_template

   select_template() 用法类似 get_template() ，除了它需要一个模板名称的列表。它按顺序尝试每个名称并返回存在的第一个模板

   ```python
   template = select_template(['story_253_detail.html','story_detail.html'])
   ```

   Django将要查找的文件，依次为：

   - /home/html/example.com/story_253_detail.html（'django'引擎）
   - /home/html/default/story_253_detail.html（'django'引擎）
   - /home/html/jinja2/story_253_detail.html（'jinja2'引擎）
   - /home/html/example.com/story_detail.html（'django'引擎）
   - /home/html/default/story_detail.html（'django'引擎）
   - /home/html/jinja2/story_detail.html（'jinja2'引擎）



### 3、模板语言

​	Django模板只是一个文本文档或使用Django模板语言标记的Python字符串。一些结构被模板引擎识别和解释，主要的是变量( {{ 变量 }} )和标签( {% 标签 %} )。



#### 1、变量

​	一个变量从上下文中输出一个值，这是一个类似字典的对象将键映射到值。

​	变量被这样包围 ：{{变量}}  譬如：

```django
# 模板中这样写：
My first name is {{ first_name }}. My last name is {{ last_name }}.

# 传入到 模板中的变量为：
{'first_name': 'John', 'last_name': 'Doe'}

# 在浏览器中显示如下：
My first name is John. My last name is Doe.
```

​	字典查找，属性查找和列表索引查找 都用点符号实现： 

```django
# 获取字典的 value
{{ my_dict.key }}

# 获取对象的 属性
{{ my_object.attribute }}

# 获取列表的 元素
{{ my_list.0 }}
```



#### 2、标签

​	标签在渲染过程中提供任意的逻辑。

​	例如，标签可以输出内容，用作控制结构，

​	例如“if”语句或“for”循环，从数据库中获取内容，甚至可以访问其他模板标签。

​	所有标签见：

​	https://docs.djangoproject.com/en/2.2/ref/templates/builtins/#ref-templates-builtins-tags



1. 基本用法

   标签被包围  {% 代码 %}  譬如：

   ```django
   # 无参数标签 csrf_token ，这个标签是用于html进行 form 表单提交时，包含一个 随机变化的字符串，在html页面中，其实就是一个 input type='hidden'
   # 作用是用于防止跨域攻击
   {% csrf_token %}
   
   # 传参的标签 cycle  ， 参数 'odd' 'even' ，空格间隔
   # 标签本身也支持 关键字参数 {% 标签 key1='value' key1='even' %}
   {% cycle 'odd' 'even' %}
   ```

   

2. 常见标签

   由于在模板中，没有办法通过代码缩进判断代码块，所以控制标签都需要有结束的标签

   1. if

      判断标签 if  endif ： 

      ```django
      # athlete_list 不为空
      {% if athlete_list %}
      	# 输出 athlete_list 的长度    | 是过滤器
          Number of athletes: {{ athlete_list|length }}
      {% elif athlete_in_locker_room_list %}
          Athletes should be out of the locker room soon!
      {% else %}
          No athletes.
      {% endif %}
      
      ```

      

   2. firstof

      输出不是False的第一个参数，所有参数都为False，则什么都不输出 

      ```django
      {% firstof var1 var2 var3 %}
      等同于
      {% if var1 %}
          {{ var1 }}
      {% elif var2 %}
          {{ var2 }}
      {% elif var3 %}
          {{ var3 }}
      {% endif %}
      
      使用默认值：
      {% firstof var1 var2 var3 "默认值" %}
      
      ```

      

   3. for

      循环遍历，for endfor结束 ，可以遍历列表，字典等

      ```django
      <ul>
      {% for athlete in athlete_list %}
          <li>{{ athlete.name }}</li>
      {% endfor %}
      </ul>
      
      反向循环：
      {% for athlete in athlete_list reversed%}
      
      字典：  data.items 这种调用方法，是不加 () 的
      {% for key, value in data.items %}
          {{ key }}: {{ value }}
      {% endfor %}
      
      设置默认值， for empty  ，类似python的  for else：
      <ul>
      {% for athlete in athlete_list %}
          <li>{{ athlete.name }}</li>
      {% empty %}
          <li>Sorry, no athletes in this list.</li>
      {% endfor %}
      </ul>
      等同于，但是比下面的写法更加简便：
      <ul>
        {% if athlete_list %}
          {% for athlete in athlete_list %}
            <li>{{ athlete.name }}</li>
          {% endfor %}
        {% else %}
          <li>Sorry, no athletes in this list.</li>
        {% endif %}
      </ul>
      
      ```

      for循环在循环中设置了许多变量：

      | **变量**                | **描述**                             |
      | ----------------------- | ------------------------------------ |
      | **forloop.counter**     | 循环的当前迭代（1索引）              |
      | **forloop.counter0**    | 循环的当前迭代（0索引）              |
      | **forloop.revcounter**  | 循环结束时的迭代次数（1索引）        |
      | **forloop.revcounter0** | 循环结束时的迭代次数（0索引）        |
      | **forloop.first**       | 如果这是通过循环的第一次，则为真     |
      | **forloop.last**        | 如果这是通过循环的最后一次，则为真   |
      | **forloop.parentloop**  | 对于嵌套循环，这是围绕当前循环的循环 |

      

   4. 布尔运算符

      and、or和not

      ```django
      {% if athlete_list and coach_list %}
          Both athletes and coaches are available.
      {% endif %}
      
      {% if not athlete_list %}
          There are no athletes.
      {% endif %}
      
      {% if athlete_list or coach_list %}
          There are some athletes or some coaches.
      {% endif %}
      
      {% if not athlete_list or coach_list %}
          There are no athletes or there are some coaches.
      {% endif %}
      
      {% if athlete_list and not coach_list %}
          There are some athletes and absolutely no coaches.
      {% endif %}
      
      ```

      允许在同一个标签中使用两个and和or子句， and优先级高于or例如：

      ```django
      {% if athlete_list and coach_list or cheerleader_list %}
      将被解释为：
      if (athlete_list and coach_list) or cheerleader_list
      
      ```

      但是在if标签中使用实际的括号是无效的语法。如果你需要它们来表示优先级，你应该使用嵌套if标签

      

   5. 逻辑运算符

      ==, !=, <, >, <=, >=, in, not in, is, 和 is not 

      ```django
      {% if somevar == "x" %}
        This appears if variable somevar equals the string "x"
      {% endif %}
      
      {% if "bc" in "abcdef" %}
        This appears since "bc" is a substring of "abcdef"
      {% endif %}
      
      {% if somevar is not True %}
        This appears if somevar is not True, or if somevar is not found in the
        context.
      {% endif %}
      
      ```

      优先级，从低到高：

      - or
      - and
      - not
      - in
      - ==，!=，<，>，<=，>=

      

   6. url

      给定视图和可选参数匹配的绝对路径引用（没有域名的URL）

      ```django
      {% url 'some-url-name' v1 v2 %}
      第一个参数是url模式名称，后面跟着的是参数，以空格分隔
      
      可以使用关键字：
      {% url 'some-url-name' arg1=v1 arg2=v2 %}
      
      如果您想检索命名空间的URL，请指定完全限定的名称：
      {% url 'myapp:view-name' %}
      
      ```

      

   7. widthratio：乘法和除法

      ```django
      {% widthratio this_value max_value max_width %}
      结果是： this_value/max_value*max_width
      如果要计算  value * 10 ： widthratio value 1 10
      如果要计算 value / 8  ： widthratio 8 1
      还可以这样使用：
      
      {% widthratio this_value max_value max_width as width %}
      The width is: {{ width }}
      
      ```

      

   8. with

      简单的名称缓存复杂变量，当访问多次耗时的方法（例如操作数据库的方法）:

      ```django
      {% with total=business.employees.count%}
          {{ total }} employee
      {% endwith %}
      
      上述的：{% with total=business.employees.count%}
          等同于：{% with business.employees.count as total %}
      
      ```

      

   9. 过滤器

      通过  |   来使用

      示例：{{ value|add:"2" }}

      value： 是模板中获取的对象

      add： 是过滤器

      “2”： 是过滤器add的参数，只支持一个参数

      

      length：messages|length这里判断 messages 不为空，并且长度大于等于100 

      ```django
      {% if messages|length >= 100 %}
         You have lots of messages today!
      {% endif %}
      ```

      

      add：相加(减法：|add:-2 ) ， 可以应用于 列表等

      ```django
      {{ value|add:"2" }}
      如果value是4，那么输出6
      
      {{ first|add:second }}
      如果first=[1,2,3] ，second=[4,5,6]，那么输出：[1,2,3,4,5,6]
      
      ```

      

      divisibleby：能否整除，返回 True和False 

      ```django
      {{ value|divisibleby:"2" }}
      ```

      

      addslashes：单引号前加 \ 

      ```django
      {{ value|addslashes }}
      value="I'm using Django"，输出："I\'m using Django".
      
      ```

      

      capfirst：首字母大写，只对字符串的第一个单词的首字母大写

      ```django
      {{ value|capfirst }}
      如果value是"django is good"，输出将是"Django is good"。
      
      ```

      

      center：将值置于给定宽度的字段中

      ```django
      "{{ value|center:"15" }}"
      如果value是"Django"，输出将是。"     Django    "，前面5个，后面4个空格
      
      ```

      

      cut：删除给定字符 

      ```django
      {{ value|cut:" " }}
      如果value是"String with spaces"，输出将是："Stringwithspaces"
      
      ```

      

      date：日期字符串 

      ```django
      格式字符  	描述	示例              输出
      b	月，文字，3个字母，小写。	'jan'
      d	每月的一天，2位数字前导零。	'01' 至 '31'
      D	星期几，文字，3个字母。	'Fri'
      e	时区名称。可能是任何格式，或者可能会返回一个空字符串，具体取决于日期时间。	''，'GMT'，'-500'，'US/Eastern'，等。
      E	月，通常用于长日期表示的区域设置特定备选表示。	'listopada'（对于波兰语区而言'Listopad'）
      f	时间在12小时和分钟之内，如果它们为零，则分钟时间不再。专有扩展。	'1'， '1:30'
      F	月，文字，长。	'January'
      g	小时，12小时制，无前导零。	'1' 至 '12'
      G	小时，24小时制，无前导零。	'0' 至 '23'
      h	小时，12小时制。	'01' 至 '12'
      H	小时，24小时制。	'00' 至 '23'
      i  	分钟。	'00' 至 '59'
      I 	夏令时，无论是否有效。	'1'  or  '0'
      J	没有前导零的月份的一天。	'1' 至 '31'
      n	月没有前导零。	'1' 至 '12'
      N   月份             'Jan.', 'Feb.', 'March', 'May'
      s    秒                  00-59
      t	给定月份的天数。	28 至 31
      T	这台机器的时区。	'EST'， 'MDT'
      u	微秒。	000000 至 999999
      U	Unix时代以来的秒数（1970年1月1日00:00:00 UTC）。	 
      w ^	没有前导零的数字。	'0'（星期日）至'6'（星期六）
      W ^	ISO-8601周数，周数从周一开始。	1， 53
      y	年，2位数字。	'99'
      Y	年，4位数字。	'1999'
      z	一年中的一天。	0 至 365
      Z	以秒为单位的时区偏移量。UTC以西时区的偏移总是负值，而UTC以东的偏移总是正值。	-43200 至 43200
      
      
      {{ value|date:"D d M Y" }}
      {{ value|date:"Y-m-d H:i:s" }}
      value：datetime.datetime.now()
      
      ```

      

   10. include

      包含另外一个模板

      模板名称可以是变量，也可以是单引号或双引号的硬编码（带引号）的字符串 

      ```django
      {% include "foo/bar.html" %}
      
      {% include template_name %}
      该变量也可以是任何具有render()接受上下文的方法的对象
      
      ```

      include传参数：

      ​	下面这个例子在页面中显示："Hello, John!"

      

      - context：

        ```python
        context = {'greeting': 'hello', 'person': 'John'}
        ```

        

      - name_snippet.html模板:

        ```django
        {{ greeting }}, {{ person|default:"friend" }}!
        ```

        

      - 原模板通过with传递参数

        ```django
        {% include "name_snippet.html" with person="John" greeting="Hello" %}
        ```

        如果只想使用include传递的参数（甚至没有参数，不使用父模板的上下文变量）渲染模板，使用only： 

        ```django
        {% include "name_snippet.html" with greeting="Hi" only %}
        ```

        ​     

### 4、静态文件

​	主要使用 css、javascript和图片文件

​	

1. settings中配置

   ```python
   # staticfiles 只在 DEBUG=True 的情况下有效，生产环境中使用 服务器（如nginx）的静态文件管理
   INSTALLED_APPS = [
       'django.contrib.staticfiles',
   ]
   
   # "/static/" or "http://static.example.com/" 这种url访问的请求都会交给 staticfiles 处理
   STATIC_URL = '/static/'
   
   # 指定静态文件保存的目录，默认是各个子应用下的 static 文件夹
   # 以下是 linux系统， windows下使用： "C:/Users/user/mysite/extra_static_content"
   STATICFILES_DIRS = [
       "/home/special.polls.com/polls/static",
       "/home/polls.com/polls/static",
       "/opt/webfiles/common",
   ]
   ```

   

2. 在子应用下建立目录 static， 存放 静态文件

   

3. 模板文件中

   ```django
   {% load static %}  # 写在模板中第一行
   
   # 图片
   <img src="{% static "images/hi.jpg" %}" alt="Hi!">
   
   # css
   <link rel="stylesheet" href="{% static 'css/mystyle.css' %}" type="text/css" media="screen">
   
   # javascript
   <script type='text/javascript' src='{% static 'js/myjs.js' %}'></script>
   
   # 设置变量
   {% static "images/hi.jpg" as myphoto %}
   <img src="{{ myphoto }}">
   ```

   

4. get_static_prefix 

   在模板中指定 settings 中配置的 STATIC_URL

   ```django
   {% load static %}
   
   <img src="{% get_static_prefix  %}images/hi.jpg" alt="Hi!">
   # 等同于
   <img src="{% static "images/hi.jpg" %}" alt="Hi!">
   ```



### 5、模板继承

​	Django模板引擎中最强大，也是最复杂的部分是模板继承。模板继承允许构建一个基本“骨架”模板，其中包含您网站的所有常见元素，并定义子模板可以覆盖的 blocks
​	如下，定义一个base.html， 如下：

```django
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="style.css" />
    <title>{% block title %}My amazing site{% endblock %}</title>
</head>

<body>
    <div id="sidebar">
        {% block sidebar %}
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/blog/">Blog</a></li>
        </ul>
        {% endblock %}
    </div>
    <div id="content">
        {% block content %}{% endblock %}
    </div>
</body>
</html>

```

上面这个模板中，定义了3个 block ：

- title
- sidebar
- content

block的基本使用方法：{% **block** title %}  {% **endblock** %}

 

​       子页面detail.html继承上面这个base.html，内容如下：

```django
{% extends "base.html" %}

{% block title %}My amazing blog{% endblock %}

{% block content %}
{% for entry in blog_entries %}
    <h2>{{ entry.title }}</h2>
    <p>{{ entry.body }}</p>
{% endfor %}
{% endblock %}

```

​	使用{% extends "base.html" %} 继承 base.html，本页面有2个block，对应base.html的2个block，会在base.html中，使用本detail.html的对应内容进行替换，而block sidebar 并没有对应的block，因此继续使用base.html的 sidebar 的内容



​	继承的技巧：

- 如果在模板中使用，[**{% extends %}**](https://docs.djangoproject.com/en/2.0/ref/templates/builtins/#std:templatetag-extends)必须是该模板中的第一个模板标签。否则模板继承将不起作用。
- 基本模板中的越多[**{% block %}**](https://docs.djangoproject.com/en/2.0/ref/templates/builtins/#std:templatetag-block)标签越好。子模板不必定义所有父块，因此可以在多个块中填写合理的默认值 
- 如果发现自己在多个模板中复制了内容，则可能意味着您应该将该内容移至父模板的 **{% block %}** 中
- 如果需要从父模板中获取块的内容，则使用 {{ block.super }}

```django
{% block sidebar %}
    {{ block.super }}
    新的内容
{% endblock %}

```

- 在使用模板标签语法之外创建的变量不能在块[**{% block% }**](https://docs.djangoproject.com/en/2.0/ref/templates/builtins/#std:templatetag-block)内使用。例如，该模板不会呈现任何内容

```django
{% trans "Title" as title %}
{% block content %}{{ title }}{% endblock %}

```

- 为了增加可读性，您可以选择为您的结束标签 命名。例如：**{% endblock** content **%}**

```django
{% block content %}

{% endblock content %}

```

​        

# admin后台管理

​	Django框架提供了一个自动化后台管理功能，对网站数据的后台维护，仅仅需要进行非常简单的配置和编写极少的代码即可实现。



## 1、配置

settings.py中：

```python
INSTALLED_APPS = [
    'django.contrib.admin',
]
```



如果需要实现后台管理的中文显示，则修改以下配置：

```python
LANGUAGE_CODE = 'zh-Hans'
USE_I18N = True
```



## 2、URL路由

​	urls.py中：

```python
urlpatterns = [
    path('admin/', admin.site.urls),
]
```



## 3、创建管理员账户

​	创建管理员账户之前，确保项目的数据库已经正确连接，并且已经将admin应用的模型进行了迁移

​	另外，如果settings中配置了 AUTH_PASSWORD_VALIDATORS，那么会对用户名和密码进行对应的检测，譬如：不能太简单，不能是纯数字等

​	

1. 项目根目录下 cmd 命令窗口运行以下命令：

```
python manage.py createsuperuser
```

 

2. 输入 用户名 并按回车：

```
Username: admin
```

 

3. 提示 电子邮件地址：

```
Email address: admin@example.com
```

 

4. 最后一步是输入密码，将被要求输入两次密码，第二次作为第一次确认：

```
Password: **********

Password (again): *********

Superuser created successfully.
```



## 4、基本模型管理

### 1、建立模型

​	在model.py中：

```python
class Student(models.Model):

    name = models.CharField(max_length=20)
    age = models.IntegerField()
```



### 2、添加模型管理

​	在admin.py中：

```python
from django.contrib import admin

from .models import Student

admin.site.register(Student)

```



### 3、在浏览器中访问

​	访问path为  /admin， 譬如：<http://127.0.0.1:8000/admin> 



### 4、进一步完善显示

```python
class Student(models.Model):
	
    # 增加 verbose_name
    name = models.CharField(max_length=20, verbose_name='姓名')
    # 增加 help_text
    age = models.IntegerField(help_text='大于18', verbose_name='年龄')

    # 增加 Meta 类
    class Meta:
	    # verbose_name_plural ： 复数形式
        verbose_name_plural = verbose_name = '学生'

    # 模型类的 字符串化
    def __str__(self):
        return f'{self.name}({self.pk})'
```

​	在 子应用下的 apps.py中：

```python
class TestAppConfig(AppConfig):

    verbose_name = '子应用名'
```



### 5、特殊下拉属性管理

```python
class Student(models.Model):
	
    SEX_CHOICES = ((1,'男')), (2, '女')
    
    # 增加 verbose_name
    name = models.CharField(max_length=20, verbose_name='姓名')
    # 增加 help_text
    age = models.IntegerField(help_text='大于18', verbose_name='年龄')
	
    # 修改已有模型，增加新字段的话，都需要设置默认值或者设置 null=True
    sex = models.IntegerField(choices=SEX_CHOICES, default=1， verbose_name='性别')
    
    # 增加 Meta 类
    class Meta:
	    # verbose_name_plural ： 复数形式
        verbose_name_plural = verbose_name = '学生'

    # 模型类的 字符串化
    def __str__(self):
        return f'{self.name}({self.pk})'
```



## 5、关系模型管理

### 1、建立模型

```python
class Place(models.Model):
    name = models.CharField(max_length=50, verbose_name='地名')
    address = models.CharField(max_length=80, verbose_name='门牌')

    def __str__(self):
        return f'{self.name}-{self.address}'

    class Meta:

        verbose_name_plural = verbose_name = '地址'

class Restaurant(models.Model):
    place = models.OneToOneField(
        Place,
        on_delete=models.CASCADE,
        primary_key=True,
        verbose_name='地址'
    )

    name = models.CharField(max_length=50, verbose_name='名字')
    # BooleanField 在数据库使用 tinyint 类型
    serves_hot_dogs = models.BooleanField(default=False, verbose_name='经营热狗')
    serves_pizza = models.BooleanField(default=False, verbose_name='经营披萨')

    def __str__(self):
        return self.name

    class Meta:

        verbose_name_plural = verbose_name = '餐馆'

class Waiter(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, verbose_name='餐馆')
    name = models.CharField(max_length=50, verbose_name='姓名')

    def __str__(self):
        return self.name

    class Meta:

        verbose_name_plural = verbose_name = '服务员'

class SchoolClass(models.Model):
    name = models.CharField(max_length=20, verbose_name='班级名')

    class Meta:

        verbose_name_plural = verbose_name = '班级'

    def __str__(self):
        return self.name

class Teacher(models.Model):
    name = models.CharField(max_length=10, verbose_name='姓名')
    school_class = models.ManyToManyField(SchoolClass, verbose_name='班级')

    class Meta:

        verbose_name_plural = verbose_name = '老师'

    def __str__(self):
        return self.name
```



### 2、添加模型管理

```python
admin.site.register(Place)
admin.site.register(Restaurant)
admin.site.register(Waiter)
admin.site.register(Teacher)
admin.site.register(SchoolClass)
```



## 6、自定义模型管理类

​	之前使用的 admin.site.register(Student) 是用的 Django 默认的管理类，也可以自定义：

```python
class StudentAdmin(admin.ModelAdmin):
    pass

admin.site.register(Student, StudentAdmin)
```



​	自定义管理类的属性：

```python
class StudentAdmin(admin.ModelAdmin):
	
    # 显示的属性列表， 值是 属性名
    list_display = ['name', 'age']
    # 排序的 属性 列表 ， 默认是升序，如果需要降序：['-age']
    ordering = ['age']

admin.site.register(Student, StudentAdmin)
```



​	使用装饰器注册：

```python
# 该装饰器使用的是 admin.register ， 不是 admin.site.register
@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
	
    list_display = ['name', 'age']
    ordering = ['age']
```



​	自定义模型管理类的属性：

```python
@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    
    # 属性为空时，在网页上显示的内容，默认是： -
    empty_value_display = '-empty-'
    # 管理的字段， 和 exclude冲突
    fields = ('name',)
    # 不管理的字段，和 fields冲突
    exclude = ('age',)
```



​	多对多关系，默认是 select多选框，一般使用 filter_horizontal 或者 filter_vertical

```python
@admin.register(Teacher)
class TeacherAdmin(admin.ModelAdmin):

    ordering = ('name', )

    filter_horizontal = ('school_class', )
```



## 7、增加额外批量操作

​	在admin.py中：

1. 动作函数是单独的模块函数：

```python
# 定义动作函数
def age_add_one(modeladmin, request, queryset):
    queryset.update(age=F('age')+1)
# 给动作函数添加描述
age_add_one.short_description = "年龄增加一岁"

class StudentAdmin(admin.ModelAdmin):
    # 在当前自定义管理类中，添加新的动作：age_add_one
    actions = [age_add_one]

admin.site.register(Student, StudentAdmin)
```



2. 动作函数写在自定义管理类中作为一个方法：

```python
class StudentAdmin(admin.ModelAdmin):
    # 这里必须是函数名的字符串
    actions = ['age_add_one']
	
    # 类方法也同样是3个参数！
    def age_add_one(modeladmin, request, queryset):
        queryset.update(age=F('age') + 1)

    age_add_one.short_description = "年龄增加一岁"

admin.site.register(Student, StudentAdmin)
```



## 8、覆盖admin默认模板

​	如果我们要在admin管理页面中，增加自己的功能，那么我们需要覆盖admin的默认模板，通过以下步骤实现：



### 1、admin允许覆盖的页面

- app_index.html
- change_form.html
- change_list.html
- delete_confirmation.html
- object_history.html
- popup_response.html



### 2、admin管理模板目录

​	django库下的 contrib/admin/templates/admin 目录，可以查看django自带的所有模板



### 3、自定义模板

​	需要修改admin的哪个内置模板，则继承哪个模板，并且在其基础上进行修改，我们以app_index.html为例：

​	原始模板是：

```django
{% extends "admin/index.html" %}
{% load i18n %}

{% block bodyclass %}{{ block.super }} app-{{ app_label }}{% endblock %}

{% if not is_popup %}
{% block breadcrumbs %}
<div class="breadcrumbs">
<a href="{% url 'admin:index' %}">{% trans 'Home' %}</a>
&rsaquo;
{% for app in app_list %}
{{ app.name }}
{% endfor %}
</div>
{% endblock %}
{% endif %}

{% block sidebar %}{% endblock %}

```



### 4、建立对应模板

​	在settings中配置的templates目录下，建立admin目录，并且在admin目录下，建立mysite目录（mysite是你的应用名，假设mysite是children，那么目录结构如下图）

![](.\imgs\admin_customize_templates.png)



​	我们不需要修改原始模板所有的block，只需要在我们要添加功能的地方，进行继承，并且修改就行了，如下： 

```python
{% extends "admin/app_index.html" %}

{% block sidebar %}
    <a href="{% url 'children:customize' %}">自定义功能页面</a>
{% endblock %}

```



### 5、修改 urls

```python
path('customize/', views.customize, name='customize'),
```



### 6、修改 views

```python
def customize(request):
    
    """
        编写你自己的自定义管理功能
    :param request: 
    :return: 
    """
    
    return redirect('/admin/children/')

```

# 会话技术

## 1、背景介绍

​	HTTP协议有一个特性就是无状态的，是指协议对于交互性场景没有记忆能力。

​	随着动态交互的web应用的出现，HTTP的无状态特性严重阻碍了动态交互应用程序的发展，例如一些购物网站在进行购物时候都会进行了页面跳转/刷新，按照HTTP的无状态协议岂不是登录一次又一次。于是，两种用于保持http连接状态的技术就应运而生了，这个就是Session和Cookie。



## 2、Cookie简介

​	Cookie，有时也用Cookies，是指web程序为了辨别用户身份、进行 session 跟踪而储存在用户本地终端上的数据（通常经过加密），一般是以键值对的形式存在，Cookie具有不可跨域名性

​	Cookie是http协议中定义在 header 中的字段 

###  1、cookie解决无状态问题原理

Cookie 技术通过在请求和响应报文中写入Cookie 信息来控制客户端的状态。
Cookie 会根据从服务器端发送的响应报文内的一个叫做Set-Cookie的首部字段信息，通知客户端保存Cookie。当下次客户端再往该服务器发送请求时，客户端会自动在请求报文中加入Cookie 值后发送出去。
服务器端发现客户端发送过来的Cookie 后，会去检查究竟是从哪一个客户端发来的连接请求，然后对比服务器上的记录，最后得到之前的状态信息。

- 没有Cookie信息状态下的请求

![preview](.\imgs\v2-85622297a93f493c891ffb90b67fd5e0_r.jpg)

- 第2次以后（存有Cookie信息状态）的请求

![img](.\imgs\v2-1f49734871c5e2da2d264d28ac310a65_720w.png)

### 2、 cookie的常见属性：

- name：cookie的名称

- value：cookie的值

- domain：该cookie的所属域名，具有继承性，只允许本域名及子域名访问

  ​	譬如：test.com 这个是顶级域名， 二级域名 aaa.test.com 就是 test.com 的子域名，三级域名 bbb.aaa.test.com 是 aaa.test.com 的子域名

  ​	如果设置一个 cookie：  user=terry ，domain = aaa.test.com

  ​	那么：  

  ​	aaa.test.com 这个域名下的url都可以访问 该cookie

  ​	bbb.aaa.test.com 下的url也可以访问 该cookie

  ​	但是 test.com 下的url不可以访问该cookie，兄弟域名ccc.test.com 也不可以访问该cookie

- path：该cookie的所属的路径，具有继承性，只允许本路径及子路径域名访问，设置为根路径 path='/' ，则所有路径都可以访问

- expires/Max-Age：expires设置为一个失效时间值，HTTP1.1 中，expires 被弃用并且被Max-Age替代，设置为cookie多久时间之后失效，是整型，表示秒数

  ```python
      response.set_cookie('num',123,max_age=24*3600)
      response.set_cookie('num',123,expires=(datetime.now()+timedelta(hours=1,seconds=30)))
     
  ```

  

- size：cookie的内容大小

- http：httponly属性，默认为False，若此属性为true，则只有在http请求头中会带有此cookie的信息，而不能通过JavaScript（document.cookie）来访问此cookie

- secure：默认为False，设置是否只能通过https来传递此cookie



## 3、django中应用cookie

1. 在django设置cookie

   ```python
   # 只设置key和value两个参数，默认关闭浏览器失效
   response.set_cookie('key', "value")  
   
   # 10秒后失效
   response.set_cookie('key', "value", max_age=10)
   ```

   

2. 在django中读取cookie

   ```python
   request.COOKIES['key']
   # 或
   request.COOKIES.get('key')
   ```

   

3. 签名的cookie

   签名指的就是加密
   
   ```python
   # 设置签名cookie， salt 的内容可以是任意的字符串， 不要泄露
   response.set_signed_cookie('key2', 'value2', salt='test')
   
   # 获取签名cookie， 第二个参数 None是默认值
   request.get_signed_cookie('key2', None, salt='test')
   ```

###    1、cookie实现三天免登录

1. urls.py

   ```python
    path('login_html/',views.login_html,name='login_html'),
    path('dologin/',views.dologin,name='dologin'),
   ```

2. 登录页面

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Document</title>
   </head>
   <body>
       <form action="{%url 'dologin' %}"  method="post">
           {% csrf_token %}
           <p>用户名:<input type="text" name="username" value="{{ username }}"/></p>
           <p>密  码:
             <input type="password" name="password" value="{{pwd}}"/>
           </p>
           <p>
               <input type="checkbox" name="rember" value="rember" {% if username %}checked{%endif%}/>记住密码
               <input type="submit" value="登录"/>
           </p>
       </form>
   </body>
   </html>
   ```

   

3. 处理视图函数

   ```python
   def login_html(request):
       #从cookie中获取用户名和密码
       username = request.COOKIES.get('username')
       password = request.get_signed_cookie('pwd',None,salt='pwdsalt')
       if username and password:
           return render(request,'cookie_app/login.html',{'username':username,'pwd':password})
       else:
           return render(request,'cookie_app/login.html')
   
   def dologin(request):
       #从登录表单中获取用户名和密码及是否勾选了记住密码
       data = request.POST
       username = data.get('username')
       password = data.get('password')
       rember = data.get('rember')
       response = HttpResponse()
       if 'root' == username and '123' == password:
           response.content='登录成功'
           if rember == 'rember':
               #勾选了记住用户名和密码
               #将用户名和密码保存到cookie中
               response.set_cookie('username',username,max_age=3*24*3600)
               response.set_signed_cookie('pwd',password,salt='pwdsalt',max_age=3*24*3600)
           else:
               #删除cookie中的之前保存用户名和密码
               response.delete_cookie('username')
               response.delete_cookie('pwd')
           return response
       else:
           response.delete_cookie('username')
           response.delete_cookie('pwd')
           return redirect('login_html')
   ```

   

## 4、Session简介

​	Session，在计算机中，尤其是在网络应用中，称为“会话控制”。Session 对象存储特定用户会话所需的属性及配置信息。这样，当用户在应用程序的 Web 页之间跳转时，存储在 Session 对象中的变量将不会丢失，而是在整个用户会话中一直存在下去。当用户请求来自应用程序的 Web 页时，如果该用户还没有会话，则 Web 服务器将自动创建一个 Session 对象。当会话过期或被放弃后，服务器将终止该会话 。

​	会话状态仅在支持 cookie 的浏览器中保留!及session是依赖于cookie的。

​	django框架中的session管理允许存储和检索任意数据，它在服务器端存储数据并抽象cookie的发送和接收。Cookie包含session的ID，而不是数据本身（除非使用基于cookie的session管理类型）

### 1、通过Cookie来管理Session

![img](.\imgs\v2-0b02fa4a73a8072eb03cdf78270235e1_720w.png)

## 5、django中应用session

### 1、启用session	

要应用session，必须开启session中间层，在settings中：

```python

MIDDLEWARE = [
    # 启用 Session 中间层
    'django.contrib.sessions.middleware.SessionMiddleware',
]
```

​	

### 2、五种类型的session

​	Django中默认支持Session，其内部提供了5种类型供开发者使用：

- 数据库（默认）
- 缓存
- 文件
- 缓存+数据库
- 加密cookie



​	5种方式的启动配置各异，但是启动完成后，在程序中的使用方式都相同：

1. 数据库方式

   默认的方式，最简单

```python
# 数据库方式（默认）：
SESSION_ENGINE = 'django.contrib.sessions.backends.db'   

# 数据库类型的session引擎需要开启此应用，启用 sessions 应用
INSTALLED_APPS = [
    'django.contrib.sessions',
]
```

2. 缓存

   速度最快，但是由于数据是保存在内存中，所以不是持久性的，服务器重启或者内存满了就会丢失数据

   PS：有其他的方式实现持久性的缓存方式，官网查阅：Memcached缓存后端

```python
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'   
  
```

1. 缓存+数据库

   速度次于单纯缓存方式，但是实现了持久性，每次写入高速缓存也将写入数据库，并且如果数据尚未存在于缓存中，则使用数据库

```python
SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'   

```

4. 文件

```python
SESSION_ENGINE = 'django.contrib.sessions.backends.file' 

# 设置文件位置， 默认是 tempfile.gettempdir()，
# linux下是：/tmp
# windows下是： C:\Users\51508\AppData\Local\Temp
SESSION_FILE_PATH = 'd:\session_dir'
  
```

5. 加密cookie

   基于cookie的session，所有数据都保存在cookie中，一般情况下不建议使用这种方式

   1. cookie有长度限制，4096个字节
   2. cookie不会因为服务端的注销而无效，那么可能造成攻击者使用已经登出的cookie模仿用户继续访问网站
   3. SECRET_KEY这个配置项绝对不能泄露，否则会让攻击者可以远程执行任意代码
   4. cookie过大，会影响用户访问速度

```python
SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'
```

 

### 3、session的参数配置

```python
# Session的cookie保存在浏览器上时的key，即：sessionid＝随机字符串（默认）
SESSION_COOKIE_NAME ＝ "sessionid"  
# Session的cookie保存的路径（默认）
SESSION_COOKIE_PATH ＝ "/" 
# Session的cookie保存的域名（默认）
SESSION_COOKIE_DOMAIN = None
# 是否Https传输cookie（默认）
SESSION_COOKIE_SECURE = False
# 是否Session的cookie只支持http传输（默认）
SESSION_COOKIE_HTTPONLY = True
# Session的cookie失效日期（2周）（默认）
SESSION_COOKIE_AGE = 1209600
# 是否关闭浏览器使得Session过期（默认）
SESSION_EXPIRE_AT_BROWSER_CLOSE = False
# 是否每次请求都保存Session，默认修改之后才保存（默认）
SESSION_SAVE_EVERY_REQUEST = False 
```



### 4、程序中的应用

```python
# 在django程序中通过 request.session 来获取session对象，并且这个session就是一个字典对象，并且 key 只能是 字符串
request.session['has_commented'] = True

# 获取某个session变量
has_commented = request.session.get('has_commented')

# 删除某个key
del request.session['has_commented']
```



### 5、session对象常见方法

```python
# 获取session对象
session = request.session

# 除常见的字典方法外

# 从会话中删除当前会话数据并删除会话cookie
flush()

# 设置测试cookie以确定用户的浏览器是否支持cookie
set_test_cookie()
# 返回True或者False，取决于用户的浏览器是否接受测试cookie
test_cookie_worked()
# 删除测试cookie
delete_test_cookie()

# 设置会话的到期时间
# 如果value是整数，则session将在多少秒不活动后到期
# 如果value是一个datetime或timedelta，该session将在相应的日期/时间到期
# 如果value是0，用户的会话cookie将在用户的Web浏览器关闭时到期
# 如果value是None，则会话将恢复为使用全局会话到期策略
set_expiry(value)

# 返回此会话到期之前的秒数
# kwargs 为 `modification` 和 `expiry`，一般不指定
# modification：最后一次访问日期，默认当前时间， now
# expiry： 到期剩余秒数，默认全局配置时间
get_expiry_age(**kwargs)

# 返回此会话将过期的日期
# 参数同 get_expiry_age
get_expiry_date(**kwargs)

# 返回True或者False，取决于用户的Web浏览器关闭时用户的会话cookie是否会过期
get_expire_at_browser_close()

# 从会话存储中删除过期的会话，这是个类方法。
clear_expired()

# 在保留当前会话数据的同时创建新的会话密钥
cycle_key()
```



### 6、示例代码

​	我们以实现登录来应用session功能（需要使用使用默认的auth应用）：

urls:

```python
urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
]
```



views:

```python
@login_required(login_url='test_app:login')
def index(request):
    return render(request, 'index.html')

def logout(request):
    auth.logout(request)
    return redirect('test_app:login')

def login(request):
    if request.method == 'GET':
        error_message = request.session.get('error_message')
        request.session['error_message'] = None
        return render(request, 'login.html', {'error_message': error_message})
    else:
        username = request.POST['username']
        password = request.POST['password']

        # 从django的authenticate中获取对应的用户名和密码的 ORM 对象
        user = auth.authenticate(username=username, password=password)

        if user:
            # 将登陆的用户写入到session中， 在其它视图函数中用 request.user 获取用户对象
            auth.login(request, user)
            return redirect('test_app:index')
        else:
            request.session['error_message'] = '用户名或密码错误!'
            return redirect('test_app:login')
```



templates:

​	index.html:

```django
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
</head>
<body>
    欢迎 {{ request.user.username  }}  光临
    <br>
    <a href="{% url 'test_app:logout' %}">退出登录</a>
</body>
</html>



```



​	login.html：

```django
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
</head>
<body>
    <form action="{% url 'test_app:login'  %}" method="POST">
        {% csrf_token %}
        用户名：<input type="text" name="username">
        <br>
        密码：<input type="password" name="password">
        <br>
        {% if error_message %}<p><strong>{{ error_message }}</strong></p>{% endif %}
        <br>
        <input type="submit" value="登录" >
    </form>
</body>
</html>
```

# django框架分页器

## 1、概述

​	分页，就是当我们在页面中显示一些信息列表，内容过多，一个页面显示不完，需要分成多个页面进行显示时，使用的技术就是分页技术。

​	在django项目中，一般是使用3种分页的技术：

1. 自定义分页功能，所有的分页功能都是自己实现
2. django的插件 django-pagination 实现
3. django自带的分页器 paginator 



## 2、分页器相关对象

​	分页器的对象在 django/core/paginator.py  模块中，主要包括Paginator类和Page类：

### 1、Paginator类

1. 初始化方法\__init__(self, object_list, per_page, orphans=0,allow_empty_first_page=True)：

   - object_list：可以是QuerySet、带有count()或\__len__()方法的列表、元组或其它可切片的对象，如果是QuerySet，应该进行排序，使用order_by()子句或者有默认的ordering
   - per_page：每个页面上显示的项目数目，不包括orphans部分
   - orphans：默认为0，如果最后一页显示的数目小于等于该数值，那么则将最后一页的内容(假设数为N)添加到倒数第二页中去，这样的话倒数第二页就成了最后一页，显示的数目为：per_page+N
   - allow_empty_first_page：默认为True，允许第一页显示空白内容，如果设置为False，那么当object_list为空时，抛出EmptyPage错误

   

2. 方法

   1. get_page(self, number)

      - numer：指定页码数，正确值应该是大于等于1的整数

      返回指定number的Page对象，同时还处理超出范围和无效页码，如果number不是数字，则返回第一页，如果number为负数或大于最大页数，则返回最后一页。 

      

   2. page(self, number)

      - numer：指定页码数，正确值应该是大于等于1的整数

      返回指定number的Page对象，不处理异常，如果number无效，则抛出 InvalidPage 错误

   

3. 属性

   1. count：项目总条数，调用该属性时，优先调用object_list的count()方法，没有count()方法才尝试len(object_list)方法
   2. num_pages：总页码数
   3. page_range：从1开始的页码迭代器，代码：range(1, self.num_pages + 1)



### 2、Page类

​	一般情况下，不会手动实例化该类，而是通过Paginator的page或者get_page方法获取

1. 初始化方法\__init__(self, object_list, number, paginator):

   - object_list：当页显示的object_list对象，object_list可以是QuerySet、带有count()或\__len__()方法的列表、元组或其它可切片的对象
   - number：页码数
   - paginator：Paginator类的实例

   

2. 方法

   主要的方法都是用来做逻辑判断的，以此来决定页面中显示的诸如：上一页、下一页，首页，末页等

   1. has_next()：如果有下一页则返回True

   2. has_previous()：如果有上一页，则返回True

   3. has_other_pages()：如果有上一页或者下一页，则返回True

   4. next_page_number()：返回下一页编号，如果下一页不存在则引发 InvalidPage 错误

   5. previous_page_number()：返回上一页编号，如果上一页不存在则引发 InvalidPage 错误

   6. start_index() ：返回页面上第一个对象的从1开始的索引，相对于分页器列表中的所有对象。例如，当为每页包含2个对象的5个对象的列表进行分页时，第二个页面Page对象的start_index返回3

   7. end_index() ：返回页面上最后一个对象的从1开始的索引，相对于分页器列表中的所有对象。例如，当为每页包含2个对象的5个对象的列表进行分页时，第二个页面Page对象的end_index返回4

      

3. 属性

   其实就是初始化方法中的3个参数

   1. object_list：对应的object_list
   2. number：该对象的所处的页码数，从1开始
   3. paginator：关联的Paginator实例



## 3、项目中应用

1. 新建django项目：paginator_study，子应用：paginator_app

    

2. 在mysql数据库新建 paginator_study 库

    

3. settings中配置数据库：

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.mysql',
           'NAME': 'paginator_study',
           'USER': 'root',
           'PASSWORD': '123456',
           'HOST': '127.0.0.1',
           'PORT': '3306',
       }
   }
   ```

   

4. 建立模型：

   ```python
   class Student(models.Model):
   
       name = models.CharField(max_length=20)
   
       age = models.IntegerField()
   
       sex = models.IntegerField(choices=((1, '男'), (2, '女')), default=1)
   
       card_no = models.CharField(max_length=18)
   ```

   

5. 迁移数据库

   ```
   python manage.py makemigrations
   
   python manage.py migrate paginator_app
   ```

   

6. 生成测试数据

   model中增加 批量插入测试数据的方法：

   ```python
   @classmethod
   def insert_test_data(cls, num=100):
       def random_str(raw_ite, length):
           return ''.join(random.choices(raw_ite, k=length))
   
       obj_list = []
       for _ in range(num):
           obj_list.append(Student(
               name=random_str(string.ascii_lowercase, 8),
               age=random.randint(18, 50),
               sex=random.choice([1, 2]),
               card_no=random_str(string.digits, 18)
           ))
   
       Student.objects.bulk_create(obj_list)
   
   ```

   然后在 python manage.py shell 中调用该方法

   ```
   python manage.py shell
   
   from paginator_app.models import *
   
   Student.insert_test_data()
   ```

   

7. urls增加路由配置

   ```python
   urlpatterns = [
       path('students/', views.students, name='students')
   ]
   ```

   

8. views中实现函数：

   每页显示的页码数，一般保存在settings中

   ```python
   def students(request):
       page = request.GET.get('page')
       all_students = Student.objects.all()
       paginator = Paginator(all_students, settings.PER_PAGE_NUMBER)
       students_page = paginator.get_page(page)
   
       return render(request, 'paginator_app/students.html', {'students_page':students_page})
   ```

   

9. 增加students.html模板

   ```django
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>学生列表</title>
   </head>
   <body>
       <table>
           <tr>
               <th>序号</th>
               <th>姓名</th>
               <th>年龄</th>
               <th>性别</th>
               <th>身份证</th>
           </tr>
           {% for student in students_page.object_list %}
               <tr>
                   <td>{{ students_page.start_index|add:forloop.counter0 }}</td>
                   <td>{{ student.name }}</td>
                   <td>{{ student.age }}</td>
                   <td>{{ student.get_sex_display }}</td>
                   <td>{{ student.card_no }}</td>
               </tr>
           {% empty %}
               <tr>
                   <td colspan="5">当前没有学生</td>
               </tr>
           {% endfor %}
       </table>
   </body>
   </html>
   ```

   

10. 增加table的样式

   使用css样式文件

   1. students.html页面加载static

      ```python
      {% load static %}
      ```

   2. 新建目录结构如下： paginator_app>>static>>paginator_app>>css>>paginator.css

   3. paginator.css内容如下：

   ```css
   table
   {
       border-collapse: collapse;
       text-align: center;
   }
   
   table td, table th
   {
       border: 1px solid #cad9ea;
       color: #666;
       height: 35px;
   }
   
   table thead th
   {
       background-color: #CCE8EB;
       width: 100px;
   }
   
   table tr:nth-child(odd)
   {
       background: #fff;
   }
   
   table tr:nth-child(even)
   {
       background: #F5FAFA;
   }
   ```

   4. 页面中导入css文件

   ```django
   <link rel="stylesheet" href="{% static 'paginator_app/css/paginator.css' %}">
   ```

   

11. 增加分页栏

    1. 目标中增加：

    ```django
    	{% if students_page.object_list %}
            <nav>
                <ul>
                    <li>
                        <a href="?page=1">
                            <span>首页</span>
                        </a>
                    </li>
                    {% if students_page.has_previous %}
                        <li>
                            <a href="?page={{ students_page.previous_page_number }}">
                                <span>上一页</span>
                            </a>
                        </li>
                    {% endif %}
                    {% for pg in page_range %}
                        {% if pg == students_page.number %}
                            <li><strong>{{ pg }}</strong></li>
                        {% else %}
                            <li><a class="pagination__number" href="?page={{ pg }}">{{ pg }}</a></li>
                        {% endif %}
                    {% endfor %}
                    {% if students_page.has_next %}
                        <li>
                            <a href="?page={{ students_page.next_page_number }}">
                                <span>下一页</span>
                            </a>
                        </li>
                    {% endif %}
                    <li>
                        <a href="?page={{ students_page.paginator.num_pages }}">
                            <span>末页</span>
                        </a>
                    </li>
                </ul>
            </nav>
        {% endif %}
    ```

    2. orphans参数的使用

       在setting.py中添加
       
       ```
       PAGE_ORPHANS = 5
       ```
       
       在视图函数中，创建Paginator时，添加orphans参数
       
       ```python
       paginator = Paginator(students_li, settings.PER_PAGE_NUMBER, orphans=settings.PAGE_ORPHANS)
       ```
       
       可以看到最后一页如果记录条数小于5，则会自动加到倒数第二页中
       
    3. 视图函数中增加：

       为了在模板使用诸如： 1 2 3 4 5 6 7 8 这样的分页栏，需要判断相对于当前页的前后页码数，这种功能的实现，可以在自定义过滤器中实现，也可以在 views中实现后传入一个 变量

    ```python
    # 新增函数
    def get_page_range_by_page_and_max_page(page, max_page, num=10):
        min = page-int(num/2)
        min = min if min > 1 else 1
        max = min + num - 1
        max = max if max < max_page else max_page
    
        return range(min, max + 1)
    
    # 返回值增加
    return render(request, 'paginator_app/students.html',
                      {
                          'students_page': students_page,
                          'page_range': get_page_range_by_page_and_max_page(students_page.number, paginator.num_pages)
                      })
    ```

    

12. 分页栏增加样式

    ```css
    ul,li{ padding:0; margin:0;list-style:none}
    .nav{border:1px solid #000; width:510px; overflow:hidden}
    .nav li{ line-height:22px; float:left; padding:0 5px;}
    .nav li a:hover{ color:#F00}
    nav li{line-height:22px; float:left; padding:0 6px;}
    nav li a{ color:#009900}
    ```

    

13. 可以将分页栏提取到一个模板文件中，成为公共的文件

    新建paginator_common.html

    ```css
    <nav>
        <ul>
            <li>
                <a href="?page=1">
                    <span>首页</span>
                </a>
            </li>
            {% if students_page.has_previous %}
                <li>
                    <a href="?page={{ students_page.previous_page_number }}">
                        <span>上一页</span>
                    </a>
                </li>
            {% endif %}
            {% for pg in page_range %}
                {% if pg == students_page.number %}
                    <li><strong>{{ pg }}</strong></li>
                {% else %}
                    <li><a class="pagination__number" href="?page={{ pg }}">{{ pg }}</a></li>
                {% endif %}
            {% endfor %}
            {% if students_page.has_next %}
                <li>
                    <a href="?page={{ students_page.next_page_number }}">
                        <span>下一页</span>
                    </a>
                </li>
            {% endif %}
            <li>
                <a href="?page={{ students_page.paginator.num_pages }}">
                    <span>末页</span>
                </a>
            </li>
        </ul>
    </nav>
    ```

    在students.html中修改：

    ```django
    {% if students_page.object_list %}
    {% include 'paginator_app/paginator_common.html' %}
    {% endif %}
    ```

    注意事项：在 paginator_common.html 中使用的 students_page和page_range需要统一命名，否则会报错
    
    **运行结果**

![image-20210727114333397](.\imgs\image-20210727114333397.png)

# django项目中使用验证码

## 1、概述

​	验证码（CAPTCHA）是“Completely Automated Public Turing test to tell Computers and Humans Apart”（全自动区分计算机和人类的图灵测试）的缩写，是一种区分用户是计算机还是人的公共全自动程序。可以防止：恶意破解密码、刷票、论坛灌水，有效防止某个黑客对某一个特定注册用户用特定程序暴力破解方式进行不断的登陆尝试等。



## 2、类别

​	当今验证码各种不同的类别很多，常见的如下：

1. 普通型：随机多个（一般是4个）字母、数字和中文的图片，可能加一些干扰项

2. 问答型：图片中显示一个问题，譬如3+3=？

3. 拖动行为型：拖动一个小图片到一个拼图中

   ![](.\imgs\captcha_drag.jpg)

4. 点击行为型：按照顺序点击图片中的特定位置

   ![](.\imgs\captcha_click.jpg)

   

## 3、实现思路

​	大部分的验证码验证的思路都是这样的：

1. 客户端发送获取验证码的请求
2. 服务端接收到验证码请求后，生成对应的验证码和正确答案
3. 服务端将验证码的正确答案保存到会话对象当中
4. 服务端将验证码返回到客户端
5. 客户端看到验证码后：
   - 如果看不清等原因，可以重新获取，那么就重新回到第1步
   - 正确显示后，输入答案，提交答案到服务端
6. 服务端接收到验证码答案后，和保存在会话对象中的正确答案比对，正确就通过验证，失败则返回错误提示



## 4、django项目中实现验证码

​	本文档中以普通的4个字母的验证码作为演示



### 1、实现登录功能(未使用验证码)

​	借用之前 session学习 课程中的部分的登录模块代码

​	

1. 新建django项目：captcha_study，子应用：captcha_app

2. 在mysql数据库新建 captcha_study 库

3. settings中配置数据库：

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.mysql',
           'NAME': 'captcha_study',
           'USER': 'root',
           'PASSWORD': '123456',
           'HOST': '127.0.0.1',
           'PORT': '3306',
       }
   }
   ```

   

4. 迁移数据库

   由于只使用了django自带的应用的数据库模型，所以直接 migrate 就可以

   ```
   python manage.py migrate
   ```

   

5. 创建 superuser

   ```
   python manager.py createsuperuser
   ```

   

6. 修改主应用的urls.py：

   ```python
   path('captcha/', include('captcha_app.urls')),
   ```

   

7. 新增子应用的urls.py

   ```python
   from django.urls import path
   from . import views
   
   app_name = 'captcha_app'
   
   urlpatterns = [
       path('', views.index, name='index'),
       path('login/', views.login, name='login'),
       path('logout/', views.logout, name='logout'),
   ]
   ```

   

8. views中修改：

   ```python
   from django.contrib import auth
   from django.contrib.auth.decorators import login_required
   from django.shortcuts import render, redirect
   
   # Create your views here.
   @login_required(login_url='captcha_app:login')
   def index(request):
       return render(request, 'captcha_app/index.html')
   
   def logout(request):
       # 登出
       auth.logout(request)
       return redirect('captcha_app:login')
   
   def login(request):
       """ 本应用的登录请求
   
           登录请求一般有2个不同的http的method
           get： 显示的就是登录页面
           post： 在登录页面输入用户名和密码之后，点击登录提交
   
       :param request:
       :return:
       """
       # get请求，对一个 登录的页面
       if request.method == 'GET':
           # 通过 session获取 error_message
           error_message = request.session.get('error_message')
           request.session['error_message'] = None
           return render(request, 'captcha_app/login.html', {'error_message':error_message})
       else:
           username = request.POST.get('username')
           password = request.POST.get('password')
   
           # 验证用户名和密码
           user = auth.authenticate(username=username, password=password)
   
           # 用户名和密码正确
           if user:
               # 使用auth应用的话，登录成功必须调用 login 方法
               # 在其他 函数中 使用 request.user 获取 用户对象实例
               auth.login(request, user)
               return redirect('captcha_app:index')
           else:
               # 在不同的 视图函数中传递参数，使用 session
               error_message = '用户名或者密码错误!!'
               request.session['error_message'] = error_message
               return redirect('captcha_app:login')
   ```

   

9. 新增template

   在子应用中建立 templates 文件夹，再建立一个子文件夹：captcha_app

   

​	新增index.html：

```django
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
</head>
<body>
    欢迎光临， 用户：{{ request.user.username }}， email：{{ request.user.email }}
    <a href="{% url 'captcha_app:logout' %}">退出登录</a>
</body>
</html>
```



​	新建login.html：

```django
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
</head>
<body>
    <form method="post" action="{% url 'captcha_app:login' %}">
        {% csrf_token %}
        <table>
            <tr>
                <td>用户名：</td>
                <td><input type="text" value="" name="username" id="username"></td>
            </tr>
            <tr>
                <td>密码：</td>
                <td><input type="password" value="" name="password" id="password"></td>
            </tr>
            {% if error_message %}
            <tr>
                <td colspan="2"><strong>{{ error_message }}</strong></td>
            </tr>
            {% endif %}
            <tr>
                <td colspan="2">
                    <input type="submit" value="登录">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
```



### 2、生成图片

​	需要安装 Pillow 库

```
pip install Pillow
```

​	还需要下载一个字体文件，譬如：ubuntu.ttf

 

新建captcha.py，代码如下：

```python
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter
import random
import string

def random_str(length=4):
    """ 随机字符串 默认长度 4

    :param length: 默认长度 4
    :return:
    """
    return ''.join(random.sample(string.ascii_letters, length))

def random_color(s=1, e=255):
    """ 随机 RGB 颜色

    :param s:  起始值, 0-255
    :param e:  结束时, 0-255
    :return:  (r, g, b)
    """
    return random.randint(s, e), random.randint(s, e), random.randint(s, e)

def veri_code(length=4, width=160, height=40, size=28):
    """ 生成验证码图片

    :param length:  验证码字符串长度
    :param width:  图片宽度
    :param height:  图片高度
    :param size:  字体大小
    :return:  (验证码图片, 验证码字符串)
    """
    # 创建Image对象
    image = Image.new('RGB', (width, height), (255, 255, 255))
    # 创建Font对象
    file = os.path.dirname(os.path.abspath(__file__))
    font = ImageFont.truetype(f'{file}/ubuntu.ttf', size)
    # 创建Draw对象
    draw = ImageDraw.Draw(image)
    # 随机颜色填充每个像素
    for x in range(0, width, 2):
        for y in range(height):
            draw.point((x, y), fill=random_color(64, 255))
    # 验证码
    code = random_str(length)
    # 随机颜色验证码写到图片上
    for t in range(length):
        draw.text((40 * t + 5, 5), code[t], font=font, fill=random_color(32, 127))
    # 模糊滤镜
    image = image.filter(ImageFilter.BLUR)
    return image, code

if __name__ == '__main__':
    img, code = veri_code()
    with open('test.png', 'wb') as f:
        img.save(f)
```



### 3、login.html增加验证码

1. 增加验证码图片标签和输入验证码内容的标签

   ```
   <tr>
       <td>验证码：</td>
       <td>
       	<input type="text" placeholder="请输入验证码" name="check_code">
       	<img src="{% url 'captcha_app:captcha_img' %}">
       </td>
   </tr>
   ```

   

2. urls增加：

   ```python
   path('captcha_img/', views.captcha_img, name='captcha_img'),
   ```

   

3. views中增加：

   ```python
   def captcha_img(request):
       stream = BytesIO()
       img, code = veri_code()
       img.save(stream, 'PNG')
       request.session['check_code'] = code
       return HttpResponse(stream.getvalue())
   ```

   

4. 在图片标签上增加点击刷新的功能

   login.html：

   ```django
   <img src="{% url 'captcha_app:captcha_img' %}" onclick="changeCheckCode(this);">
   
   <script>
       function changeCheckCode(ths){
           <!--改变URL，刷新图片。-->
           ths.src = "{% url 'captcha_app:captcha_img' %}?r=" + Math.random();
       }
   </script>
   ```



### 4、在views中增加验证码效验

修改 login 函数

```python
def login(request):
    """ 本应用的登录请求

        登录请求一般有2个不同的http的method
        get： 显示的就是登录页面
        post： 在登录页面输入用户名和密码之后，点击登录提交

    :param request:
    :return:
    """
    # get请求，对一个 登录的页面
    if request.method == 'GET':
        # 通过 session获取 error_message
        error_message = request.session.get('error_message')
        request.session['error_message'] = None
        return render(request, 'captcha_app/login.html', {'error_message':error_message})
    else:
        check_code = request.POST.get('check_code')

        # 验证码正确
        if check_code and check_code.lower() == request.session.get('check_code').lower():
            username = request.POST.get('username')
            password = request.POST.get('password')

            # 验证用户名和密码
            user = auth.authenticate(username=username, password=password)

            # 用户名和密码正确
            if user:
                # 使用auth应用的话，登录成功必须调用 login 方法
                # 在其他 函数中 使用 request.user 获取 用户对象实例
                auth.login(request, user)
                return redirect('captcha_app:index')
            else:
                # 在不同的 视图函数中传递参数，使用 session
                error_message = '用户名或者密码错误!!'
                request.session['error_message'] = error_message
                return redirect('captcha_app:login')
        # 验证码错误
        else:
            error_message = '验证码错误!'
            request.session['error_message'] = error_message
            return redirect('captcha_app:login')
```

# django中间件

## 1、概述

​	 AOP（Aspect Oriented Programming ），面向切面编程，是对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。可以实现在不修改源代码的情况下给程序动态统一添加功能的一种技术。

​     面向切面编程，就是将交叉业务逻辑封装成切面，利用AOP的功能将切面织入到主业务逻辑中。所谓交叉业务逻辑是指，通用的，与主业务逻辑无关的代码，如安全检查，事物，日志等。若不使用AOP，则会出现代码纠缠，即交叉业务逻辑与主业务逻辑混合在一起。这样，会使业务逻辑变得混杂不清。
举个例子：银行系统取款会有一个流程查询也会有一个流程。

![img](.\imgs\20190527201358371.png)

​	Django的中间件，就是应用AOP技术来实现的，它是django请求/响应处理的钩子框架，是一个轻巧的低级“插件”系统，在不修改django项目原有代码的基础上，可以全局改变django的输入或输出，每个中间件组件负责执行某些特定功能。

​	PS：因为中间件改变的是全局，所以需要谨慎实用，滥用的话，会影响到服务器的性能



## 2、django默认中间件

django项目默认有一些自带的中间件，如下：

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

​	一般情况下这些中间件都会启用（最少CommonMiddleware会启用）



## 3、自定义中间件说明

如果需要增加自定义的中间件（该中间件类必须继承MiddlewareMixin（django.utils.deprecation）），一般是添加在系统的中间件之下，如：

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    
    # 自定义中间件
    'my_app.middleware.MyMiddleware',
]
```

​	

​	中间件中主要有以下方法（一个中间件类最少需要实现下列方法中的一个）：

- process_request：处理请求对象，请求到达django框架时，第一时间调用

  多个中间件之间顺序调用

  参数：request

  返回：

  - response：调用当前中间件的process_response处理
  - None：调用下一个中间件的process_request处理

- process_response：处理响应对象，视图函数返回response后，调用

  多个中间件之间倒序调用

  参数：request, response 

  返回：

  - response：调用上一个中间件的process_response处理

    

- process_view：视图预处理，在视图函数处理之前调用，即请求在urlconf当中匹配到对应的视图函数之后，先不调用视图函数，而是先调用此方法

  多个中间件之间顺序调用

  参数：request，view_func，view_args，view_kwargs

  ​	view_func：url路由匹配到的视图函数， 不是字符串，是函数对象

  ​	view_args：视图函数的可变参数

  ​	view_kwargs：视图函数的可变关键字参数

  返回：

  - response：调用最后一个中间件的process_response开始处理
  - None：调用下一个中间件的process_view处理

- process_exception：在视图函数处理过程抛出异常时调用，中间件的方法(除了process_template_response)中抛出异常不会触发

  多个中间件之间倒序调用

  参数：request，exception

  ​	exception：是处理过程中抛出的异常对象

  返回：

  - response：之后的process_exception都不会触发，而是直接调用最后一个中间件的process_response处理
  - None：调用上一个中间件的process_exception处理

- process_template_response：默认不执行，在视图函数完成操作后调用，除非视图函数返回的response中有render方法

  多个中间件之间倒序调用

  参数：request，response

  ​	response：不是HttpReponse，而是具有render方法的对象，譬如：SimpleTemplateResponse对象，在（django.template.response中）

  返回：

  - response：具有render方法的对象，继续调用上一个中间件的process_template_response处理，最后一个process_template_response处理完成后，会自动调用 response对象中的render方法，得到一个HttpResponse对象，进行返回，再调用process_response操作

  

  ```
  中间件方法的执行时有顺序的，process_request与process_view是按照顺序去执行的，而process_response、process_exception和process_template_response是反序的 ：
  ```

![](.\imgs\image-20210729085034649.png)

​	总结：用户请求 >> process_request >> urlconf路由匹配，找到对应的视图函数 >> process_view >> 视图函数 >> process_template_response（如果视图函数返回的response，有render方法，否则这一步不会执行） >> process_response >> 返回response到用户

​	其中，在 视图函数 和 process_template_response 处理过程中，如果出现 exception ，那么就会倒序执行 中间件的process_exception



## 4、常见自定义中间件功能

总之，你如果有对全局request或response的操作需求，那么就可以使用中间件，譬如：

1. IP过滤：对一些特定IP地址返回特定响应
2. URL过滤：如果用户访问的是login视图，则通过；如果访问其他视图，需要检测是不是有session已经有了就通过，没有就返回login页面。这样就不用在多个视图函数上写装饰器login_required
3. 内容压缩：response内容实现gzip的压缩，返回压缩后的内容给前端
4. CDN：内容分发网络，实现缓存，如果缓存中有数据直接返回，没有找到缓存再去请求视图
5. URL过滤：某个子应用升级暂停使用，某个特定的path路径下的请求，返回一个特定页面



## 5、示例项目

1. 新建django项目：middleware_study，子应用：middleware_app

     

2. urls增加路由配置

   ```python
   urlpatterns = [
       path('', views.index, name='index')
   ]
   ```

   

3. views中实现函数：

   ```python
   def index(request):
       return render(request, 'middleware_app/index.html')
   ```

   

4. 增加index.html模板

   ```django
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>中间件学习的首页</title>
   </head>
   <body>
       欢迎学习中间件！
   </body>
   </html>
   ```

   

5. 新建middleware.py

   ```python
   from django.http import HttpResponse
   from django.template.response import SimpleTemplateResponse
   from django.utils.deprecation import MiddlewareMixin
   
   
   class FirstMiddleware(MiddlewareMixin):
   
       def process_request(self, request):
           print('FirstMiddleware process_request')
   
       def process_response(self, request, response):
           print('FirstMiddleware process_response')
   
           return response
   
       def process_view(self, request, view_func, view_args, view_kwargs):
           print('FirstMiddleware process_view')
   
       def process_exception(self, request, exception):
           print('FirstMiddleware process_exception')
   
       def process_template_response(self, request, response):
           print('FirstMiddleware process_template_response')
   
           return response
   
   class SecondMiddleware(MiddlewareMixin):
   
       def process_request(self, request):
           print('SecondMiddleware process_request')
   
           # 触发当前中间件的 process_response
           # return HttpResponse('SecondMiddleware 测试process_request直接返回response')
   
       def process_response(self, request, response):
           print('SecondMiddleware process_response')
   
           return response
   
       def process_view(self, request, view_func, view_args, view_kwargs):
           print('SecondMiddleware process_view')
   
           # 直接返回HttpResponse， 触发最后一个中间件的 process_response
           # return HttpResponse('SecondMiddleware process_view 返回HttpResponse')
   
           # 在 这里直接返回具有render方法的 response，
           # 依然会触发最后一个中间件的process_template_response方法
           # return SimpleTemplateResponse('middleware_app/test_template_response.html')
   
       def process_exception(self, request, exception):
           print('SecondMiddleware process_exception')
   
           # 捕获异常，直接返回HttpResponse， 触发最后一个中间件的process_response
           return HttpResponse('SecondMiddleware process_exception捕获异常，返回response')
   
       def process_template_response(self, request, response):
           print('SecondMiddleware process_template_response')
   
           # 直接返回HttpResponse，会导致后续抛出异常，因为HttpResponse没有render方法了
           # return HttpResponse('SecondMiddleware process_template_response 返回HttpResponse')
           return response
   
   class ThridMiddleware(MiddlewareMixin):
   
       def process_request(self, request):
           print('ThridMiddleware process_request')
   
       def process_response(self, request, response):
           print('ThridMiddleware process_response')
   
           return response
   
       def process_view(self, request, view_func, view_args, view_kwargs):
           print('ThridMiddleware process_view')
   
       def process_exception(self, request, exception):
           print('ThridMiddleware process_exception')
   
       def process_template_response(self, request, response):
           print('ThridMiddleware process_template_response')
   
           return response
   ```

   

6. settings中导入

   ```python
   MIDDLEWARE = [
       'django.middleware.security.SecurityMiddleware',
       'django.contrib.sessions.middleware.SessionMiddleware',
       'django.middleware.common.CommonMiddleware',
       'django.middleware.csrf.CsrfViewMiddleware',
       'django.contrib.auth.middleware.AuthenticationMiddleware',
       'django.contrib.messages.middleware.MessageMiddleware',
       'django.middleware.clickjacking.XFrameOptionsMiddleware',
   
       'middleware_app.middleware.FirstMiddleware',
       'middleware_app.middleware.SecondMiddleware',
       'middleware_app.middleware.ThridMiddleware',
   ]
   ```

   

7. urls中增加：

   ```python
   urlpatterns = [
       path('', views.index, name='index'),
   ]
   ```
   

   
8. views中增加

   ```python
   from django.http import HttpResponse
   from django.shortcuts import render
   
   # Create your views here.
   from django.template.response import SimpleTemplateResponse
   
   
   class MyTemplateTest:
   
       def render(self):
           return HttpResponse('MyTemplateTest render 内容')
   
   def index(request):
       print('views index function')
   
       # raise Exception('手动抛出异常')
   
       return MyTemplateTest()
       # return SimpleTemplateResponse('middleware_app/index.html')
   
       # 这个render 返回的是一个普通的HttpResponse，该对象没有render方法
       # return render(request, 'middleware_app/index.html')
   ```

## 6、示例-URL过滤

1. setting.py文件中的配置

   ```python
   MIDDLEWARE = [
       'middleware_app.middlewares.UpgradeMiddleware',
   ]
   ```

   

2. 增加upgrade.html模板

   ```django
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <title>升级维护中</title>
   </head>
   <body>
       当前系统正在升级，预计2022年1月1日 0点0分0秒升级完成，到时欢迎使用！
   </body>
   </html>
   ```

   

3. middleware.py

   ```python
   class UpgradeMiddleware(MiddlewareMixin):
   
       def process_request(self, request):
           if request.path.startswith('/middleware/'):
               return render(request, 'middleware_app/upgrade.html')
   ```

   

4. 浏览器中访问

   ```
   http://127.0.0.1:8000/middleware
   ```

   


# Django的生命周期

## 1、Django生命周期的含义

​       Django请求的生命周期是指：当用户在浏览器上输入url到用户看到网页的这个时间段内,Django后台所发生的事情。

## 2、Django生命周期流程图

![img](.\imgs\12367348-65a3d9b4623f7432.png)

​       首先，用户在浏览器中输入url，发送一个GET方法的request请求。Django中封装了socket的WSGi服务器，监听端口接受这个request 请求。

​       再进行初步封装，然后将请求传送到中间件中，这个request请求依次经过中间件，对请求进行校验或处理，再传输到路由系统中进行路由分发，匹配相对应的视图函数(FBV)，

​       再将request请求传输到views中的这个视图函数中，进行业务逻辑的处理，调用modles中表对象，通过orm获取数据库(DB)的数据。

​       通过templates中相应的模板进行渲染，然后将这个封装了模板response响应传输到中间件中，依次进行处理，最后通过WSGi再进行封装处理，响应给浏览器展示给用户。

## 3、生命周期分析

### 1、客户端发送请求

1. 在浏览器输入url，譬如www.baidu.com，浏览器会自动补全协议（http），变为http://www.baidu.com，现在部分网站都实现了HSTS机制，服务器自动从http协议重定向到https协议
2. 在网页中点击超链接或javascript脚本进行url跳转，仅设置 href=‘绝对路径’，浏览器会自动使用当前url的协议、host和port，譬如在 https://tieba.baidu.com/index.html网页中，点击一个超链接 /f?kw=chinajoy ， 会自动访问 https://tieba.baidu.com/f?kw=chinajoy



### 2、路由转发

1. IP查找：因特网内每个公有IP都是唯一的，域名相当于IP的别名，因为我们无法去记住一大堆无意义的IP地址，但如果用一堆有意义的字母组成，大家就能快速访问对应网站
2. DNS解析：通过域名去查找IP，先从本地缓存查找，其中本地的hosts文件也绑定了对应IP，若在本机中无法查到，那么就会去请求本地区域的域名服务器（通常是对应的网络运营商如电信），这个通过网络设置中的LDNS去查找，如果还是没有找到的话，那么就去根域名服务器查找，这里有所有因特网上可访问的域名和IP对应信息（根域名服务器全球共13台）
3. 路由转发：通过网卡、路由器、交换机等设备，实现两个IP地址之间的通信。用到的主要就是路由转发技术，根据路由表去转发报文，还有子网掩码、IP广播等等知识点



### 3、建立连接

​	通过TCP协议的三次握手建立连接

### 4、WSGIHandler处理

​	当django接受到一个请求时，会初始化一个WSGIHandler，可以在项目下的wsgi.py文件进行跟踪查看：

```python
class WSGIHandler(base.BaseHandler):
    request_class = WSGIRequest

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.load_middleware()

    def __call__(self, environ, start_response):
        set_script_prefix(get_script_name(environ))
        signals.request_started.send(sender=self.__class__, environ=environ)
        request = self.request_class(environ)
        response = self.get_response(request)
        
    ......
```

它接受2个参数：

- environ：是含有服务器端的环境变量
- start_response：可调用对象，返回一个可迭代对象。

这个handler控制了从请求到响应的整个过程，首先的就是加载django的settings配置，然后就是调用django的中间件开始操作

### 5、middleware的process_request

​	中间件的process_request方法列表对request对象进行处理

​	

​	django项目默认有一些自带的中间件，如下：

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

​	一般情况下这些中间件都会启用，如果需要增加自定义的中间件（该中间件类必须继承MiddlewareMixin），一般是添加在系统的中间件之下，如：

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    
    # 自定义中间层
    'my_app.middleware.MyMiddleware',
]
```

​	

​	中间件中主要有以下方法（一个中间件类最少需要实现下列方法中的一个）：

- process_request：处理请求对象

  参数：request

  返回：

  - response：调用process_response列表处理
  - None：调用下一个中间件的process_request处理

- process_response：处理响应对象

  参数：request, response 

  返回：

  - response：调用上一个中间件的process_response处理

    

- process_view：视图预处理，在视图函数处理之前调用

  参数：request，view_func，view_args，view_kwargs

  ​	view_func：url路由匹配到的视图函数

  ​	view_args：视图函数的可变参数

  ​	view_kwargs：视图函数的可变关键字参数

  返回：

  - response：调用process_response处理
  - None：调用下一个中间件的process_view处理

- process_exception：在视图函数或中间件处理过程抛出异常时调用

  参数：request，exception

  ​	exception：是处理过程中抛出的异常对象

  返回：

  - response：之后的process_exception都不会触发，而是调用process_response处理
  - None：调用上一个中间件的process_exception处理

- process_template_response：在视图函数完成操作后调用，默认不执行，除非视图函数返回的response中有render方法

  参数：request，response

  ​	response：不是HttpReponse，而是SimpleTemplateResponse对象，具有render方法

  返回：

  - response：SimpleTemplateResponse对象，调用上一个中间件的process_template_response处理，最后一个process_template_response处理完成后，会自动调用 response对象中的render方法，得到一个HttpResponse对象，进行返回，再调用process_response操作

  

  	中间件方法的执行时有顺序的，process_request与process_view是按照顺序去执行的，而process_response、process_exception和process_template_response是反序的 ：

![](.\imgs\django_middleware2.jpg)

​	



### 6、URLConf路由匹配

​	通过urls.py文件中的 urlpatterns 配置找到对应的 视图函数或者视图类的方法，如果没有找到匹配的方法，那么就会触发异常，由中间件的process_exception 进行处理



### 7、middleware的process_view

​	调用中间件的 process_view 方法进行预处理



### 8、views处理request

​	调用对应的视图函数或视图类的方法处理request，譬如获取GET和POST参数，并且调用特定的模型对象执行数据库操作，如果没有数据库操作，那么就直接跳到我们后续的14步了



### 9、models处理

​	视图方法中，一般情况下都需要调用模型类进行数据操作，一般是通过模型的manager管理类进行操作的，如：MyModel.objects.get(pk=1)

​	如果没有数据操作，那么这一步和下一步就忽略



### 10、数据库操作

​	如果django通过模型类执行对数据库的增删改查，那么此时整个流程就会在对应的数据库中执行



### 11、views处理数据

​	视图方法获取到数据后：

- 将数据封装到一个context字典当中，然后调用指定的template.html，通过模板中的变量、标签和过滤器等，再结合传入的数据context，会触发中间件的process_template_response方法，最终渲染成HttpResponse
- 不调用模板，直接返回数据，譬如 JsonResponse、FileResponse等
- 执行redirect，生成一个重定向的HttpResponse，触发中间件的process_response后，返回到客户端，结束该web请求的生命周期



### 12、middleware的process_response

​	调用中间件的 process_response 方法进行处理，最后一个中间件的process_response执行完成后，返回到WSGIHandler类中

​	至此，django编程的处理部分完毕



### 14、WSGIHandler处理

​	WSGIHandler类获取到response后

- 先处理response的响应行和响应头，然后调用 start_response 返回http协议的 响应行和响应头 到uWSGI，这个 start_response 只能调用一次

- 第一步处理完成后，如果是文件需要对response进行，否则就直接将response作为http协议的body部分返回给uWSGI

  

### 15、客户端接收响应

​	客户端接收到服务器的响应后，做对应的操作，譬如：显示在浏览器中，或是javascript的处理等

​	至此，整个web请求的生命周期结束。

​	


# django日志

## 1、概述

​	django框架的日志通过python内置的logging模块实现的，日记可以记录自定义的一些信息描述，也可以记录系统运行中的一些对象数据，还可以记录包括堆栈跟踪、错误代码之类的详细信息

​	logging主要由4部分组成：Loggers、Handlers、Filters和Formatters



## 2、settings中完整的配置

```python
LOGGING = {
    # 固定值
    'version'：1,
    # 格式器，详细见第6点
    'formatters': {},
    # 过滤器，详细见第5点
    'filters'：{},
    # 处理器，详细见第4点
    'handlers':{},
    # 记录器，详细见第3点
    'loggers':{},
    # 根记录器，配置等同普通记录器，但是没有propagate配置项
    'root':{},
    # 默认为False。True：是将配置解释为现有配置的增量。False：配置会覆盖已有默认配置
    'incremental':True,
    # 默认为True。禁用任何现有的非root记录器。如果设置了incremental=True，则此配置无效
    'disable_existing_loggers': False
}
```



## 3、Loggers

​	这个类是logging系统的入口

​	python定义了日志的5个级别，分别对应python程序中日志信息的不同严重性（严重程度从上到下越来越严重，也就是级别越高）：

- DEBUG：用于调试的最低级的系统信息
- INFO：一般性的系统信息
- WARNING：一些警告性的信息，发生了一些小问题，这些问题不影响系统的正常运行，但是也不建议出现
- ERROR：系统出现错误了，该错误会影响系统的正常运行，记录错误相关的信息
- CRITICAL：非常严重的问题，譬如可能引起系统崩溃的问题等



​	在使用logger记录日志时，每条日志消息还有日志级别，当logger记录该日志消息时，会将消息的级别和logger配置的日志级别进行比较，只有消息的级别达到或超过logger配置的日志级别，才会将该日志消息传递给handler进一步处理，否则该日志消息会被忽略

​	PS：一般开发环境时，会启用DEBUG级别，而在生产环境中，启用WARNING或ERROR级别



### 1.settings中配置

通过在settings中配置LOGGING配置项实现日志配置，共4个配置项（都是可选的，不过一般会指定handler）：

- level：指定记录日志的级别，没有配置则处理所有级别的日志
- propagate：设置该记录器的日志是否传播到父记录器，不设置则是True
- filters：指定过滤器列表
- handlers：指定处理器列表



示例如下：

```python
LOGGING = {
    'version': 1,  # 固定值，现在只有这一个版本
    'disable_existing_loggers': False, # 设置已存在的logger不失效
    'loggers': {
        '': {
            'handlers': ['console'],
        },
        'django': {
            'handlers': ['console'],
            'propagate': True,
        },
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': False,
        },
        'myproject.custom': {
            'handlers': ['console', 'mail_admins'],
            'level': 'INFO',
            'filters': ['special']
        }
    }
}
```

说明：

配置了4个 logger， 分别对应2个不同的handler（console输出日志到控制台，mail_admins输出日志到邮件）

- ''：默认的记录器，不指定特定名称，那么就是使用这个记录器，没有配置level，那么就是处理所有级别的日志，传递所有级别的日志到console控制器
- django：传递所有级别的日志到console控制器
- django.request：django记录器的子记录器，处理ERROR级别及以上的日志，propagate设置为 False，表明不传播日志给 "django"，该logger传递日志到mail_admins控制器
- myproject.custom：处理INFO级别及以上的日志，应用了一个 special 的过滤器来过滤日志，传递日志到2个控制器（['console', 'mail_admins']）处理



​	django框架有个默认的配置：DEFAULT_LOGGING，一旦配置了自己的LOGGING后，那么所有的默认的LOGGER全部都失效，失效不等于没有记录器了，而是说记录器不起作用了，即不会记录日志，也不会将日志传播给父记录器。因此你应该非常小心使用，因为你会感觉你丢了日志一样，可以手动设置同名的logger实现覆盖，如：

```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': '/path/to/django/debug.log',
        },
    },
    'loggers': {
        #  覆盖了 django 记录器，所有django的记录日志最后全部写入到文件中
        'django': {
            'handlers': ['file'],
            'level': 'DEBUG',
            'propagate': True,
        },
    },
}
```



​	disable_existing_loggers默认是True，除非设置disable_existing_loggers为False，那么默认配置的记录器才会起作用

```python
LOGGING = {
    'disable_existing_loggers': False,
}
```



​	配置还可以使用系统变量，如下示例中读取 DJANGO_LOG_LEVEL  环境变量：

```python
import os

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': os.getenv('DJANGO_LOG_LEVEL', 'INFO'),
        },
    },
}
```

​	



### 2.logger的简单使用

在诸如views.py中：

```python
import logging

# 生成一个以当前文件名为名字的logger实例
logger = logging.getLogger(__name__)
# __name__ 也可以换成在settings中配置的 logger 名称，生成指定的logger
logger_custom = logging.getLogger('myproject.custom')

def index(request):
    logger.debug("进入index视图函数")
    logger_custom.debug("进入index视图函数")
```

- getLogger(\__name__)：记录器名使用模块名，这是基于每个模块过滤和处理日志记录调用，对应默认记录器，即名称为 '' 的

- getLogger('myproject.custom')：通过 "." 符号分隔的方式，定义记录器名称的层次结构，'myproject' 是跟记录器， 'myproject.custom'是子记录器，甚至 'myproject.custom.child' 是孙辈的记录器。使用层次结构的作用是因为子记录器是可以传播日志记录给父记录器的，最终传播到根记录器。默认就是传播的，如果不想传播，那么需要在logger的配置中使用'propagate': False

  

### 3.常用方法

Logger.debug(msg)、Logger.info(msg)、Logger.warning(msg)、Logger.error(msg)、Logger.critical(msg) ，分别对应5个不同的日志级别

Logger.log(level,  msg) 记录日志，手动指定level，level的选择是CRITICAL = 50，ERROR = 40，WARNING = 30，INFO = 20，DEBUG = 10，需要填写数字，譬如 50或logging.DEBUG

Logger.exception()：等同于Logger.error(msg, exc_info=True)，输出异常的堆栈信息



### 4.不常用方法

Logger.setLevel(lel):指定最低的日志级别，低于lel的级别将被忽略。debug是最低的内置级别，critical为最高 

Logger.addFilter(filt)、Logger.removeFilter(filt):添加或删除指定的filter Logger.addHandler(hdlr)、Logger.removeHandler(hdlr)：增加或删除指定的handler 



### 5.django内置logger

​	内置的logger在django项目运行中会自动记录日志，与我们手动创建的logger的执行没有关系，除非我们也创建相同的logger

​	django框架调用的地方在：django.core.servers.basehttp中（如WSGIRequestHandler）

- django：django框架中所有消息的记录器，一般使用它的子记录器，而不是它发布消息，因为默认情况下子记录器的日志会传播到根记录器django，除非设置 'propagate': False

- django.request：记录与请求处理相关的消息。5XX响应作为ERROR消息; 4XX响应作为WARNING消息引发。记录到django.security记录器的请求不会记录到django.request中

  发送给此记录器的消息具有以下额外上下文： 

  - status_code：与请求关联的HTTP响应代码
  - request：生成日志消息的请求对象。

- django.server：记录与runserver命令调用的服务器接收的请求的处理相关的消息。5XX响应记录为ERROR 消息，4XX响应记录为WARNING消息，其他所有响应记录为INFO。

  发送给此记录器的消息具有以下额外上下文：

  - status_code：与请求关联的HTTP响应代码。
  - request：生成日志消息的请求对象。

- django.template：记录与模板呈现相关的消息 

- django.db.backends：记录代码和数据库交互相关的消息，例如，请求执行的每个SQL语句都会记录为DEBUG级别的日志。这个记录器只有在settings.DEBUG设置为True时才启用，并且不记录事务管理（如：BEGIN, COMMIT, 和 ROLLBACK）

  发送给此记录器的消息具有以下额外上下文：

  - duration：执行SQL语句所花费的时间。
  - sql：已执行的SQL语句。
  - params：SQL调用中使用的参数

- django.security.*：记录任何SuspiciousOperation和其他安全相关错误（django.security.csrf ）的消息，SuspiciousOperation子类型有：

  DisallowedHost
  DisallowedModelAdminLookup
  DisallowedModelAdminToField
  DisallowedRedirect
  InvalidSessionKey
  RequestDataTooBig
  SuspiciousFileOperation
  SuspiciousMultipartForm
  SuspiciousSession
  TooManyFieldsSent

  使用如：django.security.DisallowedHost

- django.db.backends.schema:记录数据库迁移过程中的日志，但是不记录执行的查询SQL语句等，发送给此记录器的消息具有以下额外上下文：

  - sql：已执行的SQL语句。
  - params：SQL调用中使用的参数



## 4、Handlers

​	这个类是确定logger中消息发生的引擎程序，描述特定的日志记录行为，譬如控制台打印、写入日志文件、通过网络进行发送等

​	与logger一样，handler也具有日志级别，如果日志记录的日志级别未达到或超过handler的级别，则handler将忽略该消息。 

​	一个logger可以有多个handler，每个handler可以有不同的日志级别和记录方法



### 1.settings中配置

4个参数（如下），加上对应class类的初始化参数

- class（必需）：处理程序类的名称
- level（可选的）：处理程序的级别
- formatter（可选的）：处理程序的格式化程序
- filters（可选的）：处理程序的过滤器的列表

```python
LOGGING = {
    'handlers': {
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
            'formatter': 'simple',
        },
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler',
            'filters': ['special']
        }
    },
}
```

说明：

配置了2个handler，使用了2个filter：require_debug_true和special， 使用了1个formatter：simple

- console：使用logging.StreamHandler，记录INFO级别及以上的日志到sys.stderr，使用simple格式化输出内容
- mail_admins：使用django.utils.log.AdminEmailHandler，将ERROR及以上的日志通过special过滤器过滤后，发送邮件到管理员邮箱（需要配置settings中的一些其他的信息，譬如ADMINS等）



### 2.不常用方法

Handler.setLevel(level):指定被处理的信息级别，低于level级别的信息将被忽略   

Handler.setFormatter(fmt)：给这个handler选择一个格式fmt         

Handler.addFilter(filt)、Handler.removeFilter(filt)：新增或删除一个filter对象 



### 3.内置处理器

1. python3的logging中的handler：

   - StreamHandler：输出到stream，未指定则使用sys.stderr输出到控制台

   - FileHandler：继承自StreamHandler，输出到文件，默认情况下，文件无限增长 

     初始化参数：filename，mode ='a'，encoding = None，delay = False

     delay如果为True，那么会延迟到第一次调用emit写入数据时才打开文件

     配置：

     ```python
     'handlers': {
             'file': {
                 'level': 'DEBUG',
                 'class': 'logging.FileHandler',
                 'filename': '/path/to/django/app.log', #参数配置在这里，多个参数按顺序继续配置即可， 如果要添加encoding，那么在下面添加 encoding: 'utf-8' 即可
             },
         }
     ```

     

   - NullHandler：没有任何输出，避免出现错误：No handlers could be found for logger XXX

   - WatchedFileHandler：自动重开log文件，配合别的会自动切分的log文件使用

   - RotatingFileHandler：自动按大小切分的log文件

     初始化参数：filename，mode ='a'，maxBytes = 0，backupCount = 0，encoding = None，delay = False

     maxBytes：最大字节数，超过时创建新的日志文件，如果backupCount或maxBytes有一个为0，那么就一直使用一个文件

     backupCount：最大文件个数，新文件的扩展名是指定的文件后加序号".1"等，譬如：backupCount=5，基础文件名为：app.log，那么达到指定maxBytes之后，会关闭文件app.log，将app.log重命名为app.log.1，如果app.log.1存在，那么就顺推，先将 app.log.1重命名为app.log.2，再将现在的app.log命名为app.log.1，最大创建到app.log.5(旧的app.log.5会被删除)，然后重新创建app.log文件进行日志写入，也就是永远只会对app.log文件进行写入。

     

   - TimedRotatingFileHandler：按时间自动切分的log文件，文件后缀 %Y-%m-%d_%H-%M-%S 

     初始化参数：filename, when='h', interval=1, backupCount=0, encoding=None, delay=False, utc=False, atTime=None

     when：时间间隔类型，不区分大小写

     ```
     'S'：秒
     'M'：分钟
     'H'：小时
     'D'：天
     'W0'-'W6'：星期几（0 = 星期一）
     'midnight'：如果atTime未指定，则在 0点0分0秒 翻转，否则在atTime时间翻转
     ```

     interval：间隔的数值

     backupCount： 文件个数

     encoding：编码

     delay：True是写入文件时才打开文件，默认False，实例化时即打开文件

     utc：False则使用当地时间，True则使用UTC时间

     atTime：必须是datetime.time实例，指定文件第一次切分的时间，when设置为S,M,H,D时，该设置会被忽略

     

   - SocketHandler：通过TCP套接字发送日志记录消息

     初始化参数：host, port

   - DatagramHandler：通过UDP套接字发送日志记录消息 

   - SysLogHandler ：发送记录消息到远程或本地Unix系统日志 

   - NTEventLogHandler：发送日志消息到本地的Windows NT，Windows 2000或Windows XP事件日志 

   - SMTPHandler：通过email发送日志记录消息

     初始化参数：mailhost, fromaddr, toaddrs, subject, credentials=None, secure=None, timeout=5.0

     mailhost：发件人邮箱服务器地址（默认25端口）或地址和指定端口的元组，如：('smtp.163.com', 25)

     fromaddr：发件人邮箱

     toaddrs：收件人邮箱列表

     subject：邮件标题

     credentials：如果邮箱服务器需要登录，则传递(username, password)元组

     secure：使用TLS加密协议

   - MemoryHandler ：在内存中的日志记录缓冲，定期将其发送到目标处理程序，只要缓冲区已满，或者发生某个严重程度或更高的事件，就会发生发送

   - HTTPHandler：发送记录消息到Web服务器，使用GET或POST 

   - QueueHandler：发送记录消息到队列中，适合多进程（multiprocessing）场景

   - QueueListener：从队列中接收消息，适合多进程（multiprocessing）场景，用于和QueueHandler搭配

     

2. django内置的handler：

   - AdminEmailHandler：会将收到的每一条日志消息发送一个邮件到ADMINS指定的邮箱地址

     必须settings中设置 DEBUG=False 才起作用

     示例配置：

     ```python
     DEBUG=False
     
     EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
     EMAIL_HOST = 'smtp.qq.com'  # smtp地址
     EMAIL_PORT = 25
     EMAIL_HOST_USER = 'xxxx@qq.com'  # smtp 服务器的用户名
     EMAIL_HOST_PASSWORD = 'xxxxxxxx'  # smtp服务器的密码
     SERVER_EMAIL = 'xxxx@qq.com'
     ADMINS = [('Terry', 'xxxx@qq.com')]
     ```

     ADMINS默认是[]，示例配置：[('John', 'john@example.com'), ('Mary', 'mary@example.com')]

     如果日志记录包含request属性，则请求的完整详细信息将包含在电子邮件中。

     如果客户端的IP地址在INTERNAL_IPS设置中，则电子邮件主题将包含短语“内部IP” ; 如果没有，它将包括“外部IP”。

     如果日志记录包含堆栈跟踪信息，则该堆栈跟踪将包含在电子邮件中。

     

     初始化参数：include_html=False, email_backend=None

     include_html：该值设置为True，并且settings中设置DEBUG=True时，则会在邮件中包括含有调试网页的全部内容的HTML附件，该附件包含完整的回溯，包含堆栈每个级别的局部变量的名称和值，以及Django设置的值，会比较敏感，谨慎使用

     email_backend：指定邮件后台，没设置使用django默认的

     

     简单配置如下：

     ```python
     'handlers': {
         'mail_admins': {
             'level': 'ERROR',
             'class': 'django.utils.log.AdminEmailHandler',
         }
     },
     ```

     覆盖django默认的邮件后台，配置：

     ```python
     'handlers': {
         'mail_admins': {
             'level': 'ERROR',
             'class': 'django.utils.log.AdminEmailHandler',
             'email_backend': 'django.core.mail.backends.filebased.EmailBackend',
             'include_html': True # 信息中包含html页面
         }
     },
     ```



### 4.自定义处理器

​	任意自定义的class，继承自logging.Handler，并且实现emit和flush方法（如下logging内置的StreamHandler类）：

```python
from logging import Handler

class StreamHandler(Handler):
    
    terminator = '\n'
    
    def __init__(self, stream=None):
        Handler.__init__(self)
        if stream is None:
            stream = sys.stderr
        self.stream = stream

    def flush(self):
        self.acquire()
        try:
            if self.stream and hasattr(self.stream, "flush"):
                self.stream.flush()
        finally:
            self.release()

    def emit(self, record):
        try:
            msg = self.format(record)
            stream = self.stream
            stream.write(msg)
            stream.write(self.terminator)
            self.flush()
        except Exception:
            self.handleError(record)

```



## 5、Filters

​	过滤器filter用于提供对日志记录从logger传递到handler的附加控制

​	默认情况下，logger和handler将处理满足日志级别要求的任何日志消息，但是，通过安装filter，可以在日志记录过程中添加其他条件。例如，可以安装仅允许ERROR级别 来自特定源的消息的filter。

​	filter还可用于在发出之前修改日志记录。例如，如果满足一组特定条件，可以编写一个过滤器，将ERROR日志记录降级为WARNING记录。

​	filter可以安装在logger或handler上; 可以在链中使用多个filter来执行多个过滤操作。



### 1.settings中配置

```python
LOGGING = {
    'filters': {
        'special': {
            '()': 'project.logging.SpecialFilter',
            'foo': 'bar',
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
}
```

说明：

配置了2个过滤器

- special：使用自定义的SpecialFilter类，传入初始化参数 foo='bar'

- require_debug_true：使用类：RequireDebugTrue

  

### 2.内置过滤器

1. python内置的过滤器：

   日志过滤器的父类：Filter，一般不直接使用

   

2. django内置的过滤器：

   - CallbackFilter：

     初始化参数：callback

     callback：为每个记录调用callback，如果callback返回True，则允许日志通过，如果callback返回False，则不允许该日志通过

     示例：

     ```python
     # callback函数：
     def skip_unreadable_post(record):
         if record.exc_info:
             exc_type, exc_value = record.exc_info[:2]
             if isinstance(exc_value, UnreadablePostError):
                 return False
         return True
     
     # filter配置：
     'filters': {
         'skip_unreadable_posts': {
             '()': 'django.utils.log.CallbackFilter',
             'callback': skip_unreadable_post,
         }
     },
     ```

     

   - RequireDebugFalse：仅在settings.DEBUG为False时传递记录 

     ```python
     'filters': {
         'require_debug_false': {
             '()': 'django.utils.log.RequireDebugFalse',
         }
     }
     ```

     

   - RequireDebugTrue：仅在settings.DEBUG为True时传递记录 



### 3.自定义过滤器

​	1.  在子应用下创建一个py文件，自定义class，继承自logging.Filter，并且实现filter方法（如下django内置的RequireDebugFalse类）

```python
class RequireDebugFalse(logging.Filter):
    def filter(self, record):
        return not settings.DEBUG
    
class ExistWordFilter(logging.Filter):

    def __init__(self, name='', exist_word=None):
        super().__init__(name)
        self.exist_word = exist_word

    def filter(self, record):
        if not self.exist_word or self.exist_word in record.msg:
            return True
        else:
            return False
```

2. setting中配置过滤

   ```python
   'filters': {
           'require_debug_true': {
               '()': 'django.utils.log.RequireDebugTrue',
           },
           'require_debug_false': {
               '()': 'django.utils.log.RequireDebugFalse',
           },
           'exist_word_filter': {
               '()': 'logger_app.log.ExistWorFilter',
               'exist_word':'测试'
           },
       },
       'handlers': {
           'console': {
               'level': 'DEBUG',
               'filters': ['require_debug_true','exist_word_filter'],
               'class': 'logging.StreamHandler',
               'formatter': 'simple'
           },
   ```

   

3. 视图函数

   ```python
   from django.http.response import HttpResponse
   from django.shortcuts import render
   
   # 这是views视图模块
   import logging
   
   # 这个 logger 只会在控制台输出 warning及以上的日志
   logger = logging.getLogger('logger_study.file')
   # 这个logger 会输出 info及以上的日志
   # logger_server = logging.getLogger('django.server')
   
   def logger_test(request):
       logger.debug('logger debug 测试')
       logger.info('logger info 测试')
       logger.warning('logger warning')
       logger.error('logger error')
   
   
       return HttpResponse('日志测试响应成功')
   ```

   

4. 运行结果

   控制台输出

   ```
   [DEBUG][2021-08-02 13:45:03,896] logger debug 测试
   [INFO][2021-08-02 13:45:03,896] logger info 测试
   ```

   只有信息中包含“测试”的日志信息才在控制台输出。

## 6、Formatters

​	日志记录最终需要呈现为文本，formatter程序描述该文本的确切格式。formatter通常由包含LogRecord属性的Python格式化字符串组成 ; 但是，也可以编写自定义formatter来实现特定的格式化行为。



### 1.settings中配置：

3个参数（具体看后面的Formatter类）：

- ()：指定格式器的类，不指定的话，默认使用logging.Formatter
- format：格式化字符串
- style：样式选择
- datefmt：日期格式化字符串，使用的是python中时间日期格式化符号 

```python
LOGGING = {
	'formatters': {
        'verbose': {
            '()': 'logging.Formatter',
            'format': '{levelname} {asctime} {module} {process:d} {thread:d} {message}',
            'style': '{',
        },
        'simple': {
            'format': '{levelname} {message}',
            'style': '{',
        },
    }
}
```

说明：

配置了2个格式器：

- simple：只输出简单的：日志级别名称 日志消息
- verbose：输出：日志级别名称 生成日志消息的时间 模块 进程 线程 日志消息



### 2.内置格式器

1. python内置的格式器

   - Formatter：默认格式器

     初始化参数：fmt=None, datefmt=None, style='%'

     - fmt：格式化字符串，指定输出格式，如：'{levelname}{process:d}{message}'

     ```
     	%(name)s：记录器logger的名称
         %(levelno)s：日志级别对应的数字
         %(levelname)s：日志级别名称
         %(pathname)s：日志记录调用的源文件的完整路径
         %(filename)s：日志记录调用的源文件名
         %(module)s：模块名
         %(lineno)d：日志调用的行数
         %(funcName)s：函数名
         %(created)f：日志创建时间，time.time()
         %(asctime)s：日志创建时间，文本类型
         %(msecs)d：日志创建时间的毫秒部分
         %(relativeCreated)d：日志创建时间 - 加载日志模块的时间 的 毫秒数
         %(thread)d：线程ID
         %(threadName)s：线程名
         %(process)d：进程ID
         %(processName)s：进程名
         %(message)s：日志消息
     ```

     - datefmt：日期格式化字符串，为None则使用ISO8601格式化，如：'2010-01-01 08:03:26,870'

     - style：'%'，'{' 或 '$'，3选一：

       - '%'：默认是这个，使用python的 % 格式化 ，  如： %(levelname)s
       - '{'：使用 str.format格式化（django框架使用这个）， 如：{levelname}
       - '$'：使用类 string.Template 格式化，如：\$levelname

       

   - BufferingFormatter：一种适于格式化批量记录的格式器，对每条记录都使用指定的格式器进行格式化

     初始化参数：linefmt=None

     linefmt：指定格式器，设置为None使用上述的默认Formatter

   

2. django内置的格式器

   - ServerFormatter：根据status_code不同，将日志消息格化式成不同的颜色的消息

     



## 7、logging.LogRecord对象

​	每次logger记录日志时，都会自动创建该LogRecord实例 

1. 初始化参数：name，level，pathname，lineno，msg，args，exc_info，func = None，sinfo = None

说明：

- name - 用于记录此LogRecord表示的事件的记录器的名称
- level - 日志记录事件的数字级别（DEBUG是10，INFO是20，以此类推），并将转换为LogRecord的两个属性： 对于数值levelno和对应的级别名称levelname
- pathname - 进行日志记录调用的源文件的完整路径名
- lineno - 进行日志记录调用的源文件中的行号
- msg - 事件描述消息，可能是带有可变数据占位符的格式字符串
- args - 要合并到msg参数中以获取事件描述的可变数据
- exc_info - 包含当前异常信息的异常元组，或者None（没有可用的异常信息）
- func - 调用日志记录调用的函数或方法的名称
- sinfo - 表示当前线程中堆栈基础的堆栈信息的文本字符串，直到日志记录调用



2. 方法

   - getMessage：返回用户提供的参数与消息合并后的消息

     

3. 属性

   首先是第6点Formatters中内置格式器Formatters类的 fmt 属性中，描述的类似：%(name)s 中的 name 就是 该对象的属性

   其他属性如下：

   - args：元组或字典（只有一个参数是），用于合并日志消息
   - exc_info：异常元组（类似：sys.exc_info），没有异常则是None
   - msg：日志记录调用中传递的格式字符串，可以合并args生成日志消息
   - stack_info：在当前线程中从堆栈底部堆栈帧信息（如果有的话），直到并包括记录调用的堆栈帧





## 8、项目中应用日志

### 1、默认配置

​	不进行额外的配置，直接在项目中使用logger，则会使用django.utils.log的默认配置DEFAULT_LOGGING，默认的情况如下：

```python
DEFAULT_LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse',
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'formatters': {
        'django.server': {
            '()': 'django.utils.log.ServerFormatter',
            'format': '[{server_time}] {message}',
            'style': '{',
        }
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
        },
        'django.server': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'django.server',
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django': {
            'handlers': ['console', 'mail_admins'],
            'level': 'INFO',
        },
        'django.server': {
            'handlers': ['django.server'],
            'level': 'INFO',
            'propagate': False,
        },
    }
}
```

- 如果设置DEBUG=True，那么会将除django.server以外的INFO及以上的日志输出到控制台

- 如果设置DEBUG=False，那么会将除django.server以外的ERROR和CRITICAL级别的日志传递到AdminEmailHandler

- 与DEBUG设置无关，所有的django.server记录器的日志，INFO及以上级别的都会输出到控制台

  之所以有上述行为，是因为除了django.server记录器外其他内置记录器都会传播消息到根记录器django，而根记录器django使用了console和mail_admins处理器

```python
# 这是views视图模块
import logging

# 这个 logger 只会在控制台输出 warning及以上的日志
logger = logging.getLogger(__name__)
# 这个logger 会输出 info及以上的日志
logger_server = logging.getLogger('django.server')

def index(request):
    logger.debug('logger debug 测试')
    logger.info('logger info 测试-------------------')
    logger.warning('logger warning 测试')
    logger.error('logger error 测试')

    logger_server.debug('logger_server debug 测试')
    logger_server.info('logger_server info 测试-------------------')
    logger_server.warning('logger_server warning 测试')
    logger_server.error('logger_server error 测试')
    return HttpResponse('欢迎学习django的日志功能！！')
```



### 2、一般应用

1. 在根目录下建立 log 目录

   

2. 在settings中配置：

   ```python
   BASE_LOG_DIR = os.path.join(BASE_DIR, "log")
   
   LOGGING = {
       'version': 1,
       'disable_existing_loggers': False,
       'formatters': {
           # 一般应用文件
           'standard': {
               'format': '[%(levelname)s][%(asctime)s][%(filename)s:%(lineno)d:%(funcName)s] %(message)s'
           },
           # 应用于控制台
           'simple':{
               'format':'[%(levelname)s][%(asctime)s] %(message)s'
           }
       },
       'filters': {
           'require_debug_true': {
               '()': 'django.utils.log.RequireDebugTrue',
           },
       },
       'handlers': {
           'console': {
               'level': 'DEBUG',
               'filters': ['require_debug_true'],
               'class': 'logging.StreamHandler',
               'formatter': 'simple'
           },
           'file': {
               'level': 'INFO',
               'class': 'logging.handlers.RotatingFileHandler',
               'filename': os.path.join(BASE_LOG_DIR, "log_study.log"), 
               'maxBytes': 1024 * 1024 * 50,  # 日志大小 50M
               'backupCount': 3, 
               'formatter': 'standard',
               'encoding': 'utf-8',
           },
       },
       'loggers': {
           '': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['console', 'file'],
               'level': 'DEBUG',
           },
       },
   }
   ```

   注意：RotatingFileHandler在生成新的文件时，会抛出 PermissionError 异常(其它分割文件的也同样会出现)，是因为django自带的简易web服务器，启动时默认启动2个进程，以便于实现 reload 的功能，如果要避免此错误，那么必须修改manage.py的启动参数为：

   ​	runserver --noreload

   但是增加了 --noreload 这个参数后，web服务器不会自动检测代码的修改和重启服务

   

3. 视图函数中使用logger：

   ```python
   import logging
   
   # __name__ 模块logger，对应settings中的 名称为：'' 的 logger
   logger = logging.getLogger(__name__)
   
   def index(request):
       logger.debug('debug 测试')
       logger.info('info 测试')
       logger.warning('warning 测试')
       logger.error('error 测试')
       return HttpResponse('欢迎学习django的日志功能！！')
   ```

   4. 结果：

   console控制台输出：

   ```
   [DEBUG][2021-07-29 17:23:42,803] logger debug 测试
   [INFO][2021-07-29 17:23:42,804] logger info 测试-------------------
   [WARNING][2021-07-29 17:23:42,804] logger warning 测试
   [ERROR][2021-07-29 17:23:42,805] logger error 测试
   ```

   log目录生成 log_study.log内容为：

   ```
   [INFO][2021-07-29 17:23:42,804][views.py:14:logger_test] logger info 测试-------------------
   [WARNING][2021-07-29 17:23:42,804][views.py:15:logger_test] logger warning 测试
   [ERROR][2021-07-29 17:23:42,805][views.py:16:logger_test] logger error 测试
   ```

   

   ### 3、自动生成新日志文件名

   1. 修改日志文件的大小

      ```python
           'file': {
                  # 这项值是修改的最多的
                  'level': 'INFO',
                  # 'filters': ['require_debug_false'],
                  'class': 'logging.handlers.RotatingFileHandler',
                  'filename': os.path.join(BASE_LOG_DIR, "logging_study.log"),
                  'maxBytes': 1024,  # 日志大小 
                  'backupCount': 3,
                  'formatter': 'standard',
                  'encoding': 'utf-8',
              },
      ```
   
      

   2. 视图函数中使用logger

      ```python
   import logging
      
      # __name__ 模块logger，对应settings中的 名称为：'' 的 logger
      logger = logging.getLogger(__name__)
      
      def index(request):
          logger.debug('logger debug 测试')
          logger.info('logger info 测试-------------------')
          logger.warning('logger warning 测试')
       for i in range(10):
              logger.error(f'logger error 测试{i}')
       return HttpResponse('欢迎学习django的日志功能！！')
      ```

      
   
   3. 生成的日志文件
   
   ![image-20210729173411667](.\imgs\image-20210729173411667.png)



### 3、propagate的使用

1. 修改配置文件

   ```python
   'loggers': {
           'logger_study': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['console'],
               'level': 'DEBUG',
           },
           'logger_study.file': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['file'],
               'level': 'DEBUG',
               'propagate':False,
           },
       },
   ```

   

2. 视图函数

   ```python
   import logging
   
   # __name__ 模块logger，对应settings中的 名称为：'' 的 logger
   logger = logging.getLogger('logger_study.file')
   
   def index(request):
       logger.debug('logger debug 测试')
       logger.info('logger info 测试-------------------')
       logger.warning('logger warning 测试')
       logger.error('logger error 测试')
   ```

   

3. 运行结果

   默认propagate的值是True，会向上传播

   控制台运行结果：

   ```
   [DEBUG][2021-07-29 17:46:23,796] logger debug 测试
   [INFO][2021-07-29 17:46:23,796] logger info 测试-------------------
   [WARNING][2021-07-29 17:46:23,797] logger warning 测试
   [ERROR][2021-07-29 17:46:23,798] logger error 测试
   ```

   日志文件

   ```
   [INFO][2021-07-29 17:46:23,796][views.py:14:logger_test] logger info 测试-------------------
   [WARNING][2021-07-29 17:46:23,797][views.py:15:logger_test] logger warning 测试
   [ERROR][2021-07-29 17:46:23,798][views.py:16:logger_test] logger error 测试
   ```

   配置propagate的值是False,会发现只有文件中有日志信息，控制台没有日志信息

   

### 4、RotatingFileHandler的使用

1. 修改配置文件

   在handlers中添加TimedRotatingFileHandler处理器

   ```python
   'handlers': {
           'console': {
               'level': 'DEBUG',
               'filters': ['require_debug_true'],
               'class': 'logging.StreamHandler',
               'formatter': 'simple'
           },
           'file': {
               'level': 'INFO',
               'class': 'logging.handlers.RotatingFileHandler',
               'filename': os.path.join(BASE_LOG_DIR, "log_study.log"), 
               'maxBytes': 1024,  # 日志大小 50M
               'backupCount': 3, 
               'formatter': 'standard',
               'encoding': 'utf-8',
           },
           'timed_file': {
               # 这项值是修改的最多的
               'level': 'INFO',
               'class': 'logging.handlers.TimedRotatingFileHandler',
               'filename': os.path.join(BASE_LOG_DIR, "logging_study_timed.log"),
               'when': 's',
               'interval': 10,
               'backupCount': 5,
               'formatter': 'standard',
               'encoding': 'utf-8',
           },
       },
       'loggers': {
           'logger_study': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['console'],
               'level': 'DEBUG',
           },
           'logger_study.file': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['file','timed_file'],
               'level': 'DEBUG',
               'propagate':False,
           },
       },
   ```

2. 视图函数

   ```python
   import logging
   
   # __name__ 模块logger，对应settings中的 名称为：'' 的 logger
   logger = logging.getLogger('logger_study.file')
   
   def index(request):
       logger.debug('logger debug 测试')
       logger.info('logger info 测试-------------------')
       logger.warning('logger warning 测试')
       logger.error('logger error 测试')
   ```

3. 运行结果

   ![image-20210802110210696](.\imgs\image-20210802110210696.png)

### 5、SMTPHandler的使用

1. setting.py中的配置

   ```python
   'handlers': {
           'console': {
               'level': 'DEBUG',
               'filters': ['require_debug_true', 'exist_word_filter'],
               'class': 'logging.StreamHandler',
               'formatter': 'simple'
           },
           'file': {
               # 这项值是修改的最多的
               'level': 'INFO',
               # 'filters': ['require_debug_false'],
               'class': 'logging.handlers.RotatingFileHandler',
               'filename': os.path.join(BASE_LOG_DIR, "logging_study.log"),
               'maxBytes': 1024,  # 日志大小 50M
               'backupCount': 3,
               'formatter': 'standard',
               'encoding': 'utf-8',
           },
           'smtp':{
               'level': 'ERROR',
               'class': 'logging.handlers.SMTPHandler',
               'formatter': 'standard',
               'mailhost': ('smtp.163.com', 25),
               'fromaddr': 'zqy871589@163.com',
               'toaddrs': ['zqy871589@163.com'],
               'subject': 'logging_study系统日志消息',
               'credentials': ('zqy871589@163.com', 'GBVSLRZPXFGATDIP')
           },
           'timed_file': {
               # 这项值是修改的最多的
               'level': 'INFO',
               'class': 'logging.handlers.TimedRotatingFileHandler',
               'filename': os.path.join(BASE_LOG_DIR, "logging_study_timed.log"),
               'when': 's',
               'interval': 10,
               'backupCount': 5,
               'formatter': 'standard',
               'encoding': 'utf-8',
           },
       },
       'loggers': {
           'logging_study': {
               # 部署到生产环境之后可以把'console'移除
               'handlers': ['console'],
               'level': 'DEBUG',
           },
           'logging_study.file': {
               # 部署到生产环境之后可以把'console'移除
               # 'handlers': ['file', 'timed_file', 'smtp'],
               'handlers': ['smtp'],
               'level': 'DEBUG',
           },
       },
   ```

   

2. 运行结果

![image-20210802113835118](.\imgs\image-20210802113835118.png)


# django的signals

## 1、概述

​	信号可以在框架中的其他位置发生操作时通知分离的应用程序，简而言之，就是信号允许特定的sender通知一组receiver某些操作已经发生，这在多处代码和同一事件有关联的情况下很有用。 

​	

## 2、内置信号

内置信号的完整文档：https://docs.djangoproject.com/zh-hans/2.2/ref/signals/



模型层中定义的内置信号，在 django.db.models.signals 模块中：

1. pre_init：实例化模型时，此信号在模型的\__init__()方法的开头发送

   此信号发送的参数：

   - instance：模型类
   - args：模型初始化的位置参数
   - kwargs：模型初始化的关键字参数

2. post_init：和pre_init一样，但是这个\__init__()方法在方法完成时发送

   此信号发送的参数：

   - instance：刚刚初始化完成的模型实例

3. pre_save：在模型 save()方法开始时发送

4. post_save：在模型 save()方法完成时发送

5. pre_delete：在模型 delete()方法开始时发送

6. post_delete：在模型 delete()方法结束时发送

7. m2m_changed：多对多关系中，模型更改时发送



对web请求，也有内置信号，在 django.core.signals 模块中

1. request_started：Django开始处理HTTP请求时发送 
2. request_finished：当Django完成向客户端发送HTTP响应时发送 



## 3、定义信号

所有的信号都是django.dispatch.Signal实例

初始化参数：providing_args=None, use_caching=False

- providing_args：信号将为sender提供的参数名称列表
- use_caching：默认为False，是否使用缓存，设置为True，会为每个sender对应的接收器进行缓存（保存到sender_receivers_cache），调用 .connect() 或 .disconnect() 后会清除缓存。内置信号基本都设置为True

示例：

```python
from django import dispatch

pizza_done = dispatch.Signal(providing_args=["toppings", "size"])
```



## 4、接收器receiver

接收器可以是任何python函数或方法，参数最少必须是：sender, **kwargs，示例如下：

```python
def my_callback(sender, **kwargs):
    print("第一个接收器函数！")
    
def my_callback1(sender, arg1=None, **kwargs):
    print("第二个接收器函数！")
```

参数说明：

- sender：信号的发送对象，其实可以是任意对象，取决于发送时传递的参数
- **kwargs：信号对象定义时的providing_args指定的参数



## 5、信号注册（连接到接收器）

有两种方式可以将信号连接上接收器

1. connect方法

   使用 Signal.connect() 监听信号，发送信号时调用接收器函数，Signal是信号对象

   Signal.connect（receiver，sender = None，weak = True，dispatch_uid = None）

   参数说明：

   - receiver - 将连接到此信号的回调函数

   - sender - 指定信号的特定发送者，为None就是任何发送者都接收

   - weak - Django默认将信号处理程序存储为弱引用。因此，如果您的接收器是本地函数，它可能是垃圾收集。为了防止这种情况，请在调用信号connect()方法时设置weak=False

   - dispatch_uid - 在可能发送重复信号的情况下信号接收器的唯一标识符，就是一个不重复的字符串

     

   示例如下：

   ```python
   from django.core.signals import request_finished
   
   request_finished.connect(my_callback)
   
   ```

   

2. receiver装饰器

   receiver(signal, **kwargs)

   参数说明：

   - signal：信号对象或信号对象列表
   - **kwargs：这个装饰器也是使用的connect方法，这个关键字参数就是传递给connect方法的关键字参数

   

   receiver源码：

   ```python
   def receiver(signal, **kwargs):
       """
       A decorator for connecting receivers to signals. Used by passing in the
       signal (or list of signals) and keyword arguments to connect::
   
           @receiver(post_save, sender=MyModel)
           def signal_receiver(sender, **kwargs):
               ...
   
           @receiver([post_save, post_delete], sender=MyModel)
           def signals_receiver(sender, **kwargs):
               ...
       """
       def _decorator(func):
           if isinstance(signal, (list, tuple)):
               for s in signal:
                   s.connect(func, **kwargs)
           else:
               signal.connect(func, **kwargs)
           return func
       return _decorator
   ```

   

   使用示例如下：

   ```python
   from django.core.signals import request_finished
   from django.dispatch import receiver
   
   @receiver(request_finished)
   def my_callback(sender, **kwargs):
       print("Request finished!")
       
   ```

   

3. 只接收特定发送者发送的信号

   ```python
   # 只接收特定模型MyModel发送的信号
   @receiver(pre_save, sender=MyModel)
   def my_handler(sender, **kwargs):
       ...
   ```

   

4. 防止重复信号

   在某些情况下，将接收器连接到信号的代码可能会多次运行，这可能导致接收器功能被多次注册，因此对于单个信号事件被多次调用（例如，在保存模型时使用信号发送电子邮件时），使用唯一标识符作为dispatch_uid参数以标识接收方函数，此标识符通常使用字符串，使用后有确保接收器仅对每个唯一dispatch_uid值绑定一次信号：

   ```python
   request_finished.connect(my_callback, dispatch_uid="my_unique_identifier")
   ```



注意事项：

上述的信号定义和注册代码，理论上可以在任意代码位置，但是模型相关的信号建议避免在应用程序的根模块及其models模块中注册，以尽量减少 import 代码的副作用

通常情况下：

- 信号定义：在对应子应用的signals模块中，如果使用connect注册的话，receive也定义在 signals 模块中

- 信号注册：在对应子应用的 apps 中的 AppConfig 类中的 ready 方法中实现，示例如下：

  apps.py：

  ```python
  class TestAppConfig(AppConfig):
      name = 'test_app'
  
      def ready(self):
          # 通过 get_model 来获取特定模型对象，参数 MyModel 就是 模型类的名称字符串
          pre_save.connect(receiver, sender=self.get_model('MyModel'))
  ```

  

## 6、信号断开连接

信号要断开连接，使用以下方法：

Signal.disconnect（receiver = None，sender = None，dispatch_uid = None）

参数说明见 Signal.connect

receiver参数表示已注册的接收器断开连接，当使用了dispatch_uid时，这个参数可以为None

返回值：如果有接收器被断开连接则返回True，没有则返回False



## 7、发送信号

两种发送信号的方法：

1. Signal.send(sender, **kwargs)：所有内置信号都是使用此方法发送信息。这个方法不能捕获由接收器抛出的异常; 它只是允许错误向上传播，因此，在出现错误时，不是所有接收器都可以被通知信号。

   

2. Signal.send_robust(sender, **kwargs)：捕获从Exception类派生的所有错误，并确保所有接收器都收到信号通知。如果发生错误，则会在引发错误的接收器的元组对中返回错误实例。正常的返回值是：[(receiver, response), ... ]，response是receiver的返回值，发生错误时是[(receiver, err), ... ]，错误的tracebacks保存在 err.\__traceback__属性上



## 8、项目中应用信号

### 1、应用内置信号

pre_save和post_save

1. 在子应用中新建signals.py

```python
def pre_save_receive(sender, **kwargs):
    print(f'模型保存之前:{sender},kwargs:{kwargs}')
```

2. 子应用的apps.py：

```python
@receiver(post_save，dispatch_uid="test_app_post_save_receive")
def post_save_receive(sender, **kwargs):
    print(f'模型保存之后:{sender},kwargs:{kwargs}')

from .signals import pre_save_receive

class TestAppConfig(AppConfig):
    name = 'test_app'

    verbose_name = '测试应用'

    def ready(self):
        pre_save.connect(pre_save_receive)
```

3. 当在admin后台登录之后，控制台输出：

```
模型保存之前:<class 'django.contrib.sessions.models.Session'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D414358>, 'instance': <Session: nnq90hk1vizs2ov9pulruvwvq36lhcba>, 'raw': False, 'using': 'default', 'update_fields': None}
模型保存之后:<class 'django.contrib.sessions.models.Session'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D4142E8>, 'instance': <Session: nnq90hk1vizs2ov9pulruvwvq36lhcba>, 'created': True, 'update_fields': None, 'raw': False, 'using': 'default'}
模型保存之前:<class 'django.contrib.auth.models.User'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D414358>, 'instance': <User: admin>, 'raw': False, 'using': 'default', 'update_fields': frozenset({'last_login'})}
模型保存之后:<class 'django.contrib.auth.models.User'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D4142E8>, 'instance': <User: admin>, 'created': False, 'update_fields': frozenset({'last_login'}), 'raw': False, 'using': 'default'}
模型保存之前:<class 'django.contrib.sessions.models.Session'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D414358>, 'instance': <Session: nnq90hk1vizs2ov9pulruvwvq36lhcba>, 'raw': False, 'using': 'default', 'update_fields': None}
模型保存之后:<class 'django.contrib.sessions.models.Session'>,kwargs:{'signal': <django.db.models.signals.ModelSignal object at 0x0000017C6D4142E8>, 'instance': <Session: nnq90hk1vizs2ov9pulruvwvq36lhcba>, 'created': False, 'update_fields': None, 'raw': False, 'using': 'default'}
```



### 2、自定义信号

1. 在子应用中新建signals.py

   ```python
   from django.dispatch import receiver
   from django import dispatch
   
   # 定义信号
   index_signal = dispatch.Signal(providing_args=["request"])
   
   
   # 定义接收器，使用装饰器注册信号
   @receiver(index_signal, dispatch_uid="test_app_pre_index_request")
   def pre_index_request(sender, request=None, **kwargs):
       print(f'访问首页之前：{sender}， {kwargs}')
       print('访问IP：', request.META['REMOTE_ADDR'])
   ```

   

2. views中：

   ```python
   def index(request):
       # 发送信号
       index_signal.send(sender='index_function', request=request)
       return render(request, 'index.html')
   ```

   

3. 访问首页，控制台输出：

   ```python
   访问首页之前：index_function， {'signal': <django.dispatch.dispatcher.Signal object at 0x0000013C2B09F160>}
   访问IP： 127.0.0.1
   ```

   

   

   

# 缓存redis

## 1、概述

​	动态网站的基本权衡是，它们是动态的。每次用户请求页面时，Web服务器都会进行各种计算 - 从数据库查询到模板呈现再到业务逻辑 - 以创建站点访问者看到的页面。从处理开销的角度来看，这比标准的文件读取文件系统服务器要耗时多了。对于大多数Web应用程序来说，这种开销并不是什么大问题。因为大多数Web应用程序只是中小型网站，没有拥有一流的流量。但对于中到高流量的站点，尽可能减少开销是至关重要的，这就是缓存的用武之地。缓存某些内容是为了保存昂贵计算的结果，这样就不必在下次执行计算。

​	Django框架带有一个强大的缓存系统，可以保存动态页面，因此不必为每个请求计算它们。Django提供不同级别的缓存粒度：可以缓存特定视图的输出，也可以只缓存页面中难以生成的部分或者可以缓存整个站点。 

​	Redis，是一个内存数据库（现在已经支持内存数据持久化到硬盘当中，重新启动时，会自动从硬盘进行加载），由于其性能极高，因此经常作为中间件、缓存使用。

​	本文档介绍就是Django框架使用Redis数据库来应用缓存框架



## 2、Redis

​	redis默认不支持windows，由于一般开发环境在windows，因为需要使用第三方团队维护的windows版本，下载地址：

​    https://github.com/tporadowski/redis/releases

​	直接减压压缩包，安装好之后，启动redis

​     启动redis：

```
redis-server
```

   连接redis数据库

```
redis-cli
```

   核心配置，在redis.windows.conf下

```
绑定IP：如果需要远程访问，可以将此注释，或绑定一个真是IP
bind 127.0.0.1

端口：默认为6379
port 6379

日志文件
logfile "Logs/redis_log.txt"

数据库个数
databases 16

```

  基本命令

```
检测 redis 服务是否启动
PING

设置键值对:
set uname baizhan

取出键值对:
get uname

删除键值对：
del uname

查看所有键值对：
keys *

删除所有的键值对
flushall
```

运行结果：

![image-20210810145317901](.\imgs\image-20210810145317901.png)

## 3、应用redis缓存

​	django中应用redis，目前一般使用第三方库 django-redis

​	安装：pip install django-redis



### 1.settings配置

```python
CACHES = {
    # default 是缓存名，可以配置多个缓存
    "default": {
        # 应用 django-redis 库的 RedisCache 缓存类
        "BACKEND": "django_redis.cache.RedisCache",
        # 配置正确的 ip和port
        "LOCATION": "redis://127.0.0.1:6379",
        "OPTIONS": {
            # redis客户端类
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            # redis连接池的关键字参数
            "CONNECTION_POOL_KWARGS": {
                "max_connections": 100
            }
            # 如果 redis 设置了密码，那么这里需要设置对应的密码，如果redis没有设置密码，那么这里也不设置
            # "PASSWORD": "123456",
        }
    }
    
    
}
```

更多配置项：

- LOCATION：设置连接url，譬如："redis://127.0.0.1:6379/0"，如果要设置redis主从连接，设置列表：["redis://127.0.0.1:6379/1", "redis://127.0.0.1:6378/1"]，第一个连接是 master 服务器

- TIMEOUT：缓存的超时时间，单位秒，默认是 300秒，如果为None，表示缓存永不超时，如果为0，表示缓存立刻超时，相当于不使用缓存

- LOCATION：支持使用 本地url符号作为连接，

  支持三种 URL scheme :

  1. redis://: 普通的 TCP 套接字连接 - redis://[:password]@localhost:6379/0
  2. rediss://: SSL 包裹的 TCP 套接字连接 - rediss://[:password]@localhost:6379/0
  3. unix://: Unix 域套接字连接 - unix://[:password]@/path/to/socket.sock?db=0

  但是密码放在url中，不是很安全，所以建议使用示例中的方式

- OPTIONS：

  - SOCKET_CONNECT_TIMEOUT：建立连接超时时间，单位秒

  - SOCKET_TIMEOUT：连接建立后，读写超时时间，单位秒

  - COMPRESSOR：默认不使用压缩，指定压缩的类，譬如"django_redis.compressors.zlib.ZlibCompressor"

  - IGNORE_EXCEPTIONS：默认为False，当Redis仅用于缓存时，连接异常或关闭后，忽略异常，不触发异常，可以设置为True，也可以全局设置 DJANGO_REDIS_LOG_IGNORED_EXCEPTIONS=True

  - PICKLE_VERSION：序列化使用的是pickle，默认情况下使用最新的pickle版本，这里可以设置指定版本号（设置为 -1 也是指最新版本）

  - CONNECTION_POOL_CLASS：设置自定义的连接池类

  - PARSER_CLASS：redis.connection.HiredisParser，可以这样设置，使用C写的redis客户端，性能更好

  - CLIENT_CLASS：设置一些特殊客户端类，譬如：

    分片客户端：

    ```python
    CACHES = {
        "default": {
            "BACKEND": "django_redis.cache.RedisCache",
            "LOCATION": [
                "redis://127.0.0.1:6379/1",
                "redis://127.0.0.1:6379/2",
            ],
            "OPTIONS": {
                "CLIENT_CLASS": "django_redis.client.ShardClient",
            }
        }
    }
    ```

    集群客户端：

    ```python
    CACHES = {
        "default": {
            "BACKEND": "django_redis.cache.RedisCache",
            "LOCATION": [
                "redis://127.0.0.1:6379/1",
            ],
            "OPTIONS": {
                "CLIENT_CLASS": "django_redis.client.HerdClient",
            }
        }
    }
    ```

  - SERIALIZER：设置序列化，如 "django_redis.serializers.json.JSONSerializer"



全局配置，即设置在settings最外层的配置项：

```python
# 给所有缓存配置相同的忽略行为
DJANGO_REDIS_LOG_IGNORED_EXCEPTIONS  = True

# 设置指定的 logger 输出日志， 需要设置logger
DJANGO_REDIS_LOGGER = 'some.specified.logger'
```



### 2.手动操作redis

通过配置获取django_redis的get_redis_connection，进行操作，如下：

```python
from django_redis import get_redis_connection

conn = get_redis_connection("default")  # redis.client.StrictRedis
# 支持所有redis的接口
conn.hset('hash_test','k1','v1')

# 也可以手动将数据清除
get_redis_connection("default").flushall()

# 得知连接池的连接数
get_redis_connection("default").connection_pool
```

运行结果

![image-20210802170153579](.\imgs\image-20210802170153579.png)

![image-20210802170237048](.\imgs\image-20210802170237048.png)

### 3.全站缓存

主要使用两个中间件实现：

- FetchFromCacheMiddleware ：从缓存中读取数据

  - 缓存状态为200的GET和HEAD请求的响应（除非响应头中设置不进行缓存）
  - 对具有不同查询参数的相同URL的请求的响应被认为是各自不同的页面，并且被分别单独缓存。
  - 该中间件会使用与对应的GET请求相同的响应头来回答HEAD请求，即可以为HEAD请求返回缓存的GET响应。

- UpdateCacheMiddleware ：将数据更新到缓存中

  - 该中间件会自动在每个响应中设置几个headers：
    - 设置Expires为当前日期/时间 加上 定义的CACHE_MIDDLEWARE_SECONDS值，GMT时间
    - 设置响应的Cache-Control的max-age，值是定义的CACHE_MIDDLEWARE_SECONDS值。

  - 如果视图设置了自己的缓存时间（即设置了Cache-Control 的max age），那么页面将被缓存直到到期时间，而不是CACHE_MIDDLEWARE_SECONDS。

    使用装饰器 django.views.decorators.cache可以设置视图的到期时间（使用cache_control()装饰器，代码：@cache_control(max_age=3600)）或禁用视图的缓存（使用never_cache()装饰器，代码：@never_cache）

  - 如果USE_I18N设置为True，则生成的缓存key将包含当前语言的名称，这样可以轻松缓存多语言网站，而无需自己创建缓存密钥。

  - 如果 USE_L10N设置为True 并且 USE_TZ被设置为True，缓存key也会包括当前语言



在settings的中间件中设置：

```python
MIDDLEWARE = [
    'django.middleware.cache.UpdateCacheMiddleware',
    
    # 其他中间件...
    
    'django.middleware.cache.FetchFromCacheMiddleware',
]
```

PS：UpdateCacheMiddleware必须是第一个中间件，FetchFromCacheMiddleware必须是最后一个中间件



然后，将以下必需设置添加到Django的settings文件中：

- CACHE_MIDDLEWARE_ALIAS - 用于存储的缓存别名。
- CACHE_MIDDLEWARE_SECONDS - 每个页面应缓存的秒数。
- CACHE_MIDDLEWARE_KEY_PREFIX - 用于生成缓存key的前缀，如果使用相同的Django安装在多个站点之间共享缓存，请将其设置为站点名称或此Django实例特有的其他字符串，以防止发生密钥冲突。如果你不在乎，请使用空字符串。



在视图中：

```python
def index(request):
    # 通过设置时间戳，进行多次访问，可以看到时间戳的变化，就可以得知是否是缓存页面了
    return HttpResponse('欢迎光临，当前时间戳：' + str(time.time()))
```



### 4.视图函数缓存

1. 通过装饰器cache_page

   ```python
   from django.views.decorators.cache import cache_page
    
    @cache_page(60 * 15)
    def index(request):
    ...
   ```

   说明：

   - cache_page除了默认的timeout参数外，还有两个可选的关键字参数

     - cache，示例代码：@cache_page(60 * 15, cache="special_cache")， 该cache指向settings中配置的缓存的名称，默认是"default"
     - key_prefix：缓存key的前缀，与CACHE_MIDDLEWARE_KEY_PREFIX功能相同

   - 如果多个url指向同一个视图函数，会为每个url建立一个单独的缓存，例如：

     ```python
     urlpatterns = [
         path('foo/<int:code>/', views.index),
     ]
     ```

     /foo/1/ 和/foo/23/ 请求会分别进行缓存

     

2. 通过urls中配置cache_page

   在URLconf中指定视图缓存，而不是在视图函数上硬编码装饰器，可以进一步解耦缓存和视图函数之间的关系，使用起来更灵活

   ```python
   from django.views.decorators.cache import cache_page
    
   urlpatterns = [
       path('index/', cache_page(60 * 15)(views.index)),
   ]
   ```



### 5.模板文件缓存

​	使用cache模板标记缓存模板片段

1. 引入TemplateTag

   ```django
   {% load cache %}
   ```

   

2. 使用缓存

   ```django
   {% cache 5000 cache_key %}
          缓存内容
   {% endcache %}
   ```

   说明：

   cache最少两个参数：

   - 5000： 缓存超时时间，单位秒，如果为None，那么就是永久缓存

   - cache_key：缓存的key，不能使用变量，只是一个字符串（不要引号），相当于CACHE_MIDDLEWARE_KEY_PREFIX 

     

   可以通过将一个或多个附加参数（可以是带或不带过滤器的变量，变量个数可以是多个，如：{% cache 500 sidebar var1 var2 var3 ... %}）传递给 cache 来唯一标识缓存片段来执行此操作，示例如下：

   ```python
   {% load cache %}
   {% cache 500 sidebar request.user.username %}
       指定登录用户的侧边栏
   {% endcache %}
   ```

   

   如果USE_I18N设置为True，每站点中间件缓存将根据语言进行区分，对于cache模板标记，可以使用模板中可用的特定于 转换的变量 来实现相同的结果，示例如下：

   ```python
   {% load i18n %}
   {% load cache %}
   
   {% get_current_language as LANGUAGE_CODE %}
   
   {% cache 600 welcome LANGUAGE_CODE %}
       {% trans "Welcome to example.com" %}
   {% endcache %}
   ```

   

   缓存超时可以是模板变量，使用变量可以避免多次使用同一个值，示例（假设my_timeout设置为 600）：

   ```python
   
   {% cache my_timeout sidebar %} ... {% endcache %}
   ```

   

   默认情况下，cache将尝试使用名为“template_fragments”的缓存。如果不存在此缓存，则使用默认的default缓存。可以通过using关键字参数指定使用的缓存，该关键字参数必须是标记的最后一个参数，示例：

   ```python
   {% cache 300 cache_key ... using="localcache" %}
   ```

   PS：指定不存在的 缓存名 会报错

   

### 6.低级缓存

有时不想缓存整个页面数据，而只是想缓存某些费时查询并且基本不会改变的数据，可以通过一个简单的低级缓存API实现，该API可以缓存任何可以安全pickle的Python对象：字符串，字典，模型对象列表等 

1. django.core.cache.caches

   ```python
   from django.core.cache import caches
   cache1 = caches['myalias']
   cache2 = caches['myalias']
   # 判断为True
   if cache1 is cache2: 
       ...
   ```

   说明：

   - 可以通过CACHES类似字典一样的方式访问settings中配置的缓存，在同一个线程中重复请求相同的别名将返回相同的对象

   - 如果指定的 myalias 不存在，将引发 InvalidCacheBackendError

   - 为了线程安全性，为会每个线程返回缓存的不同实例

   - 作为快捷方式， 默认缓存(default)可以使用 django.core.cache.cache ：

     ```python
     # 使用 default 缓存
     from django.core.cache import cache
     
     # 上面的cache等同于下面的写法
     from django.core.cache import caches
     cache = caches['default']
     ```

     

2. django.core.cache.cache

```python
from django.core.cache import cache

# 使用 redis 的一般用法
cache.set('manul_set', 'ok')
manul_set = cache.get('manul_set')

# 可以手动设置 timeout，如果不指定timeout，默认是 300秒
cache.set("key", "value", timeout=None)

# 可以获取key的超时设置（ttl：time to live）
# 返回值的3种情况：
# 0： key 不存在 (或已过期)
# None： key 存在但没有设置过期
# ttl： 任何有超时设置的 key 的超时值
cache.set("foo", "value", timeout=25)
cache.ttl("foo") # 得到 25 
cache.ttl("not-existent") # 得到 0

# 让一个值永久存在
cache.persist("foo")
cache.ttl("foo") # 得到 None

# 指定一个新的过期时间
cache.set("foo", "bar", timeout=22)
cache.ttl("foo") # 得到 22
cache.expire("foo", timeout=5)
cache.ttl("foo") # 得到 5

# 支持 redis 分布式锁， 使用 上下文管理器 分配锁
with cache.lock("somekey"):
    do_some_thing()
    
# 使用全局通配符的方式来检索或者删除键
cache.keys("foo_*")  # 返回所有匹配的值, 如 ["foo_1", "foo_2"]

# 使用 iter_keys 取代keys 得到 一个迭代器
cache.iter_keys("foo_*")  # 得到一个迭代器
next(cache.iter_keys("foo_*"))  # 得到 foo_1

# 删除 键
cache.delete_pattern("foo_*")  # 支持通配符
```

### 7.低级缓存的应用

1. 视图函数

   ```python
   def get_result():
       # 做一些费时，但是不经常变更的数据查询，运算等
       time.sleep(5)
       return 'lower level cache is ok!!!'
   
   def lower_level_cache(request):
       # 需要获取一个统计数据
       result = get_cache_or_exc_func('lower_level_cache', get_result)
   
       return JsonResponse({'result': result})
   ```

   

2. 缓存函数

   在公共包中创建py文件，定义缓存函数

   ```python
   from django.core.cache import cache
   
   def get_cache_or_exc_func(key, func, *args, **kwargs):
       """ 根据传入的key和func，先获取缓存的内容，没有则使用func计算，并保存
   
       :param key:  缓存的key
       :param func:  计算函数
       :param args:  可变参数
       :param kwargs:  可变关键字参数
       :return: 缓存的内容或func计算的结果
       """
       # 加上cache锁
       with cache.lock(key+'_lock'):
   
           # 获取缓存中的变量
           result = cache.get(key)
           # 判断缓存中的变量是否存在
           if result:
               # 直接返回缓存的结果
               return result
           # 缓存中不存在
           else:
               # 计算数据，得到结果
               result = func(*args, **kwargs)
               # 将结果保存到缓存中
               cache.set(key, result)
               # 返回计算的结果
               return result
   ```


### 8.session缓存

```python
# 配置session的引擎为cache
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
# 此处别名依赖缓存的设置
SESSION_CACHE_ALIAS = 'default'  
```

1. 路由配置

   ```python
       app_name = 'redis_app'
       path('login/',views.login,name='login'),
       path('index/',views.index,name='index')
   ```

   

2. 视图函数

   ```python
   def index(request):
       uname = request.session.get('uname')
       if uname == 'root':
           return render(request,'redis_app/index.html',{'uname':uname})
       else:
           return redirect('redis_app:login')
   
   def login(request):
       if request.method == 'GET':
           return render(request,'redis_app/login.html')
       elif request.method == 'POST':
           #获取用户名和密码
           uname = request.POST.get('uname')
           password= request.POST.get('password')
           print('uname:',uname,'password:',password)
           if uname == 'root' and password == 'root':#登录成功
               #将用户名存放到session中
               request.session['uname'] = uname
               #跳转到主页
               return redirect('redis_app:index')
           else:
               return redirect('redis_app:login')
   ```

   

3. 页面

   login.html页面

   ```html
       <form action="{%url 'redis_app:login'%}" method="POST">
           {% csrf_token %}
           <p>用户名：<input type = "text" name ="uname" ></p>
           <p>密码：<input type = "password" name ="password" ></p>
           <p><input type="submit" value="登录"></p>
       </form>
   ```

   index.html页面

   ```html
   <p>欢迎{{uname}}登录</p>
   ```

   

4. 运行结果

   ![image-20210811093530711](.\imgs\image-20210811093530711.png)

# django应用Celery

## 1、概述

### 1.Celery介绍

​	Celery是由Python开发、简单、灵活、可靠的分布式任务队列，是一个处理异步任务的框架，其本质是生产者消费者模型，生产者发送任务到消息队列，消费者负责处理任务。Celery侧重于实时操作，但对调度支持也很好，其每天可以处理数以百万计的任务。特点：

- 简单：熟悉celery的工作流程后，配置使用简单
- 高可用：当任务执行失败或执行过程中发生连接中断，celery会自动尝试重新执行任务
- 快速：一个单进程的celery每分钟可处理上百万个任务
- 灵活：几乎celery的各个组件都可以被扩展及自定制



​	Celery由三部分构成：

- 消息中间件(Broker)：官方提供了很多备选方案，支持RabbitMQ、Redis、Amazon SQS、MongoDB、Memcached 等，官方推荐RabbitMQ

- 任务执行单元(Worker)：任务执行单元，负责从消息队列中取出任务执行，它可以启动一个或者多个，也可以启动在不同的机器节点，这就是其实现分布式的核心 

- 结果存储(Backend)：官方提供了诸多的存储方式支持：RabbitMQ、 Redis、Memcached,SQLAlchemy, Django ORM、Apache Cassandra、Elasticsearch等

  

  架构如下： 

![](.\imgs\celery.png)



​	工作原理：

1. 任务模块Task包含异步任务和定时任务。其中，异步任务通常在业务逻辑中被触发并发往消息队列，而定时任务由Celery Beat进程周期性地将任务发往消息队列；
2. 任务执行单元Worker实时监视消息队列获取队列中的任务执行；
3. Woker执行完任务后将结果保存在Backend中;



### 2.django应用Celery

​	django框架请求/响应的过程是同步的，框架本身无法实现异步响应。

​	但是我们在项目过程中会经常会遇到一些耗时的任务, 比如：发送邮件、发送短信、大数据统计等等，这些操作耗时长，同步执行对用户体验非常不友好，那么在这种情况下就需要实现异步执行。

​	异步执行前端一般使用ajax，后端使用Celery。



## 2、项目应用

​	django项目应用celery，主要有两种任务方式，一是异步任务（发布者任务），一般是web请求，二是定时任务

​	

​	本文档使用redis数据库作为消息中间件和结果存储数据库

​		环境如下：

- celery4.4.7
- redis3.5.3

```
PS：本文仅适用celery库进行学习，另外有一些第三方库可以提供更方便的操作，譬如：django-celery，django-celery-beat等
```



### 1.异步任务redis

#### 1.安装库

```
pip install celery
```



#### 2.celery.py

在主项目目录下，新建 celery.py 文件：

```python
import os
import django
from celery import Celery
from django.conf import settings

# 设置系统环境变量，安装django，必须设置，否则在启动celery时会报错
# celery_study 是当前项目名
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'celery_study.settings')
django.setup()
#实例化一个celery类
celery_app = Celery('celery_study')
#指定配置文件的位置
celery_app.config_from_object('django.conf:settings')
#自动从settings的配置INSTALLED_APPS中的应用目录下加载 tasks.py
celery_app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)
```

PS：是和settings.py文件同目录，一定不能建立在项目根目录，不然会引起 celery 这个模块名的命名冲突



同时，在主项目的init.py中，添加如下代码：

```python
from .celery import celery_app

__all__ = ['celery_app']
```



#### 3.settings.py

在配置文件中配置对应的redis配置：

```python
# Broker配置，使用Redis作为消息中间件
BROKER_URL = 'redis://127.0.0.1:6379/0' 

# BACKEND配置，这里使用redis
CELERY_RESULT_BACKEND = 'redis://127.0.0.1:6379/0' 

# 结果序列化方案
CELERY_RESULT_SERIALIZER = 'json' 

# 任务结果过期时间，秒
CELERY_TASK_RESULT_EXPIRES = 60 * 60 * 24 

# 时区配置
CELERY_TIMEZONE='Asia/Shanghai'   

# 指定导入的任务模块，可以指定多个
#CELERY_IMPORTS = (     
#    'other_dir.tasks',
#)
```

PS：所有配置的官方文档：http://docs.celeryproject.org/en/latest/userguide/configuration.html 



#### 4.tasks.py

在子应用下建立各自对应的任务文件tasks.py(必须是tasks.py这个名字，不允许修改)

```python
from celery import shared_task

@shared_task
def add(x, y):
    return x + y

@shared_task
def mul(x, y):
    return x * y

@shared_task
def xsum(numbers):
    return sum(numbers)
```



#### 5.调用任务

在 views.py 中，通过 delay 方法调用任务，并且返回任务对应的 task_id，这个id用于后续查询任务状态

```python
from . import tasks

def mul_func(request):
    ar = tasks.mul.delay(10, 3)

    return HttpResponse('返回mul任务，task_id:'+ ar.id)
```



#### 6.启动celery

在cmd窗口中，切换到项目根目录下，执行：

```
celery worker -A celery_study -l info
```

说明：

- -A celery_study：指定项目
- worker： 表明这是一个任务执行单元
- -l info：指定日志输出级别



更多celery命令的参数，可以输入：

```
celery --help
或
celery worker --help
```



异常处理：

1. win10平台，使用celery4.x时，会出现以下错误：

```
ValueError: not enough values to unpack (expected 3, got 0)
```

解决方法：

- 先安装一个扩展 eventlet 

```
pip install eventlet
```

- 然后启动worker的时候加一个参数 -P eventlet，如下：

```
celery worker -A celery_study -l debug -P eventlet
```



2. 使用redis时，有可能会出现如下类似的异常

```
AttributeError: 'str' object has no attribute 'items'
```

这是由于版本差异，需要卸载已经安装的python环境中的 redis 库，重新指定安装特定版本（celery4.x以下适用 redis2.10.6， celery4.3以上使用redis3.2.0以上）：

```
pip install redis==2.10.6
```



#### 7.获取任务结果

在 views.py 中，通过 AsyncResult.get() 获取结果

```python
def get_result_by_taskid(request):
    task_id = request.GET.get('task_id')

    ar = result.AsyncResult(task_id)

    if ar.ready():
        return JsonResponse({'status': ar.state, 'result': ar.get()})
    else:
        return JsonResponse({'status': ar.state, 'result': ''})
```

AsyncResult类的常用的属性和方法：

- state: 返回任务状态，等同status；

- task_id: 返回任务id；

- result: 返回任务结果，同get()方法；

  

- ready(): 判断任务是否执行以及有结果，有结果为True，否则False；

- info(): 获取任务信息，默认为结果；

- wait(t): 等待t秒后获取结果，若任务执行完毕，则不等待直接获取结果，若任务在执行中，则wait期间一直阻塞，直到超时报错；

- successful(): 判断任务是否成功，成功为True，否则为False；



### 2.定时任务

​	在第一步的异步任务的基础上，进行部分修改即可

#### 1.settings.py

```python
from celery.schedules import crontab

CELERYBEAT_SCHEDULE = {
    'add_every_30_seconds': {
         # 任务路径
        'task': 'celery_app.tasks.add',
         # 每30秒执行一次
        'schedule': 30,
        'args': (14, 5)
    },
    'xsum_week1_20_20_00': {
         # 任务路径
        'task': 'celery_app.tasks.xsum',
        # 每周一20点20分执行
        'schedule': crontab(hour=20, minute=20, day_of_week=1),
        'args': ([1,2,3,4],),
    },
}
```

说明（更多内容见文档：http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html#crontab-schedules）：

- task：任务函数
- schedule：执行频率，可以是整型（秒数），也可以是timedelta对象，也可以是crontab对象，也可以是自定义类（继承celery.schedules.schedule）
- args：位置参数，列表或元组
- kwargs：关键字参数，字典
- options：可选参数，字典，任何 apply_async() 支持的参数
- relative：默认是False，取相对于beat的开始时间；设置为True，则取设置的timedelta时间



#### 2.启动celery

分别启动worker和beat

```
celery worker -A celery_study -l debug -P eventlet
celery beat -A celery_study -l debug
```



### 3.任务绑定

​	Celery可通过task绑定到实例获取到task的上下文，这样我们可以在task运行时候获取到task的状态，记录相关日志等 



代码如下：

```python
@shared_task(bind=True)
def mul(self, x, y):
    logger.info('-mul'*10)
    logger.info(self.name)
    logger.info(dir(self))
    return x * y
```

说明：

- 在装饰器中加入参数 bind=True

- 在task函数中的第一个参数设置为self

  self对象是celery.app.task.Task的实例，可以用于实现重试等多种功能

  ```python
  @shared_task(bind=True)
  def mul(self, x, y):
      try:
          logger.info('-mul' * 10)
          logger.info(f'{self.name}, id:{self.request.id}')
          raise Exception
      except Exception as e:
          # 出错每4秒尝试一次，总共尝试4次
          self.retry(exc=e, countdown=4, max_retries=4)  
      return x * y
  ```



### 4.任务钩子

​	Celery在执行任务时，提供了钩子方法用于在任务执行完成时候进行对应的操作，在Task源码中提供了很多状态钩子函数如：on_success(成功后执行)、on_failure(失败时候执行)、on_retry(任务重试时候执行)、after_return(任务返回时候执行)

1. 通过继承Task类，重写对应方法即可，示例：

```python
class MyHookTask(Task):

    def on_success(self, retval, task_id, args, kwargs):
        logger.info(f'task id:{task_id} , arg:{args} , successful !')

    def on_failure(self, exc, task_id, args, kwargs, einfo):
        logger.info(f'task id:{task_id} , arg:{args} , failed ! erros: {exc}')

    def on_retry(self, exc, task_id, args, kwargs, einfo):
        logger.info(f'task id:{task_id} , arg:{args} , retry !  erros: {exc}')
```



2. 在对应的task函数的装饰器中，通过 base=MyHookTask 指定

```python
@shared_task(base=MyHookTask, bind=True)
def mul(self, x, y):
	......
```



### 5.任务编排

​	在很多情况下，一个任务需要由多个子任务或者一个任务需要很多步骤才能完成，Celery也能实现这样的任务，完成这类型的任务通过以下模块完成：

- group: 并行调度任务
- chain: 链式任务调度
- chord: 类似group，但分header和body2个部分，header可以是一个group任务，执行完成后调用body的任务
- map: 映射调度，通过输入多个入参来多次调度同一个任务
- starmap: 类似map，入参类似＊args
- chunks: 将任务按照一定数量进行分组



​	文档：https://docs.celeryproject.org/en/latest/getting-started/next-steps.html#canvas-designing-work-flows

#### 1.group

​	urls.py:

```python
path('primitive/', views.test_primitive),
```

​	views.py：

```python
def test_primitive(request):
    # 创建10个并列的任务
    lazy_group = group(tasks.add.s(i, i) for i in range(10))
    promise = lazy_group()
    result = promise.get()
    return JsonResponse({'function': 'test_primitive', 'result': result})
```

说明：

通过task函数的  s  方法传入参数，启动任务



上面这种方法需要进行等待，如果依然想实现异步的方式，那么就必须在tasks.py中新建一个task方法，调用group，示例如下：

tasks.py：

```python
@shared_task
def group_task(num):
    return group(add.s(i, i) for i in range(num))().get()
```

urls.py：

```python
path('first_group/', views.first_group),
```

views.py:

```python
def first_group(request):
    ar = tasks.group_task.delay(10)

    return HttpResponse('返回first_group任务，task_id:' + ar.task_id)
```



#### 2.chain

​	默认上一个任务的结果作为下一个任务的第一个参数

```python
def test_primitive(request):
    # 等同调用  mul(add(add(2, 2), 5), 8)
    promise = chain(tasks.add.s(2, 2), tasks.add.s(5), tasks.mul.s(8))()
    #  72
    result = promise.get()  
    return JsonResponse({'function': 'test_primitive', 'result': result})
```



#### 3.**chord** 

​	任务分割，分为header和body两部分，hearder任务执行完在执行body，其中hearder返回结果作为参数传递给body

```python
def test_primitive(request):
    # header：  [3, 12] 
    # body: xsum([3, 12])
    promise = chord(header=[tasks.add.s(1,2),tasks.mul.s(3,4)],body=tasks.xsum.s())()
    result = promise.get()
    return JsonResponse({'function': 'test_primitive', 'result': result})
```



### 6、celery管理和监控

​	celery通过flower组件实现管理和监控功能 ，flower组件不仅仅提供监控功能，还提供HTTP API可实现对woker和task的管理 

​	官网：https://pypi.org/project/flower/

​	文档：https://flower.readthedocs.io/en/latest



1. 安装flower

   ```
   pip install flower
   ```

   

2. 启动flower

   ```
   flower -A celery_study --port=5555   
   ```

   说明：

   - -A：项目名
   - --port： 端口号

   

3. 访问

   在浏览器输入：http://127.0.0.1:5555

   


# DebugToolBar

### 1、概述

​	Django框架的调试工具栏使用django-debug-toolbar库，是一组可配置的面板，显示有关当前请求/响应的各种调试信息，点击时，显示有关面板内容的更多详细信息。

​	官方文档：https://django-debug-toolbar.readthedocs.io/en/latest/



## 2、应用

### 1.安装

```
pip install django-debug-toolbar
```



### 2.settings.py配置

​	先决条件：必须确认django.contrib.staticfiles 正确安装并且启用

```python
INSTALLED_APPS = [
    # ...
    'django.contrib.staticfiles',
    # ...
    'debug_toolbar',
]

STATIC_URL = '/static/'
```



### 3.urls.py路由

在主应用下的根urls.py中的最下面添加如下代码：

```python
from django.conf import settings

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns
```

说明：

- 这里使用 '\__debug__' 作为路径访问，可以设置任意的路径名，只要能轻易区分一般应用
- 如果放在子应用的urls.py下的话，会抛出NoReverseMatch  'djdt' is not a registered namespace异常



### 4.启用中间件

调试工具栏主要在中间件中实现：

```python
MIDDLEWARE = [
    # ...
    'debug_toolbar.middleware.DebugToolbarMiddleware',
    # ...
]
```

PS：这个中间件尽可能配置到最前面，但是，必须要要放在处理编码和响应内容的中间件后面，比如我们要是使用了GZipMiddleware，就要把DebugToolbarMiddleware放在GZipMiddleware后面



### 5.设置内部IP

调试工具栏只会允许特定的ip访问，在settings的INTERNAL_IPS中配置

```
INTERNAL_IPS = [
    '127.0.0.1',
]
```



### 6.访问

访问应用的任意页面，在页面的右上角会有一个 DJDT的悬浮窗

PS：如果访问的页面是如下编写的代码，则不会出现悬浮窗，因为内容中没有 body 标签

```python
def my_view(request):
	# ......
	return render(request,'toolbar_app/index.html')
```



### 7.面板功能

- History：访问历史信息
- Versions ：代表是哪个django版本
- Timer : 用来计时的，判断加载当前页面总共花的时间
- Settings : 读取django中的配置信息
- Headers : 当前请求头和响应头信息
- Request: 当前请求的相关信息（视图函数，Cookie信息，Session信息等）
- SQL:查看当前界面执行的SQL语句
- StaticFiles：当前界面加载的静态文件
- Templates:当前界面用的模板
- Cache：缓存信息
- Signals：信号
- Logging：当前界面日志信息
- Redirects：当前界面的重定向信息
- Profiling：查看视图函数的信息



### 8.面板配置

django-debug-toolbar默认使用全面板，见第7点，

默认的全局配置在 debug_toolbar.settings.CONFIG_DEFAULTS

默认的面板配置在 debug_toolbar.settings.PANELS_DEFAULTS

```python
DEBUG_TOOLBAR_PANELS = [
    'debug_toolbar.panels.history.HistoryPanel',
    'debug_toolbar.panels.versions.VersionsPanel',
    'debug_toolbar.panels.timer.TimerPanel',
    'debug_toolbar.panels.settings.SettingsPanel',
    'debug_toolbar.panels.headers.HeadersPanel',
    'debug_toolbar.panels.request.RequestPanel',
    'debug_toolbar.panels.sql.SQLPanel',
    'debug_toolbar.panels.staticfiles.StaticFilesPanel',
    'debug_toolbar.panels.templates.TemplatesPanel',
    'debug_toolbar.panels.cache.CachePanel',
    'debug_toolbar.panels.signals.SignalsPanel',
    'debug_toolbar.panels.logging.LoggingPanel',
    'debug_toolbar.panels.redirects.RedirectsPanel',
    'debug_toolbar.panels.profiling.ProfilingPanel',
]
```

如果不使用默认的全功能面板，那么在settings中配置 DEBUG_TOOLBAR_PANELS 即可，示例如下：

```
DEBUG_TOOLBAR_PANELS = [
    "debug_toolbar.panels.timer.TimerPanel",
    "debug_toolbar.panels.headers.HeadersPanel",
    "debug_toolbar.panels.request.RequestPanel",
    "debug_toolbar.panels.templates.TemplatesPanel",
]
```

说明：

- 当前只启用了4个面板：时间、头信息、请求信息和模板信息
- 可以添加自定义面板
- 可以删除默认内置面板
- 可以改变面板的顺序



### 9.工具栏配置

在settings中配置 DEBUG_TOOLBAR_CONFIG 覆盖默认配置，分为2部分，一部分适用于工具栏本身，另一部分适用于某些特定面板

```python
DEBUG_TOOLBAR_CONFIG = {
    # Toolbar options
    "DISABLE_PANELS": {"debug_toolbar.panels.redirects.RedirectsPanel"},
    "INSERT_BEFORE": "</body>",
    "RENDER_PANELS": None,
    "RESULTS_CACHE_SIZE": 10,
    "ROOT_TAG_EXTRA_ATTRS": "",
    "SHOW_COLLAPSED": False,
    "SHOW_TOOLBAR_CALLBACK": "debug_toolbar.middleware.show_toolbar",
    # Panel options
    "EXTRA_SIGNALS": [],
    "ENABLE_STACKTRACES": True,
    "HIDE_IN_STACKTRACES": (
        "socketserver" if six.PY3 else "SocketServer",
        "threading",
        "wsgiref",
        "debug_toolbar",
        "django.db",
        "django.core.handlers",
        "django.core.servers",
        "django.utils.decorators",
        "django.utils.deprecation",
        "django.utils.functional",
    ),
    "PROFILER_MAX_DEPTH": 10,
    "SHOW_TEMPLATE_CONTEXT": True,
    "SKIP_TEMPLATE_PREFIXES": ("django/forms/widgets/", "admin/widgets/"),
    "SQL_WARNING_THRESHOLD": 500,  # milliseconds
}
```

#### 工具栏选项

- `DISABLE_PANELS`

  默认： `{'debug_toolbar.panels.redirects.RedirectsPanel'}`

  此设置是要禁用（但仍显示）的面板的完整Python路径的集合。

- `INSERT_BEFORE`

  默认： `'</body>'`

  工具栏在HTML中搜索此字符串并在之前插入。

- `RENDER_PANELS`

  默认： `None`

  如果设置为`False`，调试工具栏将把面板的内容保留在服务器上的内存中并按需加载它们。如果设置为`True`，则会在每个页面内呈现面板。这可能会降低页面呈现速度，但在多进程服务器上需要这样做，例如，如果在生产中部署工具栏（不建议这样做）。

  默认值`None`告诉工具栏自动执行正确的操作，具体取决于WSGI容器是否运行多个进程。此设置允许您在需要时强制执行不同的操作。

- `RESULTS_CACHE_SIZE`

  默认： `10`

  工具栏在内存中保持的结果缓存数量。

- `ROOT_TAG_EXTRA_ATTRS`

  默认： `''`

  此设置将注入根模板div中，以避免与客户端框架发生冲突。例如，将调试工具栏与Angular.js一起使用时，将其设置为`'ng-non-bindable'`或 `'class="ng-non-bindable"'`。

- `SHOW_COLLAPSED`

  默认： `False`

  如果更改为`True`，则默认情况下将折叠工具栏。

- `SHOW_TOOLBAR_CALLBACK`

  默认： `'debug_toolbar.middleware.show_toolbar'`

  这是用于确定工具栏是否应显示的函数路径，默认检测DEBUG设置为True，并且访问IP必须在INTERNAL_IPS中，代码如下：

  ```python
  def show_toolbar(request):
      """
      Default function to determine whether to show the toolbar on a given page.
      """
      if request.META.get("REMOTE_ADDR", None) not in settings.INTERNAL_IPS:
          return False
  
      return bool(settings.DEBUG)
  ```

  可以设置自定义的检测函数路径

  

#### 面板选项

- `EXTRA_SIGNALS`

  默认： `[]`

  面板：信号

  可能在项目中的自定义信号列表，定义为信号的Python路径。

- `ENABLE_STACKTRACES`

  默认： `True`

  面板：缓存，SQL

  如果设置为`True`，则将显示SQL查询和缓存调用的堆栈跟踪。启用堆栈跟踪会增加执行查询时使用的CPU时间。

- `HIDE_IN_STACKTRACES`

  默认值：('socketserver', 'threading', 'wsgiref', 'debug_toolbar', 'django')`

  面板：缓存，SQL

  用于消除与服务器相关的堆栈跟踪，这可能导致巨大的DOM结构和工具栏渲染延迟。

- `PROFILER_MAX_DEPTH`

  默认： `10`

  面板：剖析

  此设置会影响分析器分析中的函数调用深度。

- `SHOW_TEMPLATE_CONTEXT`

  默认： `True`

  面板：模板

  如果设置为`True`则模板的上下文将包含在模板调试面板中。如果项目中拥有大型模板上下文，或者具有不希望被评估的惰性数据结构的模板上下文，则关闭此选项非常有用。

- `SKIP_TEMPLATE_PREFIXES`

  默认： `('django/forms/widgets/', 'admin/widgets/')`

  面板：模板

  收集渲染的模板和上下文时，将跳过以这些字符串开头的模板。默认情况下会跳过基于模板的表单小部件，因为面板的HTML可以轻松地增长到数百兆字节，包含许多表单字段和许多选项。

- `SQL_WARNING_THRESHOLD`

  默认： `500`

  面板：SQL

  SQL面板突出显示执行时间超过这段时间（以毫秒为单位）的查询

