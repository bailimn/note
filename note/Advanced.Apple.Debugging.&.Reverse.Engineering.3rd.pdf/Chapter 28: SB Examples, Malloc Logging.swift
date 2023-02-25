• msl.py: This is the command (which is an abbreviation for MallocStackLogging) is the script you’ll be working on in this chapter. This has a basic skeleton of the logic.
- msl.py。这是命令（MallocStackLogging的缩写），是你在本章中要做的脚本。这有一个基本的逻辑骨架。

• lookup.py: Wait — you already made this command, right? Yes, but I’ll give you my own version of the lookup command that adds a couple of additional options at the price of uglier code. You’ll use one of the options to filter your searches to specific modules within a process.
• sbt.py: This command will take a backtrace with unsymbolicated symbols, and symbolicate it. You made this in the previous chapter, and you’ll need it at the very end of this chapter. And in case you didn’t work through the previous chapter, it’s included in this chapter’s resources for you to install.
• search.py: This command will enumerate all objects in the heap and search for a particular subclass. This is a very convenient command for quickly grabbing references to instances of a particular class.
- lookup.py。等等 - 你已经做了这个命令，对吗？是的，但我将给你我自己版本的查找命令，它以更丑陋的代码为代价增加了几个额外的选项。你将使用其中的一个选项来过滤你的搜索，使之成为一个进程中的特定模块。
- sbt.py: 这个命令将获取一个带有无符号的符号的回溯，并将其符号化。你在前一章做了这个，在本章的最后你会用到它。为了防止你没有通过前一章的工作，它被包含在本章的资源中供你安装。
- search.py。这个命令将枚举堆中的所有对象并搜索一个特定的子类。这是一个非常方便的命令，可以快速抓取对某个特定类的实例的引用。


MallocStackLogging explained
In case you’re unfamiliar with the MallocStackLogging environment variable, I’ll describe it and show how it’s typically used.
When the MallocStackLogging environment variable is passed into a process, and is set to true, it’ll monitor allocations and deallocations of memory on the heap. Pretty neat!
MallocStackLogging 解释
如果您不熟悉 MallocStackLogging 环境变量，我将对其进行描述并展示它的典型使用方式。
当 MallocStackLogging 环境变量传递到进程中并设置为 true 时，它将监视堆上内存的分配和释放。 漂亮整齐！


(lldb) lookup log -m libobjc.A.dylib
****************************************************
4 hits in: libobjc.A.dylib
****************************************************
_objc_syslog(char const*)

_objc_crashlog(char const*)

TimeLogger::log(char const*)

logReplacedMethod

https://opensource.apple.com/source/libmalloc/libmalloc-116/private/stack_logging.h.auto.html
https://github.com/llvm-mirror/lldb/blob/master/examples/darwin/heap_find/heap/heap_find.cpp

pdfs
https://github.com/tpn/pdfs