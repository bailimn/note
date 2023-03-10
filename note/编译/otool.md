```
OTOOL-CLASSIC(1)                                                                                                                                OTOOL-CLASSIC(1)



NAME
       otool-classic - object file displaying tool

SYNOPSIS
       otool-classic [ option ...  ] [ file ...  ]

DESCRIPTION
       The  otool-classic command displays specified parts of object files or libraries. It is the preferred tool for inspecting Mach-O binaries, especially for
       binaries that are bad, corrupted, or fuzzed. It is also useful in situations when inspecting  files  with  new  or  "bleeding-edge"  Mach-O  file  format
       changes.

       For  historical reasons, the LLVM-based llvm-objdump(1) tool does support displaying Mach-O information in an "otool-compatibility" mode. For more infor-
       mation on using llvm-objdump(1) in this way, see the llvm-otool(1) command-line shim. Note that llvm-objdump(1) is incapable of displaying information in
       all Mach-O files.

       If  the  -m option is not used the file arguments may be of the form libx.a(foo.o), to request information about only that object file and not the entire
       library.   (Typically this argument must be quoted, ``libx.a(foo.o)'', to get it past the shell.)  Otool-classic understands both  Mach-O  (Mach  object)
       files  and  universal  file formats.  Otool-classic can display the specified information in either its raw (numeric) form (without the -v flag), or in a
       symbolic form using macro names of constants, etc. (with the -v or -V flag).

       At least one of the following options must be specified:

       -a     Display the archive header, if the file is an archive.

       -S     Display the contents of the `__.SYMDEF' file, if the file is an archive.

       -f     Display the universal headers.

       -h     Display the Mach header.

       -l     Display the load commands.

       -L     Display the names and version numbers of the shared libraries that the object file uses, as well as the shared library ID if the file is a  shared
              library.

       -D     Display just the install name of a shared library.  See install_name_tool(1) for more info.

       -s segname sectname
              Display  the  contents  of  the section (segname,sectname).  If the -v flag is specified, the section is displayed as its type, unless the type is
              zero (the section header flags).  Also the sections (__OBJC,__protocol), (__OBJC,__string_object) and (__OBJC,__runtime_setup) are displayed  sym-
              bolically  if  the  -v  flag  is specified. For unknown section types, if the -V flag is specified, the contents of the section are displayed in a
              canonical hex+ASCII display, where a column of hexadecimal values print along side a column of ASCII characters.

       -t     Display the contents of the (__TEXT,__text) section.  With the -v flag, this disassembles the text.  With the -V flag, it also symbolically disas-
              sembles the operands.

       -x     Display  the  contents  of every __text section found in the file. This is useful when looking at the Mach kernel and other files with __text sec-
              tions in more than one segment, or where the __text section is somewhere other than __TEXT. When used with the  -v  flag,  this  disassembles  the
              text. When used with the -V flag, it also symbolically disassembles the operands.

       -d     Display the contents of the (__DATA,__data) section.

       -o     Display the contents of the __OBJC segment used by the Objective-C run-time system.

       -r     Display the relocation entries.

       -c     Display the argument strings (argv[] and envp[]) from a core file.

       -I     Display the indirect symbol table.

       -T     Display the table of contents for a dynamically linked shared library.

       -R     Display the reference table of a dynamically linked shared library.

       -M     Display the module table of a dynamically linked shared library.

       -H     Display the two-level namespace hints table.

       -G     Display the data in code table.

       -C     Display the linker optimization hints (-v for verbose mode can also be added).

       -P     Print the info plist section, (__TEXT,__info_plist), as strings.

       -dyld_info
              Print bind and rebase information used by dyld to resolve external references in a final linked binary.

       -dyld_opcodes
OTOOL-CLASSIC(1)                                                                                                                                OTOOL-CLASSIC(1)



NAME
       otool-classic - object file displaying tool

SYNOPSIS
       otool-classic [ option ...  ] [ file ...  ]

DESCRIPTION
       The  otool-classic command displays specified parts of object files or libraries. It is the preferred tool for inspecting Mach-O binaries, especially for
       binaries that are bad, corrupted, or fuzzed. It is also useful in situations when inspecting  files  with  new  or  "bleeding-edge"  Mach-O  file  format
       changes.

       For  historical reasons, the LLVM-based llvm-objdump(1) tool does support displaying Mach-O information in an "otool-compatibility" mode. For more infor-
       mation on using llvm-objdump(1) in this way, see the llvm-otool(1) command-line shim. Note that llvm-objdump(1) is incapable of displaying information in
       all Mach-O files.

       If  the  -m option is not used the file arguments may be of the form libx.a(foo.o), to request information about only that object file and not the entire
       library.   (Typically this argument must be quoted, ``libx.a(foo.o)'', to get it past the shell.)  Otool-classic understands both  Mach-O  (Mach  object)
       files  and  universal  file formats.  Otool-classic can display the specified information in either its raw (numeric) form (without the -v flag), or in a
       symbolic form using macro names of constants, etc. (with the -v or -V flag).

       At least one of the following options must be specified:

       -a     Display the archive header, if the file is an archive.

       -S     Display the contents of the `__.SYMDEF' file, if the file is an archive.

       -f     Display the universal headers.

       -h     Display the Mach header.

       -l     Display the load commands.

       -L     Display the names and version numbers of the shared libraries that the object file uses, as well as the shared library ID if the file is a  shared
              library.

       -D     Display just the install name of a shared library.  See install_name_tool(1) for more info.

       -s segname sectname
              Display  the  contents  of  the section (segname,sectname).  If the -v flag is specified, the section is displayed as its type, unless the type is
              zero (the section header flags).  Also the sections (__OBJC,__protocol), (__OBJC,__string_object) and (__OBJC,__runtime_setup) are displayed  sym-
              bolically  if  the  -v  flag  is specified. For unknown section types, if the -V flag is specified, the contents of the section are displayed in a
              canonical hex+ASCII display, where a column of hexadecimal values print along side a column of ASCII characters.

       -t     Display the contents of the (__TEXT,__text) section.  With the -v flag, this disassembles the text.  With the -V flag, it also symbolically disas-
              sembles the operands.

       -x     Display  the  contents  of every __text section found in the file. This is useful when looking at the Mach kernel and other files with __text sec-
              tions in more than one segment, or where the __text section is somewhere other than __TEXT. When used with the  -v  flag,  this  disassembles  the
              text. When used with the -V flag, it also symbolically disassembles the operands.

       -d     Display the contents of the (__DATA,__data) section.

       -o     Display the contents of the __OBJC segment used by the Objective-C run-time system.

       -r     Display the relocation entries.

       -c     Display the argument strings (argv[] and envp[]) from a core file.

       -I     Display the indirect symbol table.

       -T     Display the table of contents for a dynamically linked shared library.

       -R     Display the reference table of a dynamically linked shared library.

       -M     Display the module table of a dynamically linked shared library.

       -H     Display the two-level namespace hints table.

       -G     Display the data in code table.

       -C     Display the linker optimization hints (-v for verbose mode can also be added).

       -P     Print the info plist section, (__TEXT,__info_plist), as strings.

       -dyld_info
              Print bind and rebase information used by dyld to resolve external references in a final linked binary.

       -dyld_opcodes
              Print  raw  dyld  bind  and rebase opcodes present in a final linked binary. These opcodes are stored in a region pointed to by LC_DYLD_INFO* load
              commands.

       -show-latency
              When doing disassembly print latency annotations for instructions.

       -chained_fixups
              Print raw chained fixup data present in a final linked binary built with chained fixups. The chained fixup data are  stored  either  in  a  region
              pointed to by the LC_DYLD_CHAINED_FIXUPS load command or in a (__TEXT,__chain_starts) section. This data includes the fixup chain's starting loca-
              tion on each page by segment and symbol information for each bind. Use the -dyld_info option to see the individual links in each chain.

       The following options may also be given:

       -j     When doing disassembly print the opcode bytes of the instructions.

       -m     The object file names are not assumed to be in the archive(member) syntax, which allows file names containing parenthesis.

       -p name
              Used with the -t and -v or -V options to start the disassembly from symbol name and continue to the  end  of  the  (__TEXT,__text)  section.  This
              option can also be used with the -x option to begin disassembly from symbol name in any segment where a __text section is found.

       -q     Use the llvm disassembler when doing disassembly; this is available for the x86 and arm architectures.  This is the default.

       -Q     Use otool-classic(1)'s disassembler when doing disassembly.

       -v     Display verbosely (symbolically) when possible.

       -V     Display the disassembled operands symbolically (this implies the -v option).  This is useful with the -s, -t, and -x options.

       -X     Don't print leading addresses or headers with disassembly of sections.

       -addr_slide=arg
              When  disassembling  a  binary using the -s, -t, or -o options, add an arbitrary slide to each pointer value when it is displayed.  This is useful
              for matching otool output with that from a running process.

       -arch arch_type
              Specifies the architecture, arch_type, of the file for otool-classic(1) to operate on when the file is a universal file (aka a file with  multiple
              architectures).   (See  arch(3) for the currently known arch_types.)  The arch_type can be "all" to operate on all architectures in the file.  The
              default is to display only the host architecture, if the file contains it; otherwise, all architectures in the file are shown.

       -function_offsets
              When doing disassembly print the decimal offset from the last label printed.

       -mcpu=arg
              When doing disassembly using the llvm disassembler use the cpu arg.

       --version
              Print the otool-classic(1) version information.

SEE ALSO
       dyld(1), install_name_tool(1), libtool(1), lipo(1), llvm-otool(1), and vtool(1)



Apple Inc.                                                                July 31, 2020                                                         OTOOL-CLASSIC(1)
(END)
```

