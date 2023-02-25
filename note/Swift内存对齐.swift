class ASwiftClass {
  let eyeColor = UIColor.brown
  let firstName = "Derek" // (lldb) x/s '0x600002ae4540 + 0x18'
  let lastName = "Selander" // (lldb) x/s '0x600002ae4540 + 0x28'
  
  required init() { }  
}

struct ASwiftClass {
    Class isa;

    // Simplified, see "InlineRefCounts"
    // in https://github.com/apple/swift
    uintptr_t refCounts; // 8字节的变量，用于引用计数和对齐

    UIColor *eyeColor;

    // Simplified, see "_StringGuts"
    // in https://github.com/apple/swift
    // swift字符串内存对齐：https://github.com/apple/swift/blob/main/stdlib/public/core/StringObject.swift
    // Swift字符串结构的布局使得汇编的调用约定相当有趣。如果你把一个字符串传给一个函数，它实际上会传入两个参数（并使用两个寄存器），而不是一个包含两个参数的结构的指针（在一个寄存器中）
    struct _StringCore { // swift字符串的内存布局包括16个字节
        uintptr_t _object; // packed bits for string type
        uintptr_t rawBits; // raw data
    } firstName;

    struct _StringCore {
        uintptr_t _object; // packed bits for string type
        uintptr_t rawBits; // raw data
    } lastName; 
}


// swift 打印 AnyObject 实例 内存地址
func printAddress(values: AnyObject...) {
    for value in values {
      print(Unmanaged.passUnretained(value).toOpaque())
    }
    print("---------------------------------------")
}


// 尽管一个Swift类没有继承OC类，但是任然可以在OC上下文中获得动态描述。这意味着你可以爬上类的层级结构
(lldb) po [0x600002d3b380 superclass]
_TtCs12_SwiftObject

// 查看Swift类的引用计数器
(lldb) po *(id *)(0x600002d3b380 + 0x8)
0x0000000200000003

(lldb) po [0x600002d3b380 retain]
Allocator.ASwiftClass

(lldb) po *(id *)(0x600002d3b380 + 0x8)
0x0000000400000003

(lldb) po [0x600002d3b380 retain]
Allocator.ASwiftClass

(lldb) po *(id *)(0x600002d3b380 + 0x8)
0x0000000600000003

(lldb) po [0x600002d3b380 release]
0x0000000600000003

(lldb) po *(id *)(0x600002d3b380 + 0x8)
0x0000000400000003


https://github.com/apple/swift/blob/master/stdlib/public/core/SmallString.swift

StringObject abstracts the bit-level interpretation and creation of the String struct.
StringObject抽象了String结构的位级解释和创建。

On 64-bit platforms, the discriminator is the most significant 4 bits of the bridge object.
在64位平台上，判别器是桥接对象中最重要的4位。



  ┌─────────────────────╥─────┬─────┬─────┬─────┐
  │ Form                ║ b63 │ b62 │ b61 │ b60 │
  ╞═════════════════════╬═════╪═════╪═════╪═════╡
  │ Immortal, Small     ║  1  │ASCII│  1  │  0  │
  ├─────────────────────╫─────┼─────┼─────┼─────┤
  │ Immortal, Large     ║  1  │  0  │  0  │  0  │
  ╞═════════════════════╬═════╪═════╪═════╪═════╡
  │ Native              ║  0  │  0  │  0  │  0  │
  ├─────────────────────╫─────┼─────┼─────┼─────┤
  │ Shared              ║  x  │  0  │  0  │  0  │
  ├─────────────────────╫─────┼─────┼─────┼─────┤
  │ Shared, Bridged     ║  0  │  1  │  0  │  0  │
  ╞═════════════════════╬═════╪═════╪═════╪═════╡
  │ Foreign             ║  x  │  0  │  0  │  1  │
  ├─────────────────────╫─────┼─────┼─────┼─────┤
  │ Foreign, Bridged    ║  0  │  1  │  0  │  1  │
  └─────────────────────╨─────┴─────┴─────┴─────┘

  b63: isImmortal: Should the Swift runtime skip ARC
    - Small strings are just values, always immortal
    - Large strings can sometimes be immortal, e.g. literals
  b62: (large) isBridged / (small) isASCII
    - For large strings, this means lazily-bridged NSString: perform ObjC ARC
    - Small strings repurpose this as a dedicated bit to remember ASCII-ness
  b61: isSmall: Dedicated bit to denote small strings
  b60: isForeign: aka isSlow, cannot provide access to contiguous UTF-8
  The canonical empty string is the zero-sized small string. It has a leading nibble of 1110, and all other bits are 0.
  A "dedicated" bit is used for the most frequent fast-path queries so that they can compile to a fused check-and-branch, even if that burns part of the encoding space.
  On 32-bit platforms, we store an explicit discriminator (as a UInt8) with the same encoding as above, placed in the high bits. E.g. `b62` above is in `_discriminator`'s `b6`.

  b63: isImmortal: Swift运行时应该跳过ARC
    - 小字符串只是值，总是不朽的。
    - 大字符串有时可以是不朽的，例如字面意义。
  b62: (大) isBridged / (小) isASCII
    - 对于大的字符串，这意味着懒惰的桥接的NSString：执行ObjC ARC
    - 小字符串将其作为一个专用位来记忆ASCII-ness。
  b61: isSmall: 表示小字符串的专用位
  b60: isForeign: 又名isSlow，不能提供对连续的UTF-8的访问。
  典型的空字符串是零大小的小字符串。它的前导位是1110，其他所有位都是0。
  一个 "专用 "位用于最频繁的快速路径查询，以便它们可以编译成一个融合的检查和分支，即使那会烧掉一部分编码空间。
  在32位平台上，我们存储一个显式判别器（作为一个UInt8），其编码与上述相同，放在高位。例如，上面的`b62`在`_discriminator`的`b6`中。

immortal : 永生的
dedicated ：专用的


(lldb) x/gt '0x600002ae4540 + 0x18'
0x600002ae4558: 0b0000000000000000000000000110101101100101011100100110010101000100


https://github.com/TannerJin/Swift-MemoryLayout/blob/master/SwiftCore/String.swift


