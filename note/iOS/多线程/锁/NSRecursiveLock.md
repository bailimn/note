
recursive : 递归

这段代码是一个典型的死锁情况。在我们的线程中，RecursiveMethod 是递归调用的。所以每次进入这个 block 时，都会去加一次锁，而从第二次开始，由于锁已经被使用了且没有解锁，所以它需要等待锁被解除，这样就导致了死锁，线程被阻塞住了。

将 NSLock 替换为 NSRecursiveLock：

``` objective-c
NSLock *rLock = [NSLock new];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    static void (^RecursiveBlock)(int);
    RecursiveBlock = ^(int value) {
        [rLock lock];
        if (value > 0) {
            NSLog(@"线程%d", value);
            RecursiveBlock(value - 1);
        }
        [rLock unlock];
    };
    RecursiveBlock(4);
});
```