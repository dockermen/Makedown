# HTML

## HTML4

### HTML入门

```html
<!DOCTYPE html>
<!--文档约束(DTD)-->
<html>
<head>
<meta charset="utf-8">
	<title>第一个网页</title>
</head>
<body>
	<!--body的内容会展现在用户面前-->
	This is my first HTML
</body>
</html>
```

### HTML标签的子标签

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>一个网页</title>
		
		<!--搜索引擎优化-->
		<meta name="author" content="朱自清, 张三" />
		<meta name="description" content="盼望着盼望着东风来了" />
		<meta name="keywords" content="东风, 盼望" />
        <meta name="copyright" content="网易版权所有"/>
		
		<!-- 自动跳转网页 -->
		<meta http-equiv="refresh" content="5;http://www.bjsxt.com" />
		<!--自动刷新当前网页 <meta http-equiv="refresh" content="10" />-->
		
		<!-- 禁用本地缓存，每次需要从网页读取 -->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Cache-Control" content="no-cache" />	<!-- 网页缓存控制 -->
		<meta http-equiv="expires" content="0" />	<!-- 网页预期缓存时间 -->

	</head>
	<body>
		
	</body>
</html>
```

### body基本标签

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
	</head>
	<body>
		<!-- 标题标签 h1-h6-->
		<h1 align="center">标题</h1>		<!-- 居中 -->
		<h2>标题</h2>
		
		<!-- 分割线 -->
		<hr width="500px" color="red" align="left" size="20px" />
		<!-- p段落标签  br换行   &nbsp;空格 -->
		<p>&nbsp;&nbsp;reload 方法，该方法强迫浏览器刷新当前页面。语法：location.reload([bForceGet])  参数： bForceGet， 可选参数， 默认为 false，从客户端缓存里取当前页。true, 则以 GET 方式，从服务端取最新的页面, 相当于客户端点击 F5("刷新")</p>
		
		<!-- 预文本标签--可以识别换行符 -->
		<pre>
			1. 页面需要定时刷新，实时加载数据（H5中的WebSocket和SSE可以实现局部刷新）
			2. 一定时间之后跳转到指定页面（登录注册之类）
			3. 前端开发使用伪数据调试html页面（修改一些js的变量值，可以自动刷新效果)
		</pre>
	</body>
</html>
```

### body小标签

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
	</head>
	<body>
		<u>下划线</u>
		<i>斜体</i>
		<b>加粗加黑</b>
		<del>删除线</del>
		
		上标标签<sup>Tm</sup>
		下标标签<sub>Tm</sub>
		<small>字体缩小</small>
		<big>字体放大</big>
		<font color="red" size="25px" face="楷体">字体标签</font>
		<span>字体标签2</span>
		
		<hr />
		<!-- 列表标签{有序列表, 无序列表, 自定义列表} -->
		<!-- <ol type="A"></ol> 改变序号-->
		<!-- 
		作用：树形菜单，导航栏，
		 -->
		<ol>
			<li>有序列表</li>
			<li>有序列表</li>
			<li>有序列表</li>
		</ol>
		
		<ul>
			<li>无序列表</li>
			<li>无序列表</li>
			<li>无序列表</li>
		</ul>
		
		<dl>
			<dt>自定义列表</dt>
			<dd>自定义列表</dd>
			<dd>自定义列表</dd>
		</dl>
		
		<marquee>跑马灯标签</marquee>
		<marquee direction="right" scrollamount="40px">跑马灯标签</marquee>
	
	</body>
</html>
```

**复制多个标签快捷键**

```shell
br*40再按Tab键
```

### 超链接标签

网页跳转

```html
<a href="https://www.baidu.com" target="_blank">超链接跳转</a>
```

锚点功能-实现一键直达

```html
<a href="#buttom" name="top">直达底部</a>
<a href="#top" name="buttom">返回顶部</a>
```

### 图片标签

```html
<img src="img/1.png" title="图片" />
<img src="https://···/thumb.jpg" />
<br />
<p>
    左
    <a href="https://www.baidu.com">
        <img src="img/2.png" width="200px" border="2px" alt="图片显示错误" align="center" />
    </a>
    右
</p>
```

### 表格标签

```html
<table border="1px" >
    <tr height="100px">
        <td width="100px">你好</td>
        <td width="100px">你好你好</td>
        <td width="100px"></td>
    </tr>
    <tr height="100px">
        <td width="100px"></td>
        <td width="100px">你好</td>
        <td width="100px"></td>
    </tr>
    <tr height="100px">
        <td width="100px"></td>
        <td width="100px"></td>
        <td width="100px">你好</td>
    </tr>
</table>
table：表格
tr:行
td/th:列	td:普通列 th:标题列
cellpadding="20px" 内容和单元格的距离
cellspacing="20px" 单元格和单元格之间的距离
colspan="2" 列合并
rowspan="2" 行合并
bgcolor="yellow" 背景颜色
```

### 表单标签

```ht
<form action="https://www.baidu.com/s" method="get">

    <input type="text" name="wd" />
    <input type="submit" value="提交" />

</form>	
```

```html
<form>
	<!-- 普通文本框 -->
	<p>账号:<input type="text" value="123" /></p>
	<p>密码:<input type="password" name="pwd" value="123" /></p>
	
	<!-- 单选框   checked="checked"默认选择-->
	男<input type="radio" name="sex" value="1" checked="checked" />
	女<input type="radio" name="sex" value="2" />
	<br />
	<!-- 多选框 -->
	旅游:<input type="checkbox" />
	游戏:<input type="checkbox" checked="checked" />
	游泳:<input type="checkbox" checked="checked" />
	
	<p>多行文本框<br /><textarea rows="15" cols="20" >多行文本框</textarea></p>
	<!-- 文件选择框 -->
	<input type="file" name="file" />
	<!-- 隐藏框 -->
	<input type="hidden" name="sno" value="20210811" />
	<!-- 下拉框  selected="selected"默认选择-->
	<select name="ch">
		<option value="1" selected="selected">中国</option>
		<option value="2">美国</option>
		<option value="3">俄罗斯</option>
		<option value="4">新加坡</option>
	</select>
	<p>
		<input type="submit" name="tj" value="提交" />
		<input type="reset" name="qc" value="清除" />
		<input type="button" value="普通按钮" />	<!-- 没有提交功能 -->
	</p>
</form>
```

### Ifram框架

```html
<body>
	<ul>
		<li><a href="https://www.baidu.com" target="ifm">百度</a></li>
		<li><a href="https://www.taobao.com" target="ifm">淘宝</a></li>
		<li><a href="https://www.jd.com" target="ifm">京东</a></li>
	</ul>
	<!-- 框架 -->
	<iframe width="1000px" height="600px" name="ifm" src="https://www.baidu.com/"></iframe>
</body>
```

### Frameset分割网页

h5不再支持

```html
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
	</head>
	<frameset rows="150px.*.100px">
		<!-- 顶部 -->
		<frame src="user/top.html" />
		<!-- 中间 -->
		<frameset cols="10%.*">
			<!-- 左侧 -->
			<frame src="user/left.html" />
			<!-- 右侧 -->
			<frame src="user/right.html" name="rig" />
		</frameset>
		<!-- 底部 -->
		<frame src="user/down.html" />
	</frameset>
<!-- 	<body>
	</body> -->
</html>
```

### DIV标签

```html
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		
		<style>
		
			.top{
				height: 100px;
				width: 100%;
				/* 背景颜色 */
				background-color: red;
			}
			.toptext{
				height: 40px;
				width: 100%;
				background-color: cadetblue;
			}
			.center{
				height: 475px;
				width: 100%;
				background-color: brown;
			}
			.down{
				height: 150px;
				width: 100%;
				background-color: chartreuse;
			}
			.login{
				width: 350px;
				height: 400px;
				background-color: #ffffff;
				/* 相对定位 */
				position: relative;
				left: 950px;
				top: 10px;
			}
		</style>
	</head>
	<body>
		<!-- 头部 -->
		<div class="top"></div>
		<!-- 中间提示语 -->
		<div class="toptext"></div>
		<!-- 腰部 -->
		<div class="center">
			<div class="login"></div>
		</div>
		<!-- 底部 -->
		<div class="down"></div>
	</body>
</html>
```

## HTML5

### 增强表单标签

```html
<body>
	<form>
		<p>
			邮箱：<input type="email" />
		</p>
		<p>
			数字：<input type="number" max="100"/>
		</p>
		<p>
			滑动器：<input type="range" value="10" />
		</p>
		<p>
			搜索框：<input type="search" />
		</p>
		<p>
			日期：<input type="date" value="2021-08-01" />
		</p>
		<p>
			颜色选择：<input type="color" />
		</p>
		<p>
			网址：<input type="url" />
		</p>
	</form>
	<hr />
	<form>
		<p><input type="text" placeholder="手机号/邮箱/账号" autofocus="autofocus"></p>
		<p><input type="password" placeholder="密码" maxlength="20" minlength="8" /></p>
		<p><input type="submit" name="提交"></p>
	</form>
</body>
```

#### 增强输入类型

```html
#<input type="email" />
邮箱:email	数字:number	滑动器:range	搜索框:search
日期:data		颜色选择:color	网址:url
```

### 增强类型

```html
输入框默认值:placeholder	自动获取焦点:autofocus	最大值/最小值:max/min
最大长度/最小长度:maxlength/minlength	日期默认值:value="2021-08-01"
滑动条默认值:value="10"
```

### 新增结构标签

![image-20210811173004961](https://typora-1300671906.cos.ap-nanjing.myqcloud.com/img/image-20210811173004961.png)

```html
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		
		<style>
		
			.top{
				height: 100px;
				width: 100%;
				/* 背景颜色 */
				background-color: #FFFFFF;
			}
			.toptext{
				height: 40px;
				width: 100%;
				background-color: antiquewhite;
			}
			.center{
				height: 475px;
				width: 100%;
				background-color: #483D8B;
			}
			.down{
				height: 150px;
				width: 100%;
				background-color: #FFFFFF;
			}
			.login{
				width: 350px;
				height: 400px;
				background-color: #ffffff;
				/* 相对定位 */
				position: relative;
				left: 950px;
				top: 10px;
			}
		</style>
	</head>
	<body>
		<!-- 头部 -->
		<header class="top"></header>
		<!-- 中间提示语 -->
		<nav class="toptext"></nav>
		<!-- 腰部 -->
		<div class="center">
			<div class="login"></div>
		</div>
		<!-- 底部 -->
		<footer class="down"></footer>
	</body>
</html>
```

### 音视频标签

```html
<body>
	<!-- 引入音频 -->
	<audio src="img/1.mp3" controls="controls">
		该网页不支持媒体标签
	</audio>
	<audio>
		<source src="img/1.mp3"></source>
		<source src="img/1.ogg"></source>
		该网页不支持媒体标签
	</audio>
	<!-- 引入视频 -->
	<video src="img/movie.mp4" controls="controls" width="30%" /video>
	<video>
		<source src="img/movie.mp4"></source>
		<source src="img/movie.ogg"></source>
		<source src="img/movie.webm"></source>
		该网页不支持视频标签
	</video>
	<hr />
	<!-- 多媒体标签-音视频标签 -->
	<embed src="img/movie.mp4"></embed>
</body>
```

## CSS层叠样式

### CSS引入方式

优先级：就近原则

```html
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		
		<style>
		/*【2】内嵌样式*/
			p{
				/* 字体颜色 */
				color: yellow;
				/* 字体大小 */
				font-size: 25px;
				/* 字体加粗 */
				font-weight: bold;
			}
		</style>
		
		<!-- [3]外部连接式 rel:引入文件和当前文件关系 type:类型 href:引入文件路径-->
		<link rel="stylesheet" type="text/css" href="css/css1.css"/>
		
		<!-- [4]导入方式 了解即可 -->
		<style>
			@import url("css/css1.css");
		</style>
	</head>
	<body>
		<!-- 【1】样式行内式引入 -->
		<p style="color: aqua;">我们不一样</p>
		<p>我们不一样</p>
		<p>我们不一样</p>
	</body>
</html>
```

- 行内引入

  ```html
  <p style="color: aqua;">我们不一样</p>
  ```

- 内嵌式

  ```html
  <style>
      p{
          /* 字体颜色 */
          color: yellow;
          /* 字体大小 */
          font-size: 25px;
          /* 字体加粗 */
          font-weight: bold;
      }
  </style>
  ```

- 外部连接式

  ```html
  <!-- [3]外部连接式 rel:引入文件和当前文件关系 type:类型 href:引入文件路径-->
  <link rel="stylesheet" type="text/css" href="css/css1.css"/>
  ```

- import导入方式（了解即可）

  ```html
  <style>
      @import url("css/css1.css");
  </style>
  ```

### CSS常用选择器

选择器的优先级:	ID选择器>类选择器>元素选择器>通用选择器

```html
<body>
    <div>1</div>
    <div id="div2">2</div>
    <div class="class3">3</div>
</body>
```

#### 通用选择器

选择页面所有元素

```css
/* 通用选择器-选择页面所有元素 */
*{
color: red;
}
```

#### 元素选择器

```css
div{
    width: 200px;
    height: 200px;
    background-color: aqua;
    /* 边框的粗细  边框线的风格 颜色 */
    border: 1px solid red;
}
```

#### id选择器

```css
/* id选择器 名称要唯一不能用数字命名*/
#div2{
    background-color: green;
}
```

#### class选择器

```css
/* class选择器 名称可以重复 */
.class3{
    background-color: beige;
}
```

### CSS其他选择器

#### 后代选择器

```css
div span{
    font-size: 27px;
    font-family: 楷体;
}
```

#### 子选择器

直系子标签

```css
div>span{
    font-size: 27px;
    font-family: 楷体;
}
```

#### 兄弟选择器

只会改变下面相邻的元素对象

```css
#p_1+p{
    color: red;
}
```

改变后面所有兄弟元素对象

```css
#p_1~p{
    color: red;
}
```

#### 伪类选择器

实现鼠标悬浮元素变色

```html
a:hover{
	color: red;
}
<a href="">京东</a>
```

#### 伪对象选择器

在指点元素之前或者之后插入内容

```css
.div1:before{
    content:"我们的祖国是花园";
    content:url(img/1.jpg);
}
.div1:after{}
```



### CSS其他属性

字体

```css
颜色  color:red;	大小  font-size:12px;	加粗  font-weight:bold;	字体  font-family:宋体;
倾斜  font-style:italic;	文本居中  text-align:center;	行高  line-height:40px;
边框  border:1px dotted indianred;
```

text

```css
下划线展示
text-decoration:underline;
去除下划线
text-decoration:none;
```

div

```css
背景颜色  background-color;	背景图片  background-images;
图片居中  background-position:center;	图片不重复  background-repeat:no-repeat;
图片自定义位置  background-position:10px 10px;	
调整图片大小  background-size:300px 500px;	透明度  opacity:0.5;
内容超出隐藏  overflow:hidden;	内容超出隐藏可滑动预览  overflow:auto;
```

- 行内元素

  多个标签位于同一行

  ```html
  span	fount	小标签	img a ···
  行内元素不支持定义宽高，需要转块元素
  display:block;
  display:none  整个元素隐藏
  ```

- 块元素

  标签可以自动换行

  ```html
  div	h1-h6	ul	p···
  ```

##### 元素浮动

```html
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<style>
		ul{
			float: right;
		}
		li{
			/* 列表风格去除 */
			list-style: none;
			float: left;
            /*内边距*/
			padding-left: 15px;
		}
		</style>
	</head>
	<body>
		<ul>
			<li><a href="">新闻</a></li>
			<li><a href="">hao123</a></li>
			<li><a href="">地图</a></li>
			<li><a href="">视频</a></li>
			<li><a href="">贴吧</a></li>
			<li><a href="">学术</a></li>
		</ul>
	</body>
</html>
```

### CSS定位

```css
position:static;
```

#### 绝对定位 absolute

定位离开之后释放的之前的位置，基于外层父级标签

#### 相对定位  relative

定位离开之后，之前的位置没有释放，基于之前的位置来说

#### 固定定位  fixed

始终是基于浏览器的左上角定位  适合做广告

#### 默认静态定位  static

静态定位的元素不受 top、bottom、left 和 right 属性的影响。

position: static; 的元素不会以任何特殊方式定位；它始终根据页面的正常流进行定位：

#### 层

```css
置顶
置于底层	z-index:-1;
```

#### 盒模型

```css
/* 去除body边距 */
body,html{margin: 0px;padding: 0px;}
.div_1{
    width: 200px;
    height: 200px;
    background-color: red;
    /* 内边距  真实div和border之间的距离 */
    /*padding：上右下左*/
    padding: 10px 20px 30px 40px;
    
}
.div_2{
    width: 200px;
    height: 200px;
    background-color: green;
    /* 外边距  盒子之间的距离 */
    margin-bottom: 40px;
}
div{
    float: left;
}
```

### CSS3选择器

#### 标签选择器

选择第一个子标签

```css
.div1>p:first-child
```

选择最后一个子标签

```css
.div1>p:last-chaild
```

选择指定子标签

```css
.div1>p:ntd-chaild(3)		指定标签
.div1>p:ntd-chaild(even)	奇数标签
.div1>p:ntd-chaild(add)		偶数标签
```

input获得焦点执行的操作

```css
input:focus{
    width:300px;
    height:100px;
}
```

input被选择执行的操作

```css
input:checked{
    width:20px;
    height:20px;
}
```

#### 属性选择器

```css
input[type="text"]{
    width:300px;
    height:400px;
}
input[name="fom_zh"]{}
input[value="123"]{}
input[name^="fom"]{
    /*以什么开头*/
    color:red;
}
```

#### CSS3常用属性

跳动的心项目

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<style>
			.cen{
				width: 200px;
				height: 200px;
				background-color: #d5093c;
				/* 阴影  水平方向偏移 垂直方向偏移  阴影大小 */
				box-shadow: 0px 0px 70px #D5093C;
				animation: 1s aj infinite;
			}
			.l{
				/* 边缘-圆角 */
				border-radius: 100px;
				position: absolute;
				top: 200px;
				left: 200px;
			}
			.c{
				/* 旋转角度 */
				transform: rotate(45deg);
				position: absolute;
				top: 274px;
				left: 274px;
			}
			.r{
				border-radius: 100px;
				position: absolute;
				top: 200px;
				left: 350px;
			}
			div:hover{
				/* 放大的倍数 */
				transform: scale(1.3);
/* 				位移
				transform: translate(0px,-5px);
				2d角度旋转
				transform: skew(40deg,10deg); */
			}
            
			@keyframes aj{
				0%{transform: scale(1)rotate(45deg);}
				50%{transform: scale(1.1)rotate(45deg);}
				100%{transform: scale(1)rotate(45deg);}
			}
		
		</style>
	</head>
	<body>
		<!-- class="cen l";起两个别名 -->
		<div class="cen l"></div>
		<div class="cen c"></div>
		<div class="cen r"></div>
	</body>
</html>
```

#### CSS项目搭建

##### 京东购物车

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet" type="text/css" href="css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="css/jd.css"/>
		<link rel="stylesheet" type="text/css" href="icon/iconfont.css" />
	</head>
	<body>
		<!-- 导航开始 -->
		<div class="nav">
			<div class="warp">
				<ul class="nav_ul1">
					<li><a href=""><i class="iconfont">&#xe63d;</i>京东首页</a></li>
					<li><a href="">配送至：北京</a></li>
				</ul>
				
				<ul class="nav_ul2">
					<li><a href="">洋洋宝贝</a><span>|</span></li>
					<li><a href="">我的订单</a><span>|</span></li>
					<li><a href="">我的京东</a><span>|</span></li>
					<li><a href="">京东会员</a><span>|</span></li>
					<li><a href="">企业采购</a><span>|</span></li>
					<li><a href="">京东手机</a><span>|</span></li>
					<li><a href="">关注京东</a><span>|</span></li>
					<li><a href="">客户服务</a><span>|</span></li>
					<li><a href="">网址导航</a></li>
				</ul>
				
			</div>
			
		</div>
		<!-- 导航结束 -->
		<!-- 搜索框开始 -->
		<div class="search">
			<div class="warp">
				<img src="img/logo.jpg" alt="logo加载错误">
				<div class="search_div">
					<input type="text" id="search_txt">
					<input type="button" id="search_but" value="搜索">
				</div>
			</div>
		</div>
		<!-- 搜索框结束 -->
		<!-- 标题开始 -->
		<div class="title warp">
			<h3>全部商品</h3>
			<div>
				<span>配送至</span>
				<select>
					<option>余杭</option>
					<option>临安</option>
					<option>萧山</option>
					<option>西湖</option>
				</select>
			</div>
			
		</div>
		<!-- 标题结束 -->
		<!-- 显示菜单的开始 -->
		<div class="tips warp">
			<ul>
				<li>
					<input type="checkbox" />
					全选
				</li>
				<li>商品</li>
				<li>单价</li>
				<li>数量</li>
				<li>小计</li>
				<li>操作</li>
			</ul>
			
		</div>
		<!-- 显示菜单的结束 -->
		<!-- 商品详情开始 -->
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">￥182.5</li>
				<li class="info_6">
					<button>-</button>
					<input type="text" value="1" />
					<button>+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a>删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">￥182.5</li>
				<li class="info_6">
					<button>-</button>
					<input type="text" value="1" />
					<button>+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a>删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">￥182.5</li>
				<li class="info_6">
					<button>-</button>
					<input type="text" value="1" />
					<button>+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a>删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<!-- 商品详情结束 -->
	</body>
</html>

```

```css
.nav{
	height: 30px;
	background-color: #f1f1f1;
}
.warp{
	width: 1000px;
	margin: 0px auto;
}
.nav_ul1,.nav_ul2 li{
	float: left;
}
.nav_ul2{
	float: right;
}
.nav_ul1 li{
	float: left;
	line-height: 30px;
	margin-right: 20px;
}
.nav_ul2 li,.nav_ul2 span{
	line-height: 30px;
	margin-left: 10px;
}
.nav_ul1 a,.nav_ul2 a,.nav_ul2 span{
	font-size: 12px;
	color: gray;
}
.nav a:hover{color: red;}
.search{
	margin-top: 10px;
}
.search img{
	/* 清除之前所有样式 */
	clear: both;
	float: left;
}
.search_div{
	float: right; 
	margin-top: 20px;
}
#search_txt{
	width: 265px;
	height: 21px;
	border: 3px solid #c91623;
	position: relative;
	left: 4px;
	top: -1px;
}
#search_but{
	width: 51px;
	height: 30px;
	background-color: #c91623;
	border: 0px;
	color: #FFFFFF;
}
/* 标题 */
.title{
	margin-top: 100px;
}
.title h3{
	float: left;
	font-size: 23px;
	color: #C91623;623
}
.title div{
	float: right;
	color: gray;
	font-size: 14px;
}
/* 显示菜单开始 */
.tips{
	height: 50px;
	width: 1000px;
	background-color: #f1f1f1;
	margin-top: 130px;
	border: 1px solid #e9e9e9;
}
.tips li{
	float: left;
	line-height: 50px;
	font-size: 12px;
	color: gray;
}
.tips li:nth-child(1){width: 90px;border-top: 3px solid #C91623;}
.tips li:nth-child(2){margin-left: 80px;}
.tips li:nth-child(3){margin-left: 450px;}
.tips li:nth-child(4){margin-left: 70px;}
.tips li:nth-child(5){margin-left: 100px;}
.tips li:nth-child(6){margin-left: 50px;}
/* 商品详情展示 */
.info{
	height: 125px;
	background-color: #fff4e8;
	margin-top: 20px;
	border: 1px solid gray;
	border-top: 3px solid gray;
}
.info li{
	float: left;
	margin-top: 20px;
}
.info a{
	font-size: 12px;
	color: #333333;
}
.info_1{
	margin-left: 23px;
}
.info_2{margin-left: 15px;border: 1px solid gray;}
.info_3{width: 250px;height: 20px;}
.info_4{margin-left: 60px;}
.info_5{margin-left: 80px;}
.info_6{
	margin-left: 30px;
}
.info_6 input{
	width: 30px;
	height: 14px;
	text-align: center;
	position: relative;
	top: -1px;
	left: -4px;
}
.info_6 button{
	width: 30px;
	height: 20px;
}
.info_6 button:last-child{
	position: relative;
	top: 0px;
	left: -9px;
}
.info_7{
	margin-left: 40px;
}
.info_8{
	margin-left: 15px;
}
```

## Javascript

### 引入方式

直接引入

```html
<script type="text/javascript">
    alert("hello")
</script>
```

js文件导入

```html
<script type="text/javascript" src="js/test.js" charset="UTF-8"></script>
```

### js运算符

- 等值符(==) 先比较类型
  - 如果类型一致，再比较内容
  - 如果类型不一致，这时候会进行强制转换到number类型，再进行比较
- 等同符(===) 先比较类型
  - 如果类型一致，再比较内容
  - 如果类型不一致，返回false



### JS选择语句

```javascript
if(){};
if( == true){}else{};
if () {} else if () {} else {}
```

```javascript
switch (a){
    case 10:alert("我是10")
        break;
    case 20:alert("我是20")
        break;
    case 30:alert("我是30")
        break;
    default:
        break;
```

乘法表

```html
<script type="text/javascript" charset="UTF-8">
    for (var a=1;a<=9;a++) {
        for (var b=1;b<=a;b++) {
            document.write(b+"*"+a+"="+a*b+"&nbsp;&nbsp;")
            document.write("&nbsp;&nbsp;&nbsp;&nbsp;")
        }
        document.write("<br />")
    }
</script>
```

### 函数

#### 声明方式

```javascript
// 函数声明方式一
function demo1() {
    alert("函数声明一");
};
demo1();
//函数声明方式二
var demo2=function(){
    alert("函数声明二");
};
demo2();
// 函数声明方式三(new一个函数对象)
var demo3=new Function("alert('我是函数声明三')");
demo3();
```

#### 函数参数

js中形参和实参个数可以不一致

```javascript
// 函数传递参数
function demo4 (a,b) {
    console.log("我是"+a+"\t"+"今年"+b+"岁")
}
demo4("陈",18);
```

#### 函数返回值

如果函数没有return   这时候返回 undefined未定义的值

#### JS数据学习

##### string对象学习

```javascript
/*********String对象学习*************/ 
function teatString(){
    var a="b-j-s-x-t";
    var b=new  String("bjsxt");
    // 获得下标为二的内容
    document.write(b.charAt(2)+"<br />");
    //2 查询字符串下标
    document.write(b.indexOf("sxt")+"<br />");
    // 字符串截取  开始下标   截取长度
    document.write(b.substr(2,3)+"<br />");
    // 截取坐标a到末尾
    document.write(b.substr(1)+"<br />");
    // 字符串截取  开始下标   结束下标
    document.write(b.substring(2,3)+"<br />");
    // 字符串分割-返回数组
    document.write(a.split("-")+"<br />");
}
teatString();
```

##### global对象学习

```javascript
/***********Global对象学习**********/
function testGlobal () {
    var a=1;
    var b="var c=1";
    document.write(a+"<br />");
    document.write(b+"<br />");
    // 把字符串转成可以执行的js代码
    eval(b);
    document.write(c+"<br />");
}
testGlobal();
```

##### array数组对象

数组声明方式

```javascript
function demo1 () {
    // 数组的声明方式一
    var arr=new Array();
    // 方式二  5代表默认数组长度
    var arr2=new Array(5);
    console.log(arr2);
    // 方式三
    var arr3=new Array("你好",123,new String(),true);
    console.log(arr3);
    // 方式四
    var arr4=["bjsxt",123,new String(),false];
    console.log(arr4);
}
demo1();
```

数组使用

```javascript
function demo2 () {
    var arr=[];
    arr[0]="李时珍的皮";
    arr[1]=true;
    arr[2]=new Date();
    arr[6]=12;
    //js中数组的下标可以不连续  如果没有给值就是empty
    console.log(arr);
}
demo2();
```

数组扩容

```javascript
function demo3 () {
    var arr=["bjsxt",123,new Date(),false];
    console.log(arr.length);
    // 扩大数组
    arr.length=10;
    console.log(arr);
    // 缩小数组
    arr.length=2;
    console.log(arr);
}
demo3();
```

数组遍历

```javascript
function demo4 () {
    // 方式一
    var arr=["bjsxt",123,new Date(),false];
    for (var i = 0; i < arr.length; i++) {
        console.log(arr[i]);
    }
    // 方式二
    for(var i in arr){
        console.log(arr[i]);
    }
}
demo4();
```

数组常用操作

```java
//数组添加元素
function demo5 () {
    var arr=["bjsxt",123,new Date(),false];
    console.log(arr);
    // 向数组的末尾添加一个或者更多元素，并返回新的长度
    //arr.push("我们");
    var le=arr.push("我们");
    console.log(arr+"\t"+le);
    // 删除并返回数组最后一个元素
    var pp=arr.pop();
    console.log(pp);
    // 删除并返回数组第一个元素
    var ss=arr.shift();
    console.log(ss);
    //添加到第一个元素并返回
    var uns=arr.unshift("hello");
    // 添加的含义 添加的下标  0  添加的元素
    arr.splice(1,0,"你好","我好")；
}
demo7();
```

### js事件

```javascript
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<script type="text/javascript">
			function demo1 () {
				alert("按钮被点击");
			}
			function demo2 () {
				alert("按钮被双击");
			}
			function demo3 () {
				alert("鼠标事件");
			}
			function demo4 () {
				var e=MouseEvent;
				console.log(e.clin);
			}
			function demo5 () {
				console.log("键盘事件");
			}
			function demo6 () {
				alert("获得焦点事件");
			}
			function demo7 () {
				alert("页面加载完成");
			}
		</script>
	</head>
	<body onload="demo7()">
		<!-- onload--页面被加载 -->
		<!-- 单击事件 -->
		<input type="button" value="单击操作" onclick="demo1();demo2()" /><br /><br />
		<!-- 双击事件 -->
		<input type="button" value="双击操作" ondblclick="demo2() "/><br /><br />
		<!-- 鼠标事件 onmouseover--鼠标放上事件  onmouseout--鼠标离开事件  onmousemove--鼠标移动事件-->
		<div style="width: 300px;height: 300px;background-color: red;" onmousemove="demo4()"></div>
		<!-- 键盘事件  onkeydown--键盘按下事件 onkeyup--键盘弹起事件-->
		<input type="text" onkeyup="demo5()" /><br /><br />
		<!-- 获得焦点 onfocus--获得焦点事件  onblur--失去焦点事件
		onchange--内容改变
		-->
		<input type="text" onchange="demo6()" />
	</body>
</html>
```







### BOM对象

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<script>
			function demo1 () {
				// 含有确认按钮的弹框
				window.alert("弹框A");
			}
			function demo2 () {
				// 含有确认取消的弹框
				var flag=window.confirm("是否删除");
				alert(flag);
			}
			function demo3 () {
				var va=window.prompt("请输入IP地址","127.0.0.1");
				alert(va);
			}
			// 定时器
			function getTime () {
				var date=new Date();
				// 获得时间
				var time=date.toLocaleString();
				//获得id名称是span_1的对象
				var span=document.getElementById("span_1");
                //插入到对象
				span.innerHTML=time;
			}
			function demo4 () {
				window.clearInterval()
			}
			//1s之后进行方法的调用 调用一次
			setTimeout("getTime()",1000);
			//每间隔一秒就会进行方法的调用
			var in1=setInterval("getTime()",1000);
			function demo4 () {
				// 清除定时器
				window.clearInterval(in1);
			}
			function demo5 () {
				window.open("http://www.baidu.com");
			}
			function demo6 () {
				window.close();
			}
		</script>
	</head>
	<body onload="getTime()">
		<p><input type="button" value="弹框A" onclick="demo1()"></p>
		<p><input type="button" value="弹框B" onclick="demo2()"></p>
		<p><input type="button" value="弹框C" onclick="demo3()"></p>
		<p>当前时间是：<span id="span_1"></span></p>
		<p><input type="button" value="清除定时器" onclick="demo4()"></p>
		<p><input type="button" value="打开百度" onclick="demo5()"></p>
		<p><input type="button" value="关闭网页" onclick="demo6()"></p>
	</body>
</html>
```

### BOM常用属性

```javascript
function test01 () {
				var href=window.location.href;
				
				var hostname=window.location.hostname;
				
				var port=window.location.port;
				
				var host=window.location.host; 
				
				//alert(decodeURIComponent(href)+"---"+hostname+"---"+port+"---"+host);
				// 修改当前url地址
				//window.location.href="http://www.baidu.com";
				// 重新加载页面
				window.location.reload();
			}
```

### DOM节点分类

- 元素节点 element node

  ```html
  <a href="链接地址">我的链接</a>
  ```

- 属性节点 attribute node

  ```html
  href="链接地址"
  ```

- 文本节点 text node 链接地址 我的链接

### DOM节点获取

- 直接获取

  - ```html
    document.getElementById("username");
    ```

  - ```html
    document.getElementsByTagName("input");alert(tb[2]);
    ```

  - ```html
    document.getElementsByName("hobby");
    ```

- 间接获取

  - ```html
    professional.childNodes;//获取子节点包含空白文档
    ```

  - ```html
    p2.parentNode;//获取父节点包含空白文档
    ```

  - 
    
    ```html
    p2.nextSibling;//获取下一个节点包含空白文档
    ```
    
  - ```html
    p2.nextElementSibling;//获取下一个节点不包含空白文档
    ```
  
  - ```html
    p2.previousSibling;//获取上一个节点包含空白文档
    ```
  
  - ```html
    p2.previousElementSibling;//获取上一节点不包含空白文档
    ```

### DOM获得元素属性

获得节点对象的属性

```javascript
var ty=inp1.type;
var va=inp1.value;
var na=inp1.name;
```

获得属性的默认值

```javascript
var ty1=inp1.getAttribute("type");
var va2=inp1.getAttribute("value");
```

操作元素属性

```javascript
inp1.type="button";
inp1.onclick=demo2;
inp1.setAttribute("type","button");
```

### DOM获取操作样式

只支持行内式

```javascript
//获取样式
wi=div.style.width;
//操作样式
div.style.width="300px";
div.style.backgroundColor="red";
//通过增加class类增加对应CSS样式
div.className="div2";
```

### DOM操作元素文本内容

```javascript
// 获得元素的文本内容
//有空白文档，会获得里面的html中内容
var inn=div.innerHTML;
// 没有空白文档，只会获得文本信息
var inn2=div.innerText;
console.log(inn);
console.log(inn2);
// 会识别HTML信息
div.innerHTML="<h1>我们不一样</h1>";
div.innerText="我们不一样";
//追加内容
div.innerText+="Hello";
```

### DOM操作元素节点

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<script type="text/javascript">
			function addNode () {
				var fom=document.getElementById("fom");
				//创建节点对象
				var p=document.createElement("p");
				p.innerText="照片：";
				var inp=document.createElement("input");
				inp.type="file";
				var inp2=document.createElement("input");
				inp2.type="button";
				inp2.value="删除";
				inp2.onclick=function() {
					// 移除子节点
					p.removeChild(inp);
					p.removeChild(inp2);
					// 移除本身
					p.remove();
				};
				// 添加节点对象到末尾
				//fom.appendChild(p);
				// 获得最后一个节点对象
				var lastNode=document.getElementById("lastNode");
				// 添加节点到元素之前
				fom.insertBefore(p,lastNode);
				p.appendChild(inp);
				p.appendChild(inp2);
				
			}
		</script>
	</head>
	<body>
		<form id="fom">
			<p>用户名：<input type="text"></p>
			<p>
				照片：<input type="file" accept="image/*">
				<input type="button" value="添加" onclick="addNode()" />
			</p>
			
			<p id="lastNode">
				<input type="button" value="提交">
				<input type="button" value="删除">
			</p>
		</form>
	</body>
</html>
```

创建节点

```javascript
var fom=document.getElementById("fom");
//创建节点对象
var p=document.createElement("p");
```

增加节点

```javascript
p.innerText="照片：";
// 添加节点对象到末尾
fom.appendChild(p);
// 获得最后一个节点对象
var lastNode=document.getElementById("lastNode");
// 添加节点到元素之前
fom.insertBefore(p,lastNode);
```

删除节点

```javascript
// 移除子节点
p.removeChild(inp);
p.removeChild(inp2);
// 移除本身
p.remove();
```





### 案例

#### 图书案例

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<style>
			tr{
				height: 70px;
			}
			td,th{
				width: 150px;
				text-align: center;
			}
			
		</style>
		<script>
			function addNode () {
				var tab=document.getElementById("tab");
				var tr=document.createElement("tr");
				var td1=document.createElement("td");
				var td2=document.createElement("td");
				var td3=document.createElement("td");
				var rm=document.getElementsByName("rm");
				tab.appendChild(tr);
				tr.appendChild(td1);
				td1.innerHTML='<input type="text" value=" " size="10px" />'
				tr.appendChild(td2);
				td2.innerHTML='<input type="text" value=" " size="10px" />'
				tr.appendChild(td3);
				td3.innerHTML='<input type="button"  value="添加" onclick="seaveVal(this);addNode()" /><input type="button" name="rm" value="删除" onclick="removeNode(this)" />';
			}
			function removeNode (thi) {
				var td=thi.parentNode.parentNode;
				td.remove();
			}
			function seaveVal (thi) {
				// 获取父级节点
				var td=thi.parentNode.previousElementSibling;
				var td1=td.previousElementSibling;
				td.innerHTML=td.childNodes[0].value;
				td1.innerHTML=td1.childNodes[0].value;
				
				//td.innerHTML=thi.value;
				
			}
		</script>
	</head>
	<body>
		<table id="tab" border="1px" align="center">
			<tr>
				<th>图书名称</th>
				<th>图书价格</th>
				<th>操作</th>
			</tr>
			<tr>
				<td>javaSE</td>
				<td>19</td>
				<td>
					<input type="button"  value="添加" onclick="addNode()" />
					<input type="button" value="删除"  />
				</td>
			</tr>
			<tr>
				<td>javaEE</td>
				<td>39</td>
				<td>
					<input type="button"  value="添加" onclick="addNode()" />
					<input type="button" value="删除" />
				</td>
			</tr>
		</table>
	</body>
</html>

```

#### 京东案例

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet" type="text/css" href="css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="css/jd.css"/>
		<link rel="stylesheet" type="text/css" href="icon/iconfont.css" />
		<script type="text/javascript" src="js/jd.js">
			
		</script>
	</head>
	<body>
		<!-- 导航开始 -->
		<div class="nav">
			<div class="warp">
				<ul class="nav_ul1">
					<li><a href=""><i class="iconfont">&#xe63d;</i>京东首页</a></li>
					<li><a href="">配送至：北京</a></li>
				</ul>
				
				<ul class="nav_ul2">
					<li><a href="">洋洋宝贝</a><span>|</span></li>
					<li><a href="">我的订单</a><span>|</span></li>
					<li><a href="">我的京东</a><span>|</span></li>
					<li><a href="">京东会员</a><span>|</span></li>
					<li><a href="">企业采购</a><span>|</span></li>
					<li><a href="">京东手机</a><span>|</span></li>
					<li><a href="">关注京东</a><span>|</span></li>
					<li><a href="">客户服务</a><span>|</span></li>
					<li><a href="">网址导航</a></li>
				</ul>
				
			</div>
			
		</div>
		<!-- 导航结束 -->
		<!-- 搜索框开始 -->
		<div class="search">
			<div class="warp">
				<img src="img/logo.jpg" alt="logo加载错误">
				<div class="search_div">
					<input type="text" id="search_txt">
					<input type="button" id="search_but" value="搜索">
				</div>
			</div>
		</div>
		<!-- 搜索框结束 -->
		<!-- 标题开始 -->
		<div class="title warp">
			<h3>全部商品</h3>
			<div>
				<span>配送至</span>
				<select>
					<option>余杭</option>
					<option>临安</option>
					<option>萧山</option>
					<option>西湖</option>
				</select>
			</div>
			
		</div>
		<!-- 标题结束 -->
		<!-- 显示菜单的开始 -->
		<div class="tips warp">
			<ul>
				<li>
					<input type="checkbox" name="fav" onclick="checkTest1(this),checkTest2()" />
					全选
				</li>
				<li>商品</li>
				<li>单价</li>
				<li>数量</li>
				<li>小计</li>
				<li>操作</li>
			</ul>
			
		</div>
		<!-- 显示菜单的结束 -->
		<!-- 商品详情开始 -->
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" name="fav" onclick="checkTest2()" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服1</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">182.5</li>
				<li class="info_6">
					<button onclick="checkTest3(this,1);checkTest2()">-</button>
					<input type="text" value="1" />
					<button onclick="checkTest3(this,2);checkTest2()">+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a href="#" onclick="checkTest4(this),checkTest2()">删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" name="fav" onclick="checkTest2()" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服2</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">182.5</li>
				<li class="info_6">
					<button onclick="checkTest3(this,1);checkTest2()">-</button>
					<input type="text" value="1" />
					<button onclick="checkTest3(this,2);checkTest2()">+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a onclick="checkTest4(this),checkTest2()">删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<div class="info warp">
			<ul>
				<li class="info_1"><input type="checkbox" name="fav" onclick="checkTest2()" /></li>
				<li class="info_2"><img src="img/img1.jpg" width="80px"></li>
				<li class="info_3"><a>【京东超市】春秋季儿童休闲服3</a></li>
				<li class="info_4"><a>颜色：灰色+粉色</a></li>
				<li class="info_5">182.5</li>
				<li class="info_6">
					<button onclick="checkTest3(this,1);checkTest2()">-</button>
					<input type="text" value="1" />
					<button onclick="checkTest3(this,2);checkTest2()">+</button>
				</li>
				<li class="info_7">￥182.5</li>
				<li class="info_8">
					<a onclick="checkTest4(this),checkTest2()">删除</a><br />
					<a>已到我的关注</a>
				</li>
			</ul>
		</div>
		<!-- 商品详情结束 -->
		<!-- 结算 -->
		<div class="balance warp">
			<ul class="balance_ul1">
				<li><input type="checkbox" name="fav" onclick="checkTest1(this),checkTest2()" />全选</li>
				<li><a href="javascript:void(0)" onclick="checkTest5()">删除选中商品</a></li>
				<li><a href="">移到我的关注</a></li>
				<li><a href="">清除下柜商品</a></li>
				<li><a href=""></a></li>
				<li><a href=""></a></li>
				<li><a href=""></a></li>
			</ul>
			<ul class="balance_ul2">
				<li>已经选择<span id="snum">0</span>件商品</li>
				<li>总价 <span id="zongjia">￥0</span></li>
				<li>
					<button onclick="test()">去结算</button>
				</li>
			</ul>
		</div>
	</body>
</html>
```

```javascript
var fav=document.getElementsByName("fav");
//判断是否全选
console.log(fav);
function checkTest1(th){
	var flag=th.checked;
	
	for (var i in fav){
		fav[i].checked=flag;
	}
}
//全部选择后勾选全选
function checkTest2() {
	var flag=true;
	for(var i=1;i<fav.length-1;i++){
		if(!fav[i].checked){
			flag=false;
			break;
		// 获得ul父节点
			var par=fav[i].parentNode.parentNode;
			var li=par.getElementsByTagName("li");
			var z=li[6].innerHTML.split("￥")[1];
		// 获得商品总价格
			zong+=Number(z);
			document.getElementById("zongjia").innerText=zong;
		}
	}
	// 决定是否勾选
	fav[0].checked=flag;
	fav[fav.length-1].checked=flag;
	
	// 价格统计  商品总价格
	var zong=0;
	// 统计勾选对象
	var num=0;
	// 统计商品数量
	var spNum=0;
	for (var i = 1; i < fav.length-1; i++) {
		
		if(fav[i].checked){
			num++;
		// 获得ul父节点
			var par=fav[i].parentNode.parentNode;
			var li=par.getElementsByTagName("li");
		// 获得单个商品的总价格
			var z=li[6].innerHTML.split("￥")[1];
		// 获得商品总价格
			zong+=Number(z);
			//alert(fav[i].checked+"---"+zong);
			document.getElementById("zongjia").innerText=zong;
			
			//获得商品总数量
			var z2=li[5].getElementsByTagName("input");
			var num2=z2[0].value;
			spNum+=Number(num2);
			document.getElementById("snum").innerHTML=spNum;
		
		
		
		}
	}
	if(num==0){
		document.getElementById("zongjia").innerText=0;
		document.getElementById("snum").innerText=0;
	}
}

function checkTest3 (th,sig) {
	var pre;
	if (sig=="1") {
		pre = th.nextElementSibling;
		if (Number(pre.value)>0) {
			pre.value=Number(pre.value)-1;
		}
	}else{
		pre=th.previousElementSibling;
		pre.value=Number(pre.value)+1;
	}
	var val = pre.parentNode.previousElementSibling.innerHTML;
	var zong=Number(val)*Number(pre.value);
	pre.parentNode.nextElementSibling.innerHTML="￥"+zong;

}

function checkTest4 (th) {
	var ul=th.parentNode.parentNode.parentNode;
	ul.remove();
}
function checkTest5 () {
//后到前
	for(var i=fav.length-2;i>0;i--){
		if(fav[i].checked){	
			console.log(i)
			var ul=fav[i].parentNode.parentNode.parentNode;
			var ul1=fav[i].parentNode.parentNode.getElementsByTagName("a")[0].innerHTML;
			ul.remove();
		}
	}
}

// function checkTest5 () {
// 	// 前到后
	
// 	for(var i=1;i<4;i++){
// 		fav=document.getElementsByName("fav");
// 		debugger
// 		if(fav[i].checked){	
// 			//console.log(i);
// 			var ul=fav[i].parentNode.parentNode.parentNode;
// 			//var iul1=fav[1].parentNode.parentNode.getElementsByTagName("a")[0].innerHTML;
// 			ul.remove();
// 		}
// 	}
// }
```

### prototype原型链

类似继承

```javascript
function user (age,sex) {
    this.name="张三";
    this.age=age;
    this.sex=sex;
    this.eat=function(){
        // 方法体
        alert("我是user中的吃的方法");
    }
}

function user2 () {
    this.run=function () {
        alert("我是user2中跑的方法");
    }
}

// prototype原型链   继承
user.prototype=new user2();
// 创建对象
var us=new user(12);
us.look="看雾霾";//js中对象使用比较灵活
//alert(us.name+"----"+us.age+"----"+us.sex+"--"+us.look);
us.run();
```

## jQuery

### 概述

1. 为什么使用jQuery(js遇到问题)

   1. 选择功能弱
   2. DOM操作频繁至极
   3. 浏览器兼容不好
   4. 动画效果弱

2. 什么是jQuery(概念)

   jQuery(javascriptQuery)javascript代码库

### jQuey定义和调用



```javascript
// 定义
function $(id) {
	var dom=document.getElementById(id);
	return dom;
}
// 调用
$("div");
```

### 认识jQuery

```javascript
<script src="js/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
    //js的方式实现各行变色的效果	
    /* window.onload=function(){

		  	 	//获得所有的tr对象

		  	 	var  tr =document.getElementsByTagName("tr");

		  	 	for(var i =0;i<tr.length;i++){

		  	 		 if(i%2==0){
		  	 		 	tr[i].style.backgroundColor="red";

		  	 		 }else {

		  	 		 	tr[i].style.backgroundColor="green";
		  	 		 }
		  	 	}
		  	 }*/
    //JQ实现的
    $(function(){
    	$("tr:odd").css("background-color","red");
})
/*
		  	 window.onload=function(){
		  	 	alert("123");
		  	 }
		  	 window.onload=function(){
		  	 	alert("456");
		  	 }*/
$(function(){

    alert("123");

})

jQuery(function(){

    alert("456");
})

$(document).ready(function(){

    alert("789");
})
</script>
```

### jQuery元素选择器

id选择器

```javascript
var zh1=$("#zh");
```

元素选择器

```javascript
var inp=$("input");
```

类选择器

```javascript
var inp2=$(".inp");
```

通用选择器

```javascript
$("*").css("background-color","greeyellow");
```

分组选择器

```html
<div>div</div>
<p class="a">p class="a"</p>
<span>span</span>
<p class="b">p class="b"</p>
```

```javascript
$("div,span,p.a");
```

jQuery获得内容操作

```javascript
alert(inp2.eq(0).val());
```

jQuery和js对象转换

```javascript
var zhh=$(zh);	//js对象转jQuery对象
console.log(zh1[0]);	//jQuery对象转JS对象
```

### jQuery层级选择器

div下面包含的所有span标签

```javascript
$("div span").css("background-color","red");
```

div下面的直系子元素

```javascript
$("div>span").css("background-color","green");
```

紧挨着的span标签

```javascript
$(""#sp1+span).css("background-color","red");
```

获得指定元素后面同级的span标签

```javascript
$("#sp1~span").css("background-color","aqua");
```

### jQuery其他选择器

选择第一行

```javascript
$("ul li:fist")
$("ul li").fist()
```

选择最后一行

```javascript
$("ul li:last")
$("ul li").last()
```

获得索引奇偶数---索引0开始

```javascript
$("ul li:odd");奇数
$("ul li:even");偶数
```

获得索引下标为3的对象

```javascript
$("ul li:eq(3)")
```

获得大于指定索引下标的对象

```javascript
$("ul li:gt(3)")
```

获得小于指定下标的对象

```javascript
$("ul li:lt(3)")
```

### 子选择器

```javascript
$("ul li:nth-child(1)");选择指定索引--从1开始
$("ul li:first-child");选择每个子标签第一个标签
$("ul li:last-child");选择每个子标签最后一个标签
$("ul li:only-child");选择每个子标签下面只有一个的标签
```

### 属性选择器

```javascript
$("input[type=text]");//type等于text
$("input[name^=z]");//name属性以z开头的
$("input[name$=d]");//name属性以d结尾的
$("input[name*=p]");//name属性包含p的
$("input[name!=pwd]");//name属性不是pwd的
$("input[type=text][name^=z]");//type等于text且name以z开头的
```

### from表单选择器

```javascript
//获得from中所有的表单项
$(":input");
//获得标签名是input的所有标签对象
$("input");
//获得type属性是text的对象
$(":text");
$(":password");
//匹配所有不可见元素,或者type为hidden的元素
<tr style="display:none"><td>Value1</td></tr>
<input type="hidden" name="id">
$("tr:hidden");
$("input:hidden");
```

表单属性选择器

```javascript
$("input:disabled");//获得不可用的元素
$("input:enabled");//获得不是disabled的元素
$("input:checked");//获得带有预选值的标签
$("select option:selected");//匹配所有选中的option元素
```

内容选择器-查找所有不包含子元素或者文本为空的元素

```javascript
$("td:empty");
```

### 操作页面样式

事件绑定到按钮

```java
$(function () {
    $("#bu1").click(function () {
        //事件;
    })
})

```
操作CSS

```javascript
// 获得css样式
var wid=div.css("width");
var hit=div.css("height");
//console.log(wid+"---"+hit);
// 操作css样式
div.css("width","400px");
div.css("height","500px");
div.css("background-color","red");
div.css("backgroundColor","red");
// 以上内容综合---json格式
div.css({"width":"400px","height":"500px",
    "background-image":"url(img/img01.png)",
    "background-size":"400px"})
```

通过jQuery添加类

	$("#div1").attr("class","div");
	$("#div1").addClass("div");

### 操作页面元素属性

```javascript
// 获得元素对象
var tex=$("#inp1");
// 获得元素对象属性
var te=tex.attr("type");
var cl=tex.attr("class");
var val=tex.attr("value");//获得元素默认固有属性值
var tal=tex.val();//获得的是当下文本框的value值
console.log(te+"---"+cl+"---"+val);
// 操作元素对象的属性
document.getElementById("inp1").className="div_cll";
tex.attr("type","button");
tex.attr("value","测试按钮");
tex.attr({"type":"button","value":"测试按钮"})
var ch=$("#fav").attr("checked");//返回checked或undefined
var ch1=$("#fav").prop("checked");//返回true或false
var ch2=$("#fav").prop("checked","true");//设置默认值选项 
alert(ch1);
```

### 操作页面文本

```javascript
//获得元素内容，含有HTML标签
div=$("#div1");
div.html();
//获得元素文本，不含有HTML标签
div.text();
//操作元素对象的内容和值
div.html("<b>我们都爱笑</b>");
div.text(div.text()+"我们都爱笑");//追加
$("#inp1").val("sxt");//操作value值
$("#inp1").val($("#inp1").val()+"sxt");//追加value值
```

### 操作元素对象的节点

添加子元素节点

```javascript
// 创建新的元素
var p=$("<p>List Item6</p>");
//增加子元素到末尾
$("#div1").append(p);//方法一
p.appendTo("#div1");//方法二
//增加子元素到开头
$("#div1").prepend(p);
p.prependTo("#div1");
```

添加平级元素节点

```javascript
//添加平级元素节点到元素之前
p.insertBefore("#div1");
$("#div1").before(p);
//添加平级元素节点到元素之后
p.insertAfter("#div1");
$("#div1").after(p);
```

复制节点

```javascript
var p=p.clone();
$("#div1").append(p);
```

替换指定节点

```javascript
//替换指定节点
$("div p:nth-child(1)").replaceWith(p);
p.replaceAll("div p:nth-child(5)");
```

删除元素节点

```java
// 删除元素节点
$("#div1").remove();
$("div p:first").remove();
```

清空内容-不会删除本身

```javascript
//清空内容-不会删除本身
$("#div1").empty();
$("div p:nth-child(2)").empty();
```

其他操作方法

```javascript
//获得父节点
$(obj).parent();
//查找元素标签
$("p").find("span");
```

### 事件绑定

绑定一个事件

```javascript
$(function () {
    //绑定方法一
    $("#bu1").click(function () {
        alert("单击事件");
    })
    //绑定方法2
    $("#bu2").bind("click",function () {
		alert("单击事件2");
    })
})
```

绑定多个事件

```javascript
$(function(){
    //绑定多个事件
    $("#bu2").bind({
        "click":function () {},
        "dblclick":function () {},
        "blur":function () {},
    })
})
```

一次事件绑定-只执行一次

```javascript
$(function () {
    //事件执行一次后销毁
    $("#bu3").one("click",function(){
        alert("一次事件绑定")
    })
    //绑定多个事件  
    $("#bu3").one({
        "click":function () {alert("1")},
        "dblclick":function () {alert("2")},
    })
})
```

事件转发调用

```javascript
//trigger事件转发调用操作
$("#bu4").click(function () {
    $("#bu1").trigger("click");
    $("#bu2").trigger("dblcick");
})
```

事件解绑

```javascript
//----事件解绑------//
$("#bu5").click(function () {
    $("#bu2").unbind();//解绑所有事件
    $("#bu2").unbind("click");//解绑指定事件
})
```

#### jQuery内置遍历函数

```javascript
//遍历函数
chk.each(function () {
    if(!$(this).prop("checked")){
        flag=false;
        return;	
    }
})
```



### 动画

```javascript
$(function () {
    $("#bu1").click(function () {
        // 获得div对象
        var div1=$("#div1");
        div1.hide(3000);//3s隐藏
        div1.show(3000);//3s显示
        $("div").toggle(3000);//隐藏的显示，显示的隐藏
        div1.slideUp(3000);//向上滑动
        div1.slideDown(3000);//向下滑动
        $("div").slideToggle(3000);//滑动上-滑动下  滑动下-滑动上
        div1.fadeOut(3000);//淡出
        div1.fadeIn(3000);//淡入
    })
})
```

### 图书案例

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<script src="js/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/bg.js" type="text/javascript" charset="utf-8"></script>
	</head>
	<body>
		<h3>jQuery操作表格</h3>
		<hr />
		<input type="button" id="fx" value="反选" />
		<input type="button" id="addRow" value="新增一行" />
		<input type="button" id="delRow" value="删除行" />
		<input type="button" id="copyRow" value="复制行" />
		<table border="1px" cellpadding="10px" cellspacing="0" id="ta">
			<tr>
				<td width="50px"><input type="checkbox" name="chks" id="chks" value="1" /></td>
				<td width="200px">书名</td>
				<td width="200px">作者</td>
				<td width="200px">数量</td>
				<td width="200px">操作</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="chk" id="" value="2"/></td>
				<td>《Java编程之道》</td>
				<td>wollo</td>
				<td>10</td>
				<td>
					<input type="button" class="bu1" value="修改数量" onclick="change(this)" />
					<input type="button" class="bu1" value="删除"/>
				</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="chk" id="" value="3" /></td>
				<td>《Python和我的故事》</td>
				<td>赵老师</td>
				<td>10</td>
				<td>
					<input type="button" class="bu1" value="修改数量"/>
					<input type="button" class="bu1" value="删除"/>
				</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="chk" id="" value="4" /></td>
				<td>《web开发详解》</td>
				<td>张老师</td>
				<td>30</td>
				<td>
					<input type="button" class="bu1" value="修改数量"/>
					<input type="button" class="bu1" value="删除"/>
				</td>
			</tr>			
		</table>
	</body>
</html>
```

```javascript
$(function () {
	// 全选
	$("#chks").click(function () {
		var flag=$(this).prop("checked");
		$("input[name=chk]").prop("checked",flag);
	})
	//没有全部选择自动取消勾选-全选
	$("input[name=chk]").click(function () {
		var flag=true;
		var chk=$("input[name=chk]");
		//遍历函数
		chk.each(function () {
			if(!$(this).prop("checked")){
				flag=false;
				return;	
			}
		})
		$("#chks").prop("checked",flag);
	})
	// 反选
	$("#fx").click(function () {
		var chk=$("input[name=chk]");
		chk.each(function () {
			$(this).prop("checked",!$(this).prop("checked"));
		})
	})
	// 新增一行
	$("#addRow").click(function(){
		var tab=$("#ta");
		tab.append('<tr><td><input type="checkbox" name="chk" id="" value="2"/></td><td><input type="text" onblur="saveVal(this)" /></td><td><input type="text" onblur="saveVal(this)" /></td><td><input type="number" onblur="saveVal(this)" /></td><td><input type="button" class="bu1" value="修改数量" onclick="change(this)" /><input type="button" class="bu1" value="删除"/></td></tr>');
	})
	//删除选择行
	$("#delRow").click(function () {
		var del=$("input[name=chk]:checked");
		if(del.length==0){
			alert("至少选择一个");
		}else{
			del.parent().parent().remove();
		}
	})
	// 复制行
	$("#copyRow").click(function () {
		var copy=$("input[name=chk]:checked");
		if(copy.length==0){
			alert("至少选择一个");
		}else{
			// 复制
			var tr=copy.parent().parent().clone();
			// 粘贴
			$("#ta").append(tr);
		}
	})

})
// 修改数量
function change (th) {
	// tr节点
	var par=$(th).parent().parent();
	// 子节点
	par.children().eq(3).html("<input type='number' size='3px' onblur='bul(this)' />");
}
// 失去焦点保存
function bul(th) {
	var par=$(th).parent().parent();
	par.children().eq(3).html(th.value);
}
// 文本框失去焦点
function saveVal(th) {
	var par=$(th).parent();
	par.html(th.value);
}
```

## Ajax

异步javascript和xml

### 创建请求

get

```javascript
// 创建Ajax对象
var xhr=new XMLHttpRequest();
// 告诉Ajax以什么样的方式 发送请求给 谁
xhr.open('get','http://httpbin.org/get');
// 发送请求
xhr.send()
// 处理响应
xhr.onload=function(){
    var content=document.getElementById('content');
    //content.innerHTML=xhr.responseText;
    console.log(xhr.responseText);
}
```

post

```javascript
function submitForm () {
    var name=document.getElementById("zh");
    var pwd=document.getElementById("pwd");
    // 创建Ajax对象
    url="http://httpbin.org/get";
    params="name="+name+"&pwd"+pwd;
    var xhr=new XMLHttpRequest();
    // 告诉Ajax以什么样的方式 发送请求给 谁
    xhr.open('post',url);
    xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
    // 发送请求
    xhr.send(params);
    // 处理响应
    xhr.onload=function(){
        console.log(xhr.responseText);
    }
}
```

```javascript
function submitForm2 () {
    var name=document.getElementById("zh").value;
    var pwd=document.getElementById("pwd").value;
    // 创建Ajax对象
    url="http://httpbin.org/get";
    params={"name":name,"pwd":pwd};
    params=JSON.stringify(params);
    var xhr=new XMLHttpRequest();
    // 告诉Ajax以什么样的方式 发送请求给 谁
    xhr.open('post',url);
    xhr.setRequestHeader('Content-Type','application/json');
    // 发送请求
    xhr.send(params);
    // 处理响应
    xhr.onload=function(){
        console.log(xhr.responseText);
    }
    xhr.onerror=function(){
        console.log("网络中断了");
    }
}
```

### 创建模拟服务器

```python
from flask import Flask,request,render_template

app=Flask(__name__)

@app.route('/login',methods=['GET','POST'])
def login():
    if request.method=='GET':
        return 'get访问成功'
    elif request.method=='POST':
        return  'post访问成功'
@app.route('/')
def test():
    return render_template('01ajax基本使用.html')
if __name__ == '__main__':
    app.run(debug=True)
```

### 状态码

获取状态码

```javascript
xhr.readyState
```



- 0：请求未初始化
- 1：服务器连接已建立
- 2：请求已接收
- 3：请求处理中
- 4：请求已完成，且响应已就绪

### Ajax封装

```javascript
function ajax (options) {
    var xhr=new XMLHttpRequest();
    xhr.open(options.type,options.url);
    xhr.send();
    xhr.onreadystatechange=function () {
        if(xhr.readyState==4 && xhr.status==200){
            console.log(xhr.responseText);
        }
    }
}

function test1 () {
    ajax({
        type:'get',
        url:'/login'
    })
}
```

