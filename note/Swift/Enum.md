- 共同的类型
- 原始值可以是：字符串、字符、整型、浮点型
- 每个原始值在枚举声明中必须是唯一的。
- 枚举成员可以指定任意类型的关联值存储到枚举成员中
- 一等类型（first-class）

``` swift
enum CompassPoint {
    case north // 成员值
    case south // 使用case定义一个新的枚举成员值
    case east // 不同于C和OC Swift的枚举成员不会被默认赋予整型值
    case west // 这些枚举成员本身就是完备的值，这些值的类型是CompassPoint
}

// 定义的枚举成员可以用逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// 定义一个枚举变量
var directionToHead = CompassPoint.west
directionToHead = .south
```


### 使用 Switch 语句匹配枚举值
``` swift
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// 打印“Watch out for penguins”
```

### 枚举成员的遍历
``` swift
// 遵循 CaseIterable 协议 然后调用allCases 可以获取枚举所有成员的集合
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// 打印“3 beverages available”
```

### 关联值
有时候把其他类型的值和成员值一起存储起来会很有用。这额外的信息称为关联值
- 每个枚举成员的关联值类型可以不同
- 关联值可以改变
``` swift
// 定义一个名为Barcode的枚举类型，
// 它的一个成员值是具有 (Int, Int, Int, Int)类型关联值的upc，
// 另一个成员值是具有String类型关联值的qrCode
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”

switch productBarcode {
// 如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量,你可以只在成员名称前标注一个 let 或者 var：
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”
```

### 原始值
作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。

- 原始值可以是：字符串、字符、整型、浮点型
- 每个原始值在枚举声明中必须是唯一的。
- 原始值始终不变

``` swift
// 枚举类型 ASCIIControlCharacter 的原始值类型被定义为 Character
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

##### 原始值的隐式赋值
- Int 类型的枚举，第一个成员值的隐式原始值为0，以后的依次递增
- String 类型的枚举，隐式原始值为该原始成员的名称
- 使用rawValue 获取枚举变量的原始值

##### 使用原始值初始化枚举实例
``` swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 类型为 Planet? 值为 Planet.uranus
```

##### 递归枚举
``` swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// 打印“18”
```

### 枚举中包含属性
- 可以包含计算属性和类型属性，不能包含存储属性
``` swift
enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)
    
    // var radius: Double // Enums must not contain stored properties
    var width: Double {
        get {
            return 10.0
        }
    }
    static let height = 20.0
}
```


### 枚举中包含方法
- 可以是实例方法也可以是类方法

``` swift
enum Week: Int{
    case MON, TUE, WED, THU, FRI, SAT, SUN
    
    mutating func nextDay(){
        if self == .SUN{
            self = Week.MON
        }else{
            self = Week(rawValue: self.rawValue+1)!
        }
    }
    
    static func test() {
        print("test")
    }
}

// 使用方法
var w = Week.SUN
w.nextDay()
print(w) 

Week.test()
```



### 判断枚举相等

``` swift

enum State: Equatable {
    enum CreateStep: Equatable {
        case one
        case two
    }
    case look // 查看职位时 (雇主查看职位详情)
    case create(CreateStep) // 点击创建职位
}

if case .create = state111 {
    print("111")
}

if case .create(.one) = state111 {
    print("222")
}

if case .create(.two) = state111 {
    print("333")
}

if case .look = state111 {
    print("444")
}
if case State.look = state111 {
    
}

/* 打印
111
222
*/
```



``` swift
enum NormalArg: Equatable {
    case one(Int)
    case two
	// 如果要使用 == 需要遵循 Equatable 协议，并实现下面的方法
    static func ==(lhs: NormalArg, rhs: NormalArg) -> Bool {
        switch (lhs, rhs) {
        case (let .one(a1), let .one(a2)):
            return a1 == a2
        case (.two,.two):
            return true
        default:
            return false
        }
    }
}
```





https://swiftgg.gitbook.io/swift/swift-jiao-cheng/08_enumerations

https://www.jianshu.com/p/d25860cf8757