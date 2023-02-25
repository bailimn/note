JavaScript是ECMAScript的语言层面的实现

- 控制台中按shift+enter进行换行编写
- 



<img src="/Users/blf/Library/Application Support/typora-user-images/image-20221103224338393.png" alt="image-20221103224338393" style="zoom:50%;" />



### JS编写方式

``` html
<!-- 方式1 -->
<script>
	// 直接编写
</script>

<!-- 方式2 -->
<script src="./test.js"></script>
```

### JS用户交互手段

``` javascript
// 弹窗
alert
// 用户输入
prompt
// 控制台打印
consloe.log
```

### 数据类型

- 动态类型：一个变量可以在前一刻是一个字符串，下一刻就存储一个数字

8种数据类型：

- Number：整数或浮点数
  - 转换
    - "7" / "2"
    - Number() 函数

- String
  - 双引号、单引号、反引号
  - 可以使用+拼接
  - 长度：length
  - 转换
    - +
    - String() 函数
    - toString() 方法

- Boolean
- Undefined
- Null
  - 表示一个对象为空

- Object
  - 引用类型
  - 用 {} 表示

- BigInt
  - 任意长度的整数

- Symble

### typeof操作符

- typeof(x) 或 typeof x
- typeof是一个操作符，并非是一个函数，()只是将后续的内容当做一个整体而已;

对一个值使用typeof操作符会返回下列字符串之一
- "undefined"表示值未定义;
- "boolean"表示值为布尔值;
- "string"表示值为字符串;
- "number"表示值为数值;
- "object"表示值为对象(而不是函数)或 null; 
- "function"表示值为函数;
- “symbol”表示值为符号

### 相等和严格相等

== 会先将比较值转化为数字再进行比较

=== 会先判断类型

对象类型是一种存储键值对（key-value）的数据类型

```javascript

/*
函数（function）：在JS代码中通过function定义一种结构，称之为函数
方法（method）：将一个函数放到对象中，作为对象的一个属性，称之为方法
*/
// key：字符串类型，默认情况下可以省略
// value: 可以是基本类型、函数类型、对象类型
var person = {
    name: "haha",
    eat: function() {
        
    },
    friends: {
        name: "wh",
        age: 10
    }
}
```

``` javascript
// 对象创建的方式
// 1. 对象字面量(Object Litaral): 通过{}
var obj = {
    name: "haha"
}

// 1. new Object+动态添加属性
var obj2 = new Object()
obj2.name = "haha"

// 3. new 其他类
function Person() {}
let obj3 = new Person()
```

``` javascript
var person = {
    name: "haha",
    eat: function() {
        
    }
}

// 访问对象中的属性
console.log(person.name)
console.log(person["name"])

person.eat()
person["eat"]()

// 对象添加属性
person.age = 20

// 删除对象中的属性
delete person.age
```

对象的遍历

``` javascript
// Object.keys() 方法会返回一个由给定对象的自身可枚举属性组成的数组

var info = {
    name: "haha",
    age: 18,
    height: 1.88
}

// 通过for循环
var infoKeys = Object.keys(info)
for (int i = 0; i < infoKeys.length; i++) {
    var key = infoKeys[i]
    var value = info[key]
    console.log('key: ${key}, value: ${value}')
}

// for in
for (var key in info) {
    
}
```

栈内存和堆内存

原始类型：栈内存 stack，值类型

对象类型：堆内存 heap，引用类型

![image-20221018223951425](/Users/blf/Library/Application Support/typora-user-images/image-20221018223951425.png)



this 指向什么

``` javascript
// 默认方式调用，指向window
function foo() {
    console.log(this) // window
}
foo()

// 通过对象调用，指向调用的对象
var obj = {
    bar: function() {
        console.log(this) // obj
    }
}
obj.bar()
```



##### 工厂方法创建对象

- 工厂方法创建的对象，打印该对象的类型是Object类型

``` javascript
function createPerson(name, age) {
    var p = new Object() // var p = {}
    p.name = name
    p.age = age
    
    p.eating = function() {
        console.log(this.name + "在吃东西")
    }
    
    return p
}

var p1 = createPerson("张三", 18)
var p2 = createPerson("李四", 18)
```

##### 构造函数（constructor）

- ES5之前，通过function来声明一个构造函数，之后通过new关键字来对其进行调用

- ES6之后，通过class来声明一个类

- 如果一个普通函数被使用new操作符来调用了，那么这个函数就称之为构造函数

- 构造函数创建的对象，打印该对象的类型是相应的对象类型（实际是constructor的属性）

如果一个函数被使用new操作符调用了，那么它会执行如下操作：

1. 在内存中创建一个新的对象（空对象）
2. 这个对象内部的[[prototype]]属性会被赋值为该构造函数的prototype属性
3. 构造函数内部的this，会指向创建出来的新对象
4. 执行函数的内部代码
5. 如果构造函数没有返回非空对象，则返回创建出来的新对象

``` javascript
function Person(name, age) {
    this.name = name
    this.age = age
    
    this.eating = function() {
        console.log(this.name + "在吃东西")
    }
}

var p1 = new Person("张三", 18)
var p2 = new Person("李四", 18)

console.log(typeof p1) // Person
```



