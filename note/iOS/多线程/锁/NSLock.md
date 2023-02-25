- NSLock是使用了pthread_mutex_t封装的互斥锁
- lock 和 unlock 操作必须在同一个线程中执行

``` objectivec
for (int i = 0; i < 200000; i++) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.mArray = [NSMutableArray array];
    });
}

// 运行该程序会崩溃，这是因为，我们在不断地创建array，
// mArray在不断的赋新值，释放旧值，这个时候多线程操作
// 就会可能存在值已经被释放了，而其他线程还在操作，此时
// 就会发生崩溃。此时就需要我们对程序加锁。将上述程序改
// 成如下：

NSLock *lock = [[NSLock alloc] init];
for (int i = 0; i < 200000; i++) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lock];
        self.mArray = [NSMutableArray array];
        [lock unlock];
    });
}
```

``` objectivec
- (void)test3 {
    NSLock *lock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"进入线程1 : %@", [NSThread currentThread]);
        sleep(5);
        [lock lock];
        NSLog(@"执行任务1");
        [lock unlock];
        NSLog(@"退出线程1");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"进入线程2 : %@", [NSThread currentThread]);
        [lock lock];
        sleep(10);
        NSLog(@"执行任务2");
        [lock unlock];
        NSLog(@"退出线程2");
    });
    
    /*
     2021-10-29 15:24:14.269133+0800 TestThread[28039:1709059] 进入线程2 : <NSThread: 0x600003cd2600>{number = 3, name = (null)}
     2021-10-29 15:24:14.269147+0800 TestThread[28039:1709063] 进入线程1 : <NSThread: 0x600003c80100>{number = 6, name = (null)}
     2021-10-29 15:24:24.273077+0800 TestThread[28039:1709059] 执行任务2
     2021-10-29 15:24:24.273529+0800 TestThread[28039:1709059] 退出线程2
     2021-10-29 15:24:24.273541+0800 TestThread[28039:1709063] 执行任务1
     2021-10-29 15:24:24.273980+0800 TestThread[28039:1709063] 退出线程1
     */
}
```

> lock、unlock：不多做解释，和上面一样
trylock：能加锁返回 YES 并执行加锁操作，相当于 lock，反之返回 NO
** lockBeforeDate：这个方法表示会在传入的时间内尝试加锁，若能加锁则执行加锁**操作并返回 YES，反之返回 NO


### lockBeforDate
``` objective-c
NSLock *lock = [NSLock new];
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 尝试加速ing...");
    [lock lock];
    sleep(3);//睡眠5秒
    NSLog(@"线程1");
    [lock unlock];
    NSLog(@"线程1解锁成功");
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 尝试加速ing...");
    BOOL x =  [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
    if (x) {
        NSLog(@"线程2");
        [lock unlock];
    }else{
        NSLog(@"失败");
    }
});
```