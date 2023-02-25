```swift
let group = DispatchGroup()
let global = DispatchQueue.global()
global.async(group: group, qos: .default, flags: []) {
    print("任务1 开始执行")
    sleep(1)
    print("任务1 结束执行")
}

global.async(group: group, qos: .default, flags: []) {
    print("任务2 开始执行")
    sleep(2)
    print("任务2 结束执行")
}

global.async(group: group, qos: .default, flags: []) {
    print("任务3 开始执行")
    sleep(4)
    print("任务3 结束执行")
}

group.notify(queue: global) {
    print("回到该队列中执行")
}

/*
 14:01:38 +0000 | 任务2 开始执行
 14:01:38 +0000 | 任务1 开始执行
 14:01:38 +0000 | 任务3 开始执行
 14:01:39 +0000 | 任务1 结束执行
 14:01:40 +0000 | 任务2 结束执行
 14:01:42 +0000 | 任务3 结束执行
 14:01:42 +0000 | 回到该队列中执行
 */
```

### wait方法

```swift
let group = DispatchGroup()
let global = DispatchQueue.global()
global.async(group: group, qos: .default, flags: [], execute: {
    print("任务1 开始执行")
    sleep(1)
    print("任务1 结束执行")
})
global.async(group: group, qos: .default, flags: [], execute: {
    print("任务2 开始执行")
    sleep(6)
    print("任务2 结束执行")
})

// 等待上面任务执行，会阻塞当前线程，到了 timeout 的时间，任务2继续执行。可以无限等待 .distantFuture
let result = group.wait(timeout: .now() + 2.0)
switch result {
case .success:
    print("不超时, 上面的两个任务都执行完")
case .timedOut:
    print("超时了, 上面的任务还没执行完执行这了")
}

print("接下来的操作")

/*
 14:25:39 +0000 | 任务1 开始执行
 14:25:39 +0000 | 任务2 开始执行
 14:25:40 +0000 | 任务1 结束执行
 14:25:41 +0000 | 超时了, 上面的任务还没执行完执行这了
 14:25:41 +0000 | 接下来的操作
 14:25:45 +0000 | 任务2 结束执行
 */
```



### enter leave 手动管理group计数,enter和leave必须配对

```swift
let group = DispatchGroup()
let global = DispatchQueue.global()

group.enter()//把该任务添加到组队列中执行
global.async(group: group, qos: .default, flags: [], execute: {
    print("任务1 开始执行")
    sleep(3)
    print("任务1 结束执行")
    group.leave()
})

group.enter()//把该任务添加到组队列中执行
global.async(group: group, qos: .default, flags: [], execute: {
    print("任务2 开始执行")
    sleep(1)
    print("任务2 结束执行")
    group.leave()
})

//当上面所有的任务执行完之后通知
group.notify(queue: .main) {
    print("所有的任务执行完了")
}

/*
 14:23:54 +0000 | 任务1 开始执行
 14:23:54 +0000 | 任务2 开始执行
 14:23:55 +0000 | 任务2 结束执行
 14:23:57 +0000 | 任务1 结束执行
 14:23:57 +0000 | 所有的任务执行完了
 */
```

### 实际用例

这次遇到的是一个循环网络请求的功能（怎么老是遇上这种蛋疼的API），要求本地存储的数组里循环取出存储对象，并使用存储对象的属性做参数，POST请求。然后将每次请求下来的数据进行累加计算，最后赋值。上代码：

```swift
func sumTheassets(compHandler:@escaping (_ sum:Float)->()) {
    var asset:Float = 0
    let group = DispatchGroup() //创建group
    for object in objects {  //for循环便利本地存储的数组数据
        group.enter() // 将以下任务添加进group
        let cellViewmodel = MyassetsCellViewModel() // 创建VM对象，并调用网络请求函数
        cellViewmodel.getThepriceFromnew(symbol: object.symbol, compHandler: { (price, ratio) in
            let decimals = Float(object.decimals) // 获取数量，转为Float型
            let num = price * decimals! //计算总价格  单价 * 数量
            asset += num //将计算结果累加
            group.leave() //本次任务完成（即本次for循环任务完成），将任务从group中移除
        })
    }
    group.notify(queue: .main) {  // group中的所有任务完成后再主线程中调用回调函数，将结果传出去
        compHandler(asset)  //在回调里将累加结果传出去
    }
}
```

