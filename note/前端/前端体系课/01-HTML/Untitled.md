渲染引擎：Rendering Engine（一般称为浏览器内核）

HTML：HyperText Markup Language 超文本标记语言

emmet语法

##### 什么是标记语言（markup language）

- 由无数个标记（标签/tag）组成
- 对某些内容进行特殊标记，以供其他解析器识别处理
- 比如<h1></h1> 标记的文本会被识别为标题
- 有标签和内容组成的部分称为元素（element）



##### 什么是超文本

- 不仅可以插入文本，还可以插入图片/音频/视频
- 还可以表示超链接（HyperText），从一个网页跳转到另一个网页



### HTML的基本组成

在VSCode中输入！直接回车可以创建

``` html
<html>
    <head>
        元数据（metadata 描述数据的数据）
        <title>网页的标题</title>
    <body>
        存放内容
    </body>
</html>
```



##### 常用插件

- 文件夹图标：VSCode Great Icons
- 在浏览器中打开网页：open in browser（右键选择：Open in browser）, Live Sever (自动刷新网页，右键选择Open In Live Server)
- 自动重命名标签：auto rename tag
- 颜色主题：atom one dark



##### VSCode 配置

- Auto Save 自动保存
- Font Size 修改代码字体大小
- Word Wrap 代码自动换行
- Render Whitespace 空格的渲染方式
- Tab Size 代码缩进



# 元素



<img src="/Users/lf/Library/Application Support/typora-user-images/image-20230126005545049.png" alt="image-20230126005545049" style="zoom:50%;" />

![image-20230126013257080](/Users/lf/Library/Application Support/typora-user-images/image-20230126013257080.png)

HTML有哪些元素：https://developer.mozilla.org/zh-CN/docs/Web/HTML

- 单标签元素
- 双标签元素



## 元素的属性（Attribute）

<img src="/Users/lf/Library/Application Support/typora-user-images/image-20230126012624156.png" alt="image-20230126012624156" style="zoom:50%;" />



一个属性必须包含如下内容：

1. 一个空格，在属性和元素名称之间。(如果已经有一个或多个属性，就与前一个属性之间有一个空格。)

2. 属性名称，后面跟着一个等于号。

3. 一个属性值，由一对引号“”引起来。



属性的分类

- 有些属性是公共的，每一个元素都可以设置
    - 比如class、id、title属性

- 有些属性是元素特有的，不是每一个元素都可以设置
    - 比如meta元素的charset属性、img元素的alt属性等



### 全局属性

文档：https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes

**常见的全局属性如下：**

- id：定义唯一标识符（ID），该标识符在整个文档中必须是唯一的。其目的是在链接（使用片段标识符），脚本或样式（使用CSS）时标识元素。

- class：一个以空格分隔的元素的类名（classes）列表，它允许CSS 和Javascript通过类选择器或者DOM方法来选择和访问特定的元素；

- style：给元素添加内联样式；

- title：包含表示与其所属元素相关信息的文本。这些信息通常可以作为提示呈现给用户，但不是必须的。







## 常见元素

HTML最上方的一段文本我们称之为**文档类型声明**，用于声明**文档类型**

![image-20230126015418947](/Users/lf/Library/Application Support/typora-user-images/image-20230126015418947.png)

- HTML文档声明，告诉浏览器当前页面是HTML5页面；

- 让浏览器用HTML5的标准去解析识别内容；

- 必须放在HTML文档的最前面，不能省略，省略了会出现兼容性问题；



### div

独占一行



### span

包裹的内容在同一行显示



### html

- <html> 元素表示一个HTML 文档的**根**（顶级元素），所以它也被称为**根元素**。

    - 所有其他元素必须是此元素的后代。

- W3C标准建议为html元素增加一个**lang属性**，作用是

    - 帮助语音合成工具确定要使用的发音;

    - 帮助翻译工具确定要使用的翻译规则;

    - **比如常用的规则：**

        - lang=“en”表示这个HTML文档的语言是英文；

        - lang=“zh-CN”表示这个HTML文档的语言是中文；



### head

Heading

- **HTML head 元素**规定文档相关的**配置信息（也称之为元数据），**包括文档的标题，引用的文档样式和脚本等。

    - 什么是元数据（meta data），是描述数据的数据；

    - 这里我们可以理解成对整个页面的配置

- **常见的设置有哪些呢？一般会至少包含如下2个设置。**

    - 网页的标题：title元素

        ![image-20230126020216781](/Users/lf/Library/Application Support/typora-user-images/image-20230126020216781.png)

    - 网页的编码：meta元素

        - 可以用于设置网页的字符编码，让浏览器更精准地显示每一个文字，不设置或者设置错误会导致乱码；

        - 一般都使用utf-8编码，涵盖了世界上几乎所有的文字；
            ![image-20230126020315936](/Users/lf/Library/Application Support/typora-user-images/image-20230126020315936.png)



### body

body元素里面的内容将是你**在浏览器窗口中看到的东西**，也就是**网页的具体内容和结构**。



### img

可替换元素

``` html
<img src="图片地址" alt="一张图片">
```

- **img有两个常见的属性：**

    - src属性：source单词的缩写，表示源。是**必须的**，它包含了你想嵌入的图片的文件路径。

    - alt属性：不是强制性的，有两个作用

        - 作用一：当图片加载不成功（错误的地址或者图片资源不存在），那么会显示这段文本；

        - 作用二：屏幕阅读器会将这些描述读给需要使用阅读器的使用者听，让他们知道图像的含义；



### a

anchor

在网页中我们经常需要**跳转到另外一个链接**，这个时候我们使用**a元素**；

- **HTML<a>元素**（或称锚（anchor）元素）：
    - 定义超链接，用于打开新的URL；



- **a元素有两个常见的属性：**

    - href：Hypertext Reference的简称

        - 指定要打开的URL地址；

        - 也可以是一个本地地址；

    - target：该属性指定在何处显示链接的资源。

        - _self：默认值，在当前窗口打开URL；

        - _blank：在一个新的窗口中打开URL；（空白的）

``` html
<a href="http://www.baidu.com" target="_blank">百度一下</a>
```



##### 锚点链接

锚点链接可以实现：跳转到**网页中的具体位置**

``` html
<!-- 点击锚点链接会跳转到段落 -->
<p id="one">段落</p>
<a href="#one">锚点链接</a>
```



##### 给图片添加链接

``` html
<a href="http://www.baidu.com">
    <img src="https://cdn.macsky.net/img/2021/01/Movist-Pro-01.png" alt="">
</a>
```



### link

``` html
<!-- 引入css -->
<link rel="stylesheet" href="./CSS/style.css">
<!-- 设置网站icon -->
<link rel="icon" href="./image/icon.png">
```





## 元素的语意化

用正确的元素做正确的事情



# SEO

搜索引擎优化：search engine optimization 通过了解搜索引擎的运作规则来调整网站，以及提高网站在有关搜索引擎内排名的方式。







# URL

URL的标准格式：

``` html
[协议类型]://[服务器地址]:[端口号]/[文件路径][文件名]?[查询]#[片段ID] 
```



![image-20230126014809155](/Users/lf/Library/Application Support/typora-user-images/image-20230126014809155.png)



![image-20230126014815117](/Users/lf/Library/Application Support/typora-user-images/image-20230126014815117.png)



### 

# 字符实体

|      | **描述**        | **实体名称** | **实体编号** |
| ---- | --------------- | ------------ | ------------ |
|      | 空格            | \&nbsp;      | \&#160;      |
| <    | 小于号          | \&lt;        | \&#60;       |
| >    | 大于号          | \&gt;        | \&#62;       |
| &    | 和号            | \&amp;       | \&#38;       |
| "    | 双引号          | \&quot;      | \&#34;       |
| '    | 单引号          | \&apos;      | \&#39;       |
| ￠   | 分(cent)        | \&cent;      | \&#162;      |
| £    | 镑(pound)       | \&pound;     | \&#163;      |
| ¥    | 元(yen)         | \&yen;       | \&#165;      |
| €    | 欧元(euro)      | \&euro;      | \&#8364;     |
| §    | 小节            | \&sect;      | \&#167;      |
| ©    | 版权(copyright) | \&copy;      | \&#169;      |
| ®    | 注册商标        | \&reg;       | \&#174;      |
| ™    | 商标            | \&trade;     | \&#8482;     |
| .    | 乘号            | \&times;     | \&#215;      |
| ÷    | 除号            | \&divide;    | \&#247;      |



lt: less than

gt: greater than



