### NSTimer的缺点

1. 循环引用问题

   NSTimer会强引用target,同时RunLoop会强引用未invalidate的NSTimer实例。 容易导致内存泄露。

   (关于NSTimer引起的内存泄露可阅读[iOS夯实：ARC时代的内存管理](https://github.com/100mango/zen/blob/master/iOS夯实：ARC时代的内存管理/%23iOS夯实：ARC时代的内存管理.md) NSTimer一节）

2. RunLoop问题

   因为NSTimer依赖于RunLoop机制进行工作,因此需要注意RunLoop相关的问题。NSTimer默认运行于RunLoop的default mode中。

   而ScrollView在用户滑动时，主线程RunLoop会转到`UITrackingRunLoopMode`。而这个时候，Timer就不会运行,方法得不到fire。如果想要在ScrollView滚动的时候Timer不失效，需要注意将Timer设置运行于`NSRunLoopCommonModes`。

3. 线程问题

   NSTimer无法在子线程中使用。如果我们想要在子线程中执行定时任务，必须激活和自己管理子线程的RunLoop。否则NSTimer是失效的。

4. 不支持动态修改时间间隔

   NSTimer无法动态修改时间间隔，如果我们想要增加或减少NSTimer的时间间隔。只能invalidate之前的NSTimer，再重新生成一个NSTimer设定新的时间间隔。

5. 不支持闭包。

   NSTimer只支持调用`selector`,不支持更现代的闭包语法。

替换方案：https://github.com/100mango/zen/blob/master/%E6%89%93%E9%80%A0%E4%B8%80%E4%B8%AA%E4%BC%98%E9%9B%85%E7%9A%84Timer/make%20a%20timer.md

```swift
private var timer: DispatchSourceTimer?

func addTimer() {
     // 子线程创建timer
    timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    //        let timer = DispatchSource.makeTimerSource()
    /*
     dealine: 开始执行时间
     repeating: 重复时间间隔
     leeway: 时间精度
     */
    timer?.schedule(deadline: .now() + .seconds(5), repeating: DispatchTimeInterval.seconds(1), leeway: 		 			    DispatchTimeInterval.seconds(0))
          // t 
    timer?.resume()
}

// timer暂停
func stopTimer() {
    timer?.suspend()
}

// timer结束
func cancleTimer() {
    guard let t = timer else {
        return
    }
    t.cancel()
    timer = nil
}
```

