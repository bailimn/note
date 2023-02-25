stack 堆 向下生长



0xFFFFFFFFF
.
.
.
Stack start -> +--------------+
               | First Frame  |
               |              |
               +--------------+
               | Second Frame |
               |              |
               +--------------+
               | Third Frame  |
               |              |
               +--------------+
.
.
.
0x00000000


堆栈指针寄存器 RSP 指向特定线程的堆栈头
esp永远指向堆栈栈顶

基指针寄存器 (RBP).当程序在方法/函数内部执行时，程序使用来自 RBP 的偏移量来访问局部变量或函数参数。发生这种情况是因为 RBP 在函数序言中的函数开始时被设置为 RSP 寄存器的值。


当需要将 int、Objective-C 实例、Swift 类或引用等任何内容保存到堆栈中时，将使用push操作码。 push 递减堆栈指针（记住，堆栈向下增长），然后存储分配给新 RSP 值指向的内存地址的值。


push 0x5
c伪代码为
RSP = RSP - 0x8 // 64位为8个字节
*RSP = 0x5


pop rdx
c伪代码为
RDX = *RSP
RSP = RSP + 0x8


call pushes the address of where to return to after the called function completes; then jumps to the function.
0x7fffb34de913 <+227>: call 0x7fffb34df410
0x7fffb34de918 <+232>: mov edx, eax
c伪代码为
1. RIP = 0x7fffb34de918
2. RSP = RSP - 0x8
3. *RSP = RIP
4. RIP = 0x7fffb34df410








(lldb) disassemble -n 'ViewController.awakeFromNib'
Registers`ViewController.awakeFromNib():
    0x105e69af0 <+0>:   push   rbp
    0x105e69af1 <+1>:   mov    rbp, rsp
    0x105e69af4 <+4>:   sub    rsp, 0x30
    0x105e69af8 <+8>:   mov    qword ptr [rbp - 0x8], 0x0
    0x105e69b00 <+16>:  mov    qword ptr [rbp - 0x8], r13
    0x105e69b04 <+20>:  mov    rax, qword ptr [rip + 0x754d] ; (void *)0x00007fff2022f690: objc_retain
    0x105e69b0b <+27>:  mov    rdi, r13
    0x105e69b0e <+30>:  mov    qword ptr [rbp - 0x20], r13
    0x105e69b12 <+34>:  call   rax
    0x105e69b14 <+36>:  xor    ecx, ecx
    0x105e69b16 <+38>:  mov    edi, ecx
    0x105e69b18 <+40>:  mov    qword ptr [rbp - 0x28], rax
    0x105e69b1c <+44>:  call   0x105e69a90               ; type metadata accessor for Registers.ViewController at <compiler-generated>
    0x105e69b21 <+49>:  mov    rsi, qword ptr [rbp - 0x20]
    0x105e69b25 <+53>:  mov    qword ptr [rbp - 0x18], rsi
    0x105e69b29 <+57>:  mov    qword ptr [rbp - 0x10], rax
    0x105e69b2d <+61>:  mov    rsi, qword ptr [rip + 0x881c] ; "awakeFromNib"
    0x105e69b34 <+68>:  lea    rdi, [rbp - 0x18]
    0x105e69b38 <+72>:  mov    qword ptr [rbp - 0x30], rdx
    0x105e69b3c <+76>:  call   0x105e6efde               ; symbol stub for: objc_msgSendSuper2
    0x105e69b41 <+81>:  mov    rax, qword ptr [rip + 0x7508] ; (void *)0x00007fff20231490: objc_release
    0x105e69b48 <+88>:  mov    rdi, qword ptr [rbp - 0x20]
    0x105e69b4c <+92>:  call   rax
    0x105e69b4e <+94>:  mov    edi, 0x5
->  0x105e69b53 <+99>:  call   0x105e68190               ; StackWalkthrough
    0x105e69b58 <+104>: add    rsp, 0x30
    0x105e69b5c <+108>: pop    rbp
    0x105e69b5d <+109>: ret    
(lldb) command alias dumpreg register read rsp rbp rdi rdx
(lldb) dumpreg
     rsp = 0x00007ffee9d99490
     rbp = 0x00007ffee9d994c0
     rdi = 0x0000000000000005
     rdx = 0x0000000000000023
(lldb) si // step-inst 0x105e69b53 <+99>:  call   0x105e68190               ; StackWalkthrough
Registers`StackWalkthrough:
->  0x105e68190 <+0>:  push   rbp
    0x105e68191 <+1>:  mov    rbp, rsp
    0x105e68194 <+4>:  mov    rdx, 0x0
    0x105e6819b <+11>: mov    rdx, rdi
    0x105e6819e <+14>: push   rdx
    0x105e6819f <+15>: mov    rdx, 0x0
    0x105e681a6 <+22>: pop    rdx
    0x105e681a7 <+23>: pop    rbp
    0x105e681a8 <+24>: ret    
(lldb) dumpreg
     rsp = 0x00007ffee9d99488
     rbp = 0x00007ffee9d994c0
     rdi = 0x0000000000000005
     rdx = 0x0000000000000023
(lldb) x/gx $rsp // 验证 RSP 指向的值现在将包含前一个函数的返回地址。 x/gx: x 命令是内存读取命令的快捷方式。 /gx 表示将内存格式化为一个巨大的字（8 个字节) 以十六进制格式。
0x7ffee9d99488: 0x0000000105e69b58  // 0x105e69b58 <+104>: add    rsp, 0x30
(lldb) 




0x1000013ea <+186>: mov qword ptr [rsp + 0x8], 0x8 // 包含 RSP 和可选值的括号表示取消引用, 就像 C 编程中的 * 一样。“将 0x8 放入 RSP + 0x8 指向的内存地址中”。




• RBP 将指向此函数的堆栈帧的开始。
• * RBP 将包含前一个堆栈帧的起始地址。 （在LLDB中使用x / gx $ rbp查看）。
• * (RBP + 0x8) 将指向堆栈跟踪中前一个函数的返回地址（在LLDB 中使用x / gx '$ rbp + 0x8' 来查看）。
• * (RBP + 0x10) 将指向第 7 个参数（如果有）。
• * (RBP + 0x18) 将指向第 8 个参数（如果有）。
• * (RBP + 0x20) 将指向第 9 个参数（如果有）。
• * (RBP + 0x28) 将指向第 10 个参数（如果有）。
• RBP - X，其中 X 是 0x8 的倍数，将引用该函数的局部变量。