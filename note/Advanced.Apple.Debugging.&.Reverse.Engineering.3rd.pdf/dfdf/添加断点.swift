添加断点
通过Hopper查看方法的地址为: 0x0000000102a9602c

-[WCAccountLoginControlLogic onFirstViewLogin]:
0000000102a9602c         stp        x22, x21, [sp, #-0x30]!
0000000102a96030         stp        x20, x19, [sp, #0x10]
0000000102a96034         stp        x29, x30, [sp, #0x20]
打断点

# 1. 查看ASLR为：0x0000000000558000 = 0x0000000100558000 - 0x0000000100000000
(lldb) image list | grep WeChat
[  0] 7195B97E-9078-3119-9110-8BDA959283F0 0x0000000100558000 /Users/wendy/Library/Developer/Xcode/DerivedData/Test-haevfjompsameldsewkriqunrgfe/Build/Products/Debug-iphoneos/WeChat.app/WeChat

# 2. 所以方法的内存地址为: 0x0000000102fee02c = 0x0000000000558000 + 0x0000000102a9602c
(lldb) p/x 0x0000000000558000 + 0x0000000102a9602c
(long) $27 = 0x0000000102fee02c

# 3. 添加地址断点
(lldb) breakpoint set -a 0x0000000102fee02c
Breakpoint 5: where = WeChat`___lldb_unnamed_symbol137105$$WeChat, address = 0x0000000102fee02c

# 4. 添加符号断点（失败）
(lldb) breakpoint set -n "-[WCAccountLoginControlLogic onFirstViewLogin]"
Breakpoint 8: no locations (pending).
WARNING:  Unable to resolve breakpoint to any actual locations.

断点只能通过地址添加，并不能解析符号，另外Xcode也不能解析堆栈信息，我们可以用restore-symbol恢复符号表