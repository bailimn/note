




(lldb) disassemble -b
libsystem_kernel.dylib`mach_msg_trap:
    0x7fff603032b0 <+0>:  49 89 ca        mov    r10, rcx
    0x7fff603032b3 <+3>:  b8 1f 00 00 01  mov    eax, 0x100001f
    0x7fff603032b8 <+8>:  0f 05           syscall 
->  0x7fff603032ba <+10>: c3              ret    
    0x7fff603032bb <+11>: 90              nop


(lldb) disassemble -n '-[UIViewController setTitle:]'
UIKitCore`-[UIViewController setTitle:]:
    0x7fff23f8904a <+0>:   push   rbp
    0x7fff23f8904b <+1>:   mov    rbp, rsp
    0x7fff23f8904e <+4>:   push   r15
    0x7fff23f89050 <+6>:   push   r14
    0x7fff23f89052 <+8>:   push   r13
    0x7fff23f89054 <+10>:  push   r12
    0x7fff23f89056 <+12>:  push   rbx
    0x7fff23f89057 <+13>:  push   rax
    0x7fff23f89058 <+14>:  mov    rbx, qword ptr [rip + 0x5c44be01] ; UIViewController._title
    0x7fff23f8905f <+21>:  cmp    qword ptr [rdi + rbx], rdx
    0x7fff23f89063 <+25>:  je     0x7fff23f89141            ; <+247>
    0x7fff23f89069 <+31>:  mov    r12, rdi
    0x7fff23f8906c <+34>:  mov    r15, qword ptr [rip + 0x5c3dbf55] ; "copy"
    0x7fff23f89073 <+41>:  mov    rdi, rdx
    0x7fff23f89076 <+44>:  call   qword ptr [rip + 0x60e1becc] ; (void *)0x00007fff20191840: objc_retain
    0x7fff23f8907c <+50>:  mov    r14, rax
    0x7fff23f8907f <+53>:  mov    r13, qword ptr [rip + 0x60e1beb2] ; (void *)0x00007fff20175280: objc_msgSend
    0x7fff23f89086 <+60>:  mov    rdi, rax
    0x7fff23f89089 <+63>:  mov    rsi, r15
    0x7fff23f8908c <+66>:  call   r13
    0x7fff23f8908f <+69>:  mov    rdi, qword ptr [r12 + rbx]
    0x7fff23f89093 <+73>:  mov    qword ptr [r12 + rbx], rax
    0x7fff23f89097 <+77>:  mov    r15, qword ptr [rip + 0x60e1bea2] ; (void *)0x00007fff20191530: objc_release
    0x7fff23f8909e <+84>:  call   r15
    0x7fff23f890a1 <+87>:  mov    rsi, qword ptr [rip + 0x5c3f83b8] ; "_existingNavigationItem"
    0x7fff23f890a8 <+94>:  mov    rdi, r12
    0x7fff23f890ab <+97>:  call   r13
    0x7fff23f890ae <+100>: mov    rdi, rax
    0x7fff23f890b1 <+103>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f890b6 <+108>: mov    rbx, rax
    0x7fff23f890b9 <+111>: mov    rsi, qword ptr [rip + 0x5c3dba00] ; "setTitle:"
    0x7fff23f890c0 <+118>: mov    rdi, rax
    0x7fff23f890c3 <+121>: mov    rdx, r14
    0x7fff23f890c6 <+124>: call   r13
    0x7fff23f890c9 <+127>: mov    rdi, rbx
    0x7fff23f890cc <+130>: call   r15
    0x7fff23f890cf <+133>: mov    rsi, qword ptr [rip + 0x5c3f8392] ; "_existingTabBarItem"
    0x7fff23f890d6 <+140>: mov    rdi, r12
    0x7fff23f890d9 <+143>: call   r13
    0x7fff23f890dc <+146>: mov    rdi, rax
    0x7fff23f890df <+149>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f890e4 <+154>: mov    rbx, rax
    0x7fff23f890e7 <+157>: mov    rdi, rax
    0x7fff23f890ea <+160>: mov    rsi, qword ptr [rip + 0x5c3db9cf] ; "setTitle:"
    0x7fff23f890f1 <+167>: mov    rdx, r14
    0x7fff23f890f4 <+170>: call   r13
    0x7fff23f890f7 <+173>: mov    rdi, r14
    0x7fff23f890fa <+176>: call   r15
    0x7fff23f890fd <+179>: mov    rdi, rbx
    0x7fff23f89100 <+182>: call   r15
    0x7fff23f89103 <+185>: mov    rsi, qword ptr [rip + 0x5c3dfbde] ; "parentViewController"
    0x7fff23f8910a <+192>: mov    rdi, r12
    0x7fff23f8910d <+195>: call   r13
    0x7fff23f89110 <+198>: mov    rdi, rax
    0x7fff23f89113 <+201>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f89118 <+206>: mov    rbx, rax
    0x7fff23f8911b <+209>: mov    rsi, qword ptr [rip + 0x5c3f834e] ; "updateTitleForViewController:"
    0x7fff23f89122 <+216>: mov    rdi, rax
    0x7fff23f89125 <+219>: mov    rdx, r12
    0x7fff23f89128 <+222>: call   r13
    0x7fff23f8912b <+225>: mov    rdi, rbx
    0x7fff23f8912e <+228>: mov    rax, r15
    0x7fff23f89131 <+231>: add    rsp, 0x8
    0x7fff23f89135 <+235>: pop    rbx
    0x7fff23f89136 <+236>: pop    r12
    0x7fff23f89138 <+238>: pop    r13
    0x7fff23f8913a <+240>: pop    r14
    0x7fff23f8913c <+242>: pop    r15
    0x7fff23f8913e <+244>: pop    rbp
    0x7fff23f8913f <+245>: jmp    rax
    0x7fff23f89141 <+247>: add    rsp, 0x8
    0x7fff23f89145 <+251>: pop    rbx
    0x7fff23f89146 <+252>: pop    r12
    0x7fff23f89148 <+254>: pop    r13
    0x7fff23f8914a <+256>: pop    r14
    0x7fff23f8914c <+258>: pop    r15
    0x7fff23f8914e <+260>: pop    rbp
    0x7fff23f8914f <+261>: ret

(lldb) disassemble -a 0x7fff23f89058
UIKitCore`-[UIViewController setTitle:]:
    0x7fff23f8904a <+0>:   push   rbp
    0x7fff23f8904b <+1>:   mov    rbp, rsp
    0x7fff23f8904e <+4>:   push   r15
    0x7fff23f89050 <+6>:   push   r14
    0x7fff23f89052 <+8>:   push   r13
    0x7fff23f89054 <+10>:  push   r12
    0x7fff23f89056 <+12>:  push   rbx
    0x7fff23f89057 <+13>:  push   rax
    0x7fff23f89058 <+14>:  mov    rbx, qword ptr [rip + 0x5c44be01] ; UIViewController._title
    0x7fff23f8905f <+21>:  cmp    qword ptr [rdi + rbx], rdx
    0x7fff23f89063 <+25>:  je     0x7fff23f89141            ; <+247>
    0x7fff23f89069 <+31>:  mov    r12, rdi
    0x7fff23f8906c <+34>:  mov    r15, qword ptr [rip + 0x5c3dbf55] ; "copy"
    0x7fff23f89073 <+41>:  mov    rdi, rdx
    0x7fff23f89076 <+44>:  call   qword ptr [rip + 0x60e1becc] ; (void *)0x00007fff20191840: objc_retain
    0x7fff23f8907c <+50>:  mov    r14, rax
    0x7fff23f8907f <+53>:  mov    r13, qword ptr [rip + 0x60e1beb2] ; (void *)0x00007fff20175280: objc_msgSend
    0x7fff23f89086 <+60>:  mov    rdi, rax
    0x7fff23f89089 <+63>:  mov    rsi, r15
    0x7fff23f8908c <+66>:  call   r13
    0x7fff23f8908f <+69>:  mov    rdi, qword ptr [r12 + rbx]
    0x7fff23f89093 <+73>:  mov    qword ptr [r12 + rbx], rax
    0x7fff23f89097 <+77>:  mov    r15, qword ptr [rip + 0x60e1bea2] ; (void *)0x00007fff20191530: objc_release
    0x7fff23f8909e <+84>:  call   r15
    0x7fff23f890a1 <+87>:  mov    rsi, qword ptr [rip + 0x5c3f83b8] ; "_existingNavigationItem"
    0x7fff23f890a8 <+94>:  mov    rdi, r12
    0x7fff23f890ab <+97>:  call   r13
    0x7fff23f890ae <+100>: mov    rdi, rax
    0x7fff23f890b1 <+103>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f890b6 <+108>: mov    rbx, rax
    0x7fff23f890b9 <+111>: mov    rsi, qword ptr [rip + 0x5c3dba00] ; "setTitle:"
    0x7fff23f890c0 <+118>: mov    rdi, rax
    0x7fff23f890c3 <+121>: mov    rdx, r14
    0x7fff23f890c6 <+124>: call   r13
    0x7fff23f890c9 <+127>: mov    rdi, rbx
    0x7fff23f890cc <+130>: call   r15
    0x7fff23f890cf <+133>: mov    rsi, qword ptr [rip + 0x5c3f8392] ; "_existingTabBarItem"
    0x7fff23f890d6 <+140>: mov    rdi, r12
    0x7fff23f890d9 <+143>: call   r13
    0x7fff23f890dc <+146>: mov    rdi, rax
    0x7fff23f890df <+149>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f890e4 <+154>: mov    rbx, rax
    0x7fff23f890e7 <+157>: mov    rdi, rax
    0x7fff23f890ea <+160>: mov    rsi, qword ptr [rip + 0x5c3db9cf] ; "setTitle:"
    0x7fff23f890f1 <+167>: mov    rdx, r14
    0x7fff23f890f4 <+170>: call   r13
    0x7fff23f890f7 <+173>: mov    rdi, r14
    0x7fff23f890fa <+176>: call   r15
    0x7fff23f890fd <+179>: mov    rdi, rbx
    0x7fff23f89100 <+182>: call   r15
    0x7fff23f89103 <+185>: mov    rsi, qword ptr [rip + 0x5c3dfbde] ; "parentViewController"
    0x7fff23f8910a <+192>: mov    rdi, r12
    0x7fff23f8910d <+195>: call   r13
    0x7fff23f89110 <+198>: mov    rdi, rax
    0x7fff23f89113 <+201>: call   0x7fff24cdb996            ; symbol stub for: objc_retainAutoreleasedReturnValue
    0x7fff23f89118 <+206>: mov    rbx, rax
    0x7fff23f8911b <+209>: mov    rsi, qword ptr [rip + 0x5c3f834e] ; "updateTitleForViewController:"
    0x7fff23f89122 <+216>: mov    rdi, rax
    0x7fff23f89125 <+219>: mov    rdx, r12
    0x7fff23f89128 <+222>: call   r13
    0x7fff23f8912b <+225>: mov    rdi, rbx
    0x7fff23f8912e <+228>: mov    rax, r15
    0x7fff23f89131 <+231>: add    rsp, 0x8
    0x7fff23f89135 <+235>: pop    rbx
    0x7fff23f89136 <+236>: pop    r12
    0x7fff23f89138 <+238>: pop    r13
    0x7fff23f8913a <+240>: pop    r14
    0x7fff23f8913c <+242>: pop    r15
    0x7fff23f8913e <+244>: pop    rbp
    0x7fff23f8913f <+245>: jmp    rax
    0x7fff23f89141 <+247>: add    rsp, 0x8
    0x7fff23f89145 <+251>: pop    rbx
    0x7fff23f89146 <+252>: pop    r12
    0x7fff23f89148 <+254>: pop    r13
    0x7fff23f8914a <+256>: pop    r14
    0x7fff23f8914c <+258>: pop    r15
    0x7fff23f8914e <+260>: pop    rbp
    0x7fff23f8914f <+261>: ret


    /************************************* Modules ********************************************/

(lldb) image list
[  0] FD605897-1FE5-3119-8321-89F3A73A5B40 0x000000010eb37000 /Users/blf/Library/Developer/Xcode/DerivedData/VCTransitions-erslemlcelmktifgtvcgtshrpios/Build/Products/Debug Stripped-iphonesimulator/VCTransitions.app/VCTransitions 
[  1] 57DB2053-BFD5-3683-97C6-F1DB2A1F1D09 0x0000000112172000 /usr/lib/dyld 
[  2] 2A92FC99-72A9-38ED-8DDD-AF4C25080124 0x000000010eb5f000 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/dyld_sim 
[  3] C2A18288-4AA2-3189-A1C6-5963E370DE4C 0x00007fff2071f000 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/Foundation.framework/Foundation 
[  4] 583E6742-DE52-3E41-863C-CDC43AA76767 0x00007fff20174000 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libobjc.A.dylib 
...
(lldb) image list -b
[  0] VCTransitions
[  1] dyld
[  2] dyld_sim
[  3] Foundation
...
[356] TextInputUI
// 将位于 path 的模块加载到可执行文件的进程空间中
(lldb) process load /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libobjc-trampolines.dylib
Loading "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/libobjc-trampolines.dylib"...ok
Image 4 loaded.




(lldb) register read
General Purpose Registers:
       rax = 0x00000001038ed428  (void *)0x00000001038ee0e0: _TtC9Registers14ViewController
       rbx = 0x0000600002ad0990
       rcx = 0x0000600002ad0990
       rdx = 0x0000000000000000
       rdi = 0x0000600002ad0990
       rsi = 0x00007fff7bb400c2  
       rbp = 0x00007ffeec31e350
       rsp = 0x00007ffeec31e318
        r8 = 0x0000000000000010
        r9 = 0x0000000000000000
       r10 = 0x00007fff80095512  (void *)0x2f1800007fff8009
       r11 = 0x00000001039226fc  libMainThreadChecker.dylib`__trampolines + 12340
       r12 = 0x00007f946ae33b80
       r13 = 0x0000600002ad0990
       r14 = 0x0000000000000068
       r15 = 0x00007f946ae33b80
       rip = 0x00007fff22d05797  AppKit`-[NSViewController viewDidLoad]
    rflags = 0x0000000000000212
        cs = 0x000000000000002b
        fs = 0x0000000000000000
        gs = 0x0000000000000000






(lldb) breakpoint set -n "-[UIViewController viewDidLoad]" -C "po $arg1" -G1


(lldb) rb . -s Kingfisher -C "frame info" -G1