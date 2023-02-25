# 寄存器



### rax

存放返回值

# 指令

moveq : q代表8字节



### leaq

``` assembly
# 直接将 0xd + rip 放到 rax
leaq 0xd(%rip), %rax
```



### movq

``` assembly
# 取出 0xd + rip 存放地址所指向的内存中的值，放到 rax
moveq 0xd(%rip), %rax
```

