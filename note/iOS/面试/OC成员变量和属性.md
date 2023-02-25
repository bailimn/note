# 成员变量与属性的区别

编译器将属性自动转换成了成员变量，并且自动生成了getter和setter方法。因此两者最直观的区别是**属性会有相应的getter方法和setter方法，而成员变量没有，另外，外部访问属性可以用"."来访问，访问成员变量需要用"->"来访问**

# 成员变量

只能用 self->_age 访问

``` objective-c
@interface Person : NSObject
{
    @public
    NSString *_name;
    CGFloat _age;
}
@end
```



# 属性

- 用@property声明的变量

- 可以用self.age 和 self->_age 进行访问

- 用 self.age 访问，其实就是调用 setter方法，[self setAge:10];

``` objective-c
// @property 会自动生成 _name 和 _age 成员变量，name 和 age 就是我们声明的属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int *age;
```



### 默认的 getter setter 方法实现

``` objc
- (void)setAge:(int)age {
    _age = age;
}

- (int)age {
    return _age;
}
```





### OC代码编译为cpp对属性的处理

``` objc
@interface Student()
{
  NSString *_address;
}
@property (nonatomic,copy) NSString *name;
@end

@implementation Student
@end
```



``` shell
$ clang -rewrite-objc Student.m
```



``` c++
struct Student_IMPL {
  struct NSObject_IMPL NSObject_IVARS;
  NSString *_address;
  NSString *_name;
};

static NSString * _I_Student_name(Student * self, SEL _cmd) { return (*(NSString **)((char *)self + OBJC_IVAR_$_Student$_name)); }

static void _I_Student_setName_(Student * self, SEL _cmd, NSString *name) { objc_setProperty (self, _cmd, __OFFSETOFIVAR__(struct Student, _name), (id)name, 0, 1); }
```



https://www.jianshu.com/p/be00d998a4ed