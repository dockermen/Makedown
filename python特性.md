### 迭代器

#### isinstance判断是否属于指定类

```python
from collections import Iterable,Iterator
isinstance(对象，类)
isinstance(对象，Iterable)

```

1. ##### 可迭代性 Iterable

   1. 集合类元素

      list,str,dict,tuple

   2. 生成器

      generator

2. ##### 迭代器 Iterator

   具备可迭代性的元素不一定是迭代器

3. ##### Iter()可以让具备可迭代性的元素变成迭代器



### 闭包的定义和使用

闭包就是函数

- 创建闭包

  - 嵌套函数定义（外部函数，内部函数）
  - 内部函数使用外部函数中定义的变量
  - 外部函数一定要有返回值，返回内部函数名

- ```python
  def funcOut(num1):
      def funcIn(num2):
          #nonlocal num1
          #num1 +=1
          return num1+num2
      return funcIn
  a = 10
  b = 20
  f = funcIn(a)
  print(type(f))
  result = f(b)
  
  ```

- 外部的局部变量不会随着外部的函数一起消失，假如消失的话内部函数不能用

- 如果在内部函数中修改外部函数变量使用,noolocal 声明非局部变量

##### 使用闭包求两个点的距离

```python
#普通函数实现
import math
def getdis(x1,y1,x2,y2):
    return math.sqrt((x1-x2) ** 2 + (y1-y2) ** 2)
#闭包
def getdisout(x1,y1):
    def getdisin(x2,y2):
        return math.sqrt((x1-x2) ** 2 + (y1-y2) ** 2)
    return getdisin
#-------------------------函数---------------------------#
dis = getdis(0,0,10,10)
print(dis)
dis = getdis(0,0,20,20)
print(dis)
#--------------------------闭包--------------------------#
dis1 = getdisout(0,0)
print(dis1(10,10))
print(dis1(20,20))
```

#### 闭包的用途

- 可以不修改现有功能的前提下，增加新的功能
  - 日志功能（统计访问事件，访问功能，写到日志文件中），
  - 权限验证（下载之前，验证账号是否为会员）
  
- ```python
  #日志功能普通方法实现
  import time
  def writelog(func):
      try:
          file = open("log.txt","a",encoding='utf-8')
          file.write(func.__name__)
          file.write("\t")
          file.write(time.asctime())
          file.write("\n")
      except Exception as e:
          print(e.args)
      finally:
          file.close()
  
  def func1():
      writelog(func1)
      print("我是功能一")
  def func2():
      writelog(func2)
      print("我是功能二")
  
  func1()
  func2()
  ```

- 开闭原则

  - 开放：添加功能
  - 关闭：修改源代码

  ```python
  #闭包添加功能不修改源码
  import time
  #源码
  def writelog(func):
      try:
          file = open("log.txt","a",encoding='utf-8')
          file.write(func.__name__)
          file.write("\t")
          file.write(time.asctime())
          file.write("\n")
      except Exception as e:
          print(e.args)
      finally:
          file.close()
  #闭包
  def funcOut(func):
      def funcIn():
          #新增功能
          writelog(func)
          func()
      return funcIn
  def func1():
      print("我是功能一")
  def func2():
      print("我是功能二")
  func1 = funcOut(func1)
  func2 = funcOut(func2)
  func1()
  func2()
  ```

#### 装饰器

装饰器和闭包关联紧密，很多时候二者结合使用

```py
@funcOut等价于func1 = funcOut(func1)
```

```python
#使用装饰器和闭包添加功能不修改源码
import time
#源码
def writelog(func):
    try:
        file = open("log.txt","a",encoding='utf-8')
        file.write(func.__name__)
        file.write("\t")
        file.write(time.asctime())
        file.write("\n")
    except Exception as e:
        print(e.args)
    finally:
        file.close()
#闭包
def funcOut(func):
    def funcIn():
        #新增功能
        writelog(func)
        func()
    return funcIn
@funcOut
def func1():
    print("我是功能一")
@funcOut
def func2():
    print("我是功能二")
func1()
func2()
```

多个装饰器的使用

装饰器先装饰最里面的 

- 通用装饰器

  ```python
  def funcOut(func):
      def funcIn(*args,**kwargs)
      	print("新增功能")
          return func(*args,**kwargs)
      return funcIn
  ```

### 动态添加对象属性

```python
class Person:
    def __init__(self,name,age):
        self.name = name 
        self.age = age
p1 = Person("学生",18)
#动态添加属性
p1.address = "北京"
#动态添加属性
setattr(p1,"gender","男")
#访问属性
getattr(p1,"gender")
```

#### 动态添加类属性

```py
Person.CLS_ID = 123
print(p1.CLS_ID)
print(p2.CLS_ID)
```

### 动态添加对象方法

1. 添加对象方法

   ```python
   import types
   class Person():
   	def study(self):
       	print("我爱学习")
   p1.study=types.MethodType(study,p1)
   ```

2. 添加静态方法

   ```python
   @staticmethod
   def testStaticmothod():
       print("我是静态方法")
   #给类添加静态方法
   Person.method1 = testStaticMethod
   #调用静态方法
   p1.method1()
   p2.method1()
   ```

3. 添加类方法

   ```python
   @classmethod
   def testClsmethod(cls):
       print("我是类方法")
   #添加类方法
   Person.method2 = testClsmethod
   ```

4. 访问类方法

   1. ```python
      p1.method1()	#对象访问
      ```

   2. ```python
      Person.method2()	#类名访问
      ```

#### __slots__的作用

可以对动态添加成员属性做限制(对类属性没有限制)

可以对动态添加成员方法做限制(对静态方法没有限制)

```python
class Person():
    __slots__ = ("name","age")
    def __init__(self,name,age):
        self.name = name
        self.age = age
    def eat(self):
        print("你好少年")
p1 = Person("张三"，19)
#动态添加属性
#p1.gender = "男"		#会报错
```

# 函数式编程

### range

### functools之函数partial

深加工函数添加默认函数

```python
from functools import partial
int3 = partial(int,base=2)
print(int3(str1))
```

### functools之wraps的使用

可以将原函数对象的指定属性复制给包装函数对象，默认有module,name,doc,或者通过参数选择

因为使用装饰器会丢失掉原有函数的一些属性，使用wraps可以复制

```python
from functools import wraps
def log(func):
    @wraps(func)	#原有属性复制
    def with_logging(*args,**kwargs):
        print("%s was calling" % func.__name__)
        return func(*args,**kwargs)
    return with_logging
@log
def test(x):
    """求x*x的值"""
    return x*x
print(test.__name__)
print(test.__doc__)
>>>test
>>>求x*x的值
```

### 内建函数map使用

python3生成迭代器,python2生成列表

```python
"""
map()
map(func,@iterables)
"""
list1 = [1,2,3]
list2 = [4,5,6,7]
def func1(x):
    return 2*x
lis = map(func,list1)
print(lis)
>>>2 4 6
def func2(x,y):
    return x+y
lis2 = map(func,list1,list2)
print(lis2)	#会遍历相加

```

### 内建函数reduce

函数会对参数序列中元素进行累积。

函数将一个数据集合（链表，元组等）中的所有数据进行下列操作：用传给 reduce 中的函数 function（有两个参数）先对集合中的第 1、2 个元素进行操作，得到的结果再与第三个数据用 function 函数运算，最后得到一个结果。

```python
"""
需求：
有一个储存5个随机数的列表，求列表中所有元素的和
1.生成随机数列表
2.遍历求和/或者其他方式求和
"""
from functools import reduce
list = [28,19,49,99,98]
result = reduce(lambda x,y:x+y,list1)
#result = reduce(func1,list1)
print(result)
```

### 内建函数filter的使用

过滤器，返回一个迭代器是True就留下

```python
list1 = [1,2,3,0,10,0,25]
#遍历列表不为0的元素
for i in list1:
    if i != 0 :
        print(i,end=" ")
it1 = filter(None,list1)
it1 = filter(lambda x:x != 0,list1)
for i in it1:
    print(i,end="  ")
```

### 正则表达式

```python
#查看正则是否匹配
re.match(pattern,s)
#查看匹配字符串
v = re.match(pattern,s)
#返回正则指定组索引，仅限于添加分组后
print(v.group(1))
print(v.group(2))
#返回匹配元素元组
print(v.groups())
```

匹配分组

```python
s = '<html><h1>我是一号字体</h1></html>'
pattern = r'<(.+)><(.+)>我是一号字体</\2></\1>'
pattern = r'<(?P<key1>.+)><(?P<key2>.+)>我是一号字体</(?P=key2)></(?P=key1)>'
```

#### re模块的高级用法

- match

  - 作用：从字符串的开头查找，找不到返回None

    ```python
    v = re.match('\d+',"阅读次数为9999次")
    print(v)
    ```
  
- search

  - 作用：扫描字符串，查找正则表达式模式产生匹配的第一个位置，并返回相应的匹配对象。如果字符串中没有与模式匹配的位置，则返回None

    ```python
    import re
    v1 = re.search('\d+',"阅读次数为999次")
    print(v1)
    ```
  
- findall

  - 作用：从左到右扫描字符串，并按照找到的顺序返回匹配，如果模式中有一个或多个组，返回组列表

    ```python
    list1 = re.findall(r'\d+',"阅读次数C:129 Python:99 C++:99")
    print(list1)
    ```

- sub

  - 作用：替换字符串

    - 直接替换

      ```python
      s = re.sub(r'a','c',"anjanknjann")
      print(s)
      ```

    - 函数运算替换

      ```python
      s = "阅读次数C:129 Python:99 C++:99"
      def replace(result):
          return str(int(result.group())+1)
      str1 = re.sub(pattern,replace,s)
      ```

- split

  - 作用：指定格式拆分字符串

    ```python
    s = 'He say:Hello,World'
    pattern = r'\s|:|,'
    list1 = re.split(pattern,s)
    print(list1)
    >>>['He','say','Hello','World']
    ```

#### 贪婪和非贪婪模式

- 贪婪模式：Python里数量词默认是贪婪的，总是尝试匹配尽可能多的字符

  ```python
  import re
  v = re.match(r'abc(\d+)','abc123')
  print(v.group(1))
  ```

- 非贪婪模式：总尝试匹配尽可能少的字符，可以使用"*","?","+","{m,n}"后面加上?，使贪婪变成非贪婪

  ```python
  v1 = re.match(r'abc(\d+?)','abc123')
  print(v1.group(1))
  ```

### 内存管理

#### type动态创建类

类 = type(类名,{父类...},{属性,方法})

```python
class Animal():
    def __init__(self,color):
        self.color = color
    def eat(self):
        print("动物需要吃东西")
def sleep(self):
    print("狗狗趴着睡觉")
Dog = type('Dog',(Animal,),{'age',3,'sleep':sleep})
dog = Dog("Yellow")
print(dog.age)
dog.sleep()
print(dog.color)
dog.eat()
```

#### 类装饰器的使用

```python
class AAA():
    def __init__(self,func):
        #print("我是AAA,init()")
        self.__func = func	#定义私有属性
    #TypeError:'AAA' object is not callable
    def __calll__(self,*args,**kwargs):	#调用方法
        self.addFunc()
        self.__func()
    def addFunc(self):
        print("用户权限验证")
        print("日志系统处理")
@AAA
#teat1 = AAA(test1)
def tast1():
    print("我是功能1")
test1()
```

#### 对象池

1. 数值类型

   1. 小整数池：[-4,256]

      程序开始时，一次性加载到内存

      LEGB(局部变量,闭包中的变量,全局变量,内建变量)

      全局都是同一个变量，不会因为变量使用生命周期结束而被释放，一直在内存常驻

      id():查看内存地址

      is:对象比较是否是同一个

      del删除还会存在，直到程序生命周期结束

   2. 大整数池

      每创建一个不是小整数范围内的变量，都会被自动储存到大整数池中

2. 字符串

   intern机制

   每个单词(字符串)，不夹杂空格或者其他符号，默认开启intern,共享内存，靠引用计数决定是否销毁

#### 垃圾回收

高级语言java,c#等都采用垃圾回收机制，不再是c,c++里用户自己管理维护内存的方式

python和java一样采用了垃圾回收机制，不过不一样的是：python采用的是引用计数机制为主，标记-清楚和分代收集两种机制为辅的策略

垃圾回收机制：GC机制

- python

  - 引用计数机制为主

  - ```python
    import sys
    class AA():
        #创建对象开辟内存时调用
        def __new__(cls, *args, **kwargs):
            print("开辟内存空间")
            return super(AA,cls).__new__(cls)
        #初始化方法
        def __init__(self):
            print("创建对象at:%s" % hex(id(self)))
            #对象被系统回调之前，会调用该方法
        def __del__(self):
            print("%s say bye bye" % hex(id(self)))
    
    a = AA()
    print("a的引用计数为:%d" % sys.getrefcount(a))
    ```

  - 

    如何获取一个对象的引用计数

    sys.getrefcount(a)

    刚创建的对象引用计数为2

    - 增加引用计数操作
      - 如果有新的对象使用该对象 +1
      - 装进列表+1
      - 作为函数参数
    - 减少引用计数操作
      - 如果有新的对象使用该对象，新对象不在使用+1
      - 从列表中移除-1
      - 函数调用结束
      - del 显示销毁

  - 隔代回收为辅助

  - 

