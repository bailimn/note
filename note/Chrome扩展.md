通过Manifast中的content_scripts属性可以指定将哪些脚本何时注入到哪些页面中，当用户访问这些页面后，响应的脚本即可自动运行，从而对页面DOM进行操作。

content_scripts 属性的值为数组类型，数组的每个元素可以包含matches、exclude_matches、css、js、run_at、exclude_globs等属性。

matches: 定义了哪些页面会被注入脚本

exclude_matches：定义了哪些页面不会被注入脚本

css和js：对应要注入的样式表和JavaScript

run_at: 定义了何时进行注入

all_frames: 定义了脚本是否会注入到嵌入式框架中

include_globs和exclude_globs: 全局URL匹配，最终脚本是否会被注入有matches、exclude_matches、include_globs、exclude_globs的值共同决定。简单的说，如果URL匹配matches值的同时也匹配include_globs的值，会被注入；如果URL匹配exclude_matches的值或者匹配exclude_globs的值，则不会被注入。

content_scripts中的脚本只是共享页面的DOM，而并不共享页面内嵌JavaScript的命名空间。也就是说，如果当前页面中的JavaScript有一个全局变量a，content_scripts中注入的脚本也可以有一个全局变量a，两者不会相互干扰。当然你也无法通过content_scripts访问到页面本身内嵌JavaScript的变量和函数。 DOM中的自定义属性不会被共享。

## 跨域请求

跨域指的是JavaScript通过XMLHttpRequest请求数据时，调用JavaScript的页面所在的域和被请求页面的域不一致

如果我们想设计一款获取维基百科数据并显示在其他网页中的扩展，就要在Manifest中进行如下声明：

这样Chrome就会允许你的扩展在任意页面请求维基百科上的内容了。

{
    ...
    "permissions": [
        "*://*.wikipedia.org/*"
    ]
}



在控制台上，重新加载这个页面。命令：location.reload(true)