``` objective-c
NSConditionLock *cLock = [[NSConditionLock alloc] initWithCondition:0];

//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    if([cLock tryLockWhenCondition:0]){
        NSLog(@"线程1");
        [cLock unlockWithCondition:1];
    }else{
            NSLog(@"失败");
    }
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lockWhenCondition:3];
    NSLog(@"线程2");
    [cLock unlockWithCondition:2];
});

//线程3
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lockWhenCondition:1];
    NSLog(@"线程3");
    [cLock unlockWithCondition:3];
});

/*
    2021-11-02 15:53:57.164135+0800 TestThread[33788:1129598] 线程1
    2021-11-02 15:53:57.164356+0800 TestThread[33788:1129597] 线程3
    2021-11-02 15:53:57.164523+0800 TestThread[33788:1129596] 线程2
    */
```

- 我们在初始化 NSConditionLock 对象时，给了他的标示为 0
- 执行 tryLockWhenCondition:时，我们传入的条件标示也是 0,所 以线程1 加锁成功
- 执行 unlockWithCondition:时，这时候会把condition由 0 修改为 1
- 因为condition 修改为了 1， 会先走到 线程3，然后 线程3 又将 condition 修改为 3
- 最后 走了 线程2 的流程
  

> 从上面的结果我们可以发现，NSConditionLock 还可以实现任务之间的依赖。