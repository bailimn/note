- Dart 是单线程，实现多线程效果，单线程+事件循环（Event Loop）
- Event Queue 事件队列
- 

``` dart
// dart 必须有一个入口
// dart 支持泛型，比如下面的 List<String> args

void main(List<String> args) {
  print("hello world");

  // test();
  // test2();
  // test3();
  // test4();
  // test5();
  // test6();
  // test7();
  test8();
}



// Dart 没有关键字来定义接口(interface/protocol)，默认情况下所有的class都是隐式接口
// Dart 中没有函数的重载，创建类的多个构造函数可以用 命名构造函数或工厂方法 代替。如果声明函数，可以用位置可选参数或命名可选参数代替。
// 默认所有的类继承自Object
// 继承关键字：extends
// 没有 private/public， 属性前加 _ 表示这个属性只能在当前的包里访问
// 一个Dart文件就是一个库文件
// import 'dart:core' // Dart 的核心库，默认导入
// 引入系统的库：import 'dart:库的名字'

// 第三方库：pubspec.yaml
// 库网站：pub.dev
/*
name: coder
description: test
dependencies:
  http: ^0.12.0+4
*/
// $ pub get
// import 'package:http/http.dart'

// 被标记为 @immutable 的类不可变，里面定义的变量必须是final，比如 StatelessWidget

void test2() { 
  // Dart 中没有非零非空即真
  var flag = false;

  // 如果引入库中的方法和自己的方法有冲突
  // import '***.dart' as mUtils; // 用as关键字给库起别名
  // mUtils.sum(10, 20);

  // 默认情况下导入一个库时，导入的是这个库中所有的公共的内容
  // show： 指定到导入的内容
  // hide： 隐藏某个要导入的内容，其他的都导入

  // 库文件比较多时用：export '**.dart' 

  if (flag) {
    print("真");
  }

  // 定义字符串
  var str1 = 'abc';
  var str2 = "abc";
  var str3 = """ 
  a
  b
  c
  """;

  // 字符串和表达式拼接
  // ${变量/表达式}，如果{}中是变量那么{}可以省略
  var message = "my name is ${str1} ${str1.runtimeType} $str1";

  // 集合
  // 列表List，用中括号创建
  var names = ["a", "b", "c"];
  // 集合Set，用打括号创建
  // 取出数组中的重复元素 Set<String>.from(names).toList();
  var movies = {"a", "b", "c"};
  
  // 映射Map，用打括号创建
  var info = {
    "name": "abc",
    "age": 18
  };
}

void test() {
  // 明确的声明

  // 类型推导（var/final/const）
  var age = 20;
  final height = 1.0; // 声明常量
  const address = "北京"; // 声明常量
  // final const 区别： const 必须赋值常量值（编译期间必须是一个确定的值），final可以通过计算或函数来获取一个值（运行期间来确定一个值）
  // const time = DateTime.now(); // 报错
  // final 一旦赋值就不能修改
  final time1 = DateTime.now(); // 不报错


  final p1 = Person("a");
  final p2 = Person("a");
  print(identical(p1, p2)); // false （identical：同一的）

  // 常量构造器示例
  const p3 = Person2("a");
  const p4 = Person2("a");
  const p5 = const Person2("b"); // Dart 2.0 后 可以省略 第二个 const
  print(identical(p3, p4)); // true 如果内容相同，用const修饰打印true，如果用final修饰打印false
  print(identical(p4, p5)); // false
}

class Person {
  late String name;

  Person(String name) {
    this.name = name;
  }
}

// 常量构造函数示例
class Person2 {
  final String name;
  // 如果有常量构造器 ，那么这个类的所有成员都必须用final修饰
  const Person2(this.name);
}

void test3() {
  sum(10, 20);

  sayHello("a", 1);
  sayHello("a", 1, 1.0);
  sayHello2("a", age: 1);

  sayHello2("a", age: 1, height: 1.0);
  sayHello2("a", height: 1.0);
  sayHello2("a", height: 1.0, age: 1);
}

// 必选参数
// 可选参数：位置可选参数 命名可选参数
// 位置可选参数：用中括号表示 [int age, double height]，实参和形参在进行匹配时，是根据位置来匹配的
// 命名可选参数：用打括号表示 {int age = 0, double height = 0} required 必传参数
// 必选参数name 不可以有默认值，只有可选参数才能有默认值
void sayHello(String name, [int age = 0, double height = 0]) {

} 
// 命名可选参数
void sayHello2(String name, {int age = 0, required double height = 0}) {

}

// 返回值的类型可以省略
sum(int num1, int num2) {
  return num1 + num2;
}

void test4() {
  // 匿名函数
  testF( () {
    print("匿名函数");
  });

  // 箭头函数
  // 函数体只能有一行代码
  testF(() => print("箭头函数"));

  final result = testF2((num1, num2) {
    return num1 + num2;
  });
}

// 函数是一等公民
// 函数可以作为另一个函数的参数
int testF2(int foo(int num1, int num2)) {
  return foo(10, 20);
}

typedef Caldulate = int Function(int num1, int num2);
int testF3(Caldulate foo) {
  return foo(10, 20);
}

// 运算符
void test5() {
  var name = "a";
  // ??=
  // 当原来的变量有值时，那么??=不执行
  // 当原来的变量为null时，那么将后面的值赋值给变量
  name ??= "b";
  print(name);

  var temp = name ?? "c"; // 和swift中的一样
  
  // 级联运算符
  var person = Person3()
  ..name = "A"
  ..eat();
}

class Person3 {
  String name = "";
  void eat() { }
}

// 类
void test6() {
  // var p = Person4(); // 默认构造函数, 一旦有了自定义构造函数，Dart就不再提供默认构造函数
  var p = Person4.withNameAge("a", 10);

  var p2 = Person4.fromMap({
    "name": "abc",
    "age": 19
  });
  print(p2.toString());

  // Object 与 dynamic 的区别
  // dynamic就是一种类型
  Object obj = "a";
  dynamic obj2 = "a";
  // print(obj.substring(1)); // 编译时会报错
  print(obj2.substring(1)); // 编译时不会报错，但是运行时可能崩溃
}

class Person4 {
  String name = "";
  int age = 0;

  // 一旦有了自定义构造函数，Dart就不再提供默认构造函数
  Person4(String name) {
    this.name = name;
  }
  // 语法糖
  // Person4(this.name);

  // 命名构造函数
  Person4.withNameAge(this.name, this.age);
  Person4.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.age = map["age"];
  }

  @override
  String toString() {
    return "name: $name, age: $age";
  }
}

// 类的初始化列表
class Person5 {
  final String name;
  final int age;

  Person5(this.name, {int age = 10}): this.age = age {

  }
}

// 重定向构造函数
class Person6 {
  String name;
  int age;

  Person6(String name): this._internal(name, 9);
  Person6._internal(this.name, this.age);
}

// 工厂构造函数
// 使用factory关键字创建
// 普通的构造函数默认返回创建出来的对象，工厂构造函数需要手动返回
// 工厂构造函数最大的特点: 可以手动的返回一个对象
class Person7 {
  String name;
  String color;

  static final Map<String, Person7> _nameCache = {};
  static final Map<String, Person7> _colorCache = {};

  factory Person7.withName(String name) {
    if (_nameCache.containsKey(name)) {
      return _nameCache[name]!;
    } else {
      final p = Person7(name, "default");
      _nameCache[name] = p;
      return p;
    }
  }

  factory Person7.withColor(String color) {
    if (_colorCache.containsKey(color)) {
      return _colorCache[color]!;
    } else {
      final p = Person7("default", color);
      _colorCache[color] = p;
      return p;
    }
  }

  Person7(this.name, this.color);
}

// 类的setter和getter
void test7() {
  final p = Person8();

  // 直接访问属性
  p.name = "a";
  print(p.name);
  // 通过setter和getter访问
  p.setName = "a";
  print(p.getName);

}
class Person8 {
  // 成员属性
  String name = "";
  // 静态属性（类属性）
  static String courseTime = "";

  // 对象方法
  void eating() {

  }

  // 静态方法（类方法）
  static void gotoCourse() {

  }

  // setter
  set setName(String name) {
    this.name = name;
  }
  // getter 不要写小括号
  String get getName {
    return name;
  }
}

void test8() {
  final color = Colors.red;
  switch (color) {
    case Colors.red:
      print("red");
      break;
    case Colors.blue:
      print("blude");
      break;
  }

  print(Colors.values);
  print(Colors.blue.index);
}

enum Colors {
  red,
  blue
}
```







# 类的继承

``` dart
class Animal {
  int age;
  Animal(this.age);
}

class Person extends Animal {
  String name;

  Person(this.name, int age): super(age);
}
```



# 抽象类

- 用 abstract 修饰
- 抽象类不能实例化
- 抽象类中的抽象方法必须被子类实现，抽象类中已经实现的方法，子类可以不重写

``` dart
// external 关键字，将方法的声明和方法的实现分离
// 实现用 @patch 补丁

abstract class Shape {
  int getArea();
  String getInfo() {
    return "";
  }
}

// 继承了抽象类后，必须实现抽象类的抽象方法
class Rectangle extends Shape {
  int getArea() {
    return 100;
  }
}
```



抽象方法 @protected

``` dart
@protected
Widget build(BuildContext context);
```

# 隐式接口

- Dart 没有关键字来定义接口(interface/protocol)。默认情况下，定义的每一个类都相当于一个接口文件，被称为隐式接口。
- implements 关键字修饰
- 通过 `implements` 实现隐式接口时，无论这个接口文件中的接口是否已经实现过，接口文件中所有的方法都必须被重新实现。但在某些情况下，一个类可能希望直接复用之前类的原有实现，这种情况，可以使用 Mixin 混入的方式

``` dart
void main(List<String> args) {
  
}

// Dart 没有关键字来定义接口(interface/protocol)，默认情况下所有的class都是隐式接口
// Dart 是单继承

class Runner {
  void running() {

  }
}

class Flyer {
  void flying() {
    
  }
}

// implements：工具
class SuperMan implements Runner, Flyer {
  @override
  void flying() {
    // TODO: implement flying
  }

  @override
  void running() {
    // TODO: implement running
  }

}
```



# mixin混入

- 在with多个mixin类时，如果有相同的方法，那么会执行后面的mixin类中的方法。

``` dart
main(List<String> args) {
  final sm = SuperMan();
  sm.running();
  sm.flying();
}

mixin Runner {
  void running() {
    print("runner running");
  }
}

mixin Flyer {
  void flying() {
    print("flying");
  }
}

class Animal {
  void eating() {
    print("动物次东西");
  }

  void running() {
    print("animal running");
  }
}

class SuperMan extends Animal with Runner, Flyer {
  @override
  void eating() {
    super.eating();
  }

  // void running() {
  //   print("SuperMan running");
  // }
}
```



# 联合类型

``` dart
// 返回类型可以是 FutureOr 也可以是一个具体的类型
FutureOr<T> computation()
```



# 多线程

``` dart
  // 基本使用
  Future(() {
    sleep(Duration(seconds: 2));
    return "hello world";
  }).then((value) {
    print(value);
  });

  // 异常处理
  Future(() {
    sleep(Duration(seconds: 2));
    throw Exception("error"); // 抛出异常
  }).then((value) {
    print(value);
  }).catchError((error) {
    // 捕获异常
    print(error);
  });

  // 链式调用
  Future(() {
    sleep(Duration(seconds: 1));
    return "第一次网络请求的结果";
  }).then((value) {
    sleep(Duration(seconds: 1));
    return "第二次网络请求的结果 $value";
  }).then((value) {
    sleep(Duration(seconds: 1));
    return "第三次网络请求的结果 $value";
  }).then((value) {
    print(value); // 第三次网络请求的结果 第二次网络请求的结果 第一次网络请求的结果
  }).catchError(() {});

  /**
   * await 必须在 saync 函数中使用
   * 函数后面加 async 关键字的函数就是async函数
   * async函数返回的结果必须是一个future
   */
```

