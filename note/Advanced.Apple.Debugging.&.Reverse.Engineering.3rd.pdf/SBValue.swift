
SBValue is responsible for interpreting the parsed expressions from your JIT code.
SBValue负责解释从你的JIT代码中解析出来的表达式
responsible : 负责
interpreting : 解析过程
parse ：做语法分析
 
  
Within the SBTarget and SBFrame class, there’s a method named EvaluateExpression, which will take your expression as a Python str and return an SBValue instance.  
在SBTarget和SBFrame类中，有一个名为EvaluateExpression的方法，它将把你的表达式作为Python str并返回一个SBValue实例。
In addition, there’s an optional second parameter that lets you specify how you want your code to be parsed. 
此外，还有一个可选的第二个参数，让你指定你希望你的代码如何被解析


(lldb) po [DSObjectiveCObject new]
<DSObjectiveCObject: 0x61800002eec0>

This ensures you can create a valid instance of a DSObjectiveCObject.
这确保你可以创建一个有效的DSObjectiveCObject实例。

This code works, so you can apply it to the EvaluateExpression method of either the global SBTarget or SBFrame instance:
这段代码是有效的，所以你可以把它应用于全局SBTarget或SBFrame实例的EvaluateExpression方法。

(lldb) script lldb.frame.EvaluateExpression('[DSObjectiveCObject new]')
<lldb.SBValue; proxy of <Swig Object of type 'lldb::SBValue *' at 0x111f26ae0> >


(lldb) script print(lldb.target.EvaluateExpression('[DSObjectiveCObject new]'))
(DSObjectiveCObject *) $3 = 0x000060000062bba0



You can verify the SBValue succeeded by checking the SBError instance within your SBValue. If your SBvalue was named sbval, you could do sbval.GetError().Success(), or more simply sbval.error.success. print as a quick way to see if it worked or not.
你可以通过检查你的SBValue中的SBError实例来验证SBValue的成功。如果你的SBValue被命名为sbval，你可以做sbval.GetError().Success()，或者更简单的sbval.error.success.print，作为一个快速的方法来查看它是否工作。



(lldb) script a = lldb.target.EvaluateExpression('[DSObjectiveCObject new]')
(lldb) script print(a)
(DSObjectiveCObject *) $4 = 0x000060000060d740
(lldb) script print(a.description)
<DSObjectiveCObject: 0x60000060d740>
(lldb) script print(a.value)
0x000060000060d740

Use the GetNumChildren method available to SBValue to get its child count:
使用SBValue可用的GetNumChildren方法来获得它的孩子数量。
(lldb) script print(a.GetNumChildren())
4


You'll get 4 (or potentially 3 depending on the version of LLDB/run conditions which hides an instance's isa variable)
你会得到4个（或者可能是3个，取决于LLDB/运行条件的版本，它隐藏了一个实例的isa变量

You can think children as just an array. There’s a special API to traverse the children in a class called GetChildAtIndex, so you can explore children 0-3 in LLDB.
你可以认为children只是一个数组。在一个叫做GetChildAtIndex的类中，有一个特殊的API来遍历这些孩子，所以你可以在LLDB中探索孩子的0-3。

(lldb) script print(a.GetChildAtIndex(0))
(NSObject) NSObject = {
  isa = DSObjectiveCObject
}
(lldb) script print(a.GetChildAtIndex(1))
(UICachedDeviceRGBColor *) _eyeColor = 0x000060000135c840
(lldb) script print(a.GetChildAtIndex(2))
(__NSCFConstantString *) _firstName = 0x000000010d924598 @"Derek"
(lldb) script print(a.GetChildAtIndex(3))
(__NSCFConstantString *) _lastName = 0x000000010d9245b8 @"Selander"


Each of these will return a SBValue in itself, so you can explore that object even further if you desired. 
每一个都将返回一个SBValue本身，所以如果你愿意，你可以进一步探索该对象。

(lldb) script print(a.GetChildAtIndex(2).description)
Derek


It’s important to remember the Python variable a is a pointer to an object. Type the following:
重要的是要记住 Python 变量 a 是一个指向对象的指针。输入以下内容。

(lldb) script a.size
8

This will print out a value saying a is 8 bytes long. But you want to get to the actual content! Fortunately, the SBValue has a deref property that returns another SBValue. Explore the output with the size property:
这将打印出一个值，说a是8字节长。但你想获得实际的内容! 幸运的是，SBValue有一个deref属性，可以返回另一个SBValue。用size属性探索输出。

(lldb) script a.deref.size
32

This returns the value 32 since it makes up the isa, eyeColor, firstName, and lastName, each of them being 8 bytes long themselves as they are all pointers.
Here’s another way to look at what the deref property is doing. Explore the SBType class (you can look that one up yourself ) of the SBValue.
这将返回值32，因为它构成了isa、eyeColor、firstName和lastName，它们每个都是8字节长，因为它们都是指针。
这里有另一种方法来看看deref属性在做什么。探索SBValue的SBT类型类（你可以自己去查）。

(lldb) script print(a.type.name)
DSObjectiveCObject *
(lldb) script print(a.deref.type.name)
DSObjectiveCObject




Viewing raw data through SBValue
通过SBValue查看原始数据

You can even dump the raw data out with the data property in SBValue! This is represented by a class named SBData, which is yet another class you can check out on your own.
Print out the data of the pointer to DSObjectiveCObject:
你甚至可以用SBValue中的数据属性将原始数据转储出来 这是由一个名为SBData的类来表示的，这又是一个你可以自己去查看的类。
打印出指向DSObjectiveCObject的指针的数据。

(lldb) script print(a.data)
40 d7 60 00 00 60 00 00                          @.`..`..

This will print out the physical bytes that make up the object. Again, this is the pointer to DSObjectiveCObject, not the object itself.
这将打印出组成该对象的物理字节。同样，这是对DSObjectiveCObject的指针，而不是对象本身。

Remember, each byte can be represented as two digits in hexadecimal.
Do you remember covering the little-endian formatting in Chapter 12, “Assembly & Memory,” and how the raw data is reversed?
记住，每个字节可以用十六进制的两个数字来表示。
你还记得在第12章 "汇编与内存 "中涉及的小序数格式，以及原始数据是如何反转的吗？

(lldb) script print(a.value)
0x000060000060d740

Notice how the values have been flipped. For example, the final two hex digits of my pointer are the first grouping (aka byte) in the raw data. In my case, the raw data contains 0x60 as the first value, while the pointer contains 0x60 as the final value.
Use the deref property to grab all the bytes that make up this DSObjectiveCObject.
请注意这些数值是如何被翻转的。例如，我的指针的最后两个十六进制数字是原始数据中的第一个分组（又称字节）。在我的例子中，原始数据包含0x40作为第一个值，而指针包含0x60作为最终值。
使用deref属性来抓取组成这个DSObjectiveCObject的所有字节。

(lldb) script print(a.deref.data)
00 c7 be 06 01 00 00 00 80 f1 c7 00 00 60 00 00  .............`..
98 b5 be 06 01 00 00 00 b8 b5 be 06 01 00 00 00  ................

This is yet another way to visualize what is happening. You were jumping 8 bytes each time when you were spelunking in memory with that cute po *(id*) (0x0000608000033260 + multiple_of_8) command.
这是另一种可视化正在发生的事情的方法。 当你用那个可爱的 po *(id*) (0x0000608000033260 + multiple_of_8) 命令在内存中进行探索时，你每次都跳跃 8 个字节。



SBExpressionOptions

As mentioned when discussing the EvaluateExpression API, there’s an optional second parameter that will take an instance of type SBExpressionOptions. You can use this command to pass in specific options for the JIT execution.
正如在讨论 EvaluateExpression API 时提到的，有一个可选的第二个参数，它将采用 SBExpressionOptions 类型的实例。 您可以使用此命令为 JIT 执行传递特定选项。

(lldb) script options = lldb.SBExpressionOptions()
(lldb) script options.SetLanguage(lldb.eLanguageTypeSwift)

SBExpressionOptions has a method named SetLanguage (when in doubt, use gdocumentation SBExpressionOptions), which takes an LLDB module enum of type lldb::LanguageType. The LLDB authors have a convention for sticking an "e" before an enum, the enum name, then the unique value.
SBExpressionOptions 有一个名为 SetLanguage 的方法（如有疑问，请使用 gdocumentation SBExpressionOptions），它采用 lldb::LanguageType 类型的 LLDB 模块枚举。 LLDB 作者有一个约定，在枚举、枚举名称和唯一值之前粘贴“e”。

This sets the options to evaluate the code as Swift instead of whatever the default is, based on the language type of SBFrame.
Now tell the options variable to interpret the JIT code as a of type ID (i.e. po, instead of p):
这将根据 SBFrame 的语言类型设置将代码评估为 Swift 而不是默认值的选项。
现在告诉 options 变量将 JIT 代码解释为类型 ID（即 po，而不是 p）：

(lldb) script options.SetCoerceResultToId()

SetCoerceResultToId takes an optional Boolean, which determines if it should be interpreted as an id or not. By default, this is set to True.
To recap what you did here: you set the options to parse this expression using the Python API instead of the options passed to us through the expression command.
For example, SBExpressionOptions you’ve declared so far is pretty much equivalent to the following options in the expression command:
SetCoerceResultToId 接受一个可选的布尔值，它决定是否应将其解释为 id。 默认情况下，这设置为 True。
回顾一下你在这里所做的：你设置选项来使用 Python API 解析这个表达式，而不是通过 expression 命令传递给我们的选项。
例如，到目前为止您声明的 SBExpressionOptions 几乎等同于表达式命令中的以下选项：

expression -lswift -O -- your_expression_here

Next, create an instance of the ASwiftClass method only using the expression command. If this works, you’ll try out the same expression in the EvaluateExpression command. In LLDB type the following:
接下来，仅使用表达式命令创建 ASwiftClass 方法的实例。 如果这有效，您将在 EvaluateExpression 命令中尝试相同的表达式。 在 LLDB 中键入以下内容：

(lldb) e -lswift -O -- ASwiftClass()
error: <EXPR>:3:1: error: cannot find 'ASwiftClass' in scope
ASwiftClass()
^~~~~~~~~~~

Oh yeah, — you need to import the Allocator module to make Swift play nicely in the debugger.
哦，是的，您需要导入 Allocator 模块才能使 Swift 在调试器中正常运行。

(lldb) e -lswift -- import Allocator
(lldb) e -lswift -O -- ASwiftClass()
<ASwiftClass: 0x600000c75400>

Note: This is a problem many LLDB users complain about: LLDB can’t properly evaluate code that should be able to execute. Adding this import logic will modify LLDB’s Swift expression prefix, which is basically a set of header files that a referenced right before you JIT code is evaluated.
LLDB can’t see the class ASwiftClass in the JIT code when you’re stopped in the non-Swift debugging context. This means you need to append the headers to the expression prefix that belongs to the Allocator module.
注意：这是许多 LLDB 用户抱怨的问题：LLDB 无法正确评估应该能够执行的代码。 添加这个导入逻辑将修改 LLDB 的 Swift 表达式前缀，它基本上是一组在你的 JIT 代码被评估之前引用的头文件。
当您在非 Swift 调试上下文中停止时，LLDB 无法在 JIT 代码中看到类 ASwiftClass。 这意味着您需要将标头附加到属于 Allocator 模块的表达式前缀。

There’s a great explanation from one of the LLDB authors about this very problem here: http://stackoverflow.com/questions/19339493/why-cant-lldb-evaluate-this- expression.
LLDB 的一位作者在这里对这个问题进行了很好的解释：http://stackoverflow.com/questions/19339493/why-cant-lldb-evaluate-this-expression。

Execute the previous command again. Up arrow twice then Enter:
再次执行上一条命令。 向上箭头两次然后输入：

(lldb) e -lswift -O -- ASwiftClass()
<ASwiftClass: 0x600000c6d3c0>

You’ll get a reference to an instance of the ASwiftClass().
Now that you know this works, use the EvaluateExpression method with the options parameter as the second parameter this time and assign the output to the variable b, like so:
您将获得对 ASwiftClass() 实例的引用。
现在您知道这是有效的，这次使用 EvaluateExpression 方法和 options 参数作为第二个参数并将输出分配给变量 b，如下所示：

(lldb) script b = lldb.target.EvaluateExpression('ASwiftClass()', options)

If everything went well, you’ll get a reference to a SBValue in the b Python variable.
如果一切顺利，您将在 b Python 变量中获得对 SBValue 的引用。

Note: It’s worth pointing out some properties of SBValue will not play nicely with Swift. For example, dereferencing a Swift object with SBValue’s deref or address_of property will not work properly. You can coerce this pointer to an Objective-C reference by casting the pointer as a SwiftObject, and everything will then work fine. Like I said, they make you work for it when you’re trying to go after pointers in Swift!
注意：值得指出的是 SBValue 的某些属性在 Swift 中不能很好地发挥作用。 例如，使用 SBValue 的 deref 或 address_of 属性取消引用 Swift 对象将无法正常工作。 您可以通过将指针转换为 SwiftObject 来将此指针强制转换为 Objective-C 引用，然后一切都会正常工作。 就像我说的，当你试图在 Swift 中寻找指针时，它们会让你为之努力！


Referencing variables by name with SBValue
Referencing child SBValues via GetChildAtIndex from SBValue is a rather ho-hum way to navigate to an object in memory. What if the author of this class added a property before eyeColor that totally screwed up your offset logic when traversing this SBValue?
Fortunately, SBValue has yet another method that lets you reference instance variables by name instead of by offset: GetValueForExpressionPath.
Jump back to LLDB and type the following:
使用 SBValue 按名称引用变量
通过从 SBValue 中的 GetChildAtIndex 引用子 SBValues 是导航到内存中的对象的一种相当乏味的方式。 如果这个类的作者在 eyeColor 之前添加了一个属性，在遍历这个 SBValue 时完全搞砸了你的偏移逻辑怎么办？
幸运的是，SBValue 还有另一种方法可以让您通过名称而不是偏移量来引用实例变量：GetValueForExpressionPath。
跳回 LLDB 并键入以下内容：

(lldb) script print(b.GetValueForExpressionPath('.firstName'))
(String) firstName = "Derek"

(lldb) script c = lldb.value(b)
(lldb) script print c.firstName
(lldb) script print c.firstName.sbvalue.signed

