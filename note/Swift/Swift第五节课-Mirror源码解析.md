### Mirror

反射就是可以动态获取类型、成员信息，在运⾏时可以调⽤⽅法、属性等⾏为的特性。上⾯我们分析过了，对于⼀个纯 Swift 类来说，并不⽀持我们直接像 OC 那样操作；但是 Swift 标准库依然提供了反射机制让我们访问成员信息,

``` swift
class LGTeacher {
    var age = 10
}

let t = LGTeacher()
let mirror = Mirror(reflecting: t)
for pro in mirror.children{
    print("\(pro.label):\(pro.value)")
}

/* 输出
Optional("age"):10
*/
```



可以用来做Json解析



