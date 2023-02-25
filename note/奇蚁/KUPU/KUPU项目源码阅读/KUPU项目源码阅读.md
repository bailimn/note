JSONDecoder


Codable

- 目的：取代NSCoding协议
- 支持：结构体、枚举、类
- 好处：简化了JSON和Swift类型之间相互转换的难度，能够把JSON这种弱类型数据转换成代码中使用的强类型数据。
- 类型不一样会报错

```swift
/// A type that can encode itself to an external representation. 一个可以将自己编码为外部表示的类型。
public protocol Encodable {

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place. 如果该值无法编码任何内容，`encoder` 将在其位置编码一个空的键控容器。
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.  如果任何值对于给定编码器的格式无效，则此函数会引发错误。
    ///
    /// - Parameter encoder: The encoder to write data to.
    func encode(to encoder: Encoder) throws
}

/// A type that can decode itself from an external representation.
public protocol Decodable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    init(from decoder: Decoder) throws
}

/// A type that can convert itself into and out of an external representation.
///
/// `Codable` is a type alias for the `Encodable` and `Decodable` protocols.
/// When you use `Codable` as a type or a generic constraint, it matches
/// any type that conforms to both protocols.
/// 一种可以将自身转换为外部表示的类型。
///
/// `Codable` 是 `Encodable` 和 `Decodable` 协议的类型别名。
/// 当您使用 `Codable` 作为类型或泛型约束时，它匹配符合这两种协议的任何类型。
public typealias Codable = Decodable & Encodable
```

### 解码、编码过程
``` swift
struct Person: Codable {
    let name: String
    let age: Int
}

//解码 JSON 数据
let json = #" {"name":"Tom", "age": 2} "#
let person = try JSONDecoder().decode(Person.self, from: json.data(using: .utf8)!)
print(person) //Person(name: "Tom", age: 2)

//编码导出为 JSON 数据
let data0 = try? JSONEncoder().encode(person)
let dataObject = try? JSONSerialization.jsonObject(with: data0!, options: [])
print(dataObject ?? "nil") //{ age = 2; name = Tom; }

let data1 = try? JSONSerialization.data(withJSONObject: ["name": person.name, "age": person.age], options: [])
print(String(data: data1!, encoding: .utf8)!) //{"name":"Tom","age":2}
```
####  自定义编码和解码逻辑
``` swift
struct Person: Codable {
    let name: String
    let age: Int
    var additionInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case name, age
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        age = try values.decode(Int.self, forKey: .age)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
    }
}
```

### JSON 数据解析
#### 字段匹配问题
带下划线的蛇形命名法 -> 驼峰命名法
``` swift
// {"first_name":"Tom", "age": 2 }
struct Person: Codable {
    let firstName: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name" // 方法 1
        case age
    }
}

// 方法 2
var decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
```

#### 解析部分数据
``` swift
struct Person: Codable {
    let firstName: String
    let age: Int
    var additionalInfo: String?
    var addressInfo: String?
    
    // 需要解析的字段，未列出的不解析
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case age
    }
}

//JSON 数据
let json = #" {"first_name":"Tom", "age": 2, "additionalInfo":"123", "info":"abc"} "#
//解码
let person = try JSONDecoder().decode(Person.self, from: json.data(using: .utf8)!)
print(person)
//Person(firstName: "Tom", age: 2, additionalInfo: nil, addressInfo: nil)
```

#### 空值字段问题
属性要声明为可选类型
``` swift
struct Person: Codable {
    var name: String?
    var age: Int?
}
struct Family: Codable {
    let familyName: String
    var person1: Person?
    var person2: Person?
    var person3: Person?
}

let family = try JSONDecoder().decode(Family.self, from: json.data(using: .utf8)!)
print(family)
//Family(familyName: "101", person1: Optional(__lldb_expr_83.Person(name: Optional("小明"), age: Optional(1))), person2: Optional(__lldb_expr_83.Person(name: nil, age: nil)), person3: nil)


```
当遇到返回值为 null 时，需要给对应的属性设置一个默认值，这时我们 可以重写 init(from decoder: Decoder) 方法，在里面做相应的处理，如下：
``` swift
init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    familyName = try container.decode(String.self, forKey: .familyName)
    //..
    person3 = try container.decodeIfPresent(Person.self, forKey: .person3) ?? Person(name: "defaultName", age: -1)
}
```
#### 枚举值
``` swift
{
    "name": "小明",
    "age": 1,
    "gender": "male"
}

// 数据类型为string
enum Gender: String, Codable {
    case male
    case female
}
struct Person: Codable {
    var name: String?
    var age: Int?
    var gender: Gender?
}

// 数据类型为整数
enum Gender: Int, Codable {
    case male = 1
    case female = 2
}

```

#### 日期解析
``` swift
let json = """
{
    "birthday": "2001-04-20T14:15:00-0000"
}
"""

struct Person: Codable {
    var birthday: Date?
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601 // secondsSince1970: 时间戳 millisecondsSince1970：毫秒的时间戳

let person = try decoder.decode(Person.self, from: json.data(using: .utf8)!)
print(person)
//Person(birthday: Optional(2001-04-20 14:15:00 +0000))
```
自定义解析
``` swift
extension DateFormatter {
    static let myDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 8)
        formatter.locale = Locale(identifier: "zh_Hans_CN")
        return formatter
    }()
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.myDateFormatter)
```

###  plist 文件解析
Codable 协议并非只支持 JSON 格式的数据，它同样支持 plist 文件格式。使用方式与 JSON 格式一致，并不需要对已经实现的 Codable 协议作任何修改，只需要将 JSONEncoder 和 JSONDecoder 替换成对应的 PropertyListEncoder 和 PropertyListDecoder 即可。

plist 本质上是特殊格式标准的 XML 文档，所以理论上来说，我们可以参照系统提供的 Decoder/Encoder 自己实现任意格式的数据序列化与反序列化方案。同时苹果也随时可能通过实现新的 Decoder/Encoder 类来扩展其他数据格式的处理能力。Codable 的能力并不止于此，它具有很大的可扩展空间。



https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

https://zhuanlan.zhihu.com/p/50043306

https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types

掘金翻译计划：https://github.com/xitu/gold-miner

https://github.com/xitu/gold-miner/blob/master/TODO/ultimate-guide-to-json-parsing-with-swift-4.md

喵神的播客：https://onevcat.com/2020/11/codable-default/

https://github.com/AndyCuiYTT/fastjson_swift


照片选择：TatsiPickerViewController