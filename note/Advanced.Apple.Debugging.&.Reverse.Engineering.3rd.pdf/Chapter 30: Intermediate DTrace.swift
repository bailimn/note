

pid$target:SomeTarget::entry
SomeTarget模块内实现的每一个函数的开头设置一个探针




pid$target 跟踪所有非 Objective-C 代码，这个探针也会探测到C和C++的代码




class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
在viewDidLoad上创建一个断点
SomeTarget.ViewController.viewDidLoad() -> ()



如果你想在SomeTarget中搜索每一个由Swift实现的viewDidLoad，你可以创建一个DTrace探针描述
pid$target:SomeTarget:*viewDidLoad*:entry
这实际上是说，"只要SomeTarget和viewDidLoad在函数部分，就给我探针。"




╰─ sudo dtrace -n 'pid$target:Finding?Ray::entry' -p `pgrep "Finding Ray"`
Password:
dtrace: description 'pid$target:Finding?Ray::entry' matched 247 probes
CPU     ID                    FUNCTION:NAME
  4 168502 @objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:):entry
  4 168500 type metadata accessor for UITouch:entry
  4 168501 lazy protocol witness table accessor for type UITouch and conformance NSObject:entry
  4 168500 type metadata accessor for UITouch:entry
  4 168499 QuickTouchPanGestureRecognizer.touchesBegan(_:with:):entry





// -q : 告诉DTrace不显示你所发现的探针数量，也不在探针被击中时显示其默认输出
╰─ sudo dtrace -qn 'pid$target:Finding?Ray::entry { printf("%s\n", probefunc); } ' -p `pgrep "Finding Ray"`
Password:
@objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
type metadata accessor for UITouch
lazy protocol witness table accessor for type UITouch and conformance NSObject
QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
@objc QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
type metadata accessor for UITouch
lazy protocol witness table accessor for type UITouch and conformance NSObject
type metadata accessor for QuickTouchPanGestureRecognizer
@objc QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
@objc QuickTouchPanGestureRecognizer.canPrevent(_:)
QuickTouchPanGestureRecognizer.canPrevent(_:)


// 返回任何不包含"@"且在输出中包含句号的东西。这实质上是说不要返回任何@objc桥接方法，而且由于模块命名空间的存在
╰─ sudo dtrace -qn 'pid$target:Finding?Ray::entry { printf("%s\n", probefunc); } ' -p `pgrep "Finding Ray"` | grep -E "^[^@].*\."
Password:
QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
QuickTouchPanGestureRecognizer.canPrevent(_:)
QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
ViewController.handleGesture(panGesture:)
ViewController.dynamicAnimator.getter
ViewController.snapBehavior.getter
ViewController.containerView.getter
MotionView.animate(isSelected:)
specialized CGFloat.init<A>(_:)
specialized CGFloat.init<A>(_:)
CAAnimationGroup.__allocating_init()
Array._endMutation()
ViewController.handleGesture(panGesture:)





// flowindent选项将正确缩进函数条目和返回
╰─ sudo dtrace -qFn 'pid$target:Finding?Ray::*r* { printf("%s\n", probefunc); } ' -p `pgrep "Finding Ray"`
Password:
CPU FUNCTION
  0  -> @objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:) @objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
  0    -> type metadata accessor for UITouch  type metadata accessor for UITouch
  0    <- type metadata accessor for UITouch  type metadata accessor for UITouch
  0    -> lazy protocol witness table accessor for type UITouch and conformance NSObject lazy protocol witness table accessor for type UITouch and conformance NSObject
  0    <- lazy protocol witness table accessor for type UITouch and conformance NSObject lazy protocol witness table accessor for type UITouch and conformance NSObject
  0    -> QuickTouchPanGestureRecognizer.touchesBegan(_:with:) QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
  0      -> @objc QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:) @objc QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
  0        -> QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:) QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
  0        <- QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:) QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
  0      <- @objc QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:) @objc QuickTouchPanGestureRecognizer.gestureRecognizerShouldBegin(_:)
  0      -> type metadata accessor for UITouch type metadata accessor for UITouch
  0      <- type metadata accessor for UITouch type metadata accessor for UITouch
  0      -> lazy protocol witness table accessor for type UITouch and conformance NSObject lazy protocol witness table accessor for type UITouch and conformance NSObject
  0      <- lazy protocol witness table accessor for type UITouch and conformance NSObject lazy protocol witness table accessor for type UITouch and conformance NSObject
  0      -> type metadata accessor for QuickTouchPanGestureRecognizer type metadata accessor for QuickTouchPanGestureRecognizer
  0      <- type metadata accessor for QuickTouchPanGestureRecognizer type metadata accessor for QuickTouchPanGestureRecognizer
  0    <- QuickTouchPanGestureRecognizer.touchesBegan(_:with:) QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
  0  <- @objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:) @objc QuickTouchPanGestureRecognizer.touchesBegan(_:with:)
  0  -> @objc QuickTouchPanGestureRecognizer.shouldRequireFailure(of:) @objc QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
  0    -> QuickTouchPanGestureRecognizer.shouldRequireFailure(of:) QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
  0    <- QuickTouchPanGestureRecognizer.shouldRequireFailure(of:) QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
  0  <- @objc QuickTouchPanGestureRecognizer.shouldRequireFailure(of:) @objc QuickTouchPanGestureRecognizer.shouldRequireFailure(of:)
  0  -> @objc QuickTouchPanGestureRecognizer.canPrevent(_:) @objc QuickTouchPanGestureRecognizer.canPrevent(_:)
  0    -> QuickTouchPanGestureRecognizer.canPrevent(_:) QuickTouchPanGestureRecognizer.canPrevent(_:)
  0    <- QuickTouchPanGestureRecognizer.canPrevent(_:) QuickTouchPanGestureRecognizer.canPrevent(_:)
  0  <- @objc QuickTouchPanGestureRecognizer.canPrevent(_:) @objc QuickTouchPanGestureRecognizer.canPrevent(_:)
  0  -> @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0    -> QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0    <- QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0  <- @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0  -> @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0    -> QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0    <- QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0  <- @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter @objc QuickTouchPanGestureRecognizer.delaysTouchesBegan.getter
  0  -> @objc ViewController.handleGesture(panGesture:) @objc ViewController.handleGesture(panGesture:)
  0    -> ViewController.handleGesture(panGesture:) ViewController.handleGesture(panGesture:)
  0      -> type metadata accessor for UIGestureRecognizerState type metadata accessor for UIGestureRecognizerState
  0      <- type metadata accessor for UIGestureRecognizerState type metadata accessor for UIGestureRecognizerState
  0      -> ViewController.dynamicAnimator.getter ViewController.dynamicAnimator.getter
  0      <- ViewController.dynamicAnimator.getter ViewController.dynamicAnimator.getter
  0      -> ViewController.snapBehavior.getter ViewController.snapBehavior.getter
  0      <- ViewController.snapBehavior.getter ViewController.snapBehavior.getter
  0      -> ViewController.containerView.getter ViewController.containerView.getter
  0      <- ViewController.containerView.getter ViewController.containerView.getter
  0      -> MotionView.animate(isSelected:)   MotionView.animate(isSelected:)
  0        -> type metadata accessor for CABasicAnimation type metadata accessor for CABasicAnimation
  0        <- type metadata accessor for CABasicAnimation type metadata accessor for CABasicAnimation
  0        -> @nonobjc CABasicAnimation.__allocating_init(keyPath:) @nonobjc CABasicAnimation.__allocating_init(keyPath:)
  0        <- @nonobjc CABasicAnimation.__allocating_init(keyPath:) @nonobjc CABasicAnimation.__allocating_init(keyPath:)
  0        -> __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        <- __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        -> __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0        <- __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0        -> __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        <- __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        -> __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0        <- __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0        -> specialized CGFloat.init<A>(_:) specialized CGFloat.init<A>(_:)
  0        <- specialized CGFloat.init<A>(_:) specialized CGFloat.init<A>(_:)
  0        -> specialized CGFloat.init<A>(_:) specialized CGFloat.init<A>(_:)
  0        <- specialized CGFloat.init<A>(_:) specialized CGFloat.init<A>(_:)
  0        -> @nonobjc CABasicAnimation.__allocating_init(keyPath:) @nonobjc CABasicAnimation.__allocating_init(keyPath:)
  0        <- @nonobjc CABasicAnimation.__allocating_init(keyPath:) @nonobjc CABasicAnimation.__allocating_init(keyPath:)
  0        -> type metadata accessor for CGSize type metadata accessor for CGSize
  0        <- type metadata accessor for CGSize type metadata accessor for CGSize
  0        -> __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        <- __swift_project_boxed_opaque_existential_0 __swift_project_boxed_opaque_existential_0
  0        -> __swift_memcpy16_8              __swift_memcpy16_8
  0        <- __swift_memcpy16_8              __swift_memcpy16_8
  0        -> __swift_memcpy16_8              __swift_memcpy16_8
  0        <- __swift_memcpy16_8              __swift_memcpy16_8
  0        -> __swift_noop_void_return        __swift_noop_void_return
  0        <- __swift_noop_void_return        __swift_noop_void_return
  0        -> __swift_noop_void_return        __swift_noop_void_return
  0        <- __swift_noop_void_return        __swift_noop_void_return
  0        -> __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0          -> __swift_noop_void_return      __swift_noop_void_return
  0          <- __swift_noop_void_return      __swift_noop_void_return
  0        <- __swift_destroy_boxed_opaque_existential_0 __swift_destroy_boxed_opaque_existential_0
  0        -> type metadata accessor for CAAnimationGroup type metadata accessor for CAAnimationGroup
  0        <- type metadata accessor for CAAnimationGroup type metadata accessor for CAAnimationGroup
  0        -> CAAnimationGroup.__allocating_init() CAAnimationGroup.__allocating_init()
  0          -> @nonobjc CAAnimationGroup.init() @nonobjc CAAnimationGroup.init()
  0          <- @nonobjc CAAnimationGroup.init() @nonobjc CAAnimationGroup.init()
  0        <- CAAnimationGroup.__allocating_init() CAAnimationGroup.__allocating_init()
  0        -> type metadata accessor for CAAnimation type metadata accessor for CAAnimation
  0        <- type metadata accessor for CAAnimation type metadata accessor for CAAnimation
  0        -> _finalizeUninitializedArray<A>(_:) _finalizeUninitializedArray<A>(_:)
  0          -> Array._endMutation()          Array._endMutation()
  0          <- Array._endMutation()          Array._endMutation()
  0        <- _finalizeUninitializedArray<A>(_:) _finalizeUninitializedArray<A>(_:)
  0      <- MotionView.animate(isSelected:)   MotionView.animate(isSelected:)
  0    <- @objc ViewController.handleGesture(panGesture:) @objc ViewController.handleGesture(panGesture:)
  4  -> @objc ViewController.handleGesture(panGesture:) @objc ViewController.handleGesture(panGesture:)
  4    -> ViewController.handleGesture(panGesture:) ViewController.handleGesture(panGesture:)
  4      -> type metadata accessor for UIGestureRecognizerState type metadata accessor for UIGestureRecognizerState
  4      <- type metadata accessor for UIGestureRecognizerState type metadata accessor for UIGestureRecognizerState
  4      -> ViewController.containerView.getter ViewController.containerView.getter
  4      <- ViewController.containerView.getter ViewController.containerView.getter
  4      -> ViewController.containerView.getter ViewController.containerView.getter
  4      <- ViewController.containerView.getter ViewController.containerView.getter
  4      -> MotionView.recursivelyTransformByAmount(distance:baseView:) MotionView.recursivelyTransformByAmount(distance:baseView:)
  4        -> MotionView.transformAmount.getter MotionView.transformAmount.getter
  4        <- MotionView.transformAmount.getter MotionView.transformAmount.getter
  4        -> MotionView.transformAmount.getter MotionView.transformAmount.getter
  4        <- MotionView.transformAmount.getter MotionView.transformAmount.getter
  4        -> MotionView.motionAmount.getter  MotionView.motionAmount.getter
  4        <- MotionView.motionAmount.getter  MotionView.motionAmount.getter
  4        -> type metadata accessor for UIView type metadata accessor for UIView
  4        <- type metadata accessor for UIView type metadata accessor for UIView
  4        -> Array.subscript.read            Array.subscript.read
  4        <- Array.subscript.read            Array.subscript.read
  4        -> type metadata accessor for MotionView type metadata accessor for MotionView
  4        <- type metadata accessor for MotionView type metadata accessor for MotionView
  4        -> MotionView.recursivelyTransformByAmount(distance:baseView:) MotionView.recursivelyTransformByAmount(distance:baseView:)
  4          -> MotionView.transformAmount.getter MotionView.transformAmount.getter
  4          <- MotionView.transformAmount.getter MotionView.transformAmount.getter
  4          -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4          -> type metadata accessor for UIView type metadata accessor for UIView
  4          <- type metadata accessor for UIView type metadata accessor for UIView
  4          -> Array.subscript.read          Array.subscript.read
  4          <- Array.subscript.read          Array.subscript.read
  4          -> type metadata accessor for MotionView type metadata accessor for MotionView
  4          <- type metadata accessor for MotionView type metadata accessor for MotionView
  4          -> MotionView.recursivelyTransformByAmount(distance:baseView:) MotionView.recursivelyTransformByAmount(distance:baseView:)
  4            -> MotionView.transformAmount.getter MotionView.transformAmount.getter
  4            <- MotionView.transformAmount.getter MotionView.transformAmount.getter
  4            -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            -> MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            <- MotionView.motionAmount.getter MotionView.motionAmount.getter
  4            -> type metadata accessor for UIView type metadata accessor for UIView
  4            <- type metadata accessor for UIView type metadata accessor for UIView
  4            -> outlined destroy of IndexingIterator<[UIView]> outlined destroy of IndexingIterator<[UIView]>
  4            <- outlined destroy of IndexingIterator<[UIView]> outlined destroy of IndexingIterator<[UIView]>
  




Scalar variables
标量变量

#!/usr/sbin/dtrace -s
#pragma D option quiet
dtrace:::BEGIN
{
    isSet = 0;
    object = 0;
}
objc$target:NSObject:-init:return / isSet == 0 /
{
    object = arg1;
    isSet = 1;
}
objc$target:::entry / isSet && object == arg0 /
{
    printf("0x%p %c[%s %s]\n", arg0, probefunc[0], probemod,
    (string)&probefunc[1]);
}


Clause-local variables 
子句局部变量
不需要释放
使用方式： this->

pid$target::objc_msgSend:entry
{
    this->object = arg0;
}
pid$target::objc_msgSend:entry / this->object != 0 / {
    /* Do some logic here */
}
obc$target:::entry {
    this-f = this->object; /* Won’t work since different probe */
}



Thread-local variables 
线程局部变量
最大灵活性，但牺牲了速度
需要手动释放
使用方式： self->
好处：可以在不同的探针中使用

objc$target:NSObject:init:entry {
    self->a = arg0; // 把 self->a 分配给正在被初始化的任何对象
}
objc$target::-dealloc:entry / arg0 == self->a / {
    self->a = 0; // 当这个对象被释放时，你需要释放 self->a
}



DTrace conditions
DTrace 条件
1. 三元运算符
2. 使用多个DTrace子句和一个谓词


// 追踪所有被-[UIViewController initWithNibName:bundle:]执行的Objective-C方法调用
#!/usr/sbin/dtrace -s
#pragma D option quiet
dtrace:::BEGIN
{
    trace = 0;
}
objc$target:target:UIViewController:-initWithNibName?bundle?:entry {
    trace = 1
}
objc$target:target:::entry / trace / {
    printf("%s\n", probefunc);
}
objc$target:target:UIViewController:-initWithNibName?bundle?:return {
    trace = 0
}




Inspecting process memory
检查进程内存

DTrace脚本在内核中执行，所以快，而且不需要改变已经编译好的程序中的任何代码来执行动态跟踪

// 负责文件打开读取的内核函数签名
int open_nocancel(const char *path, int flags, mode_t mode);
int open(const char *path, int oflag, ...);



// 下面的DTrace子句把第一个参数读成一个字符串
sudo dtrace -n 'syscall::open:entry { printf("%s", copyinstr(arg0)); }'


// 这将打印 open（或 open_nocancel）的内容以及调用 open* 系统调用的程序以及负责调用的用户态堆栈跟踪。
sudo dtrace -qn 'syscall::open*:entry { printf("%s opened %s\n", execname, copyinstr(arg0)); ustack(); }'


sudo dtrace -qn 'syscall::open*:entry / execname == "Finding Ray" / { printf("%s opened %s\n", execname, copyinstr(arg0)); ustack(); }'


// 追寻到Ray.pdf被打开的位置
sudo dtrace -qn 'syscall::open*:entry / execname == "Finding Ray" / { printf("%s opened %s\n", execname, copyinstr(arg0)); ustack(); }' 2>/dev/null | grep Ray.png -A40


sudo dtrace -qn 'syscall::open*:entry / execname == "Finding Ray" && strstr(copyinstr(arg0), "Ray.png") != NULL / { printf("%s opened %s\n", execname, copyinstr(arg0)); ustack(); }' 2>/dev/null





sudo dtrace -wn 'syscall::open*:entry / execname == "Finding Ray" && arg0 > 0xfffffffe && strstr(copyinstr(arg0), ".png") != NULL && strlen(copyinstr(arg0)) >= 32 / { this->a = "/Users/blf/Desktop/troll.png"; copyoutstr(this->a, arg0, 30); }'




// 查找电脑上的dtrace脚本
man -k dtrace