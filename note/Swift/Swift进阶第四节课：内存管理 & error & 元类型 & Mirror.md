### 元类型、AnyClass、Self

``` swift
var t = LGTeacher()

//此时代表的就是当前 LGTeacher 的实例对象
var t1: AnyObject = t

//此时代表的就是 LGTeacher 这个类的类型
var t2: AnyObject = LGTeacher.self
```

AnyObject:代表任意类的 instance，类的类型，仅类遵守的协议。

Any: 代表任意类型，包括 funcation 类型或者 Optional 类型

AnyClass 代表任意实例的类型: AnyObject.Type

T.self，如果 T是实例对象，返回的就是它本身； T 是类，那么返回的是 Metadata

T.Type：⼀种类型， T.self 是 T.Type 类型

type(of:) : ⽤来获取⼀个值的动态类型



### 错误处理

Swift 提供Error 协议来标识当前应⽤程序发⽣错误的情况， Error 的定义如下:

``` swift
public protocol Error{
}
```

所以不管是我们的 struct 、 Class 、 enum 我们都可以通过遵循这个协议来表示⼀个错误。这⾥我们选择 enum 。

``` swift
enum JSONMapError: Error{
	case emptyKey
	case notConformProtocol
}
```

接下来我们的代码⾥关于 print 的输出修改成对应错误的枚举值了~

``` swift

enum JSONMapError: Error {
    case emptyKey
    case notConformProtocol
}

protocol CustomJSONMap {
    func jsosnMap() -> Any
}

extension CustomJSONMap {
    func jsonMap() -> Any {
        let mirror = Mirror(reflecting: self)
        
        guard !mirror.children.isEmpty else {return self}
        
        var keyValue: [String: Any] = [:]
        
        for children in mirror.children {
            if let value = children.value as? CustomJSONMap {
                if let keyName = children.label {
                    keyValue[keyName] = value.jsonMap()
                } else {
                    return JSONMapError.emptyKey
                }
            } else {
                return JSONMapError.notConformProtocol
            }
        }
        return keyValue
    }
}
```

但是这⾥我们使⽤ return 关键字直接接收了⼀个 Any 的结果，如何抛出错误那，正确的⽅式是使⽤*throw 关键字。

于此同时，编译器会告诉我们当前的我们的 function 并没有声明成 throws ，所以修改代码之后就能得出这样的结果了:

``` swift

enum JSONMapError: Error{
    case emptyKey
    case notConformProtocol
}

protocol CustomJSONMap {
    func jsosnMap() -> Any
}

extension CustomJSONMap {
	  // 添加 throws -> Any 表示函数中的异常抛出
    func jsonMap() throws -> Any {
        let mirror = Mirror(reflecting: self)
        
        guard !mirror.children.isEmpty else {return self}
        
        var keyValue: [String: Any] = [:]
        
        for children in mirror.children{
            if let value = children.value as? CustomJSONMap{
                if let keyName = children.label {
                    keyValue[keyName] = value.jsonMap()
                }else{
                    throw JSONMapError.emptyKey
                }
            }else{
                throw JSONMapError.notConformProtocol
            }
        }
        return keyValue
    }
}
```

这个时候会有⼀个问题，那就是当前的 value 也会默认调⽤ jsonMap 的⽅法，意味着也会有错误抛出，这⾥我们先根据编译器的提示，修改代码如下：

``` swift
enum JSONMapError: Error{
    case emptyKey
    case notConformProtocol
}

protocol CustomJSONMap{
    func jsosnMap() throws -> Any
}

extension CustomJSONMap{
    func jsonMap() throws -> Any{
        let mirror = Mirror(reflecting: self)
        
        guard !mirror.children.isEmpty else {return self}
        
        var keyValue: [String: Any] = [:]
        
        for children in mirror.children{
            if let value = children.value as? CustomJSONMap{
                if let keyName = children.label {
                    // 这里添加了try
                    keyValue[keyName] = try value.jsonMap()
                }else{
                    throw JSONMapError.emptyKey
                }
            }else{
                throw JSONMapError.notConformProtocol
            }
        }
        return keyValue
    }
}

```

到这⾥我们就完成了⼀个地道的 swift 错误表达⽅式了。

我们来使⽤⼀下我们当前编写完成的代码，会发现编译器要求我们使⽤ try 关键字来处理错误。接下来

我们就来说⼀说 Swift 中错误处理的⼏种⽅式：

- 使⽤ try 关键字，是最简便的，也是我们最喜欢的：甩锅*
    - 使⽤ try 关键字有两个注意点：⼀个还是 try? ，⼀个是 try!
    - try? :返回的是⼀个可选类型，这⾥的结果就是两类，⼀类是成功，返回具体的字典值；⼀类就错*误，但是具体哪⼀类错误我们不关系，统⼀返回了⼀个nil
    - try! 表示你对这段代码有绝对的⾃信，这⾏代码绝对不会发⽣错误！
- 第⼆种⽅式就是使⽤ do...catch

如何你觉得仅仅使⽤ Error 并不能达到你想要详尽表达错误信息的⽅式，可以使⽤LocalError 协议

