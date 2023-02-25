condition : 状态

- 封装 pthread_mutex (cond)
  
### 唤醒一个等待线程
``` objective-c
NSCondition *cLock = [NSCondition new];
  //线程1
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [cLock lock];
      NSLog(@"线程1加锁成功");
      [cLock wait];
      NSLog(@"线程1");
      [cLock unlock];
  });

  //线程2
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [cLock lock];
      NSLog(@"线程2加锁成功");
      [cLock wait];
      NSLog(@"线程2");
      [cLock unlock];
  });

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      sleep(2);
      NSLog(@"唤醒一个等待的线程");
      [cLock signal];
  });
  
  /*
   2021-11-02 15:29:09.322927+0800 TestThread[33380:1106000] 线程1加锁成功
   2021-11-02 15:29:09.323182+0800 TestThread[33380:1106001] 线程2加锁成功
   2021-11-02 15:29:11.323263+0800 TestThread[33380:1106008] 唤醒一个等待的线程
   2021-11-02 15:29:11.323946+0800 TestThread[33380:1106000] 线程1
   */
```


### 唤醒所有等待的线程
``` objective-c
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    sleep(2);
    NSLog(@"唤醒所有等待的线程");
    [cLock broadcast];
});
/*
   2021-11-02 15:29:09.322927+0800 TestThread[33380:1106000] 线程1加锁成功
   2021-11-02 15:29:09.323182+0800 TestThread[33380:1106001] 线程2加锁成功
   2021-11-02 15:29:11.323263+0800 TestThread[33380:1106008] 唤醒一个等待的线程
   2021-11-02 15:29:11.323946+0800 TestThread[33380:1106000] 线程1
   2021-11-02 15:29:11.323946+0800 TestThread[33380:1106000] 线程2
   */
```