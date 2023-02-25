### 两个概念
- 任务(Task): 你需要执行的操作
- 队列(Queue): 存放任务的容器

### 两个函数
- dispatch_async(dispatch_queue_t  _Nonnull queue, ^(void)block)
- dispatch_sync(dispatch_queue_t  _Nonnull queue, ^(void)block)

这两个函数中均需要填入两个参数, 一个是队列, 一个是任务, 任务就是封装在block代码块中的. 所以, 我们在使用以上两个函数时, 只需要创建队列,将任务（block）添加进指定的队列中。并根据是否为sync决定调用该函数的线程是否需要阻塞。

> 这里调用该函数的线程并不执行参数中指定的任务（block块），任务的执行者是GCD分配给任务所在队列的线程。调用dispatch_sync和dispatch_async的线程，并不一定是任务（block块）的执行者。

### 同步执行和异步执行有什么区别呢?
- 同步执行：比如这里的dispatch_sync，这个函数会把一个block加入到指定的队列中，而且会一直等到执行完blcok，这个函数才返回。因此在block执行完之前，调用dispatch_sync方法的线程是阻塞的。

- 异步执行：一般使用dispatch_async，这个函数也会把一个block加入到指定的队列中，但是和同步执行不同的是，这个函数把block加入队列后不等block的执行就立刻返回了。

### 另外, 还有一点需要明确的是
- 同步执行没有开启新线程的能力, 所有的任务都只能在当前线程执行
- 异步执行有开启新线程的能力, 但是, 有开启新线程的能力, 也不一定会利用这种能力, 也就是说, 异步执行是否开启新线程, 需要具体问题具体分析



### 1. 任务与队列
#### 1.1 任务
- 同步执行：阻塞当前线程并等待 Block 中的任务执行完成，然后当前线程才会继续往后执行。不具备开启新线程的能力。
- 异步执行：不阻塞当前线程，当前线程直接往后执行。具备开启新线程的能力，但不一定会开启新线程。


#### 1.2 队列
任务存放在队列中。队列是一种特殊的线性表，采用先进先出（FIFO）的规则。
- 串行队列中的任务按照 FIFO 的顺序取出并执行，前一个任务执行完才会取出下一个。
- 并行队列中的任务也是按照 FIFO 的顺序取出，但是 GCD 会开启新的线程来执行取出的任务。
  
### 2、使用 GCD
#### 2.1 创建队列
**主队列（Main Dispatch Queue）**
- 串行队列
``` objective-c
/// 获取主队列
dispatch_queue_t mainQueue = dispatch_get_main_queue();
/// swift
DispatchQueue.main.async{}
```

**全局队列（Global Dispatch Queue）**
- 并发队列

``` objective-c
/*
 * @function: dispatch_get_global_queue
 * @abstract: 获取全局队列
 * @para identifier
        队列优先级，一般使用 DISPATCH_QUEUE_PRIORITY_DEFAULT。
 * @para flags
        保留参数，传 0。传递除零以外的任何值都可能导致返回值为 NULL。
 * @result: 返回指定的队列，若失败则返回 NULL
 */
dispatch_queue_global_t 
dispatch_get_global_queue(long identifier, unsigned long flags);

// 获取 默认优先级 的全局队列
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
```

**自定义队列**
``` objective-c
/*
 * @funcion: dispatch_queue_create
 * @abstract: 创建自定义队列
 * @para label
        队列标签，可以为 NULL。
 * @para attr
        队列类型，串行队列还是并行队列，DISPATCH_QUEUE_SERIAL 与 NULL 表示串行队列，DISPATCH_QUEUE_CONCURRENT 表示并行队列。
 * @result: 返回创建好的队列。
 */
dispatch_queue_t
dispatch_queue_create(const char *_Nullable label, dispatch_queue_attr_t _Nullable attr);

```
- DISPATCH_QUEUE_SERIAL
- DISPATCH_QUEUE_CONCURRENT

#### 2.2 创建任务
- dispatch_sync 会阻塞当前线程。
- dispatch_async 不会阻塞当前线程。
  
#### 2.3 组合任务与队列

|      | 串行队列           | 并行队列                 | 主队列           |
|------|----------------|----------------------|---------------|
| 同步执行 | 不开启新线程，串行执行任务  | 不开启新线程，串行执行任务        | 死锁            |
| 异步执行 | 开启一条新线程，串行执行任务 | 开启新线程（可能会有多条），并发执行任务 | 不开启新线程，串行执行任务 |


- 同步执行 + 串行队列 = 死锁
- 同步执行 + 主队列 = 死锁

#### 2.4 延迟执行 dispatch_after
**优点：**
- dispatch_after 比 NSTimer 优秀，因为他不需要指定 Runloop 的运行模式。
- dispatch_after 比 NSObject.performSelector:withObject:afterDelay: 优秀，因为它不需要 Runloop 支持。

**缺点：**
- 但是请注意，dispatch_after 并不是在指定时间后执行任务，而是在指定时间之后才将任务提交到队列中。所以，这个延迟的时间是不精确的。这是缺点之一。
- 第二个缺点便是，dispatch_after 延后执行的 Block 无法直接取消。但是 [Dispatch-Cancel](https://github.com/Spaceman-Labs/Dispatch-Cancel) 提供了一种解决方案。


``` objective-c
NSLog(@"开始执行 dispatch_after");
    
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSLog(@"三秒后");
});
```

#### 2.5 单次执行 dispatch_once
``` objective-c
static TheClass *instance = nil;
+ (instance)sharedInstance 
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TheClass alloc] init];
    });
    
    return instance;
}
```

#### 2.6 并发迭代 dispatch_apply
适用于迭代非常大的集合
``` objective-c
dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
    NSLog(@"dispatch_apply --- %zu --- %@", index, [NSThread currentThread]);
});

/*
 2021-11-02 19:39:32.750636+0800 TestThread[37196:1334081] dispatch_apply --- 6 --- <_NSMainThread: 0x600002e5c7c0>{number = 1, name = main}
 2021-11-02 19:39:32.750728+0800 TestThread[37196:1334290] dispatch_apply --- 2 --- <NSThread: 0x600002e61ec0>{number = 4, name = (null)}
 2021-11-02 19:39:32.750730+0800 TestThread[37196:1334331] dispatch_apply --- 7 --- <NSThread: 0x600002e32700>{number = 10, name = (null)}
 2021-11-02 19:39:32.750732+0800 TestThread[37196:1334288] dispatch_apply --- 4 --- <NSThread: 0x600002e0f780>{number = 8, name = (null)}
 2021-11-02 19:39:32.750735+0800 TestThread[37196:1334287] dispatch_apply --- 0 --- <NSThread: 0x600002e61f00>{number = 5, name = (null)}
 2021-11-02 19:39:32.750736+0800 TestThread[37196:1334286] dispatch_apply --- 1 --- <NSThread: 0x600002e1ec80>{number = 7, name = (null)}
 2021-11-02 19:39:32.750733+0800 TestThread[37196:1334289] dispatch_apply --- 3 --- <NSThread: 0x600002e089c0>{number = 2, name = (null)}
 2021-11-02 19:39:32.750737+0800 TestThread[37196:1334296] dispatch_apply --- 5 --- <NSThread: 0x600002e13400>{number = 9, name = (null)}
 2021-11-02 19:39:32.750815+0800 TestThread[37196:1334081] dispatch_apply --- 8 --- <_NSMainThread: 0x600002e5c7c0>{number = 1, name = main}
 2021-11-02 19:39:32.750850+0800 TestThread[37196:1334290] dispatch_apply --- 9 --- <NSThread: 0x600002e61ec0>{number = 4, name = (null)}
 */
```

#### 2.7 栅栏方法 dispatch_barrier_async

需求：异步执行两组任务，但第二组任务需要第一组完成之后才能执行。

``` objective-c
NSLog(@"当前线程 -- %@", [NSThread currentThread]);
        
dispatch_queue_t theConcurrentQueue = dispatch_queue_create("com.junes.serial.queue", DISPATCH_QUEUE_CONCURRENT);

dispatch_queue_t theQueue = theConcurrentQueue;

dispatch_async(theQueue, ^{
    NSLog(@"任务1 开始");
    // 模拟耗时任务
    [NSThread sleepForTimeInterval:2];
    
    NSLog(@"任务1 完成");
});

dispatch_async(theQueue, ^{
    NSLog(@"任务2 开始");
    // 模拟耗时任务
    [NSThread sleepForTimeInterval:1];
    
    NSLog(@"任务2 完成");
});

dispatch_barrier_async(theQueue, ^{
    NSLog(@"==================  栅栏任务 ==================");
});

dispatch_async(theQueue, ^{
    NSLog(@"任务3 开始");
    // 模拟耗时任务
    [NSThread sleepForTimeInterval:4];
    
    NSLog(@"任务3 完成");
});
dispatch_async(theQueue, ^{
    NSLog(@"任务4 开始");
    // 模拟耗时任务
    [NSThread sleepForTimeInterval:3];
    
    NSLog(@"任务4 完成");
});

/*
 2021-11-02 20:02:47.742137+0800 TestThread[56036:1397712] 当前线程 -- <_NSMainThread: 0x6000007780c0>{number = 1, name = main}
 2021-11-02 20:02:47.742395+0800 TestThread[56036:1397929] 任务1 开始
 2021-11-02 20:02:47.742401+0800 TestThread[56036:1397930] 任务2 开始
 2021-11-02 20:02:48.742878+0800 TestThread[56036:1397930] 任务2 完成
 2021-11-02 20:02:49.747631+0800 TestThread[56036:1397929] 任务1 完成
 2021-11-02 20:02:49.747854+0800 TestThread[56036:1397929] ==================  栅栏任务 ==================
 2021-11-02 20:02:49.748017+0800 TestThread[56036:1397929] 任务3 开始
 2021-11-02 20:02:49.748025+0800 TestThread[56036:1397928] 任务4 开始
 2021-11-02 20:02:52.752378+0800 TestThread[56036:1397928] 任务4 完成
 2021-11-02 20:02:53.752218+0800 TestThread[56036:1397929] 任务3 完成
 */
```


| ****                     | **主队列**  | **自定义串行队列** | **全局并行队列**                   | **自定义并行队列**                                           |
|--------------------------|----------|-------------|------------------------------|-------------------------------------------------------|
| dispatch\_barrier\_async | 串行队列毫无意义 | 串行队列毫无意义    | 相当于 dispatch\_async，无法达成栅栏目的 | 在之前和之后的任务之间加一道栅栏，栅栏任务在之前的所有任务完成之后开始执行，完成之后恢复队列原本的工作状态 |
| dispatch\_barrier\_sync  | 死锁       | 串行执行任务      |                              |                                                       |


结论：自定义并行队列 是栅栏方法的好帮手


#### 2.8 调度组 dispatch_group_t

需求：分别异步执行几个耗时任务，然后当几个耗时任务都执行完毕后再回到主线程执行任务。

- Dispatch Group 会在整个组的任务全部完成时通知开发者。这些任务可以使同步的，也可以是异步的，甚至可以再不同队列。
- dispatch_group_enter 和 dispatch_group_leave 需要成对出现
- dispatch_group_async 的任务会顺序执行


``` objective-c
/// 创建一个调度组
dispatch_group_t group = dispatch_group_create();

dispatch_queue_t theGlobalQueue = dispatch_get_global_queue(0, 0);
dispatch_queue_t theSerialQueue = dispatch_queue_create("com.junes.serial.queue", DISPATCH_QUEUE_CONCURRENT);
dispatch_queue_t theConcurrentQueue = dispatch_queue_create("com.junes.serial.queue", DISPATCH_QUEUE_CONCURRENT);

/// 将任务丢进调度组
dispatch_group_async(group, theGlobalQueue, ^{
    NSLog(@"任务1 开始 +++++++");
    
    /// 模拟耗时操作
    sleep(2);
    
    NSLog(@"任务1 完成 -----------------");
});

dispatch_group_async(group, theSerialQueue, ^{
    NSLog(@"任务2 开始 +++++++");
    
    /// 模拟耗时操作
    sleep(4);
    
    NSLog(@"任务2 完成 -----------------");
});

dispatch_group_async(group, theConcurrentQueue, ^{
    NSLog(@"任务3 开始 +++++++");
    dispatch_group_enter(group);
    /// 模拟异步网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        
        NSLog(@"任务3 完成 -----------------");
        dispatch_group_leave(group);
    });
});


dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    NSLog(@"所有任务都完成了。。。");
});

NSLog(@"dispatch_group_notify 为异步执行，并不会阻塞线程。我就是证据");

/*
 2021-11-02 20:45:28.524047+0800 TestThread[57938:1440954] 任务3 开始 +++++++
 2021-11-02 20:45:28.524052+0800 TestThread[57938:1440763] dispatch_group_notify 为异步执行，并不会阻塞线程。我就是证据
 2021-11-02 20:45:28.524051+0800 TestThread[57938:1440958] 任务1 开始 +++++++
 2021-11-02 20:45:28.524080+0800 TestThread[57938:1440955] 任务2 开始 +++++++
 2021-11-02 20:45:30.528357+0800 TestThread[57938:1440958] 任务1 完成 -----------------
 2021-11-02 20:45:32.525794+0800 TestThread[57938:1440955] 任务2 完成 -----------------
 2021-11-02 20:45:33.527243+0800 TestThread[57938:1440954] 任务3 完成 -----------------
 2021-11-02 20:45:33.527513+0800 TestThread[57938:1440763] 所有任务都完成了。。。
 */
```

**dispatch_group_wait**
``` objective-c
/// 创建一个调度组
dispatch_group_t group = dispatch_group_create();

dispatch_queue_t theGlobalQueue = dispatch_get_global_queue(0, 0);
dispatch_queue_t theSerialQueue = dispatch_queue_create("com.junes.serial.queue", DISPATCH_QUEUE_CONCURRENT);
dispatch_queue_t theConcurrentQueue = dispatch_queue_create("com.junes.serial.queue", DISPATCH_QUEUE_CONCURRENT);

/// 将任务丢进调度组
dispatch_group_async(group, theGlobalQueue, ^{
    NSLog(@"任务1 开始 +++++++");
    
    /// 模拟耗时操作
    sleep(2);
    
    NSLog(@"任务1 完成 -----------------");
});

dispatch_group_async(group, theSerialQueue, ^{
    NSLog(@"任务2 开始 +++++++");
    
    /// 模拟耗时操作
    sleep(4);
    
    NSLog(@"任务2 完成 -----------------");
});

dispatch_group_async(group, theConcurrentQueue, ^{
    NSLog(@"任务3 开始 +++++++");
    dispatch_group_enter(group);
    /// 模拟异步网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        
        NSLog(@"任务3 完成 -----------------");
        dispatch_group_leave(group);
    });
});

NSLog(@"dispatch_group_wait 即将囚禁线程");

/// 传入指定调度组，与超时时间（DISPATCH_TIME_FOREVER 代表永不超时，DISPATCH_TIME_NOW 代表立马超时，完全搞不懂这个有什么用）。
dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

NSLog(@"dispatch_group_wait 释放了线程");

dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    NSLog(@"所有任务都完成了。。。");
});

NSLog(@"dispatch_group_notify 为异步执行，并不会阻塞线程。我就是证据");

/*
DISPATCH_TIME_FOREVER

 2021-11-03 09:37:15.932318+0800 TestThread[67406:1847748] dispatch_group_wait 即将囚禁线程
 2021-11-03 09:37:15.932322+0800 TestThread[67406:1848060] 任务1 开始 +++++++
 2021-11-03 09:37:15.932331+0800 TestThread[67406:1848061] 任务2 开始 +++++++
 2021-11-03 09:37:15.932333+0800 TestThread[67406:1848059] 任务3 开始 +++++++
 2021-11-03 09:37:17.934285+0800 TestThread[67406:1848060] 任务1 完成 -----------------
 2021-11-03 09:37:19.936294+0800 TestThread[67406:1848061] 任务2 完成 -----------------
 2021-11-03 09:37:20.934744+0800 TestThread[67406:1848059] 任务3 完成 -----------------
 2021-11-03 09:37:20.935312+0800 TestThread[67406:1847748] dispatch_group_wait 释放了线程
 2021-11-03 09:37:20.935807+0800 TestThread[67406:1847748] dispatch_group_notify 为异步执行，并不会阻塞线程。我就是证据
 2021-11-03 09:37:21.116150+0800 TestThread[67406:1847748] 所有任务都完成了。。。
 */

/*
DISPATCH_TIME_NOW

 2021-11-03 09:38:10.180625+0800 TestThread[67423:1849462] dispatch_group_wait 即将囚禁线程
 2021-11-03 09:38:10.180628+0800 TestThread[67423:1849622] 任务1 开始 +++++++
 2021-11-03 09:38:10.180628+0800 TestThread[67423:1849624] 任务2 开始 +++++++
 2021-11-03 09:38:10.180638+0800 TestThread[67423:1849627] 任务3 开始 +++++++
 2021-11-03 09:38:10.180763+0800 TestThread[67423:1849462] dispatch_group_wait 释放了线程
 2021-11-03 09:38:10.180864+0800 TestThread[67423:1849462] dispatch_group_notify 为异步执行，并不会阻塞线程。我就是证据
 2021-11-03 09:38:12.184311+0800 TestThread[67423:1849622] 任务1 完成 -----------------
 2021-11-03 09:38:14.184136+0800 TestThread[67423:1849624] 任务2 完成 -----------------
 2021-11-03 09:38:15.183358+0800 TestThread[67423:1849627] 任务3 完成 -----------------
 2021-11-03 09:38:15.183535+0800 TestThread[67423:1849462] 所有任务都完成了。。。
 */

```

#### 2.9 信号量 dispatch_semaphore_t

一种锁

#### 2.10 调度资源 dispatch_source
最常用于定时器

