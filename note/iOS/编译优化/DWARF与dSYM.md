### DWARF & dSYM
- DWARF: Debugging with Attribute Record Formats （源码调试信息的记录格式），主要用于源码级调试，如 gdb、llvm 调试或者在 Xcode 进行断点调试。

- dSYM: Debug Symbols。也就是调试符号，我们常常称为符号表文件。
- 符号表文件是内存与符号(函数名，文件名，行号等)的映射

##### dSYM文件格式
``` text
MyDemo.app.dSYM
└── Contents
    ├── Info.plist
    └── Resources
        └── DWARF
            └── MyDemo 
```

##### 查看DWARF文件
```c++
dwarfdump MyDemo.app.dSYM/Contents/Resources/DWARF/MyDemo

/*
0x00022d30:       DW_TAG_typedef
                    DW_AT_type	(0x00022ddb "long unsigned int")
                    DW_AT_name	("CFOptionFlags")
                    DW_AT_decl_file	("/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk/System/Library/Frameworks/CoreFoundation.framework/Headers/CFBase.h")
                    DW_AT_decl_line	(473)

0x00022d3c:       DW_TAG_typedef
                    DW_AT_type	(0x00022df3 "long int")
                    DW_AT_name	("CFIndex")
                    DW_AT_decl_file	("/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk/System/Library/Frameworks/CoreFoundation.framework/Headers/CFBase.h")
                    DW_AT_decl_line	(475)
*/
```

##### DWARF文件内容
``` text
DW_AT_low_pc表示函数的起始地址

DW_AT_high_pc表示函数的结束地址

DW_AT_frame_base表示函数的栈帧基址

DW_AT_object_pointer表示对象指针地址

DW_AT_name表示函数的名字

DW_AT_decl_file表示函数所在的文件

DW_AT_decl_line表示函数所在的文件中的行数

DW_AT_prototyped为一个 Bool 值, 为 true 时代表这是一个子程序/函数(subroutine)

DW_AT_type表示函数的返回值类型

DW_AT_artificial为一个Bool值，为true时代表这是一个由编译器生成而不是源程序显式声明
```

##### DWARF & dSYM 的生成
<div align="center">    
<img src="../images/1.png" alt="图片名称" height="1000" align=center />
</div>

在汇编产生的目标文件中，包含着 dwarf 信息，如果我们在 Debug 模式下打包且选择了Debug Information Format 为DWARF，那么最终的 App Mach-O 文件中则会包含 dwarf 信息。如果我们在 Release 模式下打包且选择了Debug Information Format 为DWARF with dSYM File ，那么则会通过 dsymutil 根据 mach-o 文件中的 dwarf 信息生成 dSYM 文件，然后通过 strip 命令去除掉 mach-o 中的调试符号化信息，以减少包体积以及不必要的源码隐私泄漏。

##### Generate Debug Symbols
<div align="center">    
<img src="../images/2.png" alt="图片名称" align=center />
</div>
这个项默认是开启的，如果设置为NO，那么调试符号根本不会产生，也就没有 dwarf 和 dSYM 什么事了，就连我们在 Xcode 打断点调试时，断点都不会中断。这点需要注意下。

无论 Debug 还是 Release，我们都建议是开启状态。开启时，源文件在编译的时候，编译参数会多一个-g和-gmodules 选项，然后生成的目标文件中就会包含 dwarf 信息，所以目标文件会比没开启的时候稍微大点，最终 dwarf 会被包含在 mach-o 中或者生成的 dSym 中。

##### 最后
- 主项目的多个Target，必要时都可以对 Debug/Release 模式下要不要生成 dSYM 做调整，以减少 Debug 模式下的编译耗时。
- 对于静态库，不会生成 dSYM 文件，即使设为DWARF with dSYM File。