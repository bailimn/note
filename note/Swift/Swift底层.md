``` shell
$ swiftc -h
# 生成 swift ast 语法树
$ swiftc -dump-ast main.swift
# 生成 sil
$ swiftc -emit-sil main.swift >> ./main.sil && open main.sil
# 生成 sil 并 还原符号
$ swiftc -emit-sil main.swift | xcrun swift-demangle >> ./main.sil && open main.sil
```



``` shell
# 还原 swift 编译后的符号
$ xcrun swift-demangle s4main1tAA9LGTeacherCvp 
# main.t : main 中的 t 变量的类型是 main.LGTeacher
$s4main1tAA9LGTeacherCvp ---> main.t : main.LGTeacher
```



### SIL

``` swift

/*
%0...: 表示寄存器（虚拟的），可以理解为编程语言中的常量
*/

// main
sil @main : $@convention(c) (Int32, UnsafeMutablePointer<Optional<UnsafeMutablePointer<Int8>>>) -> Int32 {
bb0(%0 : $Int32, %1 : $UnsafeMutablePointer<Optional<UnsafeMutablePointer<Int8>>>):
  alloc_global @$s4main1tAA9LGTeacherCvp          // id: %2
  // 定一个全局变量
  %3 = global_addr @$s4main1tAA9LGTeacherCvp : $*LGTeacher // user: %7
  // metatype 元类型
  %4 = metatype $@thick LGTeacher.Type            // user: %6
  // function_ref LGTeacher.__allocating_init()
  // 拿到 s4main9LGTeacherCACycfc 函数的地址，赋值给 %5
  %5 = function_ref @$s4main9LGTeacherCACycfC : $@convention(method) (@thick LGTeacher.Type) -> @owned LGTeacher // user: %6
  // apply 调用 %5 这个函数，返回的是实例变量
  %6 = apply %5(%4) : $@convention(method) (@thick LGTeacher.Type) -> @owned LGTeacher // user: %7
  // 存储 %6 这个实例变量到全局变量 %3
  store %6 to %3 : $*LGTeacher                    // id: %7
  // 下面三句，构建一个值为0的整形变量，并返回这个状态码
  %8 = integer_literal $Builtin.Int32, 0          // user: %9
  %9 = struct $Int32 (%8 : $Builtin.Int32)        // user: %10
  return %9 : $Int32                              // id: %10
} // end sil function 'main'
```



``` swift

// alloc_ref 在堆上分配内存
%1 = alloc_ref $LGTeacher                       // user: %3
// function_ref LGTeacher.init() 初始化当前变量
%2 = function_ref @$s4main9LGTeacherCACycfc : $@convention(method) (@owned LGTeacher) -> @owned LGTeacher // user: %3
%3 = apply %2(%1) : $@convention(method) (@owned LGTeacher) -> @owned LGTeacher // user: %4
// 返回实例变量
return %3 : $LGTeacher                          // id: %4
```



类属性

``` swift
builtin "once" -> swift_one -> dispatch_once_t
```









<img src="/Users/lf/Library/Application Support/typora-user-images/image-20230111225214801.png" alt="image-20230111225214801" style="zoom:50%;" />

![image-20230111225239894](/Users/lf/Library/Application Support/typora-user-images/image-20230111225239894.png)

![image-20230111231016219](/Users/lf/Library/Application Support/typora-user-images/image-20230111231016219.png)





Swift中的实例变量默认有16个字节的大小（HeapObject），然后才是存储属性的大小，所以LGTeacher 占用40个字节（16+16+8）

HeapObject: metadata + refCounted (8 + 8)

``` swift
// 获取类对应实例的内存大小
class_getInstanceSize(LGTeacher.self)
// 获取基础类型的 内存分配大小
MemoryLayout<String>.stride
// 获取基础类型的 实际大小
MemoryLayout<String>.size
```





OC的类结构：objc_class



![image-20230111233846543](/Users/lf/Library/Application Support/typora-user-images/image-20230111233846543.png)



OC 中的方法存放在：objc_class:Method_list?

init中给属性赋值，不会触发属性观察者



### 类属性

``` swift
class LGTeacher {
  static var age: Int = 10
}
```

- 使用static修饰
- 必须有默认值
- 只会初始化一次

OC单例的写法

``` objective-c
@implementation LGThread

+ (instancetype)sharedInstance {
  static LGThread * sharedInstance = nil;
  static dispatch_once_t onceToken;
  
  dispatch_one(&onceToken, ^{
    statedInstance = [[LGThread alloc] init];
  });
  return sharedInstance;
}
  
@end
```

Swift单例的写法

``` swift
class LGTeacher {
  // 类型属性底层也调用了 dispatch_once_t
  static let sharedInstance: LGTeacher = LGTeacher()
  private init() {}
}
```



### 结构体的初始化

- 结构体中的属性没有默认值，也不需要定义初始化方法，因为编译器会默认生成初始化方法
- 如果属性有默认值，编译器会生成不同的默认初始化方法
- 如果自定义了初始化方法，编译器不会生成默认初始化方法



![image-20230118000853767](/Users/lf/Library/Application Support/typora-user-images/image-20230118000853767.png)



### 结构体（值类型）内部最好不要定义类（引用类型）属性，因为结构体赋值（值拷贝）的时候，类属性的引用计数会加1

``` swift

struct Teacher {
    var peo: People
}

class People {
    var name: String = "zhangsan"
}

let people = People()

let t = Teacher(peo: people)
let t2 = t

// 获取引用计数
CFGetRetainCount(t.peo)
```

``` swift
/ Teacher.peo.getter
sil hidden [transparent] @main.Teacher.peo.getter : main.People : $@convention(method) (@guaranteed Teacher) -> @owned People {
// %0 "self"                                      // users: %2, %1
bb0(%0 : $Teacher):
  debug_value %0 : $Teacher, let, name "self", argno 1, implicit // id: %1
  %2 = struct_extract %0 : $Teacher, #Teacher.peo // users: %4, %3
  // 重点在这一句
  strong_retain %2 : $People                      // id: %3
  return %2 : $People                             // id: %4
} // end sil function 'main.Teacher.peo.getter : main.People'
```





### 报错：Cannot use mutating member on immutable value: 'self' is immutable

``` swift

struct Stack {
    var items: [Int]
    
    func push(_ item: Int) {
      	// 会报错：Cannot use mutating member on immutable value: 'self' is immutable
      	// 原因：看下面的SIL，self 为 let 类型，又因为是结构体，所以成员也不可以修改
      	// 解决办法：方法添加 mutating
	      items.append(item)
    }
}
```

``` swift
// 上面代码对应的 SIL 文件
// Stack.push(_:)
sil hidden @main.Stack.push(Swift.Int) -> () : $@convention(method) (Int, @guaranteed Stack) -> () {
// %0 "item"                                      // users: %11, %2
// %1 "self"                                      // user: %3
bb0(%0 : $Int, %1 : $Stack):
  debug_value %0 : $Int, let, name "item", argno 1 // id: %2
  debug_value %1 : $Stack, let, name "self", argno 2, implicit // id: %3
```

``` swift
// 解决办法：方法添加 mutating
struct Stack {
    var items: [Int]
    
    mutating func push(_ item: Int) {
	      items.append(item)
    }
}
```

``` swift
// 上面代码对应的 SIL 文件
// 与不加 mutating 的区别：传递的参数添加了 inout，而且 self 也是 var 类型
// Stack.push(_:)
sil hidden @main.Stack.push(Swift.Int) -> () : $@convention(method) (Int, @inout Stack) -> () {
// %0 "item"                                      // users: %5, %2
// %1 "self"                                      // users: %6, %3
bb0(%0 : $Int, %1 : $*Stack):
  debug_value %0 : $Int, let, name "item", argno 1 // id: %2
  debug_value %1 : $*Stack, var, name "self", argno 2, implicit, expr op_deref // id: %3
```



### 交换两个参数（值类型）的值

``` swift
// 报错原因：方法的参数默认是let类型
func swap(_ a: Int, _ b: Int) {
    let temp = a
    a = b // 报错：Cannot assign to value: 'a' is a 'let' constant
    b = temp // 报错：Cannot assign to value: 'b' is a 'let' constant
}

// 解决办法：添加inout
// inout 的本质就是引用
func swap(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

let a = 10
let b = 20
// 注意传参，传递的是引用
swap(&a, &b)
```







![image-20230124130941484](/Users/lf/Library/Application Support/typora-user-images/image-20230124130941484.png)

字符串表：存放所有的函数名和变量名

符号表：

Scheme 设置为release 时，符号表中的符号名称是加密的，但是会生成dYSM

``` shell
# 输出可执行文件的符号表
$ nm 可执行文件
# 输出可执行文件的符号表，并搜索指定的符号
$ nm 可执行文件 | grep 地址

```



C/OC不支持函数的重载，因为编译生成的符号中没有参数，而Swift/C++通过复杂的函数命名规则，符号中是有参数的，所以swift支持函数的重载



### ALSR

![image-20230124134555940](/Users/lf/Library/Application Support/typora-user-images/image-20230124134555940.png)

当前程序运行的首地址/基地址/偏移地址



静态基地址：VM Address

![image-20230124134736137](/Users/lf/Library/Application Support/typora-user-images/image-20230124134736137.png)



函数调用的地址

![image-20230124134839250](/Users/lf/Library/Application Support/typora-user-images/image-20230124134839250.png)



函数调用的实际地址 = 符号表中函数的地址 + ASLR





### 方法调度

结构体中函数的调用方式：静态调用（直接调用）

类方法是通过V-table 来进行调度的



V-Table 在 SIL 中的表示是这样的：

``` swift
decl ::= sil-vtable
sil-vtable ::= 'sil_vtable' identifier '{' sil-vtable-entry* '}'
sil-vtable-entry ::= sil-decl-ref ':' sil-linkage? sil-function-name
```

![image-20230124143605837](/Users/lf/Library/Application Support/typora-user-images/image-20230124143605837.png)

*⾸先是 sil_vtable 的关键字，然后是 LGTeacher 表明当前是 LGTeacher class 的函数表*

*其次就是当前⽅法的声明对应着⽅法的名称*

*这张表的本质其实就类似我们理解的数组，声明在 class 内部的⽅法在不加任何关键字修饰的过程中，*

*连续存放在我们当前的地址空间中。*

![image-20230124143614682](/Users/lf/Library/Application Support/typora-user-images/image-20230124143614682.png)



class extension 中的方法是直接调用的，不是通过V-table

为什么？

class extension 中的方法可能是定义在其他文件中，当父类和子类的文件编译后，父类中的方法直接拷贝到了子类中，但是定义函数的extension的文件还没有编译，当编译到这个文件时，父类时可以直接在函数表的最后插入这个方法的，但是编译时并不知道在子类的哪里插入这个函数，所以 extension 中的方法是直接调用的

OC的不同，OC中的方法是存放在二维数组method_list中的，当category中定义函数时，method_list会偏移category_list中所有函数的大小，在method_list的头插入新的方法。所以在category中定义和类中相同的方法，会调用category中的方法。



final 关键字

意味这不用继承，变为直接调用



@objc 关键字

暴露swift的方法给OC调用



dynamic 关键字

``` swift
class LGTeacher {
  var age: Int = 10
	//动态的特性
  dynamic func teach（）{
    print("teach")
  }
}

class LGTeacher {
  var age: Int = 10
  @objc dynamic func teach（）{ // 加@objc后：objc_msgSend()
    print("teach")
  }
}
```



``` swift
class LGTeacher{
  var age: Int = 10
  func teach() {
    print("teach")
  }
}

extension LGTeacher{
  // @_dynamicReplacement(for: teach) // teach 必须用 dynamic 修饰
  func teach1() {
    print("teach1")
  } 
}
```





### 桥接

查看swift暴露给OC的头文件

<img src="/Users/lf/Library/Application Support/typora-user-images/image-20230124195950662.png" alt="image-20230124195950662" style="zoom:50%;" />



