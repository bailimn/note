// 查找包含 UIAlertController 的所有已编译或加载到可执行文件中的代码。
(lldb) image lookup -rn UIAlertController
1086 matches found in /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore:
        Address: UIKitCore[0x000000000001b891] (UIKitCore.__TEXT.__text + 100593)
        Summary: UIKitCore`-[_UIAlertControllerShimPresenter _presentAlertControllerAnimated:hostingScene:completion:]        Address: UIKitCore[0x000000000001b9d5] (UIKitCore.__TEXT.__text + 100917)
        Summary: UIKitCore`__91-[_UIAlertControllerShimPresenter _presentAlertControllerAnimated:hostingScene:completion:]_block_invoke        Address: UIKitCore[0x000000000001b9e8] (UIKitCore.__TEXT.__text + 100936)
        ...
        Summary: UIKitCore`-[_UIAlertControllerView setDiscreteCancelActionViewHeightConstraint:]        Address: UIKitCore[0x0000000000090f3c] (UIKitCore.__TEXT.__text + 581532)
        Summary: UIKitCore`-[_UIAlertControllerView .cxx_destruct]
2 matches found in /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/Developer/Library/PrivateFrameworks/DTDDISupport.framework/libViewDebuggerSupport.dylib:
        Address: libViewDebuggerSupport.dylib[0x000000000000d4f2] (libViewDebuggerSupport.dylib.__TEXT.__text + 46577)
        Summary: libViewDebuggerSupport.dylib`+[UIAlertController(DebugHierarchyAdditionsFallback) fallback_debugHierarchyPropertyDescriptions]        Address: libViewDebuggerSupport.dylib[0x000000000000d7e4] (libViewDebuggerSupport.dylib.__TEXT.__text + 47331)
        Summary: libViewDebuggerSupport.dylib`+[UIAlertController(DebugHierarchyAdditionsFallback) fallback_debugHierarchyValueForPropertyWithName:onObject:outOptions:outError:]
// 不区分大小写搜索包含“hosturl”的任何代码。
(lldb) image lookup -rn (?i)hosturl
// 查找 UIViewController 实现或覆盖的所有 setter 属性方法
(lldb) image lookup -rn 'UIViewController\ set\w+:\]'
// 查找位于安全模块中的所有代码。
(lldb) image lookup -rn . Security
// 根据地址 0x10518a720 查找代码
(lldb) image lookup -a 0x10518a720
// 查找名为 mmap 的符号的代码。
(lldb) image lookup -s mmap
// 限制搜索模块 Kingfisher
(lldb) image lookup -rn setImage Kingfisher


