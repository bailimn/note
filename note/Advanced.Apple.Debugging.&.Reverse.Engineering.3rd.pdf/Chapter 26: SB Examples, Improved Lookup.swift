(lldb) image lookup -rn viewDidLoad
8 matches found in /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/DocumentManager.framework/DocumentManager:
        Address: DocumentManager[0x00000000000031d8] (DocumentManager.__TEXT.__text + 7481)
        Summary: DocumentManager`-[UIDocumentBrowserViewController viewDidLoad]        Address: DocumentManager[0x000000000000eb5b] (DocumentManager.__TEXT.__text + 54972)
        Summary: DocumentManager`-[DOCRemoteViewController viewDidLoad]        Address: DocumentManager[0x000000000002bd16] (DocumentManager.__TEXT.__text + 174199)
        Summary: DocumentManager`-[DOCTargetSelectionBrowserViewController viewDidLoad]        Address: DocumentManager[0x000000000002bf7c] (DocumentManager.__TEXT.__text + 174813)
        Summary: DocumentManager`__54-[DOCTargetSelectionBrowserViewController viewDidLoad]_block_invoke        Address: DocumentManager[0x000000000002c105] (DocumentManager.__TEXT.__text + 175206)
        Summary: DocumentManager`__54-[DOCTargetSelectionBrowserViewController viewDidLoad]_block_invoke.37        Address: DocumentManager[0x000000000002c473] (DocumentManager.__TEXT.__text + 176084)
        Summary: DocumentManager`__54-[DOCTargetSelectionBrowserViewController viewDidLoad]_block_invoke.46        Address: DocumentManager[0x000000000002fdd6] (DocumentManager.__TEXT.__text + 190775)
        Summary: DocumentManager`-[DOCTargetSelectionBrowserViewController viewDidLoad].cold.1        Address: DocumentManager[0x000000000002fdf7] (DocumentManager.__TEXT.__text + 190808)
        Summary: DocumentManager`__54-[DOCTargetSelectionBrowserViewController viewDidLoad]_block_invoke.37.cold.1
49 matches found in /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore:



Automating script creation
Included with the starter directory of this project are two Python scripts that will make your life easier when creating LLDB script content. They are as follows:
• generate_new_script.py: This will create a new skeleton script with whatever name you provide it and stick it into the same directory generate_new_script resides in.
• lldbinit.py: This script will enumerate all scripts (files that end with .py) located within the same directory as itself and try to load them into LLDB. In addition, if there are any files with a txt extension, LLDB will try to load those files’ contents through command import.
Take both of these files found in the starter folder of this chapter and stick them into your ~/lldb/ directory.
Once the files are in their correct locations, jump over to your ~/.lldbinit file and add following line of code:
自动化脚本创建
该项目的 starter 目录中包含两个 Python 脚本，它们将使您在创建 LLDB 脚本内容时更轻松。 它们如下：
• generate_new_script.py：这将使用您提供的任何名称创建一个新的骨架脚本，并将其粘贴到 generate_new_script 所在的同一目录中。
• lldbinit.py：此脚本将枚举与自身位于同一目录中的所有脚本（以.py 结尾的文件），并尝试将它们加载到LLDB 中。 此外，如果有任何带有 txt 扩展名的文件，LLDB 将尝试通过命令导入加载这些文件的内容。
把本章的 starter 文件夹中的这两个文件放到你的 ~/lldb/ 目录中。
一旦文件位于正确的位置，跳转到你的 ~/.lldbinit 文件并添加以下代码行：

command script import ~/lldb/lldbinit.py

This will load the lldbinit.py file which will enumerate all .py files and .txt files found in the same directory and load them into LLDB. This means that from here on out, simply adding a script file into the ~/lldb directory will load it automatically once LLDB starts.
这将加载 lldbinit.py 文件，该文件将枚举在同一目录中找到的所有 .py 文件和 .txt 文件，并将它们加载到 LLDB 中。 这意味着从现在开始，只需将脚本文件添加到 ~/lldb 目录中，LLDB 启动后就会自动加载它。

╭─     ~                                                5590  22:56 
╰─ lldb
(lldb) reload_script
(lldb) __generate_script lookup
Opening "/Users/blf/lldb/lookup.py"...
(lldb) reload_script
(lldb) lookup
Hello! the lookup command is working!


扩展的lldb命令
https://github.com/DerekSelander/lldb
https://github.com/facebook/chisel


(lldb) script help(lldb.SBTarget.FindGlobalFunctions)
Help on function FindGlobalFunctions in module lldb:

FindGlobalFunctions(self, name: 'char const *', max_matches: 'uint32_t', matchtype: 'lldb::MatchType') -> 'lldb::SBSymbolContextList'
    FindGlobalFunctions(SBTarget self, char const * name, uint32_t max_matches, lldb::MatchType matchtype) -> SBSymbolContextList


https://lldb.llvm.org/python_reference/_lldb%27-module.html#eMatchTypeRegex



# 1 
clean_command = shlex.split(args[0])[0]
# 2
target = debugger.GetSelectedTarget()

# 3
contextlist = target.FindGlobalFunctions(clean_command, 0, lldb.eMatchTypeRegex)

# 4
result.AppendMessage(str(contextlist))

(lldb) reload_script
Executing commands in '/Users/blf/.lldbinit'.
command script import ~/lldb/lldbinit.py
(lldb) lookup DSObjectiveCObject
     Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Allocator-fgovrbhvwfgmptbqtwlvjijirmho/Build/Products/Debug-iphonesimulator/Allocator.app/Allocator", arch = "x86_64"
CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/25-Script Bridging with SBValue & Language Contexts/starter/Allocator/Allocator/DSObjectiveCObject.m", language = "unknown"
   Function: id = {0x100000258}, name = "-[DSObjectiveCObject setLastName:]", range = [0x0000000100001b00-0x0000000100001b34)
   FuncType: id = {0x100000258}, byte-size = 0, decl = DSObjectiveCObject.h:37, compiler_type = "void (NSString *)"
     Symbol: id = {0x0000012c}, range = [0x0000000100001b00-0x0000000100001b40), name="-[DSObjectiveCObject setLastName:]"
     Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Allocator-fgovrbhvwfgmptbqtwlvjijirmho/Build/Products/Debug-iphonesimulator/Allocator.app/Allocator", arch = "x86_64"
CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/25-Script Bridging with SBValue & Language Contexts/starter/Allocator/Allocator/DSObjectiveCObject.m", language = "unknown"
   Function: id = {0x100000296}, name = "-[DSObjectiveCObject .cxx_destruct]", range = [0x0000000100001b40-0x0000000100001ba5)

(lldb) script k = lldb.target.FindGlobalFunctions('DSObjectiveCObject', 0, lldb.eMatchTypeRegex)

把SBSymbolContextList实现的所有方法都倒出来
(lldb) script dir(lldb.SBSymbolContextList)
['Append', 'Clear', 'GetContextAtIndex', 'GetDescription', 'GetSize', 'IsValid', '__bool__', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__module__', '__ne__', '__new__', '__nonzero__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__swig_destroy__', '__weakref__', 'blocks', 'compile_units', 'functions', 'get_block_array', 'get_compile_unit_array', 'get_function_array', 'get_line_entry_array', 'get_module_array', 'get_symbol_array', 'line_entries', 'modules', 'symbols', 'thisown']

(lldb) script k[0]
<lldb.SBSymbolContext; proxy of <Swig Object of type 'lldb::SBSymbolContext *' at 0x111f26d80> >

Use the print command to get the context of this SBSymbolContext:
使用print命令可以得到这个SBSymbolContext的上下文。
(lldb) script print(k[0])
     Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Allocator-fgovrbhvwfgmptbqtwlvjijirmho/Build/Products/Debug-iphonesimulator/Allocator.app/Allocator", arch = "x86_64"
CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/25-Script Bridging with SBValue & Language Contexts/starter/Allocator/Allocator/DSObjectiveCObject.m", language = "unknown"
   Function: id = {0x100000258}, name = "-[DSObjectiveCObject setLastName:]", range = [0x0000000100001b00-0x0000000100001b34)
   FuncType: id = {0x100000258}, byte-size = 0, decl = DSObjectiveCObject.h:37, compiler_type = "void (NSString *)"
     Symbol: id = {0x0000012c}, range = [0x0000000100001b00-0x0000000100001b40), name="-[DSObjectiveCObject setLastName:]"
(lldb) script print(k[1])
     Module: file = "/Users/blf/Library/Developer/Xcode/DerivedData/Allocator-fgovrbhvwfgmptbqtwlvjijirmho/Build/Products/Debug-iphonesimulator/Allocator.app/Allocator", arch = "x86_64"
CompileUnit: id = {0x00000000}, file = "/Users/blf/Documents/PDF/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd/Advanced.Apple.Debugging.&.Reverse.Engineering.3rd.code/25-Script Bridging with SBValue & Language Contexts/starter/Allocator/Allocator/DSObjectiveCObject.m", language = "unknown"
   Function: id = {0x100000296}, name = "-[DSObjectiveCObject .cxx_destruct]", range = [0x0000000100001b40-0x0000000100001ba5)
   FuncType: id = {0x100000296}, byte-size = 0, decl = DSObjectiveCObject.m:31, compiler_type = "void (void)"
     Symbol: id = {0x00000130}, range = [0x0000000100001b40-0x0000000100001ba5), name="-[DSObjectiveCObject .cxx_destruct]"
(lldb) script print(k[0].symbol.name)
-[DSObjectiveCObject setLastName:]


(lldb) lookup -l DSObjectiveCObject
************************************************************
8 hits in Allocator
************************************************************
[0x000106be0b00-0x000106be0b40]
-[DSObjectiveCObject setLastName:]

[0x000106be0b40-0x000106be0ba5]
-[DSObjectiveCObject .cxx_destruct]

[0x000106be0aa0-0x000106be0ae0]
-[DSObjectiveCObject setFirstName:]

[0x000106be0a20-0x000106be0a40]
-[DSObjectiveCObject eyeColor]

[0x000106be0910-0x000106be0a20]
-[DSObjectiveCObject init]

[0x000106be0ae0-0x000106be0b00]
-[DSObjectiveCObject lastName]

[0x000106be0a40-0x000106be0a80]
-[DSObjectiveCObject setEyeColor:]

[0x000106be0a80-0x000106be0aa0]
-[DSObjectiveCObject firstName]


(lldb) b 0x000106be0a40
Breakpoint 2: where = Allocator`-[DSObjectiveCObject setEyeColor:] at DSObjectiveCObject.h:35, address = 0x0000000106be0a40

(lldb) lookup -s viewWillAppear
2 hits in Allocator
1 hits in DocumentManager
56 hits in UIKitCore
4 hits in ShareSheet
1 hits in GLKit
10 hits in MapKit
27 hits in ContactsUI
7 hits in OnBoardingKit

https://github.com/DerekSelander/LLDB/blob/master/lldb_commands/lookup.py


