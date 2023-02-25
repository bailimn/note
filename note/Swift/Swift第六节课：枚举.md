C 语⾔的枚举写法

``` C
enum weak
{
	MON, TUE, WED, THU, FRI, SAT, SUN
};
```

第⼀个枚举成员的默认值为整型的 0，后⾯的枚举值依次类推，如果我们想更改，只需要这样操作

``` C
enum weak
{
	MON = 1, TUE, WED, THU, FRI, SAT, SUN
};
```

何定义⼀个枚举变量

``` C
enum weak
{
	MON = 1, TUE, WED, THU, FRI, SAT, SUN
} weak;

enum
{
	MON = 1, TUE, WED, THU, FRI, SAT, SUN
} weak;
```

