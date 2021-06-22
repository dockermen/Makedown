<center><font size=28><b>Python全系列</b></font><center></center>

# Python全系列

## Python入门

1. 解释型、面向对象的语言，吉多`范罗苏姆(龟叔)1989年发明，1991年发布
2. 可读性强，简洁

### 海龟绘图

```shell
import turtle
turtle.showturtle()	#显示箭头
turtle.write("Hello")	#写字符串
turtle.forward(300)	#前进300像素
turtle.color("red")	#颜色改为红色
turtle.left(90)	#箭头左转90度
turtle.goto(0,50)	#去坐标(0,50)
```

操纵海龟绘图有着许多的命令,这些命令可以划分为两种:一种为运动命令，一种为画笔控制命令

(1)运动命令:

![img](https://typora-1300671906.cos.ap-nanjing.myqcloud.com/img/20161025233331053)

 

(2)画笔控制命令:

 ![img](https://typora-1300671906.cos.ap-nanjing.myqcloud.com/img/20161025233523598)

**画笔常用属性和方法**

| 属性/方法                                                  | 描述                                                         |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| turtle.pensize()                                           | 设置画笔的宽度                                               |
| turtle.pencolor()                                          | 没有参数传入，返回当前画笔颜色，传入参数设置画笔颜色（RGB、字符串） |
| turtle.speed(speed)                                        | 设置画笔的速度。speed属于[0, 10]区间的整数，数字越大速度越快 |
| turtle.forward(distance)                                   | 向当前画笔方向移动distance像素长                             |
| turtle.backward(distance)                                  | 向当前画笔相反方向移动distance像素长度                       |
| turtle.right(degree)                                       | 顺时针移动degree°                                            |
| turtle.left(degree)                                        | 逆时针移动degree°                                            |
| turtle.pendown()                                           | 移动时绘制图形,缺省时也为绘制                                |
| turtle.goto(x,y)                                           | 将画笔移动到坐标为(x, y)的位置                               |
| turtle.penup()                                             | 移动时不绘制图形,提起笔，用于另起一个地方绘制时用            |
| turtle.speed(speed)                                        | 画笔绘制的速度范围[0,10]整数                                 |
| turtle.circle()                                            | 画圆,半径为正(负),表示圆心在画笔的左边(右边)画圆             |
| turtle.pensize(width)                                      | 绘制图形时的宽度                                             |
| turtle.pencolor()                                          | 画笔颜色                                                     |
| turtle.fillcolor(colorstring)                              | 绘制图形的填充颜色                                           |
| turtle.color(color1, color2)                               | 同时设置pencolor=color1, fillcolor=color2                    |
| turtle.filling()                                           | 返回当前是否在填充状态                                       |
| turtle.begin_fill()                                        | 准备开始填充图形                                             |
| turtle.end_fill()                                          | 填充完成；                                                   |
| turtle.hideturtle()                                        | 隐藏箭头显示；                                               |
| turtle.showturtle()                                        | 与hideturtle()函数对应                                       |
| turtle.clear()                                             | （全局）清空turtle窗口，但是turtle的位置和状态不会改变       |
| turtle.reset()                                             | （全局）清空窗口，重置turtle状态为起始状态                   |
| turtle.undo()                                              | （全局）撤销上一个turtle动作                                 |
| turtle.isvisible()                                         | （全局）返回当前turtle是否可见                               |
| stamp()                                                    | （全局）复制当前图形                                         |
| turtle.write(s[,font=("font-name",font_size,"font_type")]) | （全局）写文本，s为文本内容，font是字体的参数，里面分别为字体名称，大小和类型；font为可选项, font的参数也是可选项 |