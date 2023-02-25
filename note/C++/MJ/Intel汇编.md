# 1. 内联汇编

``` c++
__asm {
    
}
```

 

# 2. x64汇编要点

h：十六进制

ptr：指定单位

call之前的push，传参

不能内存到内存，只能左右两边有一个寄存器

mov 不能做运算，但是 [] 可以

- mov dest，src
    - 将src的内容赋值给dest，dest = src
- [地址值]
    - 中括号[ ]里面放的都是地址值
- word是2字节，dword是4字节（double word），qword是8字节（quad word）
- call 函数地址
- ret 函数返回
- xor op1, op2
    - 将op1和op2异或的结果赋值给op1，类似于op1 = op1 ^ op2
- add op1, op2
    - op1 = op1 + op2
- sub op1, op2
    - op1 = op1 - op2
- inc op
    - op = op + 1 (increase) 自增
- dec op
    - op = op - 1 (decrease) 自减
- jmp 内存地址
    - jump
- cmp
    - compare 
- jne
    - jump not equal 比较结果不想等才跳转，如果相等继续执行



``` assembly
# 取出 1122h 地址指向的内容给 eax，eax = *1122h
mov eax, dword ptr [1122h]

# 将 1122h 这个地址值赋值给eax， eax = 1122h
# lea: load effect address
lea eax, [1122h] # 等价于：mov eax, 1122h

```



# call

``` assembly
E8 ****** 地址值 # 直接调用地址值指向的函数
FF ****** eax # 取出寄存器的地址值指向的函数进行调用
```



# mov

``` assembly
# ds: data segment 数据段，全局区
move dword ptr ds:[地址],2
```

