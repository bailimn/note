
### dispatch_semaphore
停车场剩余4个车位，那么即使同时来了四辆车也能停的下。如果此时来了五辆车，那么就有一辆需要等待。
信号量的值（signal）就相当于剩余车位的数目，dispatch_semaphore_wait 函数就相当于来了一辆车，dispatch_semaphore_signal 就相当于走了一辆车。停车位的剩余数目在初始化的时候就已经指明了（dispatch_semaphore_create（long value）），调用一次 dispatch_semaphore_signal，剩余的车位就增加一个；调用一次dispatch_semaphore_wait 剩余车位就减少一个；当剩余车位为 0 时，再来车（即调用 dispatch_semaphore_wait）就只能等待。有可能同时有几辆车等待一个停车位。有些车主没有耐心，给自己设定了一段等待时间，这段时间内等不到停车位就走了，如果等到了就开进去停车。而有些车主就像把车停在这，所以就一直等下去。

### 使用
``` objective-c
__block int theNumber = 0;

dispatch_semaphore_t signal = dispatch_semaphore_create(1);
dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);

//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 等待ing");
    // overTime 可以用 DISPATCH_TIME_FOREVER 代替
    dispatch_semaphore_wait(signal, overTime); //signal 值 -1
    NSLog(@"线程1");
    for (int i = 0; i < 10000000; ++i) {
        theNumber++;
    }
    dispatch_semaphore_signal(signal); //signal 值 +1
    NSLog(@"线程1 发送信号");
    NSLog(@"--------------------------------------------------------");
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 等待ing");
    dispatch_semaphore_wait(signal, overTime);
    NSLog(@"线程2");
    for (int i = 0; i < 10000000; ++i) {
        theNumber++;
    }
    dispatch_semaphore_signal(signal);
    NSLog(@"线程2 发送信号");
});

// theNumber如果不加锁 theNumber 结果不是循环次数的两倍

```

> dispatch_semaphore_create(1)： 传入值必须 >=0, 若传入为 0 则阻塞线程并等待timeout,时间到后会执行其后的语句
> dispatch_semaphore_wait(signal, overTime)：可以理解为 lock,会使得 signal 值 -1
> dispatch_semaphore_signal(signal)：可以理解为 unlock,会使得 signal 值 +1


#### 可能会遇到的问题
``` objective-c
// 创建一个ViewController实例，push 到 navigationController，
// 然后 pop，接着便触发了 crash，crash 调用栈的 top 操作是
// _dispatch_semaphore_dispose，看到如下有价值的提示信息：
// BUG IN CLIENT OF LIBDISPATCH: Semaphore object deallocated while in use
@implementation ViewController {
    dispatch_semaphore_t _semaphore;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    _semaphore = dispatch_semaphore_create(3);
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

@end
```
上述代码在逻辑非常简单，viewDidLoad里构建了一个初始值为 3 的 semaphore，之后的 P 操作使得 semaphore.count 减 1，似乎没啥毛病。

如何理解这个 crash 呢？一段懵逼时间之后，查处各种资料，最终在搞清楚了原因。

简单来说，当 semaphore 在被释放时，其值小于原来的初始值，则系统认为该资源仍然处于「in use」状态，对其进行 dispose 时就会报错...

### 解决方案1
使用dispatch_semaphore_create()创建 semaphore 时，传入 0 参数，然后使用dispatch_semaphore_signal将 semaphore.count 加到想要的值，即：
``` objective-c
_semaphore = dispatch_semaphore_create(0);
for (int i = 0; i < 3; ++i) {
    dispatch_semaphore_signal(_semaphore);
}
```

### 使用 dispatch_semaphore 实现互斥锁
如下简短代码基于 dispatch_semaphore 实现了互斥锁：
``` objective-c
@interface Lock : NSObject

- (void)lock;
- (void)unlock;

@end

@implementation Lock {
    dispatch_semaphore_t _semaphore;
}

- (instancetype)init {
    if (self = [super init]) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)lock {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
}

- (void)unlock {
    dispatch_semaphore_signal(_semaphore);
}

@end
```
P.S: 有空使用[这里](https://github.com/ibireme/tmp/blob/master/iOSLockBenckmark/iOSLockBenckmark/ViewController.m)的方法比较一下上述 Lock 和NSLock的性能。

P.P.S: 这种基于 dispatch_semaphore 的自定义 Lock 相较于NSLock有一个优点，即 lock 和 unlock 操作可以分别在不同的线程进行，而后者要求对NSLock的所有行为都得在同一个线程进行。

### 使用 dispatch_semaphore 实现互斥锁
https://zhangbuhuai.com/post/dispatch-semaphore.html
### 使用 dispatch_semaphore 实现读写锁
https://zhangbuhuai.com/post/dispatch-semaphore.html