第一行告诉 LLDB 以 Intel 风格显示 x86 程序集（32 位和 64 位）。 
第二行告诉 LLDB 不要跳过函数序言
settings set target.x86-disassembly-flavor intel
settings set target.skip-prologue false




command alias -H "Print value in ObjC context in hexadecimal" -h "Print in hex" -- cpx expression -f x -l objc --




// 这将打印出组成 A 字符所需的字节数
(lldb) p sizeof('A')
(unsigned long) $0 = 1

(lldb) p/t 'A'
(char) $1 = 0b01000001 // 字符 A 在 ASCII 中的二进制表示
(lldb) p/x 'A'
(char) $2 = 0x41 // 字符 A 在 ASCII 中的十六进制表示

十六进制非常适合查看内存，因为单个十六进制数字正好代表 4 位。 因此，如果您有 2 个十六进制数字，则您有 1 个字节


• Nybble: 4 bits, a single value in hexadecimal
• Half word: 16 bits, or 2 bytes
• Word: 32 bits, or 4 bytes
• Double word or Giant word: 64 bits or 8 bytes.




RIP 或指令指针寄存器



(lldb) command alias -H "Print value in ObjC context in hexadecimal" -h "Print in hex" -- cpx expression -f x -l objc --
(lldb) cpx $rip
(unsigned long) $0 = 0x000000010e40d700
// -v，用于转储详细输出
(lldb) image lookup -vrn ^Registers.*aBadMethod
1 match found in /Users/blf/Library/Developer/Xcode/DerivedData/Registers-bnzpejchhuvkmggiixdvrlfdkpmr/Build/Products/Debug/Registers.app/Contents/MacOS/Registers:
        Address: Registers[0x0000000100008700] (Registers.__TEXT.__text + 21312)
        Summary: Registers`Registers.AppDelegate.aBadMethod() -> () at AppDelegate.swift:38
         Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Registers-bnzpejchhuvkmggiixdvrlfdkpmr/Build/Products/Debug/Registers.app/Contents/MacOS/Registers", arch = "x86_64"
    CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/12-Assembly & Memory/final/Registers/Registers/AppDelegate.swift", language = "swift"
       Function: id = {0x40000009d}, name = "Registers.AppDelegate.aBadMethod() -> ()", mangled = "$s9Registers11AppDelegateC10aBadMethodyyF", range = [0x000000010e40d700-0x000000010e40d928)
       FuncType: id = {0x40000009d}, byte-size = 8, decl = AppDelegate.swift:38, compiler_type = "() -> ()
"
         Blocks: id = {0x40000009d}, range = [0x10e40d700-0x10e40d928)
      LineEntry: [0x000000010e40d700-0x000000010e40d71c): /Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/12-Assembly & Memory/final/Registers/Registers/AppDelegate.swift:38
         Symbol: id = {0x00000363}, range = [0x000000010e40d700-0x000000010e40d930), name="Registers.AppDelegate.aBadMethod() -> ()", mangled="$s9Registers11AppDelegateC10aBadMethodyyF"
       Variable: id = {0x4000000ba}, name = "self", type = "Registers.AppDelegate", location = DW_OP_fbreg -16, decl = AppDelegate.swift:38

(lldb) image lookup -vrn ^Registers.*aGoodMethod
1 match found in /Users/blf/Library/Developer/Xcode/DerivedData/Registers-bnzpejchhuvkmggiixdvrlfdkpmr/Build/Products/Debug/Registers.app/Contents/MacOS/Registers:
        Address: Registers[0x0000000100008960] (Registers.__TEXT.__text + 21920)
        Summary: Registers`Registers.AppDelegate.aGoodMethod() -> () at AppDelegate.swift:42
         Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Registers-bnzpejchhuvkmggiixdvrlfdkpmr/Build/Products/Debug/Registers.app/Contents/MacOS/Registers", arch = "x86_64"
    CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/12-Assembly & Memory/final/Registers/Registers/AppDelegate.swift", language = "swift"
       Function: id = {0x4000000e3}, name = "Registers.AppDelegate.aGoodMethod() -> ()", mangled = "$s9Registers11AppDelegateC11aGoodMethodyyF", range = [0x000000010e40d960-0x000000010e40db88)
       FuncType: id = {0x4000000e3}, byte-size = 8, decl = AppDelegate.swift:42, compiler_type = "() -> ()
"
         Blocks: id = {0x4000000e3}, range = [0x10e40d960-0x10e40db88)
      LineEntry: [0x000000010e40d960-0x000000010e40d97c): /Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/12-Assembly & Memory/final/Registers/Registers/AppDelegate.swift:42
         Symbol: id = {0x0000036b}, range = [0x000000010e40d960-0x000000010e40db90), name="Registers.AppDelegate.aGoodMethod() -> ()", mangled="$s9Registers11AppDelegateC11aGoodMethodyyF"
       Variable: id = {0x400000100}, name = "self", type = "Registers.AppDelegate", location = DW_OP_fbreg -16, decl = AppDelegate.swift:42
// 替换 rip 寄存器的值为 aGoodMethod 函数的地址
(lldb) register write rip 0x000000010e40d960
aGoodMethod()


// range = [0x000000010e40d960-0x000000010e40db90) : 该地址称为加载地址。 这是该函数在内存中的实际物理地址。



RIP 寄存器以 R 开头，表示 64 位



由于 R8 到 R15 系列寄存器仅针对 64 位体系结构创建，因此它们使用完全不同的格式来表示较小的对应物


表格生成网站：https://tableconvert.com/
+-----------------+-----------------+-----------------+----------------+
| 64-bit Register | 32-bit Register | 16-bit Register | 8-bit Register |
+-----------------+-----------------+-----------------+----------------+
|       rax       |       eax       |        ax       |       al       |
+-----------------+-----------------+-----------------+----------------+
|       rbx       |       ebx       |        bx       |       bl       |
+-----------------+-----------------+-----------------+----------------+
|       rcx       |       ecx       |        cx       |       cl       |
+-----------------+-----------------+-----------------+----------------+
|       rdx       |       edx       |        dx       |       dl       |
+-----------------+-----------------+-----------------+----------------+
|       rsi       |       esi       |        si       |       sil      |
+-----------------+-----------------+-----------------+----------------+
|       rdi       |       edi       |        di       |       dil      |
+-----------------+-----------------+-----------------+----------------+
|       rbp       |       ebp       |        bp       |       bpl      |
+-----------------+-----------------+-----------------+----------------+
|       rsp       |       esp       |        sp       |       spl      |
+-----------------+-----------------+-----------------+----------------+
|        r8       |       r8d       |       r8w       |       r8l      |
+-----------------+-----------------+-----------------+----------------+
|        r9       |       r9d       |       r9w       |       r9l      |
+-----------------+-----------------+-----------------+----------------+
|       r10       |       r10d      |       r10w      |      r10l      |
+-----------------+-----------------+-----------------+----------------+
|       r11       |       r11d      |       r11w      |      r11l      |
+-----------------+-----------------+-----------------+----------------+
|       r12       |       r12d      |       r12w      |      r12l      |
+-----------------+-----------------+-----------------+----------------+
|       r13       |       r13d      |       r13w      |      r13l      |
+-----------------+-----------------+-----------------+----------------+
|       r14       |       r14d      |       r14w      |      r14l      |
+-----------------+-----------------+-----------------+----------------+
|       r15       |       r15d      |       r15w      |      r15l      |
+-----------------+-----------------+-----------------+----------------+


(lldb) register write rdx 0x0123456789ABCDEF
(lldb) p/x $rdx
(unsigned long) $0 = 0x0123456789abcdef
(lldb) p/x $edx
(unsigned int) $1 = 0x89abcdef
(lldb) p/x $dx
(unsigned short) $2 = 0xcdef
(lldb) p/x $dl // DL 中的 L 代表“低”而 DH 中的 H 代表“高”
(unsigned char) $3 = 0xef
(lldb) p/x $dh
(unsigned char) $4 = 0xcd

(lldb) register write $r9 0x0123456789abcdef
(lldb) p/x $r9
(unsigned long) $5 = 0x0123456789abcdef
(lldb) p/x $r9d
(unsigned int) $6 = 0x89abcdef
(lldb) p/x $r9w
(unsigned short) $7 = 0xcdef
(lldb) p/x $r9l
(unsigned char) $8 = 0xef


它不是在执行存储在 RIP 寄存器中的指令——而是在执行指向 RIP 寄存器中的指令


(lldb) cpx $rip
(unsigned long) $0 = 0x0000000109b22700
// -f : 格式化参数，这种情况是汇编指令格式
// -c : 打印的条数
(lldb) memory read -fi -c1 0x0000000109b22700
->  0x109b22700: 55  push   rbp 
// 55 就是 指令 push rbp 的编码
// 验证
(lldb) expression -f i -l objc -- 0x55
(int) $1 = 55  push   rbp
(lldb) p/i 0x55 // 需要在OC上下文执行
(int) $2 = 55  push   rbp

(lldb) memory read -fi -c4 0x0000000109b22700
    0x109b22700: 55                    push   rbp
    0x109b22701: 48 89 e5              mov    rbp, rsp
    0x109b22704: 41 55                 push   r13
    0x109b22706: 48 81 ec d8 00 00 00  sub    rsp, 0xd8
(lldb) x/4i 0x0000000109b22700
    0x109b22700: 55                    push   rbp
    0x109b22701: 48 89 e5              mov    rbp, rsp
    0x109b22704: 41 55                 push   r13
    0x109b22706: 48 81 ec d8 00 00 00  sub    rsp, 0xd8
(lldb) p/i 0xe58948
(int) $3 = 48 89 e5  mov    rbp, rsp

// -s1 : 要读取1个字节的大小
(lldb) memory read -s1 -c20 -fx 0x0000000109b22700
0x109b22700: 0x55 0x48 0x89 0xe5 0x41 0x55 0x48 0x81
0x109b22708: 0xec 0xd8 0x00 0x00 0x00 0x48 0xc7 0x45
0x109b22710: 0xf0 0x00 0x00 0x00
(lldb) memory read -s2 -c10 -fx 0x0000000109b22700
0x109b22700: 0x4855 0xe589 0x5541 0x8148 0xd8ec 0x0000 0x4800 0x45c7
0x109b22710: 0x00f0 0x0000