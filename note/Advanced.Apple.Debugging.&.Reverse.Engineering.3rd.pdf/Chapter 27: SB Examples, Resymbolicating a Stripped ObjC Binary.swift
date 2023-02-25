Using your assembly knowledge of the Objective-C runtime, you know the RSI register (x64) or the X1 register (ARM64) will contain the Objective-C Selector that holds the name of method. In addition, you also have the RDI (x64) or X0 (ARM64) register which holds the reference to the instance (or class).
使用您对 Objective-C 运行时的汇编知识，您知道 RSI 寄存器 (x64) 或 X1 寄存器 (ARM64) 将包含保存方法名称的 Objective-C 选择器。 此外，您还有 RDI (x64) 或 X0 (ARM64) 寄存器，用于保存对实例（或类）的引用。

So how are you doing this, exactly?
Let’s first discuss how one can go about resymbolicating Objective-C code in a stripped binary with the Objective-C runtime.
The Objective-C runtime can list all classes from a particular image (an image being the main executable, a dynamic library, an NSBundle, etc.) provided you have the full path to the image. This can be accomplished through the objc_copyClassNamesForImage API.
From there, you can get a list of all classes returned by objc_copyClassNamesForImage where you can dump all class and instance methods for a particular class using the class_copyMethodList API.
那么你是如何做到这一点的？
让我们首先讨论如何使用 Objective-C 运行时在剥离的二进制文件中重新符号化 Objective-C 代码。
Objective-C 运行时可以列出特定映像（一个映像是主要可执行文件、动态库、NSBundle 等）中的所有类，前提是您拥有该映像的完整路径。 这可以通过 objc_copyClassNamesForImage API 来完成。
从那里，您可以获得 objc_copyClassNamesForImage 返回的所有类的列表，您可以在其中使用 class_copyMethodList API 转储特定类的所有类和实例方法。



Therefore, you can grab all the method addresses and compare them to the addresses of the stack trace. If the stack trace’s function can’t generate a default function name (such as if the SBSymbol is synthetically generated by LLDB), then you can assume LLDB has no debug info for this address.
Using the lldb Python module, you can get the starting address for a particular function — even when a function’s execution is partially complete. This is accomplished using SBValue’s reference to an SBAddress. From there, you can compare the addresses of all the Objective-C methods you’ve obtained to the starting address of the synthetic SBSymbol. If two addresses match, then you can swap out the stripped (synthetic) method name and replace it with the function name that was obtained with the Objective-C runtime.
Don’t worry: You’ll explore this systematically using LLDB’s script command before you go building this Python script.
因此，您可以获取所有方法地址并将它们与堆栈跟踪的地址进行比较。 如果堆栈跟踪的函数无法生成默认函数名称（例如 SBSymbol 是由 LLDB 合成生成的），那么您可以假设 LLDB 没有该地址的调试信息。
使用 lldb Python 模块，您可以获得特定函数的起始地址——即使函数的执行部分完成。 这是使用 SBValue 对 SBAddress 的引用来完成的。 从那里，您可以将您获得的所有 Objective-C 方法的地址与合成 SBSymbol 的起始地址进行比较。 如果两个地址匹配，那么您可以换出剥离的（合成）方法名称并将其替换为通过 Objective-C 运行时获得的函数名称。
别担心：在构建此 Python 脚本之前，您将使用 LLDB 的脚本命令系统地探索这一点。


021-08-18 21:20:59.007752+0800 50 Shades of Ray[17899:1499877] {
    4401701824 = "-[ViewController generateRayViewTapped:]";
    4401702400 = "-[ViewController preferredStatusBarStyle]";
    4401702432 = "-[ViewController dumpObjCMethodsTapped:]";
    4401704080 = "-[ViewController toolBar]";
    4401704144 = "-[ViewController setToolBar:]";
    4401704208 = "-[ViewController .cxx_destruct]";
    4401704256 = "-[AppDelegate window]";
    4401704288 = "-[AppDelegate setWindow:]";
    4401704352 = "-[AppDelegate .cxx_destruct]";
    4401704576 = "-[RayView initWithFrame:]";
}
(lldb) image lookup -a 4401702432
      Address: 50 Shades of Ray[0x0000000100001620] (50 Shades of Ray.__TEXT.__text + 608)
      Summary: 50 Shades of Ray`-[ViewController dumpObjCMethodsTapped:] at ViewController.m:56


Head on in to ViewController.m and hunt for the dumpObjCMethodsTapped:
The exact details don’t need to be covered too closely, but it’s worth pointing out the following:
• All the Objective-C classes implemented in the main executable are enumerated through objc_copyClassNamesForImage.
• For each class, there’s logic to grab all the class and instance methods.
• In order to grab the class methods for a particular Objective-C Class, you must get the meta class. No, that term was not made up by some hipster developer in tight jeans, plaid shirt & beard. The meta class is the class responsible for the static methods of a particular class. For example, all methods that begin with + are implemented by the meta Class and not the Class.
• All the methods are aggregated into a NSMutableDictionary, where the key for each of these methods is the location in memory where the function resides.
前往 ViewController.m 并寻找 dumpObjCMethodsTapped：
不需要详细介绍确切的细节，但值得指出以下几点：
• 在主可执行文件中实现的所有Objective-C 类都通过objc_copyClassNamesForImage 枚举。
• 对于每个类，都有获取所有类和实例方法的逻辑。
• 为了获取特定Objective-C 类的类方法，您必须获取元类。 不，这个词不是由一些穿着紧身牛仔裤、格子衬衫和胡须的时髦开发者编造的。 元类是负责特定类的静态方法的类。 例如，所有以 + 开头的方法都是由元类而不是类实现的。
• 所有方法都聚合到一个 NSMutableDictionary 中，其中每个方法的键是函数所在的内存位置。


(lldb) b NSLog
Breakpoint 1: where = Foundation`NSLog, address = 0x00007fff208096c5
(lldb) script print(lldb.frame)
frame #0: 0x00007fff208096c5 Foundation`NSLog
(lldb) script print(lldb.frame.symbol)
id = {0x000054d1}, range = [0x00000000000ea6c5-0x00000000000ea767), name="NSLog"


The SBSymbol is responsible for the implementation offset address of NSLog. That is, the SBSymbol will tell you where this function is implemented in a module; it doesn’t hold the actual address of where the NSLog was loaded into memory.
However, you can use the SBAddress property along with the GetLoadAddress API of SBAddress to find where the start location of NSLog is in your current process.
SBSymbol 负责 NSLog 的实现偏移地址。 也就是说，SBSymbol 会告诉你这个函数在模块中的什么地方实现； 它不保存 NSLog 加载到内存中的实际地址。
但是，您可以使用 SBAddress 属性以及 SBAddress 的 GetLoadAddress API 来查找 NSLog 的起始位置在当前进程中的位置。

(lldb) script print(lldb.frame.symbol.addr.GetLoadAddress(lldb.target))
140733738686149

Convert it to hex using LLDB and compare the output to the start address of NSLog:
使用 LLDB 将其转换为十六进制并将输出与 NSLog 的起始地址进行比较：

(lldb) p/x 140733738686149
(long) $0 = 0x00007fff208096c5

Jump to the calling frame, - [ViewController dumpObjCMethodsTapped:].
跳转到调用帧，-[ViewController dumpObjCMethodsTapped:]。
(lldb) f 1
frame #1: 0x00000001065cac5e 50 Shades of Ray`-[ViewController dumpObjCMethodsTapped:](self=0x00007f7f45405f80, _cmd="dumpObjCMethodsTapped:", sender=0x00007f7f454078d0) at ViewController.m:89:3
   86  	    free(classMethods);
   87  	  }
   88  	  free(allClasses);
-> 89  	  NSLog(@"%@", retdict);
    	  ^
   90  	}
   91  	
   92  	@end

Grab the SBValue interpretation of the retdict reference.
获取 retdict 引用的 SBValue 解释。

(lldb) script print(lldb.frame.FindVariable('retdict'))
(__NSDictionaryM *) retdict = 0x0000600001f604c0 10 key/value pairs

Since this an NSDictionary, you actually want to dereference this value so you can enumerate it.
由于这是一个 NSDictionary，您实际上想要取消引用这个值，以便您可以枚举它。

(lldb) script print(lldb.frame.FindVariable('retdict').deref)
(__NSDictionaryM) *retdict = {
  [0] = {
    key = 0x0000600001f605e0 @"4401704256"
    value = 0x0000600001179f20 @"-[AppDelegate window]"
  }
  [1] = {
    key = 0x0000600001f60560 @"4401704080"
    value = 0x0000600001179e90 @"-[ViewController toolBar]"
  }
  [2] = {
    key = 0x0000600001f60360 @"4401701824"
    value = 0x0000600001179e00 @"-[ViewController generateRayViewTapped:]"
  }
  [3] = {
    key = 0x0000600001f60320 @"4401704144"
    value = 0x0000600001179dd0 @"-[ViewController setToolBar:]"
  }
  [4] = {
    key = 0x0000600001f60580 @"4401704352"
    value = 0x0000600001179c50 @"-[AppDelegate .cxx_destruct]"
  }
  [5] = {
    key = 0x0000600001f60400 @"4401704208"
    value = 0x0000600001179da0 @"-[ViewController .cxx_destruct]"
  }
  [6] = {
    key = 0x0000600001f60640 @"4401704288"
    value = 0x0000600001179c80 @"-[AppDelegate setWindow:]"
  }
  [7] = {
    key = 0x0000600001f605a0 @"4401702400"
    value = 0x0000600001179d40 @"-[ViewController preferredStatusBarStyle]"
  }
  [8] = {
    key = 0x0000600001f60540 @"4401702432"
    value = 0x0000600001179ce0 @"-[ViewController dumpObjCMethodsTapped:]"
  }
  [9] = {
    key = 0x0000600001f605c0 @"4401704576"
    value = 0x0000600001179b60 @"-[RayView initWithFrame:]"
  }
}

Make a lldb.value out of this SBValue and assign it to a variable a.
从这个 SBValue 中创建一个 lldb.value 并将它分配给一个变量 a。

(lldb) script a = lldb.value(lldb.frame.FindVariable('retdict').deref)
(lldb) script print(a[0])
(__lldb_autogen_nspair) [0] = {
  key = 0x0000600001f605e0
  value = 0x0000600001179f20
}
(lldb) script print(a[0].key)
(__NSCFString *) key = 0x0000600001f605e0 @"4401704256"
(lldb) script print(a[0].value)
(__NSCFString *) value = 0x0000600001179f20 @"-[AppDelegate window]"
(lldb) 

If you only want the return value without the referencing address, you’ll need to cast this lldb.value back into a SBValue then grab the description.
如果您只想要没有引用地址的返回值，则需要将此 lldb.value 转换回 SBValue，然后获取描述。

(lldb) script print(a[0].value.sbvalue.description)
-[AppDelegate window]

This will get you the desired -[AppDelegate window] for output. Note you may have a different method.
If you wanted to dump all keys in this lldb.value a instance, you can use Python List comprehensions to dump all the keys out.
这将为您提供所需的 -[AppDelegate window] 输出。 请注意，您可能有不同的方法。
如果你想转储这个 lldb.value 实例中的所有键，你可以使用 Python List comprehensions 转储所有的键。

(lldb) script print('\n'.join([x.key.sbvalue.description for x in a]))
4401704256
4401704080
4401701824
4401704144
4401704352
4401704208
4401704288
4401702400
4401702432
4401704576
(lldb) script print('\n'.join([x.value.sbvalue.description for x in a]))
-[AppDelegate window]
-[ViewController toolBar]
-[ViewController generateRayViewTapped:]
-[ViewController setToolBar:]
-[AppDelegate .cxx_destruct]
-[ViewController .cxx_destruct]
-[AppDelegate setWindow:]
-[ViewController preferredStatusBarStyle]
-[ViewController dumpObjCMethodsTapped:]
-[RayView initWithFrame:]



Symbol: -[UIView initWithFrame:]
Condition: (BOOL)[$arg1 isKindOfClass:(id)objc_getClass("RayView")]


Use script to see if it’s synthetic or not:
使用脚本查看它是否是合成的：
(lldb) script lldb.frame.symbol.synthetic
False


(lldb) f 0
frame #0: 0x00007fff24be4f36 UIKitCore`-[UIView initWithFrame:]
UIKitCore`-[UIView initWithFrame:]:
->  0x7fff24be4f36 <+0>: pushq  %rbp
    0x7fff24be4f37 <+1>: movq   %rsp, %rbp
    0x7fff24be4f3a <+4>: pushq  %r14
    0x7fff24be4f3c <+6>: pushq  %rbx
(lldb) script lldb.frame.symbol.synthetic
False
(lldb) f 1
frame #1: 0x0000000106c67200 ShadesOfRay`___lldb_unnamed_symbol14$$ShadesOfRay + 896
ShadesOfRay`___lldb_unnamed_symbol14$$ShadesOfRay:
->  0x106c67200 <+896>: movq   %rax, %rsi
    0x106c67203 <+899>: movq   %rsi, -0x30(%rbp)
    0x106c67207 <+903>: leaq   -0x30(%rbp), %rsi
    0x106c6720b <+907>: movq   %rsi, %rdi
(lldb) script lldb.frame.symbol.synthetic
True

(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00007fff24be4f36 UIKitCore`-[UIView initWithFrame:]
  * frame #1: 0x0000000106c67200 ShadesOfRay`___lldb_unnamed_symbol14$$ShadesOfRay + 896
    frame #2: 0x00007fff24be48ff UIKitCore`-[UIView init] + 44
    frame #3: 0x0000000106c66403 ShadesOfRay`___lldb_unnamed_symbol1$$ShadesOfRay + 67
    frame #4: 0x00007fff246c7937 UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 83
    frame #5: 0x00007fff23beccc5 UIKitCore`-[UIBarButtonItem _triggerActionForEvent:] + 158
    frame #6: 0x00007fff23bc45d3 UIKitCore`__45-[_UIButtonBarTargetAction _invoke:forEvent:]_block_invoke + 39
    frame #7: 0x00007fff23bc4484 UIKitCore`-[_UIButtonBarTargetAction _invoke:forEvent:] + 152
    frame #8: 0x00007fff246c7937 UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 83
    frame #9: 0x00007fff23fe845d UIKitCore`-[UIControl sendAction:to:forEvent:] + 223
    frame #10: 0x00007fff23fe8780 UIKitCore`-[UIControl _sendActionsForEvents:withEvent:] + 332
    frame #11: 0x00007fff23fe707f UIKitCore`-[UIControl touchesEnded:withEvent:] + 500
    frame #12: 0x00007fff24703d01 UIKitCore`-[UIWindow _sendTouchesForEvent:] + 1287
    frame #13: 0x00007fff24705b8c UIKitCore`-[UIWindow sendEvent:] + 4792
    frame #14: 0x00007fff246dfc89 UIKitCore`-[UIApplication sendEvent:] + 596
    frame #15: 0x00007fff247727ba UIKitCore`__processEventQueue + 17124
    frame #16: 0x00007fff24768560 UIKitCore`__eventFetcherSourceCallback + 104
    frame #17: 0x00007fff20390ede CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
    frame #18: 0x00007fff20390dd6 CoreFoundation`__CFRunLoopDoSource0 + 180
    frame #19: 0x00007fff2039029e CoreFoundation`__CFRunLoopDoSources0 + 242
    frame #20: 0x00007fff2038a9f7 CoreFoundation`__CFRunLoopRun + 875
    frame #21: 0x00007fff2038a1a7 CoreFoundation`CFRunLoopRunSpecific + 567
    frame #22: 0x00007fff2b874d85 GraphicsServices`GSEventRunModal + 139
    frame #23: 0x00007fff246c14df UIKitCore`-[UIApplication _run] + 912
    frame #24: 0x00007fff246c639c UIKitCore`UIApplicationMain + 101
    frame #25: 0x0000000106c66e50 ShadesOfRay`___lldb_unnamed_symbol13$$ShadesOfRay + 112
    frame #26: 0x00007fff2025abbd libdyld.dylib`start + 1
(lldb) sbt bt
frame #0 : 0x7fff24be4f36 UIKitCore`-[UIView initWithFrame:] 
frame #1 : 0x106c67200 ShadesOfRay`-[RayView initWithFrame:] + 896
frame #2 : 0x7fff24be48ff UIKitCore`-[UIView init] + 44
frame #3 : 0x106c66403 ShadesOfRay`-[ViewController generateRayViewTapped:] + 67
frame #4 : 0x7fff246c7937 UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 83
frame #5 : 0x7fff23beccc5 UIKitCore`-[UIBarButtonItem _triggerActionForEvent:] + 158
frame #6 : 0x7fff23bc45d3 UIKitCore`__45-[_UIButtonBarTargetAction _invoke:forEvent:]_block_invoke + 39
frame #7 : 0x7fff23bc4484 UIKitCore`-[_UIButtonBarTargetAction _invoke:forEvent:] + 152
frame #8 : 0x7fff246c7937 UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 83
frame #9 : 0x7fff23fe845d UIKitCore`-[UIControl sendAction:to:forEvent:] + 223
frame #10: 0x7fff23fe8780 UIKitCore`-[UIControl _sendActionsForEvents:withEvent:] + 332
frame #11: 0x7fff23fe707f UIKitCore`-[UIControl touchesEnded:withEvent:] + 500
frame #12: 0x7fff24703d01 UIKitCore`-[UIWindow _sendTouchesForEvent:] + 1287
frame #13: 0x7fff24705b8c UIKitCore`-[UIWindow sendEvent:] + 4792
frame #14: 0x7fff246dfc89 UIKitCore`-[UIApplication sendEvent:] + 596
frame #15: 0x7fff247727ba UIKitCore`__processEventQueue + 17124
frame #16: 0x7fff24768560 UIKitCore`__eventFetcherSourceCallback + 104
frame #17: 0x7fff20390ede CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
frame #18: 0x7fff20390dd6 CoreFoundation`__CFRunLoopDoSource0 + 180
frame #19: 0x7fff2039029e CoreFoundation`__CFRunLoopDoSources0 + 242
frame #20: 0x7fff2038a9f7 CoreFoundation`__CFRunLoopRun + 875
frame #21: 0x7fff2038a1a7 CoreFoundation`CFRunLoopRunSpecific + 567
frame #22: 0x7fff2b874d85 GraphicsServices`GSEventRunModal + 139
frame #23: 0x7fff246c14df UIKitCore`-[UIApplication _run] + 912
frame #24: 0x7fff246c639c UIKitCore`UIApplicationMain + 101
frame #25: 0x106c66e50 ShadesOfRay`___lldb_unnamed_symbol13$$ShadesOfRay ... unresolved womp womp + 112
frame #26: 0x7fff2025abbd libdyld.dylib`start + 1

(lldb) 
