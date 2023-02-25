### Mach-O文件源码

https://opensource.apple.com/tarballs/xnu/

xnu: Mac系统的内核

EXTERNAL_HEADERS：内部头文件

lipo

Load commands: 描述有哪些段

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/7/17/1735b62ae788ba6f~tplv-t2oaga2asx-watermark.awebp)

```
# -l     Display the load commands.
# -v     Display verbosely (symbolically) when possible. 在可能的情况下，以沉长（符号）方式显示。
╰─ otool -v -l hello.o
hello.o:
Load command 0
      cmd LC_SEGMENT_64
  cmdsize 632
  segname
   vmaddr 0x0000000000000000
   vmsize 0x0000000000000128
  fileoff 792
 filesize 288
  maxprot rwx
 initprot rwx
   nsects 7
    flags (none)
Section
  sectname __text
   segname __TEXT
      addr 0x0000000000000000
      size 0x0000000000000066
    offset 792
     align 2^4 (16)
    reloff 1080
    nreloc 5
      type S_REGULAR
attributes PURE_INSTRUCTIONS SOME_INSTRUCTIONS
 reserved1 0
 reserved2 0
Section
  sectname __data
   segname __DATA
      addr 0x0000000000000068
      size 0x0000000000000008
    offset 896
     align 2^2 (4)
    reloff 0
    nreloc 0
      type S_REGULAR
attributes (none)
 reserved1 0
 reserved2 0
Section
  sectname __common
   segname __DATA
      addr 0x0000000000000120
      size 0x0000000000000004
    offset 0
     align 2^2 (4)
    reloff 0
    nreloc 0
      type S_ZEROFILL
attributes (none)
 reserved1 0
 reserved2 0
Section
  sectname __cstring
   segname __TEXT
      addr 0x0000000000000070
      size 0x0000000000000004
    offset 904
     align 2^0 (1)
    reloff 0
    nreloc 0
      type S_CSTRING_LITERALS
attributes (none)
 reserved1 0
 reserved2 0
Section
  sectname __bss
   segname __DATA
      addr 0x0000000000000124
      size 0x0000000000000004
    offset 0
     align 2^2 (4)
    reloff 0
    nreloc 0
      type S_ZEROFILL
attributes (none)
 reserved1 0
 reserved2 0
Section
  sectname __compact_unwind
   segname __LD
      addr 0x0000000000000078
      size 0x0000000000000040
    offset 912
     align 2^3 (8)
    reloff 1120
    nreloc 2
      type S_REGULAR
attributes DEBUG
 reserved1 0
 reserved2 0
Section
  sectname __eh_frame
   segname __TEXT
      addr 0x00000000000000b8
      size 0x0000000000000068
    offset 976
     align 2^3 (8)
    reloff 0
    nreloc 0
      type S_COALESCED
attributes NO_TOC STRIP_STATIC_SYMS LIVE_SUPPORT
 reserved1 0
 reserved2 0
Load command 1
      cmd LC_BUILD_VERSION
  cmdsize 24
 platform MACOS
    minos 11.0
      sdk 12.0
   ntools 0
Load command 2
     cmd LC_SYMTAB
 cmdsize 24
  symoff 1136
   nsyms 7
  stroff 1248
 strsize 112
Load command 3
            cmd LC_DYSYMTAB
        cmdsize 80
      ilocalsym 0
      nlocalsym 2
     iextdefsym 2
     nextdefsym 4
      iundefsym 6
      nundefsym 1
         tocoff 0
           ntoc 0
      modtaboff 0
        nmodtab 0
   extrefsymoff 0
    nextrefsyms 0
 indirectsymoff 0
  nindirectsyms 0
      extreloff 0
        nextrel 0
      locreloff 0
        nlocrel 0
```

