/*  OC -> C++
$ clang -rewrite-objc test.m
# arc环境：
$ clang -rewrite-objc -fobjc-arc main.m

# 编译UIViewController 的子类
$ xcrun -sdk iphonesimulator clang -rewrite-objc ViewController.m
*/

// OC类 DSObjectiveCObject
@interface DSObjectiveCObject : NSObject

@property (nonatomic, strong) UIColor *eyeColor;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end

// 编译后生成的C++结构体
struct DSObjectiveCObject_IMPL {
	struct NSObject_IMPL NSObject_IVARS; // (lldb) po 0x600000031f80
	UIColor *_eyeColor; // (lldb) po *(id *)(0x600000031f80 + 0x8)
	NSString *_firstName; // (lldb) po *(id *)(0x600000031f80 + 0x10)
	NSString *_lastName; // (lldb) po *(id *)(0x600000031f80 + 0x18)
};

