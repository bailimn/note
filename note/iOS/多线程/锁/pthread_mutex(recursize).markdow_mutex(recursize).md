经过上面几种例子，我们可以发现：加锁后只能有一个线程访问该对象，后面的线程需要排队，并且 lock 和 unlock 是对应出现的，同一线程多次 lock 是不允许的，而递归锁允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作。

``` objective-c
static pthread_mutex_t pLock;
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
pthread_mutex_init(&pLock, &attr);
pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用

//1.线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    static void (^RecursiveBlock)(int);
    RecursiveBlock = ^(int value) {
        pthread_mutex_lock(&pLock);
        if (value > 0) {
            NSLog(@"value: %d", value);
            RecursiveBlock(value - 1);
        }
        pthread_mutex_unlock(&pLock);
    };
    RecursiveBlock(5);
});

/*
    2021-11-02 15:17:29.186195+0800 TestThread[33193:1093812] value: 5
    2021-11-02 15:17:29.186348+0800 TestThread[33193:1093812] value: 4
    2021-11-02 15:17:29.186463+0800 TestThread[33193:1093812] value: 3
    2021-11-02 15:17:29.186563+0800 TestThread[33193:1093812] value: 2
    2021-11-02 15:17:29.186666+0800 TestThread[33193:1093812] value: 1
    */
```

> 上面的代码如果我们用 pthread_mutex_init(&pLock, NULL) 初始化会出现死锁的情况，递归锁能很好的避免这种情况的死锁；