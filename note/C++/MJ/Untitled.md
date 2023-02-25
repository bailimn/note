# 1. 函数重载（Overload）

函数名相同，参数个数、参数类型、参数顺序不同，和返回值类型无关。

本质：采用了name mangling技术，C++编译器默认会对符号名（比如函数名）进行改编、修饰。

``` c
// display_v
void display() {
	cout << "display()" << endl;
}

// display_i
void display(int a) {
	cout << "display(int) - " << a << endl;
}

// display_l
void display(long a) {
	cout << "display(long) - " << a << endl;
}

// display_d
void display(double a) {
	cout << "display(double) - " << a << endl;
}
```

# 2. 默认参数

- 默认参数只能按照右到左的顺序
- 如果函数同时有声明、实现，默认参数只能放在函数声明中
- 默认参数的值可以是常量、全局符号（全局变量、函数名）

``` c
int sum(int v1 = 10; int v2 = 6) {
    return v1 + v2;
}

sum(10);
```



# 3. extern "C"

被extern"c" 修饰的代码会按照C语言的方式去编译

函数既有声明又有实现，写在声明中

一般用于C、C++混合开发

``` c
#ifndef 头文件名
#define 头文件名

#ifdef __cplusplus
extern "C" {
#endif
    
void func();
void func(int v);
    
#ifdef __cplusplus
}
#endif

#endif
```



``` c
extern "C" void func() { }
extern "C" void func(int v) { }

extern "C" {
	void func() { }
	void func(int v) { }
} 

extern "C" {
    #include "math.h"
}
```



# 4. 内联函数（inline function）

编译器会将函数调用直接展开为函数体代码



# 5. const

被const修饰的变量不可修改

const修饰的变量，必须在定义时就给定值。

修饰类、结构体（的指针），其成员也不可以更改

**const修饰的是右边的内容**



``` c++
struct Date {
    int year;
    int month;
    int day;
};


// 示例 1
// C++ 定义结构体变量，可以不用加 struct
Date d = {2022, 10, 1};
d.year = 2023; // 可以修改

// 示例 2
const Date d = {2022, 10, 1};
d.year = 2023; // 报错：Cannot assign to variable 'd' with const-qualified type 'const Date'

// 示例 3
Date d = {2022, 10, 1};
Date d2 = {2022, 10, 1};
Date *p = &d; // 定义结构体指针p，并指向结构体变量d
p->year = 2021; // 指针访问结构体成员用 箭头
(*p).year = 2011; // *p 取出结构体d，再给成员赋值
*p = d2; // 不是用p指针指向d2，而是把d2的值赋值给d
p = &d2; // 用p指针指向d2

// 示例 4
Date d = {2022, 10, 1};
Date d2 = {2022, 10, 1};
const Date *p = &d;
p->year = 2021; // 报错：Cannot assign to variable 'p' with const-qualified type 'const Date *'
(*p).year = 2011; // 报错：Read-only variable is not assignable
*p = d2; // 报错：No viable overloaded '='
p = &d2; // 不会报错

// 示例 5
Date d = {2022, 10, 1};
Date d2 = {2022, 10, 1};
Date * const p = &d;
p->year = 2021; // 不会报错 Date *'
(*p).year = 2011; // 不会报错
*p = d2; // 不会报错
p = &d2; // 报错：Cannot assign to variable 'p' with const-qualified type 'Date *const'
```



# 6. 引用（Reference）

引用的本质就是指针

``` c++
int age = 10;
// 定义一个age的引用，refAge相当于是age的别名，在定义时就必须初始化，而且以后不可以修改
int &refAge = age;
refAge = 20;

int *p = age;
int *&ref = p;

// 数组里面放的是int类型的指针
int *arr[3] = {};

// 用于存放指向数组的指针
int (*arr)[3];
```



用引用和指针实现两个方法的交换

``` c++
// 用指针 实现两个方法的交换
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}
// 用引用 实现两个方法的交换
void swap(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

int a = 10;
int b = 20;

//    swap(&a, &b); // 指针
swap(a, b); // 引用
```



## 6.1 常引用

``` c++
int age = 10;
const in &ref = age;
```

``` c++
int sum(const in &v1, const int &v2) {
    
}

int a = 10;
int b = 20;
sum(a, b);
sum(10, 20); // 如果sum参数不是常引用，会报错
```





