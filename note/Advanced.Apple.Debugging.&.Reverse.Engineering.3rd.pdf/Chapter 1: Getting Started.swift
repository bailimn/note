╰─ lldb          
(lldb) file /Applications/Xcode.app/Contents/MacOS/Xcode // This will set the executable target to Xcode.
Current executable set to '/Applications/Xcode.app/Contents/MacOS/Xcode' (x86_64).
(lldb) process launch -e /dev/ttys001 -- // -e: 指定stderr输出位置，常见的日志功能，例如 Objective-C 的 NSLog 或 Swift 的打印功能，输出到 stderr
Process 3685 launched: '/Applications/Xcode.app/Contents/MacOS/Xcode' (x86_64)
在 lldb 窗口 Ctrl + C 暂停调试
(lldb) b -[NSView hitTest:]
Breakpoint 1: where = AppKit`-[NSView hitTest:], address = 0x00007fff22e538f8
(lldb) c
Process 3685 resuming
(lldb) po $rdi
<NSThemeFrame: 0x13dca2b40>

(lldb) breakpoint delete
About to delete all breakpoints, do you want to do that?: [Y/n] Y
All breakpoints removed. (1 breakpoint)
(lldb) breakpoint set -n "-[NSView hitTest:]" -C "po $rdi" -G1
Breakpoint 2: where = AppKit`-[NSView hitTest:], address = 0x00007fff22e538f8
(lldb) c
Process 4675 resuming

(lldb) p/x $rdi // swift 影藏了指针，用这种方法可以打印指针
(unsigned long) $3 = 0x0000000110a42600

(lldb) po [$rdi setHidden:!(BOOL)[$rdi isHidden]]; [CATransaction flush]


// 检查当前运行的Xcode的路径
╰─ ps -ef `pgrep -x Xcode`
  UID   PID  PPID   C STIME   TTY           TIME CMD
  501   831     1   0  2:43下午 ??         1:02.67 /Applications/Xcode.app/Contents/MacOS/Xcode