### Swift中地址转类型

```shell
(lldb) e let $pin2 = unsafeBitCast(0x14ea71800, to: NavigationController.self)
(lldb) po pin2
(lldb) po pin2.viewControllers
```

### 打印

```shell
# x/数量、格式、字节 内存地址
# 格式：x是16进制，f是浮点，d是10进制
# 字节：b1 h2 w4 g8

(lldb) x/8xg 0x6000035092e0
x: 检查内存 memory read
g: 巨型字大小（a giant word）64位，8字节
x: 格式化为16进制

例：
(lldb) x/xg 0x6000035092e0
0x6000035092e0: 0x000000010b0916d8
(lldb) x/4gx 0x6000035092e0
0x6000035092e0: 0x000000010b0916d8 0x0000600002074a40
0x6000035092f0: 0x000000010b090570 0x000000010b090590

(lldb) x/tb 0x6000035092e0
x: 检查内存
b: 一个字节
t: 格式化为二进制

(lldb) x/tg '0x600002d3b380 + 0x18'
0x600002d3b398: 0b0000000000000000000000000110101101100101011100100110010101000100


(lldb) x/s '0x600002ae4540 + 0x20'
0x600002ae4560: ""

十进制转十六进制
(lldb) p/x 106102872289888
(long) $6 = 0x0000608000033260
```

### RxSwift

``` shell
# 导入模块

# debugging contexts 是 objc ,导入UIKit成功
(lldb) expr @import UIKit
(lldb) expr @import RxCocoa
# 导入失败是因为当前的 debugging contexts 是objc，而RxCocoa是swift库
error: while importing modules:
error: Header search couldn't locate module RxCocoa

# 当解析表达式时，指定语言为swift
(lldb) expression -l swift -- UIApplication.shared
error: <EXPR>:3:1: error: cannot find 'UIApplication' in scope
UIApplication.shared
^~~~~~~~~~~~~

(lldb) expression -l swift -O -- import UIKit
(lldb) expression -l swift -- UIApplication.shared
(UIApplication) $R0 = 0x0000000119604d10 {
  baseUIApplication@0 = {
    UIResponder = {
      NSObject = {
        isa = NSKVONotifying_UIApplication
      }
    }
  }
}
(lldb) expression -l swift -O -- UIApplication.shared
<UIApplication: 0x119604d10>

# 将原始地址转换为可用类型
(lldb) expression -l swift -- import RxCocoa
(lldb) expr -l Swift -- let $pin = unsafeBitCast(0x283a3b600, to: RxCocoa.ControlTarget.self)
(lldb) expr -l Swift -- print($pin)
expr -l Swift -- $pin

ObservableType+Extensions 65
```



### apropos

apropos提供了一种更直接的方式来查看LLDB有哪些功能，使用”apropos+关键字“命令，它会根据关键字来搜索LLDB帮助文档，并为每个命令选取一个帮助字符串

``` shell
(lldb) apropos thread
The following commands may relate to 'thread':
  _regexp-bt                     -- Show the current thread's
                                    call stack.  Any numeric
                                    argument displays at most
                                    that many frames.  The
                                    argument 'all' displays
                                    all threads.
  disassemble                    -- Disassemble specified
                                    instructions in the
                                    current target.  Defaults
                                    to the current function
                                    for the current thread and
                                    stack frame.
  expression                     -- Evaluate an expression on
                                    the current thread.
                                    Displays any returned
                                    value with LLDB's default
                                    formatting.
  frame                          -- Commands for selecting and
                                    examing the current
                                    thread's stack frames.
...
```



### help

- 列出某个命令更多的细节
- 可以列出所有可以用于调试代码的命令及功能说明

``` shell
(lldb) help thread
Commands for operating on one or more threads in the current
process.

Syntax: thread <subcommand> [<subcommand-options>]

The following subcommands are supported:

      backtrace      -- Show thread call stacks.  Defaults to
                        the current thread, thread indexes can
                        be specified as arguments.
                        Use the thread-index "all" to see all
                        threads.
                        Use the thread-index "unique" to see
                        threads grouped by unique call
                        stacks.
                        Use 'settings set frame-format' to
                        customize the printing of frames in
                        the backtrace and 'settings set
                        thread-format' to customize the thread
                        header.
      continue       -- Continue execution of the current
                        target process.  One or more threads
                        may be specified, by default all
                        threads continue.
      exception      -- Display the current exception object
                        for a thread. Defaults to the current
                        thread.
      info           -- Show an extended summary of one or
                        more threads.  Defaults to the current
                        thread.
...
```



### image

由于LLDB给 **target modules** 取了个别名 **image**，所以 **target modules lookup** 这个命令我们又可以写成 **image lookup**。

``` shell
# 查找方法名（自己写的方法， 系统的和第三方的 .a ）
(lldb) image lookup –n viewDidLoad
```



# 报错

``` shell
(lldb) po GMSServices.sharedServices()
error: Execution was interrupted, reason: internal ObjC exception breakpoint(-5)..
The process has been returned to the state before expression evaluation.
```





# Custom LLDB Commands

```shell
/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/Resources/Python/lldb/macosx/heap.py

# 加载上面脚本的内容
 (lldb) command script import lldb.macosx.heap
```



##### LLDB 附加到进程（process）

``` shell
lldb -n Proxyman
```





#### To find out which Python version is linked to LLDB

找出与LLDB链接的Python版本

``` shell
$ lldb
# The script command brings up the Python interpreter for LLDB. 
# scrip命令带来了LLDB Python解析器

(lldb) script import sys
(lldb) script print (sys.version)
3.9.6 (default, Aug  5 2022, 15:21:02)
[Clang 14.0.0 (clang-1400.0.29.102)]
```

查看python版本

``` shell
$ python3.9
Python 3.9.0 (default, Dec  3 2020, 16:09:02)
[Clang 12.0.0 (clang-1200.0.32.27)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> print(sys.version)
3.9.0 (default, Dec  3 2020, 16:09:02)
[Clang 12.0.0 (clang-1200.0.32.27)]
>>> h.split(" ", 0) # 分割字符串的最大上限
['hello world']
>>> def test(a):
...   print(a + " world!")
...
>>> test("hello")
hello world!
>>>
```





``` python
>>> h = "hello world"
>>> h
'hello world'
>>> h.split(" ")
['hello', 'world']
>>> h.split(" ").__class__
<class 'list'> # 数组类型
>>> h.__class__
<type 'str'> # 字符串类型
>>> help (str) # q 退出
>>> help (str.split) # 缩小搜索范围
>>> def test(a):

```



``` python
def your_first_command(debugger, command, result, internal_dict):
  import pdb; pdb.set_trace()
  print("hello world")

# 函数名为 __lldb_init_module，它是一个钩子函数，在你的模块加载到 LLDB 时被调用。
def __lldb_init_module(debugger, internal_dict):
    # 你正在使用一个传入名为debugger的函数的参数。对于这个对象，即SBDebugger的一个实例，你正在使用一个名为HandleCommand的可用方法。调用 debugger.HandleCommand 几乎等同于在 LLDB 中键入一些东西。
    # 模块加载后立即创建 yay 函数
    debugger.HandleCommand('command script add -f helloworld.your_first_command yay')
```



``` shell
# 命令所做的唯一一件事就是把 helloworld (是的，以文件命名) 模块的路径带入，作为 Python 的候选使用。
(lldb) command script import ~/lldb/helloworld.py
# 教程：https://lldb.llvm.org/use/python-reference.html
# https://www.jianshu.com/p/e59379da849e

# 如果你打算在Python中使用这个函数，则需要导入该模块才能使用其中的任何函数。在 LLDB 中键入以下内容。
(lldb) script import helloworld

# 你可以通过转储helloworld python模块中的所有方法来验证你是否成功导入了该模块。
(lldb) script dir(helloworld)
['__builtins__', '__cached__', '__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__', 'your_first_command']

# 我们通过command script add把helloworld模块中的your_first_command方法定义为LLDB命令yay了。-f表示你要添加的是一个python方法。
# -g：
(lldb) command script add -f helloworld.your_first_command yay

(lldb) script help(lldb.SBDebugger.HandleCommand)
Help on function HandleCommand in module lldb:

HandleCommand(self, command)
    HandleCommand(SBDebugger self, char const * command)
    
# 打开你的~/.ldbinit文件。你现在要指定你想让helloworld模块在每次LLDB加载时都能在启动时加载。

```



``` shell
command regex ls 's/(.+)/po @import Foundation; [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"%1" error:nil]/'
command regex dump_stuff "s/(.+)/image lookup -rn '\+\[\w+(\(\w+\))?\ \w+\]$' %1/"
command regex ivars 's/(.+)/expression -lobjc -O -- [%1 _ivarDescription]/'
command regex methods 's/(.+)/expression -lobjc -O -- [%1 _shortMethodDescription]/'
command regex lmethods 's/(.+)/expression -lobjc -O -- [%1 _methodDescription]/'
```



- python 没有常量的概念







## Debugging Script Bridging

- Python pdb module 用于调试python脚本，设置断点
- 你可以在SBDebugger（或SBCommandReturnObject）的HandleCommand方法中执行你自己的 "正常 "Objective-C、Objective-C++、C或Swift代码（甚至是其他语言）。
- 在Xcode中调试Python脚本时，pdb将无法工作
- Ctrl + D 退出 pdb



``` python
def your_first_command(debugger, command, result, internal_dict):
  import pdb; pdb.set_trace()
  print("hello world")

# 函数名为 __lldb_init_module，它是一个钩子函数，在你的模块加载到 LLDB 时被调用。
def __lldb_init_module(debugger, internal_dict):
    # 你正在使用一个传入名为debugger的函数的参数。对于这个对象，即SBDebugger的一个实例，你正在使用一个名为HandleCommand的可用方法。调用 debugger.HandleCommand 几乎等同于在 LLDB 中键入一些东西。
    # 模块加载后立即创建 yay 函数
    debugger.HandleCommand('command script add -f helloworld.your_first_command yay')
```



``` shell
(lldb) yay woot
> /Users/blf/lldb/helloworld.py(3)your_first_command()
-> print("hello world")
(Pdb) command # 这将转储您提供给您的自定义 LLDB 命令的命令
'woot'
(Pdb) result
# 这是SBCommandReturnObject的一个实例，它是ldb模块用来让你指示LLDB命令的执行是否成功的一个类。此外，你还可以附加一些信息，当你的命令完成后会显示出来。
<lldb.SBCommandReturnObject; proxy of <Swig Object of type 'lldb::SBCommandReturnObject *' at 0x10740ed20> >
(Pdb) result.AppendMessage("2nd hello world") # 这将附加一条信息，当这个命令完成时，LLDB将显示该信息
(Pdb) debugger
<lldb.SBDebugger; proxy of <Swig Object of type 'lldb::SBDebugger *' at 0x1071c8a80> >
(Pdb) c
hello world
2nd hello world
```



``` shell
# 当触发了 raise AssertionError("Uhoh... something went wrong, can you figure it out? :]") 错误时
# 可以使用pdb来检查错误发生时的堆栈跟踪
(lldb) script import pdb # 把pdb导入到LLDB的Python上下文中
(lldb) findclass
(lldb) script pdb.pm() # pdb运行“事后分析” post mortem，然后lldb将切换到pdb接口，并调到出错的那一行
> /Users/blf/lldb/findclass.py(40)findclass()
-> raise AssertionError("Uhoh... something went wrong, can you figure it out? :]")

(Pdb) l
 35  	    '''
 36
 37  	    res = lldb.SBCommandReturnObject()
 38  	    debugger.GetCommandInterpreter().HandleCommand("expression -lobjc -O -- " + codeString, res)
 39  	    if res.GetError():
 40  ->	        raise AssertionError("Uhoh... something went wrong, can you figure it out? :]")
 41  	    elif not res.HasResult():
 42  	        raise AssertionError("There's no result. Womp womp....")
 43
 44  	    returnVal = res.GetOutput()
 45  	    resultArray = returnVal.split(",")
 
(Pdb) print(res.GetError())
error: expression failed to parse:
warning: warning: got name from symbols: classes
error: <user expression 1>:6:18: 'objc_getClassList' has unknown return type; cast the call to its declared return type
    numClasses = objc_getClassList(NULL, 0);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
error: <user expression 1>:9:18: 'objc_getClassList' has unknown return type; cast the call to its declared return type
    numClasses = objc_getClassList(classes, numClasses);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
warning: warning: got name from symbols: i
error: <user expression 1>:13:42: 'class_getName' has unknown return type; cast the call to its declared return type
      [returnString appendFormat:@"%s,", class_getName(c)];
                                         ^~~~~~~~~~~~~~~~


(Pdb) l 37, 41 # 列出当前脚本的第37到41行代码
 37  	    res = lldb.SBCommandReturnObject()
 38  ->	    debugger.GetCommandInterpreter().HandleCommand("expression -lobjc -O -- " + codeString, res)
 39  	    if res.GetError():
 40  	        raise AssertionError("Uhoh... something went wrong, can you figure it out? :]")
 41  	    elif not res.HasResult():

(Pdb) n # next 向下执行一行
> /Users/blf/lldb/findclass.py(38)findclass()
-> debugger.GetCommandInterpreter().HandleCommand("expression -lobjc -O -- " + codeString, res)

(Pdb) c # continu 继续执行

(Pdb) print(res.GetError()) # 执行python代码

(Pdb) codeString # \n 也会被输出，阅读起来不方便
'\n    @import Foundation;\n    int numClasses;\n    Class * classes = NULL;\n    classes = NULL;\n    numClasses = (int)objc_getClassList(NULL, 0);\n    NSMutableString *returnString = [NSMutableString string];\n    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *\n    numClasses);\n    numClasses = (int)objc_getClassList(classes, numClasses);\n    for (int i = 0; i < numClasses; i++) {\n        Class c = classes[i];\n        [returnString appendFormat:@"%s,", (char *)class_getName(c)];\n    }\n    free(classes);\n    returnString;\n    '

(Pdb) print(codeString) # \n 会被解析，阅读起来方便

    @import Foundation;
    int numClasses;
    Class * classes = NULL;
    classes = NULL;
    numClasses = (int)objc_getClassList(NULL, 0);
    NSMutableString *returnString = [NSMutableString string];
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *
    numClasses);
    numClasses = (int)objc_getClassList(classes, numClasses);
    for (int i = 0; i < numClasses; i++) {
        Class c = classes[i];
        [returnString appendFormat:@"%s,", (char *)class_getName(c)];
    }
    free(classes);
    returnString;

(lldb) gui
```



##### 修改Python脚本后如何重新载入

``` shell
# 1. pdb 模式 Ctrl + D 退出 

# 直接重新载入会报错
(lldb) command script import ~/lldb/findclass.py
error: cannot add command: user command exists and force replace not set

# 解决办法
(lldb) command script delete findclass
(lldb) command script import ~/lldb/findclass.py
# 并不需要执行 script import findclass
```



##### findclass.py

``` python
import lldb 

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f findclass.findclass findclass')


def findclass(debugger, command, result, internal_dict):
    """
    The findclass command will dump all the Objective-C runtime classes it knows about.
    Alternatively, if you supply an argument for it, it will do a case sensitive search
    looking only for the classes which contain the input. 

    Usage: findclass  # All Classes
    Usage: findclass UIViewController # Only classes that contain UIViewController in name
    """ 


    codeString = r'''
    @import Foundation;
    int numClasses;
    Class * classes = NULL;
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    NSMutableString *returnString = [NSMutableString string];
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);

    for (int i = 0; i < numClasses; i++) {
      Class c = classes[i];
      [returnString appendFormat:@"%s,", class_getName(c)];
    }
    free(classes);
    
    returnString;
    '''

    res = lldb.SBCommandReturnObject()
    debugger.GetCommandInterpreter().HandleCommand("expression -lobjc -O -- " + codeString, res)
    
    """
    (lldb) findclass
     # 通过下面的  raise AssertionError("Uhoh... something went wrong, can you figure it out? :]") 代码实现错误输出
	Traceback (most recent call last):
  		File "/Users/blf/lldb/findclass.py", line 40, in findclass
    		raise AssertionError("Uhoh... something went wrong, can you figure it out? :]")
	AssertionError: Uhoh... something went wrong, can you figure it out? :]
    """
    if res.GetError(): 
		raise AssertionError("Uhoh... something went wrong, can you figure it out? :]")
    elif not res.HasResult():
        raise AssertionError("There's no result. Womp womp....")
      
    returnVal = res.GetOutput()
    resultArray = returnVal.split(",")
    if not command: # No input supplied 
        print(returnVal.replace(",", "\n").replace("\n\n\n", ""))
    else: 
        filteredArray = filter(lambda className: command in className, resultArray)
        filteredResult = "\n".join(filteredArray)
        result.AppendMessage(filteredResult)


```



##### 以后探索

``` python
# -g 选项
debugger.GetCommandInterpreter().HandleCommand("expression -lobjc -g -O -- " + codeString, res)
```







## Script Bridging Classes & Hierarchy

脚本衔接类和层次结构

- `lldb.SBDebugger`：你需要用这个类来访问你在调试脚本中创建的其他类。一个函数中一定会有一个对这个类实例对象的引用。这个类负责处理输入到`LLDB`中的命令，而且可以控制在哪儿或者怎么展示输出。

- `lldb.SBTarget`：负责在内存中调试的可执行文件、调试文件和驻留在磁盘上的可执行文件的物理文件。调试的时候，你要用`SBDebugger`的实例来选择`SBTarget`实例，之后你就可以通过它访问其他类了。

- `lldb.SBProcess`：`SBTarget`与`SBProcess`有一对多关系：`SBTarget`管理一个或多个`SBProcess`实例。`SBProcess`负责内存访问以及进程中的多线程。

- `lldb.SBThread`：管理该特定线程中的栈帧`SBFrames`，还管理单步执行的控制逻辑。

- `lldb.SBFrame`：管理本地变量（通过调试信息给出）以及冻结在该特定帧上的任何寄存器。

- `lldb.SBModule`：表示特定的可执行文件。模块可以包含主可执行文件或任何动态加载的代码（如基础框架）。可以使用`image list`命令获得加载到可执行文件中的模块的完整列表。

- `lldb.SBFunction`：表示一个加载到内存中的泛型函数。这个类与`SBFrame`类有一对一的关系。

![SBFunction](/Users/blf/Documents/Git/SBFunction.png)



##### 运行lldb时重新加载 ~/.lldbinit 文件

``` shell
# 在 ~/.lldbinit 文件中添加
command alias reload_script command source ~/.lldbinit
```

##### LLDB有几个容易访问的全局变量，映射到上面描述的一些类中。

- lldb.SBDebugger->lldb.debugger

- lldb.SBTarget->lldb.target

- lldb.SBProcess->lldb.process

- lldb.SBThread->lldb.thread

- lldb.SBFrame->lldb.frame

``` shell
(lldb) script lldb.debugger
<lldb.SBDebugger; proxy of <Swig Object of type 'lldb::SBDebugger *' at 0x11168d960> >
(lldb) script lldb.target
<lldb.SBTarget; proxy of <Swig Object of type 'lldb::SBTarget *' at 0x111533390> >
(lldb) script print(lldb.target)
Meh
(lldb) script print(lldb.process)
SBProcess: pid = 67735, state = stopped, threads = 5, executable = Meh
(lldb) script print(lldb.thread)
thread #1: tid = 0x809a2, 0x0000000101442078 Meh`ViewController.viewDidLoad(self=0x0000600001c05400) at ViewController.swift:13:9, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
(lldb) script print(lldb.frame)
frame #0: 0x0000000101442078 Meh`ViewController.viewDidLoad(self=0x0000600001c05400) at ViewController.swift:13:9
# 使用Python的help功能来获取一个特定类的文档
(lldb) script help(lldb.target)
(lldb) script help(lldb.SBTarget)
```



##### 了解这些类实现了哪些发放

https://lldb.llvm.org/python_reference/index.html



``` shell
SBTarget site:http://lists.llvm.org/pipermail/lldb-dev/
```



##### BreakAfterRegex.py

``` python
import lldb

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f BreakAfterRegex.breakAfterRegex bar')

def breakAfterRegex(debugger: lldb.SBDebugger, command, result, internal_dict):
    print("yay. basic script setup with input: {}".format(command))
    
    # 1
    target: lldb.SBTarget = debugger.GetSelectedTarget()
    breakpoint: lldb.SBBreakpoint = target.BreakpointCreateByRegex(command)
    
    # 2
    if not breakpoint.IsValid() or breakpoint.num_locations == 0:
        result.AppendWarning("Breakpoint isn`t valid or hasn`t found any hits")
    else:
        result.AppendMessage("{}".format(breakpoint))
    
    # 3
    breakpoint.SetScriptCallbackFunction("BreakAfterRegex.breakpointHandler")

# 这包括一个 SBFrame、SBBreakpointLocation 和一个 Python 字典。
# SBFrame 代表你已经停止的帧。SBBreakpointLocation是你在SBBreakpoint中找到的一个断点的实例。
# 你不应该在你的脚本中使用 lldb.frame 或其他全局变量，因为它们在脚本中执行时可能会保持一个陈旧的状态，所以你必须遍历从 frame 开始的变量，或者 bc_loc 来获得你想要的类的实例。
def breakpointHandler(frame, bp_loc, dict):
    function_name = frame.GetFunctionName()
    # 执行：(lldb) bar NSObject.init\]
    # 击中断点时打印：stopped in: -[NSObject init]
    print("stopped in: {}".format(function_name))


    # 1
    # 1. 是的，如果你要建立一个完整的Python命令脚本，你必须要添加一些文档字符串。你以后会感谢自己的。相信我。
    '''The function called when the regular expression breakpoint gets triggered'''

    # 2
    # 2. 你要爬上分层参考链，抓住SBDebugger和SBThread的实例。你的起点是通过SBFrame。
    thread = frame.GetThread()
    process = thread.GetProcess()
    debugger = process.GetTarget().GetDebugger()

    # 3
    # 3. 这就抓取了父函数的名称。因为你即将跨出当前的SBFrame，它即将被无效化，所以在跨出发生之前抓取任何你能抓到的堆栈引用。
    function_name = frame.GetFunctionName()

    # 4
    # 4. SetAsync是一个有趣的函数，当在程序中编写脚本时篡改控制流时可以使用。调试器在执行程序时将以异步方式运行，所以你需要告诉它同步等待，直到stepOut完成执行后再将控制权交还给Python脚本。
    #一个好的程序员会把状态清理到异步的前一个值，但这变得有点复杂，因为如果多个断点都打到这个回调函数上，当这个回调函数触发时，你可能会遇到线程问题。在你调试的时候，这不是一个明显的设置变化，所以把它关掉就可以了。
    debugger.SetAsync(False)

    # 5
    # 5. 然后你走出方法。在这一行执行后，你将不再处于你先前停止的帧中。
    thread.StepOut()

    # 6
    # 6. 你正在调用一个即将实现的方法evaluateReturnedObject，它接收适当的信息并生成一个输出消息。这个消息将包含你所停的帧，返回的对象，以及断点所跨出的帧。
    output = evaluateReturnedObject(debugger, thread, function_name)

    if output is not None:
        print(output)
    
    return False
    

    # 返回True将导致你的程序停止执行。返回 "假"，甚至省略返回语句将导致程序在这个方法执行后继续运行。
    # return True

def evaluateReturnedObject(debugger, thread, function_name):
    '''Grabs the reference from the return register 
    and returns a string from the evaluated value.
    TODO Objc only
    '''

    # 1
    # 你首先实例化一个新的SBCommandReturnObject。你已经在你的主要函数中看到这个类作为结果参数。然而，你在这里要创建你自己的，因为你要用这个实例来评估和修改一个表达式。一个典型的po "something "会产生输出，包括两个换行，直接到控制台。你需要在输出到控制台之前抓住这个输出，并删除这些换行符......因为你就是这样花哨。在第25章 "用SBValue和语言上下文进行脚本桥接 "中，你将探索一种评估代码和获得输出的更简洁的替代方法，但现在你将利用你现有的SBCommandReturnObject类的知识。
    res = lldb.SBCommandReturnObject()

    # 2
    # 你抓取一些变量供以后使用。
    interpreter = debugger.GetCommandInterpreter()
    target = debugger.GetSelectedTarget()
    frame = thread.GetSelectedFrame()
    parent_function_name = frame.GetFunctionName()

    # 3
    # 在这里你创建要执行的表达式，打印出返回值。getRegisterString是另一个未实现的函数，你马上就会实现--我保证这将是我最后一次对你这样做！你可以使用这个函数。这个函数将返回访问保存返回值的寄存器所需的语法。 这是必须的，因为你不知道这个脚本是在watchOS、iOS、tvOS还是macOS设备上运行的，所以你需要根据架构来增加寄存器的名称。记住，你还需要使用Objective-C的上下文，因为Swift对你隐藏了寄存器。
    expression = 'expression -lobjc -O -- {}'.format(getRegisterString(target))

    # 4
    # 最后，你通过调试器的命令解释器SBCommandInterpreter执行表达式。这个类解释你的命令，但允许你控制输出的去向，而不是立即把它输送到stderr或stdout。
    interpreter.HandleCommand(expression, res)

    # 5
    #  一旦HandleCommand执行完毕，表达式的输出现在应该位于SBCommandReturnObject实例中。然而，确保返回对象实际上有任何输出可以给你，是一个很好的做法。
    if res.HasResult():
        # 6
        # 如果一切工作正常，你可以将旧的、已退出的函数连同对象和当前停止的函数一起格式化为一个字符串并返回。
        output = '{}\nbreakpoint: '\
            '{}\nobject: {}\nstopped: {}'.format(
                '*' * 80,
                function_name,
                res.GetOutput().replace('\n', ''),
                parent_function_name
            )
        return output
    else:
        # 7
        # 然而，如果没有从SBCommandReturnObject中输入打印，你就返回None。
        return None

# 你正在使用SBTarget实例来调用GetTriple，它返回可执行文件被设计为运行的硬件的描述。接下来，你要根据你的架构确定你需要哪种语法来访问负责返回值的寄存器。如果是一个未知的架构，那么就引发一个异常。
def getRegisterString(target):
    triple_name = target.GetTriple()
    if "x86_64" in triple_name:
        return "$rax"
    elif "i386" in triple_name:
        return "$eax"
    elif "arm64" in triple_name:
        return "$x0"
    elif "arm" in triple_name:
        return "$r0"
    raise Exception('Unknow hardware. Womp womp')
```

``` shell
(lldb) reload_script
Executing commands in '/Users/blf/.lldbinit'.
command alias reload_script command source ~/.lldbinit
warning: Overwriting existing definition for 'reload_script'.
command script import ~/lldb/BreakAfterRegex.py

(lldb) bar UIViewController test -a -b
yay. basic script setup with input: UIViewController test -a -b

(lldb) command script clear

(lldb) reload_script
Executing commands in '/Users/blf/.lldbinit'.

(lldb) command alias reload_script command source ~/.lldbinit
warning: Overwriting existing definition for 'reload_script'.
command script import ~/lldb/BreakAfterRegex.py

(lldb) bar jsljkfsljfsdffljkjksjkljklf
yay. basic script setup with input: jsljkfsljfsdffljkjksjkljklf
warning: Breakpoint isn`t valid or hasn`t found any hits

(lldb) bar NSObject.init\]
yay. basic script setup with input: NSObject.init\]
SBBreakpoint: id = 3, regex = 'NSObject.init\]', locations = 2

stopped in: -[NSObject init]

# 删除所有断点
(lldb) br del
```



##### 展示了当你在某一特定函数上停止时类的简化交互

![page352image55867616](/Users/blf/Documents/Git/page352image55867616.png)



- 你不应该在你的脚本中使用 lldb.frame 或其他全局变量，因为它们在脚本中执行时可能会保持一个陈旧的状态，所以你必须遍历从 frame 开始的变量，或者 bc_loc 来获得你想要的类的实例。

``` python
# optparse 是您刚刚介绍的模块，其中包含 OptionParser 类以解析提供给您的命令的任何额外输入。
import optparse
# shlex 模块有一个不错的 Python 小函数，它可以方便地拆分代表您提供给命令的参数，同时保持字符串参数不变。
import shlex

import shlex
command = '"hello world" "2nd parameter" 34'
shlex.split(command)
# ['hello world', '2nd parameter', '34']


```







## Script Bridging with Options & Arguments

## Script Bridging with SBValue & Language Contexts

## SB Examples, Improved Lookup

## SB Examples, Resymbolicating a Stripped ObjC Binary

## SB Examples, Malloc Logging

