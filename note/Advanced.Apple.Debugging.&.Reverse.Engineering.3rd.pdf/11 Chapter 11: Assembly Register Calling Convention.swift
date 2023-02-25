汇编寄存器调用约定


Intel assembly
AT&T assembly (默认)


在 x64 中（从现在开始，x64 是 x86_64 的缩写），机器使用 16 个通用寄存器来操作数据。 
这些寄存器是 RAX、RBX、RCX、RDX、RDI、RSI、RSP、RBP 和 R8 到 R15。


• First Argument: RDI
• Second Argument: RSI
• Third Argument: RDX
• Fourth Argument: RCX
• Fifth Argument: R8
• Sixth Argument: R9
如果参数超过六个，则使用程序的堆栈将附加参数传递给函数


RAX: 保存返回值


[UIApplication sharedApplication];
OC方法调用，相当于下面的伪代码
id UIApplicationClass = [UIApplication class];
objc_msgSend(UIApplicationClass, "sharedApplication");


NSString *helloWorldString = [@"Can't Sleep; " stringByAppendingString:@"Clowns will eat me"];
OC方法调用，相当于下面的伪代码（有几个冒号就有几个参数）
NSString *helloWorldString;
helloWorldString = objc_msgSend(@"Can't Sleep; ", "stringByAppendingString:", @"Clowns will eat me");





AppKit`-[NSViewController viewDidLoad]:
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

(lldb) po (char *)0x00007fff7bb400c2
"viewDidLoad"

(lldb) po 0x0000600002ad0990
<Registers.ViewController: 0x600002ad0990>

(lldb) po 0x00007fff7bb400c2
140735268782274

(lldb) po rdi
error: <user expression 3>:1:1: use of undeclared identifier 'rdi'
rdi
^
(lldb) po $rdi
<Registers.ViewController: 0x600002ad0990>

(lldb) po $rsi
140735268782274

(lldb) po (SEL)$rsi
"viewDidLoad"

(lldb) 





// 转储所有实现 mouseDown: 的 Objective-C 类的示例是 
image lookup -rn '\ mouseDown:'


当 Swift 调用一个函数时，它不需要使用 objc_msgSend，除非你标记一个方法使用 @objc。
Swift 4.2 版本通常会选择删除自寄存器 (RDI) 作为第一个参数，而是将其放在堆栈中。这意味着 RDI 寄存器（最初将实例保存给 self）和 RSI 寄存器（在 Objective-C 中最初保存选择器）被释放来处理函数的参数。



// -f d 以十进制格式显示
(lldb) register read -f d






// 列出所有模拟器设备
╰─ xcrun simctl list                                                  
== Device Types ==
iPhone 4s (com.apple.CoreSimulator.SimDeviceType.iPhone-4s)
iPhone 5 (com.apple.CoreSimulator.SimDeviceType.iPhone-5)
iPhone 5s (com.apple.CoreSimulator.SimDeviceType.iPhone-5s)
iPhone 6 Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus)
iPhone 6 (com.apple.CoreSimulator.SimDeviceType.iPhone-6)
iPhone 6s (com.apple.CoreSimulator.SimDeviceType.iPhone-6s)
iPhone 6s Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus)
iPhone SE (1st generation) (com.apple.CoreSimulator.SimDeviceType.iPhone-SE)
iPhone 7 (com.apple.CoreSimulator.SimDeviceType.iPhone-7)
iPhone 7 Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-7-Plus)
iPhone 8 (com.apple.CoreSimulator.SimDeviceType.iPhone-8)
iPhone 8 Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus)
iPhone X (com.apple.CoreSimulator.SimDeviceType.iPhone-X)
iPhone Xs (com.apple.CoreSimulator.SimDeviceType.iPhone-XS)
iPhone Xs Max (com.apple.CoreSimulator.SimDeviceType.iPhone-XS-Max)
iPhone Xʀ (com.apple.CoreSimulator.SimDeviceType.iPhone-XR)
iPhone 11 (com.apple.CoreSimulator.SimDeviceType.iPhone-11)
iPhone 11 Pro (com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro)
iPhone 11 Pro Max (com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max)
iPhone SE (2nd generation) (com.apple.CoreSimulator.SimDeviceType.iPhone-SE--2nd-generation-)
iPhone 12 mini (com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini)
iPhone 12 (com.apple.CoreSimulator.SimDeviceType.iPhone-12)
iPhone 12 Pro (com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro)
iPhone 12 Pro Max (com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max)
iPod touch (7th generation) (com.apple.CoreSimulator.SimDeviceType.iPod-touch--7th-generation-)
iPad 2 (com.apple.CoreSimulator.SimDeviceType.iPad-2)
iPad Retina (com.apple.CoreSimulator.SimDeviceType.iPad-Retina)
iPad Air (com.apple.CoreSimulator.SimDeviceType.iPad-Air)
iPad mini 2 (com.apple.CoreSimulator.SimDeviceType.iPad-mini-2)
iPad mini 3 (com.apple.CoreSimulator.SimDeviceType.iPad-mini-3)
iPad mini 4 (com.apple.CoreSimulator.SimDeviceType.iPad-mini-4)
iPad Air 2 (com.apple.CoreSimulator.SimDeviceType.iPad-Air-2)
iPad Pro (9.7-inch) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-)
iPad Pro (12.9-inch) (1st generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro)
iPad (5th generation) (com.apple.CoreSimulator.SimDeviceType.iPad--5th-generation-)
iPad Pro (12.9-inch) (2nd generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation-)
iPad Pro (10.5-inch) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--10-5-inch-)
iPad (6th generation) (com.apple.CoreSimulator.SimDeviceType.iPad--6th-generation-)
iPad (7th generation) (com.apple.CoreSimulator.SimDeviceType.iPad--7th-generation-)
iPad Pro (11-inch) (1st generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch-)
iPad Pro (12.9-inch) (3rd generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---3rd-generation-)
iPad Pro (11-inch) (2nd generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch---2nd-generation-)
iPad Pro (12.9-inch) (4th generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---4th-generation-)
iPad mini (5th generation) (com.apple.CoreSimulator.SimDeviceType.iPad-mini--5th-generation-)
iPad Air (3rd generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Air--3rd-generation-)
iPad (8th generation) (com.apple.CoreSimulator.SimDeviceType.iPad--8th-generation-)
iPad Air (4th generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Air--4th-generation-)
iPad Pro (11-inch) (3rd generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-3rd-generation)
iPad Pro (12.9-inch) (5th generation) (com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-5th-generation)
Apple TV (com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p)
Apple TV 4K (com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-4K)
Apple TV 4K (at 1080p) (com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-1080p)
Apple TV 4K (2nd generation) (com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-4K)
Apple TV 4K (at 1080p) (2nd generation) (com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-1080p)
Apple Watch - 38mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-38mm)
Apple Watch - 42mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-42mm)
Apple Watch Series 2 - 38mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-2-38mm)
Apple Watch Series 2 - 42mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-2-42mm)
Apple Watch Series 3 - 38mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-3-38mm)
Apple Watch Series 3 - 42mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-3-42mm)
Apple Watch Series 4 - 40mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-4-40mm)
Apple Watch Series 4 - 44mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-4-44mm)
Apple Watch Series 5 - 40mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-5-40mm)
Apple Watch Series 5 - 44mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-5-44mm)
Apple Watch SE - 40mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-SE-40mm)
Apple Watch SE - 44mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-SE-44mm)
Apple Watch Series 6 - 40mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-40mm)
Apple Watch Series 6 - 44mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-44mm)
== Runtimes ==
iOS 14.5 (14.5 - 18E182) - com.apple.CoreSimulator.SimRuntime.iOS-14-5
tvOS 14.5 (14.5 - 18L191) - com.apple.CoreSimulator.SimRuntime.tvOS-14-5
watchOS 7.4 (7.4 - 18T187) - com.apple.CoreSimulator.SimRuntime.watchOS-7-4
== Devices ==
-- iOS 14.5 --
    iPhone 6s (788808D1-56E6-498E-B098-07315E5097E1) (Shutdown) 
    iPhone 8 (2A0FAF70-77C6-43D6-A96D-CB7C48FEDC19) (Shutdown) 
    iPhone 8 Plus (F1A7EA07-7192-45A2-8A21-788059699B61) (Shutdown) 
    iPhone 11 (0EC4CE7C-CA13-43E1-BAD3-1047BCE10F21) (Shutdown) 
    iPhone 11 Pro (FDD6315C-502A-45E9-B6CF-31758C47A73D) (Shutdown) 
    iPhone 11 Pro Max (109C52D9-F31E-4A29-AC6A-B965BC4611D2) (Shutdown) 
    iPhone SE (2nd generation) (5F720D21-04C4-418E-BB28-448AC101F228) (Shutdown) 
    iPhone 12 mini (4A008AF6-4ED0-4C62-8E02-8E727B80A805) (Shutdown) 
    iPhone 12 (F2A1DC9B-B199-4278-8B66-7E1E32DE3765) (Shutdown) 
    iPhone 12 Pro (0F9FC3A9-B3C8-4520-A6B7-2CE90C851A18) (Shutdown) 
    iPhone 12 Pro Max (F76E9DFB-DB64-4C0A-9102-58AF6631B7D7) (Shutdown) 
    iPod touch (7th generation) (20243968-A58E-4AB8-97CA-430A5A14C2F7) (Shutdown) 
    iPad Pro (9.7-inch) (5B420F9C-3191-4119-B461-45D4B4E2880C) (Shutdown) 
    iPad Pro (11-inch) (2nd generation) (D233349C-A39B-4104-B058-8AE84EC7094B) (Shutdown) 
    iPad Pro (12.9-inch) (4th generation) (594692A4-4145-45A0-B018-367C004EB7E0) (Shutdown) 
    iPad (8th generation) (E440BA19-4B7C-4A4B-8DEB-4C37D52CB097) (Shutdown) 
    iPad Air (4th generation) (8D1181EB-C40D-4617-A472-4E68D7478149) (Shutdown) 
    iPad Pro (11-inch) (3rd generation) (56FE38D4-6463-453C-91E1-59F4034827F9) (Shutdown) 
    iPad Pro (12.9-inch) (5th generation) (60886628-5D9E-48C4-9C08-D01A688B4381) (Shutdown) 
-- tvOS 14.5 --
    Apple TV (BDBC9399-345E-4FD3-A8F6-9B11C04D99AB) (Shutdown) 
    Apple TV 4K (87FCE9EA-62D6-4BC3-AF07-574884CB39B8) (Shutdown) 
    Apple TV 4K (at 1080p) (165EAF7D-E78A-4117-B9E4-C8BA3D399B57) (Shutdown) 
    Apple TV 4K (2nd generation) (7FF3E540-B441-49E8-8BC9-709AB0A0F5E3) (Shutdown) 
    Apple TV 4K (at 1080p) (2nd generation) (0D417EC6-AEB2-4DC4-9A74-C27AC37D9E5A) (Shutdown) 
-- watchOS 7.4 --
    Apple Watch Series 5 - 40mm (7BD765BD-9EEA-482D-A567-66B8EF48B730) (Shutdown) 
    Apple Watch Series 5 - 44mm (925A0A22-EF0E-4AE6-A85B-82E23E3B2E55) (Shutdown) 
    Apple Watch Series 6 - 40mm (F2612F77-C431-4946-9A67-F90AB1001DD5) (Shutdown) 
    Apple Watch Series 6 - 44mm (B96F2D16-C900-47D8-8048-57FA77EAEAAA) (Shutdown) 
== Device Pairs ==
D1618EF0-2382-4F7B-82EE-651FBFEA6254 (active, disconnected)
    Watch: Apple Watch Series 5 - 40mm (7BD765BD-9EEA-482D-A567-66B8EF48B730) (Shutdown)
    Phone: iPhone 12 mini (4A008AF6-4ED0-4C62-8E02-8E727B80A805) (Shutdown)
A57460A7-783A-43A7-9E1B-1DC842D01FA6 (active, disconnected)
    Watch: Apple Watch Series 5 - 44mm (925A0A22-EF0E-4AE6-A85B-82E23E3B2E55) (Shutdown)
    Phone: iPhone 12 (F2A1DC9B-B199-4278-8B66-7E1E32DE3765) (Shutdown)
7EF557B6-AE9A-452F-94F4-441E31245A7E (active, disconnected)
    Watch: Apple Watch Series 6 - 40mm (F2612F77-C431-4946-9A67-F90AB1001DD5) (Shutdown)
    Phone: iPhone 12 Pro (0F9FC3A9-B3C8-4520-A6B7-2CE90C851A18) (Shutdown)
F163A66E-91CB-4A36-B39B-86CB7AE87BCE (active, disconnected)
    Watch: Apple Watch Series 6 - 44mm (B96F2D16-C900-47D8-8048-57FA77EAEAAA) (Shutdown)
    Phone: iPhone 12 Pro Max (F76E9DFB-DB64-4C0A-9102-58AF6631B7D7) (Shutdown)


// 通过模拟器UUID打开模拟器
╰─ open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app --args -CurrentDeviceUDID F76E9DFB-DB64-4C0A-9102-58AF6631B7D7



╰─ lldb -n SpringBoard
(lldb) process attach --name "SpringBoard"


(lldb) p/x @"Yay! Debugging"
(__NSCFString *) $0 = 0x0000600003201a40 @"Yay! Debugging"
(lldb) br set -n "-[UILabel setText:]" -C "po $rdx = 0x0000600003201a40" -G1
Breakpoint 1: where = UIKitCore`-[UILabel setText:], address = 0x00007fff24b51eb5
(lldb) c