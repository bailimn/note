https://www.cnblogs.com/mjios/category/459066.html



- 面向过程
- 基本数据类型：int、float、double、char（没有boolean类型）
- 基本语句：循环语句（do-while、while、for）、条件语句（if、if-else、switch）、goto语句、空语句
- \#include 是C语言的预处理指令之一，所谓预处理，就是在编译之前做的处理，预处理指令一般以 # 开头
- \#include 指令后面会跟着一个文件名，预处理器发现 #include 指令后，就会根据文件名去查找文件，并把这个文件的内容包含到当前文件中。被包含文件中的文本将替换源文件中的 #include 指令，就像你把被包含文件中的全部内容拷贝到这个 #include 指令所在的位置一样
- #include，如果是系统自带的文件，最好用<>；如果是开发人员自己创建的文件，最好用""
- 在标准C语言中，函数的定义顺序是有讲究的，默认情况下，只有后面定义的函数才可以调用前面定义过的函数



# 1. 函数

- C中的函数就是面向对象中的"方法"
- 如果函数只有声明，没有定义，在链接时会报错



## 1.1 函数的顺序

在标准C语言中，函数的定义顺序是有讲究的，默认情况下，只有后面定义的函数才可以调用前面定义过的函数

如果想把其他函数的定义写在main函数后面，而且main函数能正常调用这些函数，那就必须在main函数前面作一下函数的声明

``` c
// 只是做个函数声明，并不用实现
int sum(int a, int b);
/* 可以省略参数名称
int sum(int, int);
*/

int main() {
    int c = sum(1, 4);
    return 0;
}

// 函数的定义(实现)
int sum(int a, int b) {
    return a + b;
}
```



## 1.2 函数的声明格式

```
返回值类型  函数名(参数1, 参数2, ...)
```



## 1.3 函数的形参和实参

在定义函数时，函数名后面的()中定义的变量称为形式参数(形参)；在调用函数时传入的值称为实际参数(实参)。

``` c
// b是test函数的形参(形式参数)
void test(int b)  {
	
}

int main() {
    int a = 10;
    test(a); // a是test函数的实参(实际参数)
    return 0;
}
```



# 2. 基本数据类型

- 指针类型：void *
- 构造类型
    - 数组
    - 结构体：struct
    - 共用体：union
    - 枚举：enum
- 基本数据类型
    - 整形：int
    - 浮点型
        - 单精度浮点型：float
        - 双精度浮点型：double
    - 字符型：char



## 2.1 局部变量的初始化

在C语言中，你声明看一个局部变量后，没有经过初始化赋值是可以使用的。但这是很危险的，不建议这样做。大多数人应该觉得变量b打印出来应该是0，其实不是。因为系统会随意给变量b赋值，得到的是垃圾数据。

``` c
int a;
printf("%d", b); // 打印的是随机值
```



如果是全局的int类型变量，系统会默认赋值为0

``` c
int a;
int main() {
    printf("%d", a); // 0
    return 0;
}
```



## 2.2 char

### 2.2.1 取值范围

char的取值范围是：**ASCII码字符** 或者 **-128~127**的整数

``` c
// 使用char存储大写字母A有2种赋值方式
char c = 'A';
char c = 65;
```



### 2.2.2 char 只能存储一个字符

``` c
// 错误示范
char c1 = '我';
char c2 = '123';
char c3 = "123";
```



## 2.3 类型修饰符

- short：短型
- long：长型
- signed：有符号型
- unsigned：无符号型

``` c
 1 // 下面两种写法是等价的
 2 short int s1 = 1;
 3 short s2 = 1;
 4 
 5 // 下面两种写法是等价的
 6 long int l1 = 2;
 7 long l2 = 2;
 8 
 9 // 可以连续使用2个long
10 long long ll = 10; // 8字节
11 
12 // 下面两种写法是等价的
13 signed int si1 = 3;
14 signed si2 = 3;
15 
16 // 下面两种写法是等价的
17 unsigned int us1 = 4;
18 unsigned us2 = 4;
19 
20 // 也可以同时使用2种修饰符
21 signed short int ss = 5;
22 unsigned long int ul = 5;
```



### 2.3.1 short 和 long

short占2个字节(16位)，int占4个字节(32位)，long占8个字节(64位)



### 2.3.2 signed、unsigned也可以修饰char，long还可以修饰double

``` c
unsigned char c1 = 10;
signed char c2 = -10;

long double d1 = 12.0;
```



# 3. printf 和 scanf 函数

## 3.1 常用格式符及其含义

- %d：带符号的十进制整数
- %o：不带符号的八进制整数
- %x：不带符号的十六进制整数
- %u：不带符号的十进制整数
- %c：字符
- %s：一个或多个字符
- %f：浮点数

## 3.2 格式符的格式控制

- %4d的意思是输出宽度为4，而"14"的宽度为2，因此多出2个宽度，多出的宽度就会在左边用空格填补，因此你会看到"14"左边多了2个空格；如果实际数值宽度比较大，比如用%4d输出宽度为6的"142434"，那就会按照实际数值宽度6来输出。
- %-4d表示输出宽度为4，如果比实际数值宽度大，多出的宽度会在右边用空格填补；如果4比实际数值宽度小，就按照实际数值的宽度来输出
- 如果只想输出2位小数，把%f换成%.2f即可



## 3.3 scanf

调用scanf函数时，需要传入变量的地址作为参数，scanf函数会等待标准输入设备（比如键盘）输入数据，并且将输入的数据赋值给地址对应的变量

``` c
int age;
scanf("%d", &age);

int a, b, c;
scanf("%d-%d-%d", &a, &b, &c); // 输入需要为：10-20-30 然后按回车
```



# 4. 基本语句和运算



## 4.1 基本语句

- 循环语句（do while、while、for）
- 条件语句（if 、if-else、switch）
- goto语句



## 4.2 基本运算

### 4.2.1 算术运算符

- \+ 加法运算符

- \- 减法运算符，或负值运算符

- \* 乘法运算符

- / 除法运算符

- % 模运算符，或称取余运算符，要求%两侧均为整型

### 4.2.2 关系运算符

在C语言中，关系运算的结果为"真"就返回1，"假"就返回0。任何非0值都为"真"，只有0值才为"假"

- <  小于运算符

- <= 小于等于运算符

- \>  大于运算符

- \>= 大于等于运算符

- == 等于运算符

- != 不等于运算符

### 4.2.3 逻辑运算符

逻辑运算的结果也只有两个：成立就为"真"，返回1；不成立就为"假"，返回0

- &&  逻辑与运算符

- || 逻辑或运算符

- !  逻辑非运算符

### 4.2.4 赋值运算符

- =
- += 加赋值运算符。如a += 3+1，等价于 a = a +（3+1）

- -= 减赋值运算符。如a -= 3+1，等价于 a = a -（3+1）

- *= 乘赋值运算符。如a *= 3+1，等价于 a = a *（3+1）

- /= 除赋值运算符。如a /= 3+1，等价于 a = a /（3+1）

- %= 取余赋值运算符。如a %= 3+1，等价于 a = a %（3+1）

### 4.2.5 自增运算符和自减运算符

- ++ 自增运算符。如a++，++a，都等价于a = a+1

- -- 自减运算符。如a--，--a，都等价于a = a-1

### 4.2.6 逗号运算符和逗号表达式

- 逗号运算符主要用于连接表达式：a = a+1 , b = 3*4;

- 整个逗号表达式的值是最后一个表达式的值：c = (++a, a *= 2, b = a * 5); 

### 4.2.7 条件运算符和条件表达式

```
int a = (b > 5) ? 10 : 9;
```

### 4.2.8 sizeof

sizeof可以用来计算一个变量或者一个常量、一种数据类型所占的内存字节数。



# 5. 数组

## 5.1 地址

``` c
int c = 10;
// 获取c变量的地址
printf("%x", &c);
```



## 5.1 一维数组

### 5.1.1 定义

``` c
// 类型  数组名[元素个数]
int a[5];
```



### 5.1.2 一维数组的存储

第一个元素的地址就是整个数组的地址

int a[3]，其实a不算是变量，是个常量，它代表着数组的地址

### 5.1.3 一维数组的初始化

``` c
int a[2] = {1, 3};
```

``` c
int a[2];
a[0] = 1;
a[1] = 2;
```



元素值列表可以是数组所有元素的初值，也可以是前面部分元素的初值

``` c
int a[4] = {1, 2}; // 当数组为整型时，初始化未确定初值的元素，默认为0，所以上面的a[2]、a[3]都为0
```



当对全部数组元素都赋初值时，可以省略元素个数

``` c
int a[] = {2, 5, 7};
```



数组初始化时的赋值方式只能用于数组的定义，定义之后只能一个元素一个元素地赋值

``` c
int a[3];
a[3] = {1, 2, 3}; // 错误
a = {1, 2, 3}; // 错误
```



### 5.2.4 一维数组与函数参数

``` c
void test(int b) { }
void test2(int b[]) { // 也可以写int b[3]
    b[0] = 9;
}

int main() {
    int a[3];
    a[0] = 10;
    
    test(a[0]); // 值拷贝
    
    // 数组名代表着整个数组的地址
    test(a); // 传递的是a数组的指针

    return 0;
}
```



## 5.2 二维数组



### 5.2.1 定义

``` c
// 定义形式：类型  数组名[行数][列数]
int a[2][3]; // 共2行3列，6个元素
```



### 5.2.2 二维数组存储

``` c
// a[0]、a[1]也是数组，是一维数组，而且a[0]、a[1]就是数组名，因此a[0]、a[1]就代表着这个一维数组的地址
// a = a[0] = &a[0][0]
// a[1] = &a[1][0]
int a[2][2];
```



### 5.2.3 二维数组的初始化

``` c
// 按行进行初始化
int a[2][3] = { {2, 2, 3}, {3, 4, 5} };

// 按存储顺序进行初始化(先存放第1行，再存放第2行)
int a[2][3] = {2, 2, 3, 3, 4, 5};

// 对部分元素进行初始化
int a[2][3] = { {2}, {3, 4} };
int b[3][3] = { { }, { , , 2}, {1, 2, 3}};

// 如果只初始化了部分元素，可以省略行数，但是不可以省略列数
int a[][3] = {1, 2, 3, 4, 5, 6};
int a[][3] = {{1, 2, 3}, {3, 5}, {}};
```



# 6. 字符串

字符串就是字符序列，由多个字符组成，在C语言中，我们可以用字符数组来存储字符串。

为了跟普通的字符数组区分开来，应该在字符串的尾部添加了一个结束标志'\0'

``` c
char *name = "abc"; // 会报错，因为是一个字符串常量
const char *name = "abc"; // 不会报错

char name[] = {'a', 'b', 'c', '\0'}; // 变量字符串
```



## 6.1 字符串的初始化

``` c
char a[3] = {'m', 'j', '\0'};

char b[3];
b[0] = 'm';
b[1] = 'j';
b[2] = '\0';

char c[3] = "mj";

char d[] = "mj"; // 系统会自动在字符串尾部加上一个\0结束符

char e[20] = "mj";
```



## 6.2 字符串的输出

``` c
char a[3] = {'m', 'j', '\0'};
printf("%s", a);
```



字符串结尾必须添加\0，不然会出错。%s表示期望输出一个字符串，因此printf函数会从b的首地址开始按顺序输出字符，一直到\0字符为止，因为\0是字符串的结束标记。

``` c
char a[3] = {'m', 'j', '\0'}; // 添加了结束符\0
char b[] = {'i', 's'}; // 假设忘记添加结束符\0

printf("字符串a：%s", a); // 输出: mj
printf("字符串b：%s", b); // 输出: ismj
```



## 6.3 字符串的输入

scanf函数会从a的首地址开始存放用户输入的字符，存放完毕后，系统会自动在尾部加上一个结束标记\0。注意，不要写成scanf("%s", &a)，因为a已经代表了数组的地址，没必要再加上&这个地址运算符。

gets跟scanf一样，会从a的首地址开始存放用户输入的字符，存放完毕后，系统会自动在尾部加上一个结束标记\0。

\* gets一次只能读取一个字符串，scanf则可以同时读取多个字符串

\* gets可以读入包含空格、tab的字符串，直到遇到回车为止；scanf不能用来读取空格、tab



## 6.4 字符串数组

``` c
char names[2][10] = { {'J','a','y','\0'}, {'J','i','m','\0'} };

char names2[2][10] = { {"Jay"}, {"Jim"} };

char names3[2][10] = { "Jay", "Jim" };
```



**字符数组只有在定义时才能将整个字符串一次性赋值给它，一旦定义完了，就只能一个字符一个字符地赋值了。**

``` c
char str[7];
str = "abc"; // 错误

str[0] = 'a'; // 正确
str[1] = 'b';
```



# 7. 字符和字符串常用处理函数

## 7.1 字符处理函数

### 7.1.1 字符输出函数putchar

``` c
putchar(65); // A
putchar('A'); // A
int a = 65;
putchar(a); // A

// putchar一次只能输出一个字符，而printf可以同时输出多个字符
printf("%c %c %c", 'A', 'B', 'a');
```



### 7.1.2 字符输入函数getchar

- getchar函数可以读入空格、TAB，直到遇到回车为止。scanf则不能读入空格和TAB。

- getchar一次只能读入一个字符。scanf则可以同时接收多个字符。

- getchar还能读入回车换行符，这时候你要敲2次回车键。第1次敲的回车换行符被getchar读入，第2次敲的回车键代表输入结束。

``` c
char c;
// getchar会将用户输入的字符赋值给变量c。
c = getchar();
```



## 7.2 字符串处理函数

### 7.2.1 strlen 函数

这个函数可以用来测量字符串的字符个数，不包括\0

``` c
int size = strlen("mj"); // 长度为2
 
char s1[] = "lmj";
int size1 = strlen(s1); // 长度为3
 
char s2[] = {'m', 'j', '\0', 'l', 'm', 'j', '\0'};
int size2 = strlen(s2); // 长度为2
```



### 7.2.2 strcpy函数

``` c
// strcpy函数会将右边的"lmj"字符串拷贝到字符数组s中。在s的尾部肯定会保留一个\0
char s[10];
strcpy(s, "lmj");

// 假设右边的字符串中有好几个\0，strcpy函数只会拷贝第1个\0之前的内容，后面的内容不拷贝
char s[10];
char c[] = {'m', 'j', '\0', 'l', 'm', 'j', '\0'};
strcpy(s, c);
```



### 7.2.3 strcat

``` c
char s1[30] = "LOVE";
// strcat函数会从s1的第1个\0字符开始连接字符串，s1的第1个\0字符会被右边的字符串覆盖，连接完毕后在s1的尾部保留一个\0
strcat(s1, "OC");
```



# 8. 指针

通过变量名引用变量，由系统自动完成变量名和其存储地址之间的转换，称为变量的"直接引用"方式

``` c
char a;
a = 10;
```



## 8.1 什么是指针？

用来存放变量地址的变量，就称为"指针变量"



## 8.2 指针的定义

``` c
// 类名标识符  *指针变量名;
int *p;
float *q;
```



## 8.3 指针的初始化

### 8.3.1 先定义后初始化

``` c
// 定义int类型的变量a
int a = 10;

// 定义一个指针变量p
int *p;

// 将变量a的地址赋值给指针变量p，所以指针变量p指向变量a
p = &a;
```

### 8.3.1 在定义的同时初始化

``` c
// 定义int类型的变量a
int a = 10;

// 定义一个指针变量p
// 并将变量a的地址赋值给指针变量p，所以指针变量p指向变量a
int *p = &a;
```



## 8.4 指针运算符

### 8.4.1 **给指针指向的变量赋值**

``` c
char a = 10;

// 指针变量p指向变量a
char *p = &a; // "*"只是用来说明p是个指针变量

// 通过指针变量p间接修改变量a的值
*p = 9; // "*"是一个指针运算符，这里的*p代表根据p值ffc3这个地址访问对应的存储空间，也就是变量a的存储空间，然后将右边的数值9写入到这个存储空间，相当于 a = 9;


```



### 8.4.2 取出指针所指向变量的值

``` c
char a = 10;

char *p = &a;

char value = *p;
```



# 9. 指向一维数组元素的指针

## 9.1 用指针指向一维数组的元素

``` c
// 定义一个int类型的数组
int a[2];

// 定义一个int类型的指针
int *p;

// 让指针指向数组的第0个元素
p = &a[0]; // 等价于：p = a;

// 修改所指向元素的值
*p = 10;

// 打印第一个元素的值
printf("a[0] = %d", a[0]);
```



## 9.2 用指针遍历数组元素

``` c
// 定义一个int类型的数组
int a[4] = {1, 2, 3, 4};
int i;
for (i = 0; i < 4; i++) {
    printf("%d", a[i]);
}
```



``` c
// 定义一个int类型的数组
int a[4] = {1, 2, 3, 4};

// 定义一个int类型的指针，并指向数组的第0个元素
int *p = a;

int i;
for (i = 0; i < 4; i++) {
    // 利用指针运算符*取出数组元素的值
    int value = *(p+i); // p的值不会改变
    // int value = *(p++); // p的值会改变
	
    
    printf("a[%d] = %d \n", i, value);
}
```



## 9.3 数组、指针与函数参数

``` c
void change(int b[]) {
    b[0] = 10;
}

void change2(int *b) {
    b[0] = 10;
    // 或者*b = 10;
}

int main()
{
    int a[4] = {1, 2, 3, 4};
    
    int *p = a;
	
    change(a);
    change(p);
    
    change2(a);
    
    return 0;
}
```



# 10. 指针和字符串

一个字符串由一个或多个字符组成，因此我们可以用字符数组来存放字符串，不过在数组的尾部要加上一个空字符'\0'。

``` c
// 定义一个字符数组s来存储字符串"mj"，系统会自动在尾部加上一个空字符'\0'。
char s[] = "mj";
```



## 10.1 用指针遍历字符串的所有字符

``` c
// 定义一个指针p
char *p;

// 定一个char类型的数组
char s[] = "mj";

// 指针p指向字符串的首字符'm'
p = s; // 或者 p = &s[0];

for (; *p != '\0'; p++) {
    printf("%c \n", *p);
}
```



## 10.2 用指针直接指向字符串

``` c
#include <string.h>

int main()
{
    // 定义一个char *类型的指针，指向字符串 ‘mj’
    char *s = "mj";
    
    printf("%c", *s); // m
    printf("%c", s[0]); // m
    printf("%s", *s); // 报错
    printf("%s", s); // mj
    
    *s = "like"; // 错误。相当于把字符串"like"存进s指向的那一块内存空间，由第1行代码可以看出，s指向的是"mj"的首字符'm'，也就是说s指向的一块char类型的存储空间，只有1个字节，要"like"存进1个字节的空间内，肯定内存溢出
	s = "like"; // 这样是可以的，指针s指向新的字符串
    
    // 相当于把s的值赋值给指针p，s的值就是字符串mj的首地址，所以p指针指向字符串mj
    char *p = s;
    printf("%s", p); // mj
    
    return 0;
}
```



示例

``` c
char s[10];
*s = 'a';
printf("%s\n", s); // 输出：a6? 乱码，因为没有 \0 结束符
```



``` c
char s[10];
*s = 'a';
*(s+1) = '\0';
printf("%s\n", s); // 输出正确：a
```



## 10.3 指针处理字符串的注意

``` c
// 定义一个字符串变量"lmj"
char a[] = "lmj";

// 将字符串的首字符改为'L'
*a = 'L';

printf("%s", a);
```

``` c
// 定义的是一个字符串常量！
char *p2 = "lmj";
*p2 = 'L'; // 报错，因为p2指向的是一块字符串常量

printf("%s", p2);
```



# 11. 返回指针的函数与指向函数的指针

## 11.1 返回指针的函数

``` c
char * upper(char *str) {
    
}
```



## 11.2 指向函数的指针

``` c
int sum(int a, int b) {
    return a + b;
}

int main()
{
    // 定义一个指针变量p，指向sum函数
    int (*p)(int a, int b) = sum;
    // 或者 int (*p)(int, int) = sum;
    // 或者 int (*p)() = sum;
    
    // 利用指针变量p调用函数
    int result = (*p)(1, 3); // 先利用*p取出指向的函数，再传入参数调用函数
    // 或者 int result = p(1, 3); // 跟调用普通函数没什么区别
    
    printf("%d", result);
    return 0;
}
```



将函数作为参数在函数间传递

``` c
#include <stdio.h>

// 减法运算
int minus(int a, int b) {
    return a - b;
}

// 加法运算
int sum(int a, int b) {
    return a + b;
}

// 这个counting函数是用来做a和b之间的计算，至于做加法还是减法运算，由函数的第1个参数决定
void counting(int (*p)(int, int) , int a, int b) {
    int result = p(a, b);
    printf("计算结果为：%d\n", result);
}

int main()
{
    // 进行加法运算
    counting(sum, 6, 4);
    
    // 进行减法运算
    counting(minus, 6, 4);
    
    return 0;
}

```



# 12. 变量类型

## 12.1 变量的作用域

### 12.1.1 局部变量

定义：在函数内部定义的变量，称为局部变量。形式参数也属于局部变量。

作用域：局部变量只在定义它的函数内部有效，即局部变量只有在定义它的函数内部使用，其它函数不能使用它。

### 12.1.2 全局变量

定义：在所有函数外部定义的变量，称为全局变量。

作用域：全局变量的作用范围是从定义变量的位置开始到源程序结束，即全局变量可以被在其定义位置之后的其它函数所共享。

``` c
// 全局变量
int a;

int main () {
    // 局部变量
    int b;
    return 0;
}
```



## 12.2 变量的存储类型

### 12.2.1 自动变量

定义：自动变量是存储在堆栈中的。

哪些是自动变量：被关键字auto修饰的局部变量都是自动变量，但是极少使用这个关键字，基本上是废的，因为所有的局部变量在默认情况下都是自动变量。

生命周期：在程序执行到声明自动变量的代码块(函数)时，自动变量才被创建；当自动变量所在的代码块(函数)执行完毕后，这些自动变量就会自行销毁。如果一个函数被重复调用，这些自动变量每次都会重新创建。

### 12.2.2 静态变量

定义：静态变量是存储在静态内存中的，也就是不属于堆栈。

 哪些是静态变量：

- 所有的全局变量都是静态变量
- 被关键字static修饰的局部变量也是静态变量

生命周期：静态变量在程序运行之前创建，在程序的整个运行期间始终存在，直到程序结束。

``` c
#include <stdio.h>

int a; // 静态变量

void test() {
    // 只会被创建一次，而且生命周期会延续到程序结束。因为它只会创建一次，所以这行代码只会执行一次，下次再调用test函数时，变量b的值不会被重新初始化为0。
    // 注意：虽然变量b是静态变量，但是只改变了它的存储类型(即生命周期)，并没有改变它的作用域，变量b还是只能在test函数内部使用。
    static int b = 0; // 静态变量
    b++;
    
    int c = 0; // 自动变量
    c++;
    
    printf("b=%d, c=%d \n", b, c);
}

int main() {
    int i; // 自动变量
    // 连续调用3次test函数
    for (i = 0; i<3; i++) {
        test();
    }
    
    return 0;
}
```



### 12.2.3 寄存器变量

定义：存储在硬件寄存器中的变量，称为寄存器变量。寄存器变量比存储在内存中的变量访问效率更高(默认情况下，自动变量和静态变量都是放在内存中的)

哪些变量是寄存器变量：

- 被关键字register修饰的自动变量都是寄存器变量
- 只有自动变量才可以是寄存器变量，全局变量和静态局部变量不行
- 寄存器变量只限于int、char和指针类型变量使用

生命周期：因为寄存器变量本身就是自动变量，所以函数中的寄存器变量在调用该函数时占用寄存器中存放的值，当函数结束时释放寄存器，变量消失。

使用注意：

- 由于计算机中寄存器数目有限，不能使用太多的寄存器变量。如果寄存器使用饱和时，程序将寄存器变量自动转换为自动变量处理
- 为了提高运算速度，一般会将一些频繁使用的自动变量定义为寄存器变量，这样程序尽可能地为它分配寄存器存放，而不用内存



# 13. static和extern关键字1-对函数的作用

static和extern不仅可以用在变量上，还可以用在函数上。

## 13.1 extern与函数

在定义函数时，如果在函数的最左边加上关键字extern，则表示此函数是外部函数，可供其他文件调用。C语言规定，如果在定义函数时省略extern，则隐含为外部函数。

在一个文件中要调用其他文件中的外部函数，则需要在当前文件中用extern声明该外部函数，然后就可以使用，这里的extern也可以省略。



## 13.2 static与函数

在定义函数时，在函数的最左边加上static可以把该函数声明为内部函数(又叫静态函数)，这样该函数就只能在其定义所在的文件中使用。如果在不同的文件中有同名的内部函数，则互不干扰。



# 14. static和extern关键字2-对变量的作用



# 15. 共用体（union）

**共用体**是一种特殊的数据类型，允许您在相同的内存位置存储不同的数据类型。您可以定义一个带有多成员的共用体，但是任何时候只能有一个成员带有值。共用体提供了一种使用相同的内存位置的有效方式。

``` c
union Data
{
   int i;
   float f;
   char  str[20];
} data;

union Data
{
   int i;
   float f;
   char  str[20];
};

union Data data;        
 
data.i = 10;
data.f = 220.5;
strcpy( data.str, "C Programming");

```
