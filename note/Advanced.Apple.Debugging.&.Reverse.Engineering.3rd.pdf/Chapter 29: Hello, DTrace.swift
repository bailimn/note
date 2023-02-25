DTrace工具组件包括提供器和探测器：
1、提供器：由dtrace内核驱动命令及附加在上面的dtrace脚本组成（后缀名.d）。Mac OS X默认就安装了dtrace工具；脚本使用D语言编写，也叫d脚本，Mac OS X系统的 /usr/share/examples/DTTk/ 目录下有很多例子，xcode内存分析工具instruments的基础就是dtrace，具体路径/usr/sbin/dtrace；
sudo /usr/sbin/dtrace -s xxx.d //运行原始的d脚本
man -k dtrace //查看系统的原始d脚本；
复制代码2、探测器（即探针）：由提供器启动，可标识所检测的模块和函数，其名称标准格式为提供器:模块:函数:名称，每个探针还具有一个唯一的整数标识符。在苹果开源的xnu内核中可以看到苹果版的DTrace源码，打包为内核模块来收集跟踪数据，它提供接口通过 dtrace 内核驱动命令访问内核数据，在内核源码中很多带有provider关键字都属于标识某个模块数据的探针。其定义如下：
// 探针定义
typedef struct sdt_provider {
    const char          *sdtp_name; /* name of provider */
    const char          *sdtp_prefix;   /* prefix for probe names */
    dtrace_pattr_t      *sdtp_attr; /* stability attributes */
    dtrace_provider_id_t    sdtp_id;    /* provider ID */
} sdt_provider_t;

// xnu中在使用的一些探针
sdt_provider_t sdt_providers[] = {
    { "vtrace", "__vtrace____", &vtrace_attr, 0 },
    { "sysinfo", "__cpu_sysinfo____", &info_attr, 0 },
    { "vminfo", "__vminfo____", &info_attr, 0 },
    { "fpuinfo", "__fpuinfo____", &fpu_attr, 0 },
    { "sched", "__sched____", &stab_attr, 0 },
    { "proc", "__proc____", &stab_attr, 0 },
    { "io", "__io____", &stab_attr, 0 },
    { "ip", "__ip____", &stab_attr, 0 },
    { "tcp", "__tcp____", &stab_attr, 0 },
    { "mptcp", "__mptcp____", &stab_attr, 0 },
    { "mib", "__mib____", &stab_attr, 0 },
    { "fsinfo", "__fsinfo____", &fsinfo_attr, 0 },
    { "nfsv3", "__nfsv3____", &stab_attr, 0 },
    { "nfsv4", "__nfsv4____", &stab_attr, 0 },
    { "sysevent", "__sysevent____", &stab_attr, 0 },
    { "sdt", "__sdt____", &sdt_attr, 0 },
    { "boost", "__boost____", &stab_attr, 0},
    { NULL, NULL, NULL, 0 }
};


// 这将倾倒出每一个包含以 "ViewController "结尾的Objective-C类名称的点击（又称探针）
╰─ sudo dtrace -n 'objc$target:*ViewController::entry' -p `pgrep SpringBoard`
Password:
dtrace: description 'objc$target:*ViewController::entry' matched 50982 probes
CPU     ID                    FUNCTION:NAME
  4 467729               -_updateView:entry
  4 467708          -dateViewIfExists:entry
  4 471383              -isViewLoaded:entry
  4 467707                  -dateView:entry
  4 471380                      -view:entry
  4 471379        -loadViewIfRequired:entry
  4 471384             -_existingView:entry
  4 467732         -_startUpdateTimer:entry
  7 446633  -layoutElementControllers:entry



// ustack: dtrace 内部方法，打印堆栈
╰─ sudo dtrace -n 'objc$target:*ViewController:-viewWillAppear:entry { ustack(); }' -p `pgrep -x DingTalk`
dtrace: description 'objc$target:*ViewController:-viewWillAppear:entry ' matched 5 probes
CPU     ID                    FUNCTION:NAME
  2 510382            -viewWillAppear:entry
              AppKit`-[NSViewController viewWillAppear]
              AppKit`-[NSViewController _sendViewWillAppear]+0x28
              AppKit`-[NSView _recursiveViewWillAppearBecauseUnhidden]+0x59
              AppKit`-[NSView _setHidden:setNeedsDisplay:]+0x20a
              AppKit`-[NSView prepareForReuse]+0x37
              AppKit`-[NSCollectionViewItem prepareForReuse]+0x73
              UIFoundation`-[_NSCollectionViewCore _dequeueReusableViewOfKind:withIdentifier:forIndexPath:viewCategory:]+0x392
              UIFoundation`-[_NSCollectionViewCore dequeueReusableItemWithReuseIdentifier:forIndexPath:]+0x48
              AppKit`-[NSCollectionView makeItemWithIdentifier:forIndexPath:]+0x58
              DingTalk`0x0000000105b9c810+0x12a
              DingTalk`0x0000000105b9d010+0x80
              AppKit`-[_NSCollectionViewDataSourceAdapter collectionView:itemForRepresentedObjectAtIndexPath:]+0x1b6
              UIFoundation`-[_NSCollectionViewCore _createPreparedCellForItemAtIndexPath:withLayoutAttributes:applyAttributes:isFocused:notify:]+0x64
              UIFoundation`-[_NSCollectionViewCore _createPreparedCellForItemAtIndexPath:withLayoutAttributes:applyAttributes:]+0x1f
              UIFoundation`-[_NSCollectionViewCore _updateVisibleCellsNow:]+0x112d
              UIFoundation`-[_NSCollectionViewCore _layoutItems]+0x11d
              AppKit`-[NSCollectionView layout]+0x157
              AppKit`_NSViewLayout+0x25b
              AppKit`-[NSView _layoutSubtreeWithOldSize:]+0x183
              AppKit`-[NSView _layoutSubtreeWithOldSize:]+0x2ef

  4 510382            -viewWillAppear:entry



╰─ sudo dtrace -n 'objc$target:*ViewController:-viewWillAppear:entry { printf("\nUIViewController is: 0x%p\n", arg0); ustack(); }' -p `pgrep -x DingTalk`
dtrace: description 'objc$target:*ViewController:-viewWillAppear:entry ' matched 5 probes
CPU     ID                    FUNCTION:NAME
  0 510382            -viewWillAppear:entry
UIViewController is: 0x600002586580

              AppKit`-[NSViewController viewWillAppear]
              AppKit`-[NSViewController _sendViewWillAppear]+0x28


// ? 运算符将充当单个字符的通配符，而 * 将匹配任何内容
// $target 视为实际 PID 的占位符



dtrace -n 'objc$target:NSView:-init*:entry' -p `pgrep -x Xcode`



// -l，它将列出你在探针描述中匹配的所有探针。当你使用-l选项时，不管你是否提供探针，DTrace只列出探针，不执行任何操作。
// -x选项表示只 给我与名称DingTalk完全匹配的PID（s）
╰─ sudo dtrace -ln 'objc$target:*ViewController:-viewWillAppear:entry { printf("\nUIViewController is: 0x%p\n", arg0); ustack(); }' -p `pgrep -x DingTalk`
Password:
   ID   PROVIDER            MODULE                          FUNCTION NAME
510381    objc948 NSSplitViewController                   -viewWillAppear entry
510382    objc948  NSViewController                   -viewWillAppear entry
510383    objc948 NSTitlebarAccessoryViewController                   -viewWillAppear entry
511118    objc948 NSTouchBarSharingServicePickerViewController                   -viewWillAppear entry
513761    objc948 RPPipViewController                   -viewWillAppear entry




(lldb) tobjectivec -g

#!/usr/sbin/dtrace -s

#pragma D option quiet
dtrace:::BEGIN { printf("Starting... use Ctrl + c to stop\n"); }
dtrace:::END   { printf("Ending...\n"  ); }

/* Script content below */

objc$target:::entry 
{
    printf("0x%016p %c[%s %s]\n", arg0, probefunc[0], probemod, (string)&probefunc[1]);
}




╰─  sudo /tmp/lldb_dtrace_profile_objc.d  -p 36946  2>/dev/null

Password:
Starting... use Ctrl + c to stop






(lldb) tobjectivec -m *StatusBar* -g

#!/usr/sbin/dtrace -s

#pragma D option quiet
dtrace:::BEGIN { printf("Starting... use Ctrl + c to stop\n"); }
dtrace:::END   { printf("Ending...\n"  ); }

/* Script content below */

objc$target:*StatusBar*::entry 
{
    printf("0x%016p %c[%s %s]\n", arg0, probefunc[0], probemod, (string)&probefunc[1]);
}






(lldb) po UIApp
<UIApplication: 0x7f7f8fa04310>
(lldb) tobjectivec -g -p 'arg0 == 0x7f7f8fa04310'

#!/usr/sbin/dtrace -s

#pragma D option quiet
dtrace:::BEGIN { printf("Starting... use Ctrl + c to stop\n"); }
dtrace:::END   { printf("Ending...\n"  ); }

/* Script content below */

objc$target:::entry / arg0 == 0x7f7f8fa04310 /
{
    printf("0x%016p %c[%s %s]\n", arg0, probefunc[0], probemod, (string)&probefunc[1]);
}

// 这是在倾倒[UIApplication sharedApplication]实例上的每个Objective-C方法调用。
╰─  sudo /tmp/lldb_dtrace_profile_objc.d  -p 36946  2>/dev/null

Password:
Starting... use Ctrl + c to stop
0x00007f7f8fa04310 -[UIApplication _supportsIndirectInputEvents]
0x00007f7f8fa04310 -[UIApplication _supportsIndirectInputEvents]
0x00007f7f8fa04310 -[UIApplication _supportsIndirectInputEvents]
0x00007f7f8fa04310 -[UIApplication _supportsIndirectInputEvents]







(lldb) tobjectivec -g -p 'arg0 == 0x7f7f8fa04310' -a '@[probefunc] = count()'

#!/usr/sbin/dtrace -s

#pragma D option quiet
dtrace:::BEGIN { printf("Starting... use Ctrl + c to stop\n"); }
dtrace:::END   { printf("Ending...\n"  ); }

/* Script content below */

objc$target:::entry / arg0 == 0x7f7f8fa04310 /
{
    @[probefunc] = count()
}
