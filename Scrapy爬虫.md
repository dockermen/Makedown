# Scrapy爬虫

## Xpath语法:

1. (“//p”)选取所有p元素

2. ("//a")选取所有链接

   ```html
   <a href="http://www.baidu.com">链接</a>
   ```

3. (@href)返回属性href

4. ("//div/*")选择指定层级所有元素

5. (“//a[@href]”)选择包含href属性的链接

6. ("//a[@href='http://www.baidu.com']")选择href属性为特定值的链接

7. (“//a[contains(@href,'iana')]"选择属性值包含'iana'的元素

8. ("//a[starts-with(@href,'http://www')]")选择属性值"htttp://www"开头的元素

9. ("//a[not(contains(@href,"abc"))]")选择属性值不包含"abc"的值

10. ("//h1[@id="abc]/span/text()")获取id为"abc"的h1标签下的span中的text

11. ("//div[@id="abc]/ul//a/@href")获取id为"abc"的div标签内无序列表(ul)中所有链接的url

12. ("//*[contains(@class,"abc") and contains(@class,"cba")]//h1//text()")获取class属性包含"abc"和"cba"的任意元素内所有标题元素h1中的文本，这两个字符串可能在同一个class中也可能在不同的class中

13. contains()类 选择包含指定类的所有元素

14. ("//imh/@src")获取页面中每张图片的url

15. id比class好用，class会因为css更改布局

16. xpath索引是从[1]开始而不是[0]

17. response.xpath("//div/a['@title']/text()").re('[.0-9]+')使用正则re()表达式提取非负自然数

18. xpath不加text()或extract()默认返回selector选择器对象

## Scrapy shell命令

```shell
scrapy shell [URL]  #使用命令行方式获取网页源码  返回response
response.xpath("//div/a[@herf]").extract() #用xpath方式提取元素
response.body[:50]  #返回body内容前50个字符（body是HTML语言的一个标签，用于承载和包含一个网页的内容）
response.xpath("//a[@title]/text()")  #text()提取文本字段
```

extract():这个方法返回的是一个数组list，里面包含了多个string，如果只有一个string，则返回['ABC']这样的形式。extract_first()：这个方法返回的是一个string字符串，是list数组里面的第一个字符串

```shell
scrapy shell -s USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36 Edg/89.0.774.45" https://[URL]  #Scrapy Shell方式加请求头

scrapy shell --pdb [URL]  #交互式调试
```



## Scrapy示例

### 简单的spider

```shell
#爬取两个网站记录爬取过的url
import scrapy
class QuotesSpider(scrapy.Spider):
    name = "quotes1"

    def start_requests(self):
        urls = [
            'http://quotes.toscrape.com/page/1/',
            'http://quotes.toscrape.com/page/2/',
        ]
        requests = []
        for url in urls:
            requests.append(scrapy.Request(url=url, callback=self.parse))
        return requests

    def parse(self, response):
        self.log('I just visited {}'.format(response.url))
```

```shell
#使用start_urls取代start_requests函数
import scrapy
class QuotesSpider(scrapy.Spider):
    name = "quotes2"
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
        'http://quotes.toscrape.com/page/2/',
    ]

    def parse(self, response):
        self.log('I just visited {}'.format(response.url))
```

```shell
#处理第一页面并且return
import scrapy
class QuotesSpider(scrapy.Spider):
    name = "quotes3"
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
        'http://quotes.toscrape.com/page/2/',
    ]

    def parse(self, response):
        quotes = []
        for quote in response.css('div.quote'):
            quotes.append({
                'text': quote.css('span.text::text').extract_first(),
                'author': quote.css('span small::text').extract_first(),
                'tags': quote.css('div.tags a.tag::text').extract(),
            })
        # spider_4_quotes.py shows this same spider, but it generates
        # the items individually instead of returning all of them in list
        return quotes
#返回数据获取
scrapy runspider .\spiders\easy.py -o 1.json
```



## 一个Scrapy项目

```shell
scrapy startproject project01 #创建一个scrapy爬虫项目
cd project
scrapy genspider project p3terx.com #创建一个名为"project"的爬虫并且只能爬取指定网址下的内容
#scrapy genspider [爬虫名][目标爬虫URL]
```

爬虫默认使用”basic“模板创建

```shell
scrapy genspider [参数]  #参数[-l] 查看其它可用的爬虫模板、参数[-t] 指定爬虫模板
```

保存爬取文件

```shell
scrapy crawl [爬虫名] -o [文件格式]
#保存文件格式支持 'json', 'jsonlines', 'jl', 'csv', 'xml', 'marshal', 'pickle'

scrapy crawl [reptiles爬虫名] -o "ftp://user:pass@ftp.scrapybook.com/items.json"
scrapy crawl [reptiles爬虫名] -o "s3://aws_key:aws_secret@scrapybook/items.json"
#将文件保存到ftp或s3储存桶
```

## Item装载器与管理字段工具ItemLoader

ItemLoader工具，替代extract()和xpath()操作,如parse()方法

```python
import scrapy
from project01.items import Project01Item
from scrapy.loader import ItemLoader
def parse(self,response):
    l = ItemLoader(item=Project01Item(), response=response)
    MY=MapCompose(lambda i: i.replace(' ','')) #MapCompose处理器可以实现复杂的处理方式
    #可以使用python的lambda表达式
    l.add_xpath('title','//ul[@id="masonry"]/li/a/article/div[2]/h1/text()',MY) #可以直接把上面MY的方法替换进来
    #add_xpath add_css
    l.add_xpath('url', '//ul[@id="masonry"]/li/a/@href')
    #l.add_value('url,response.url')
    '''add_value()方法添加Python计算出来的单个值，而不是xpath,css表达式,该方法可以管理字段，比如url,爬		虫名称,时间戳等.需要引入datetime 和socket模块
    '''
    return l.load_item()
```

#### 定义items

```python
from scrapy.item import Item,Field


class Project01Item(Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    title = Field()

    #计算字段
    images = Field()
    location = Field()
    #管理字段
    url = Field()
```

处理器Join和MapCompose

| 处理器                                                 | 功能                                          |
| ------------------------------------------------------ | --------------------------------------------- |
| Join()                                                 | 把多个结果连接在一起                          |
| MapCompose(unicode.strip)                              | 去除首尾空白符                                |
| MapCompose(unicode.strip,unicode.title)                | 去除首尾空白符并且安装标题格式                |
| MapCompose(lambda i: i.replace(',', ''),float)         | 将字符串转为数值，替换可能存在的','           |
| MapCompose(lambda i: urlparse.urljoin(response.url,i)) | 以response.url为基础，将url相对路径转绝对路径 |

## 创建contract

contract爬虫设计的单元测试，可以知道爬虫项目哪里有运行异常,contract包含在紧挨着函数名的注释中以[@]开头

```python
def parse(self,response):
	"""这是爬虫contract
	@url http://p3terx.com
	@return items 1
	@scrapes title price description addess image_urls
	@scrapes url project spider server date
	"""
```

```shell
scrapy check project
#成功返回Ran 3 contracts in 1.085s和OK
```

## 双向爬取

**水平爬取**：横向—从一个索引页到另外一个索引页

**垂直爬取**：纵向—从一个索引页到房源页并且抽取Item

**yield语句**：yield和return都是将返回值返回给调用者，不同的是yield不会退出函数继续执行for循环



## 使用CrawlSpider实现双向爬取

```shell
scrapy genspider -t crawl [爬虫模块名] [目标网址]
#使用crawl模板创建一个双向爬虫
```



## Setting基本设置

### 分析

#### 日志：

1. LOG_LEVEL(日志等级):DEBUG(最低)、INFO、WARNING、ERROR、CRTTCAL(最高)，STLENT(不记录)
2. LOGSTATS_INTERVAL(日志频率):默认60秒
3. LOG_FILE(写入日志文件)
4. LOG_ENABLED(显示禁用):False(禁用)
5. LOG_STDOUT(Scrapy所有标准输出写入日志):True(写入)

#### 统计:

1. STATS_DUMP:默认开启，爬虫结束会将统计信息收集器中的值转存到日志当中
2. DOWNLOADER_STATS:控制是否下载记录统计信息
3. DEPTH_STATS:控制是否收集站点深度统计信息
4. DEPTH_STATS_VERBOSE:了解有关深度的更多信息设置为True
5. STATSMAILER_RCPTS:邮件列表(['my@mail.com'])爬取完成时会向列表中邮箱发送邮件

#### Telnet(scrapy内部控制台):

```shell
telnet localhost 6023(prot) #连接Scrapy内部控制台
est() #了解详细状态
engine.pause() #暂停
engine.unpause() #继续
engine.stop() #终止
```

### 性能：

1. CONCURRENT_REQUESTS(设置同时执行的最大请求数)
2. CONCURRENT_REQUESTS_PER_DOMAIN(设置对每个域名发出的请求数)
3. CONCURRENT_REQUESTS_PER_IP(设置对每个IP发出的请求数，为0时域名限制取消)
4. COMCURRENT_ITEMS(设置每个响应同时处理的items默认100，减小会提升性能)
5. DOWNLOAD_TIMEOUT(请求延时)
6. DOWNLOAD_DELAY(抓取速度)

#### 提前终止爬取：

```shell
CLOSESPIDER_TIMEOUT(以秒计) CLOSESPIDER_ITEMCOUNT(抓取一定数量Items后) CLOSESPIDER_PAGECOUNT(接到一定数量响应后)
```



