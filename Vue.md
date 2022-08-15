# Vue框架

## 准备工具

- nodejs安装

- cnpm安装

  ```shell
  npm install -g cnpm --registry=https://registry.npm.taobao.org
  ```

- webpack构建工具

## Vue安装

Vue官网

```http
https://cli.vuejs.org/zh/
```

安装

```shell
//设置npm安装目录
npm config set prefix “d:\nodejs\node_global”
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install -g @vue/cli
```

创建项目

```shell
vue create my-project
#or
vue ui
```

安装jQuery

```shell
npm install --save jquery
```



## Vue基础知识

### 模板语法

1. 插值
   1. 文本：{{}}

      ```vue
      <template>
        <div id="app">
      	<h1>{{msg}}</h1>
      	<h2>{{message}}</h2>
        </div>
      </template>
      
      <script>
          export default {
            name: 'app',
            data() {
              return {
                  msg: "这是一个模板语法",
                  message: "这是语法2",
              }
            }
          }
      </script>
      
      <style>
          
      </style>
      ```

   2. 原始HTML：v-html

      ```vue
      <template>
        <div id="app">
      	<p v-html="price"></p>
        </div>
      </template>
      
      <script>
          export default {
            name: 'app',
            data() {
              return {
                  price:"<b>语法</b>",
              }
            }
          }
      </script>
      ```

   3. 动态属性：v-bind:attr

      ```vue
      <div id="app">
          <div v-bind:class="active_class">hello</div>
          <div v-bind:id="active_id">Welcome</div>
      </div>
      export default {
      	name:"app",
      	data() {
      		return {
      			active_class: "class1",
      			active_id:"id1"
      		}
      	},
      }
      ```

   4. 模板语法使用限制：每个绑定都只能包含单个表达式

      ```vue
      //三元表达式
      <p>{{num==3 ? "yes" : "no"}}</p>
      //javascript表达式
      <p>{{num+1}}</p>
      <p>{{num*1}}</p>
      ```

2. 指令

   ```vue
   v-开头的指令
   v-html
   v-bind
   ```

3. 缩写

   1. v-bind:缩写   ->   :

### 属性

ref属性

- 加在普通元素可以操作DOM元素

  ```html
  <div ref="test">test</div>
  console.log(this.$refs.test)
  <!--打印出来就是绑定的dom对象可以用来执行一些dom操作，比如操作样式，获取属性等-->
  let testDom = this.$refs.test
  testDom.style.height = '200px'
  testDom.style.background = 'red'
  console.log(testDom.clientHeight)
  ```

- 循环渲染

  ```html
  //简单的数组:
  list:[1,2,3,4]
  //绑定在循环渲染上
  <ul>
      <li v-for="(item,index) in list" :key="index" ref="list">
          {{index}}--{{item}}
      </li>
  </ul>
  //打印看一下这个ref="list"是什么
  console.log(this.$refs.list)
  <!--打印出数组数组，也很好理解，数组的每一项就是每个li元素-->
  ```

- 绑定在组件标签

  ```html
  <HelloWorld ref="my_hello" />
  <button @click="log_hello">获取Hello变量</button>
  methods:{
      log_hello(){
          this.$refs.my_hello.msg="Hello新变量"
      }
  },
  <!--这些属性里面有一个$el就是dom对象，是和直接绑定在dom元素上获取的一样-->
  let testDom = this.$refs.test.$el
  console.log(testDom.clientHeight)  //打印出来就是设置的200
  <!--调用在之前组件里面定义的_alert()方法-->
  this.$refs.test._alert()
  ```

  

### 条件渲染

1. v-if (基于元素的移除和添加)

   ```vue
   <!--flag为true显示，false不显示-->
   <p v-if="flag">显示</p>
   ```

2. v-else

   ```vue
   <!--flag为true显示第一个标签，为false显示第二个标签-->
   <p v-if="flag">真</p>
   <p v-else>假</p>
   ```

3. v-if-elseif-else

   ```vue
   <p v-if="flag==true">孙悟空</p>
   <p v-else-if="flag==false">六耳猕猴</p>
   <p v-else>如来佛祖</p>
   ```

4. 组

   ```vue
   <!--div组  会渲染div标签-->
   <div v-if="flag">
       <p>1</p>
       <p>2</p>
       <p>3</p>
   </div>
   <!--template组 不会渲染标签和多一个新容器-->
   <template v-if="flag">
   <p>1</p>
   <p>2</p>
   <p>3</p>
   </template>
   ```

5. v-show(基于CSS元素的显示与隐藏)

   ```vue
   <div v-show="flag">显示</div>
   ```

   

### 列表渲染

1. v-for

   ```vue
   <ul>
       <li v-for="(item,index) in result" :key="index">{{item.text}}--{{item.id}}</li>
   </ul>
     data() {
     	return {
   		result:[
   			{
   				id:1001,
   				text:"音乐"
   			},
   			{
   				id:1002,
   				text:"美术"
   			},
   			{
   				id:1003,
   				text:"体育"
   			}
   		]
     	}
     }
   ```

   ```vue
   <ul>
       <li v-for="(item,index) in result1" :key="index">
           <p>{{item.title}}</p>
           <p>{{item.author}}</p>
           <p>{{item.publishedAt}}</p>
       </li>
   </ul>
   result1:[
       {
           title: 'How to do lists in Vue',
           author: 'Jane Doe',
           publishedAt: '2016-04-10'
       },
       {
           title: 'How',
           author: 'Jane',
           publishedAt: '2019-04-10'
       },
   ]
   ```

2. 数组

   ```vue
   addItemHandle(){
       this.result.push({
       id:1004,
       text:"加油加油",
   })
   ```

   

### 事件处理

1. v-on:click

   ```vue
   <p v-if="flags">我是新人，请多关照</p>
   <button v-on:click="clickHandle()">按钮</button>
   ```

   

2. methods:承载事件函数

   ```vue
   export default {
     name: 'app',
     data() {
     	return {
   		flags:false,
     	}
     },
     methods:{
   	  clickHandle(){
   		  console.log("hello");
   		  this.flags=!this.flags;
   	  }
     }
   }
   ```

3. v-on:  ->   @

4. 事件传递参数

   ```vue
   <!--不传参默认返回event对象-->
   <ul>
       <li @click="getMessage" v-for="(item,index) in result" :key="index">{{item.text}}--{{item.id}}</li>
   </ul>
   getMessage(e){
   	console.log(e);
   }
   ```

   ```vue
   <!--事件传参-->
   <ul>
       <li @click="getMessage(item.text)" v-for="(item,index) in result" :key="index">{{item.text}}--{{item.id}}</li>
   </ul>
   getMessage(data){
       console.log(data);
   }
   ```

   ```vue
   <!--传参同时返回Event-->
   @click="getMessage(item.text,$event)"
   getMessage(data,e){
       console.log(data,e);
   }
   ```

5. element-ui绑定事件

   ```vue
   @click.native.prevent="Hello"
   ```
   
6. 修饰符

   .prevent阻止跳转

   ```vue
   <a @click.prevent="clickIwenHandle" href="http://iwenwiki.com">iwen</a>
   ```

   .once事件只执行一次

   ```vue
   <li @click="getMessage(item.text)" v-for="(item,index) in result" :key="index">{{item.text}}--{{item.id}}</li>
   ```




### 表单输入与绑定

1. v-model

   ```vue
   <p>{{username}}</p>
   <input type="text" v-model="username" />
   <button type="button" @click="click_console">获取</button>
   ```

2. 修饰符

   .lazy

   ```vue
   <!--懒加载-->
   <input type="text" v-model.lazy="username" />
   ```

   .number

   .trim

### 计算属性vs监听器

1. computed

   ```vue
   <p>{{getMessage}}</p>
   computed:{
       getMessage(){
           return this.message.split('').reverse().join('');
       }
   }
   ```

2. watch  返回新值和老值

   ```vue
   <input type="text" v-model="nike" />
   data() {
     	return {
   		nike:"",
   		}
   	},
   watch:{
   	  nike(newValue,oldValue){
   		  console.log(newValue,oldValue);
   	  }
     }
   ```

   

### class与style绑定

1. 数组

   ```vue
   <p :class="['a1','a2']">Hello</p>
   <p :class="[{'active':true},'a1','a2']">Hello</p>
   ```

2. 对象

   ```vue
   <p :class="{'active':true}">Hello</p>
   ```

### 组件基础

1. 创建组件

   ```vue
   <template>
   	<div>
   		<!-- 唯一根元素 -->
   	</div>
   </template>
   
   <script>
   	export default {
   	}
   </script>
   
   <style scoped>
   
   </style>
   ```

2. 引用组件

   ```vue
   <Hello />
   <Hello></Hello>
   import Hello from "./components/Hello.vue"
   components:{
   	Hello, //注入组件
   }
   ```

   ```vue
   组件在使用的时候才会加载
   const Child2 = () => import ('./Child2')
   ```

3. 组件是独立实例化，data必须是一个函数

   ```vue
   <p>{{count}}</p>
   <button @click="count +=1">按钮</button>
   data() {
       return {
           count: 0
       }
   },
   ```

4. prop  父传子

   App.vue入口文件1

   ```vue
   :num 加":"字符串变动态对象
   <Hello title="组件基础" :num="1"/>
   <Hello title="组件深入"/>
   <Hello />
   ```

   Hello.vue子组件

   ```vue
   <p>组件:{{title}}</p>
   
   props:{
       title:{
           type:String,
           default:"",
       }
   }
   ```

5. 子传父

   App.vue

   ```vue
   <Hello @onMyEvent="getMessagetwo"></Hello>
   	  getMessagetwo(mes){
   		  console.log(mes);
   	  }
   ```

   Hello.vue

   ```vue
   <button @click="sendMessage">传递数据</button>
   message:"我是hello的数据"
   sendMessage(){
   	this.$emit("onMyEvent",this.message)
   }
   ```

### 插槽

传递数据和视图

1. 插槽内容：<slot>

2. 编译作用域

   在写的地方声明而不是最终呈现的地方声明

   ```vue
   ##主入口文件
   <MyComponents>
       <p>{{msg}}</p>
   </MyComponents>
   msg:"我是插槽内容"
   ```

   ```vue
   ##子组件
   <div>
       <slot></slot>
   </div>	
   ```

3. 后备内容

   ```vue
   <slot>默认值/缺省值</slot>
   ```

4. 具名插槽

   ```vue
   ##App入口
   <MyComponents>
       <template v-slot:header>
   		<p>{{msg}}</p>
       </template>
       <template v-slot:main>
   		<p>我是腰部</p>
       </template>
       <template v-slot:body>
   		<p>我是内容</p>
       </template>
       <template v-slot:footer>
   		<p>我是底部</p>
       </template>
   </MyComponents>
   ```

   ```vue
   ##子组件
   <div>
       <slot name="header">默认值/缺省值</slot>
       <slot name="main">默认值/缺省值</slot>
       <slot name="body">默认值/缺省值</slot>
       <slot name="footer">默认值/缺省值</slot>
   </div>	
   ```

   作用域插槽

   ```vue
   ##App主入口
   <template v-slot:default="slotProps">
   	<h3>{{slotProps.demo}}</h3>
   </template>
   ##子组件
   <slot :demo="demo"></slot>
   demo:"我是demo",
   ```

### 动态组件&异步组件

动态组件

keep-alive缓存

```vue
<keep-alive>
	<component :is="currentComponent"></component>
</keep-alive>
currentComponent:Child1,
changeViewHandle(){
    if(this.currentComponent==Child1){
        this.currentComponent=Child2
    }else{
        this.currentComponent=Child1
    }
}
```

异步组件

```vue
组件在使用的时候才会加载
const Child2 = () => import ('./Child2')
```

## 路由Router

### 安装

```shell
cnpm install vue-router --save
```

main.js添加

```js
import VueRouter from 'vue-router'
Vue.use(VueRouter)
```

### 基础使用

```js
import Home from "./pages/Home.vue"
import User from "./pages/User.vue"

Vue.use(VueRouter)
Vue.config.productionTip = false
/**
 * 定义路由
 */
const routes =[
	{path:"/",component:Home},
	{path:"/user",component:User},
]
/**
 * 创建路由对象
 */
const router = new VueRouter({
	routes
})
/**
 * 挂载路由
 */
new Vue({
	router,
  render: h => h(App),
}).$mount('#app')
```

```vue
<div id="">
    <template>
		<router-link to="/">首页</router-link> |
		<router-link to="/user">用户中心</router-link>
		<router-view></router-view>
    </template>
</div>
```

### 动态路由匹配

#### 动态路由传递参数

```vue
<router-link to="/user/123">用户中心</router-link>
```

```js
{path:'/User/:id',component:User}
```

```vue
<h2>用户:{{$route.params.id}}</h2>
```

#### 文件分离

```shell
##src下新建目录router，并创建index.js
import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from '../pages/Home.vue'
import User from '../pages/User.vue';
Vue.use(VueRouter)

/**
 * 定义路由
 */
const routes=[
	{path:'/',component:Home},
	{path:'/User/:id',component:User}
]
/**
 * 创建路由对象
 */
const router=new VueRouter({
	routes
})

export default router
```

```main.js
import Vue from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router/index.js'

Vue.config.productionTip = false

/**
 * 挂载路由
 */
new Vue({
	router,
  render: h => h(App),
}).$mount('#app')
```

### 路由嵌套-二级路由

文件树形图

```shell
D:\HTML\VUE\VUE_ROUTE\SRC
│  App.vue
│  main.js
│  registerServiceWorker.js
│
├─assets
│      logo.png
│
├─components
├─pages
│  │  Home.vue
│  │  News.vue
│  │  User.vue
│  │
│  └─newssub
│          sports.vue
│          yule.vue
│
└─router
        index.js
```

```js
##index.js
import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from '../pages/Home.vue'
import User from '../pages/User.vue'
import News from '../pages/News.vue'
import Sports from '../pages/newssub/sports.vue'
import Yule from '../pages/newssub/yule.vue'
Vue.use(VueRouter)

/**
 * 定义路由
 */
const routes=[
	{path:'/',component:Home},
	{path:'/User/:id',component:User},
	{
		path:'/news',
		component:News,
		children:[{path:'sports',component:Sports},{path:'yule',component:Yule}],
	}
]
/**
 * 创建路由对象
 */
const router=new VueRouter({
	routes
})
export default router
```

- children:[{path:'sports',component:Sports},} 声明子路由

```vue
##News.vue
<h2>新闻</h2>
<template>
    <router-link to="/news/sports">体育</router-link> |
    <router-link to="/news/yule">娱乐</router-link>
    <router-view></router-view>
</template>
```

### 编程式导航

##### 路由事件跳转

```javascript
this.$router.push('/');//A跳B有缓存，可以返回
this.$router.replace('/');//A跳B，B完全覆盖A，不能返回
this.$router.push({name:'Home'});//也可使用命名路由方式跳转
```

### 命名路由

给路由增加别名

```vue
<router-link :to="{ name:'Home'}">首页</router-link>
<router-link :to="{name:'User',params:{id:'1001'},}">用户中心</router-link>
{
    path:'/',
    name="Home",
    component:Home,
},
```

### 命名视图

添加多个视图同时进行显示，比如**广告**

```js
###index.js
import AD from '../pages/AD.vue'
{
		path:'/',
		name:"Home",
		components:{
			default:Home,
			ad:AD,
		},
	},
###app.vue
<router-view name="ad"></router-view>
```

##### 重定向页面

默认显示页面

```js
###默认显示体育页面
{path:'/news',
 component:News,
 redirect:'/news/sports',}
```

##### 别名

```js
####访问/news 和 /hello一个效果
{path:'/news',
 alias:'/hello',
 component:News,
 redirect:'/news/sports',}
```

### HTML5  History模式-路径有#号

history模式直接访问某页面可能出现404

```js
const router=new VueRouter({
	mode:"history",//去除#号
	routes
})
```

## 路由进阶

### 导航守卫

1. 全局前置守卫

   ```js
   router.beforeEach((to,from,next)=>{
   	console.log(from);
   	console.log(to);
   	next();//允许跳转，必须
   })
   ```

2. 全局后置钩子

   ```js
   router.afterEach((to,from)=>{
   	console.log(from,to);
   })
   ```

3. 路由独享守卫

   ```js
   ##只在某一个组件生效
   {
       path:"/",
       component:Home,
           beforeEnter(to,from,next){
           console.log(from,to);
           next();
       },
   },
   ```

4. 组件内守卫

   ```vue
   export default{
   	beforeRouteEnter(to, from, next){
   		console.log(to,from);
   		next();
   	},
   	beforeRouteLeave(to, from, next){
   		console.log(to,from);
   		next();
   	}
   }
   ```

   - 路由元信息
   
     判断用户是否登录
   
5. 路由懒加载

   ```vue
   {
       path:'sports',
       component:() => import("../pages/newssub/sports.vue")
   },
   ```

## 生命周期函数

```vue
created(){
// 创建期
},
mounted(){
// 渲染期
},
updated(){
// 更新期
},
destoryed(){
// 销毁期
}
```



## Axios网络请求

### 安装

```http
https://www.kancloud.cn/yunye/axios/234845
```

```shell
npm install axios --save
```

### 请求

GET请求

```http
http://iwenwiki.com/api/blueberrypai/getIndexBanner.php
```

```vue
import axios from "axios";
export default {
  name: 'HelloWorld',
  mounted(){
    axios.get("url").then(res =>{
          console.log(res.data['banner']);
        })
      },
```

POST请求

```http
http://iwenwiki.com/api/blueberrypai/login.php
```

```vue
#
#user_id=iwen%40qq.com&password=iwen123&verification_code=crfvw
#
axios.post("url",qs.stringify({
    user_id:"iwen@qq.com",
    password:"iwen123",
    verification_code:"crfvw"
})).then(res=>{
    console.log(res.data);
})
```

## ElementUI

安装

```shell
vue create my-app
cd my-app
vue add element
```

