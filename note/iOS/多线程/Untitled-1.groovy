/*!
 * @function dispatch_queue_create
 *
 * @abstract
 * Creates a new dispatch queue to which blocks may be submitted.
 创建一个新的调度队列，区块可以被提交给它。
 *
 * @discussion
 * Dispatch queues created with the DISPATCH_QUEUE_SERIAL or a NULL attribute
 * invoke blocks serially in FIFO order.
 用DISPATCH_QUEUE_SERIAL或NULL属性创建的调度队列按FIFO顺序串行调用块。
 order : 顺序
 serial : 串行 （连续剧）
 *
 * Dispatch queues created with the DISPATCH_QUEUE_CONCURRENT attribute may
 * invoke blocks concurrently (similarly to the global concurrent queues, but
 * potentially with more overhead), and support barrier blocks submitted with
 * the dispatch barrier API, which e.g. enables the implementation of efficient
 * reader-writer schemes.
 * 使用 DISPATCH_QUEUE_CONCURRENT 属性创建的调度队列可以并发调用块（类似于全局并发队列，但可能有更多开销），并支持使用调度屏障 API 提交的屏障块，例如 能够实现高效的读写器方案。
 *
 * When a dispatch queue is no longer needed, it should be released with
 * dispatch_release(). Note that any pending blocks submitted asynchronously to
 * a queue will hold a reference to that queue. Therefore a queue will not be
 * deallocated until all pending blocks have finished.
 * 当不再需要调度队列时，应使用 dispatch_release() 释放它。 请注意，异步提交到队列的任何挂起块都将持有对该队列的引用。 因此，在所有挂起的块都完成之前，不会释放队列。
 *
 * Passing the result of the dispatch_queue_attr_make_with_qos_class() function
 * to the attr parameter of this function allows a quality of service class and
 * relative priority to be specified for the newly created queue.
 * The quality of service class so specified takes precedence over the quality
 * of service class of the newly created dispatch queue's target queue (if any)
 * as long that does not result in a lower QOS class and relative priority.
 * 将 dispatch_queue_attr_make_with_qos_class() 函数的结果传递给该函数的 attr 参数允许为新创建的队列指定服务质量等级和相对优先级。 如此指定的服务质量等级优先于新创建的调度队列的目标队列（如果有）的服务质量等级，只要不会导致较低的 QOS 等级和相对优先级。
 *
 * When no quality of service class is specified, the target queue of a newly
 * created dispatch queue is the default priority global concurrent queue.
 * 当没有指定服务质量等级时，新创建的调度队列的目标队列是默认优先级全局并发队列。
 *
 * @param label
 * A string label to attach to the queue.
 * This parameter is optional and may be NULL.
 * 要附加到队列的字符串标签。
 * 此参数是可选的，可以为 NULL。
 *
 * @param attr
 * A predefined attribute such as DISPATCH_QUEUE_SERIAL,
 * DISPATCH_QUEUE_CONCURRENT, or the result of a call to
 * a dispatch_queue_attr_make_with_* function.
 * 预定义的属性，例如 DISPATCH_QUEUE_SERIAL、DISPATCH_QUEUE_CONCURRENT，或调用 dispatch_queue_attr_make_with_* 函数的结果。
 *
 * @result
 * The newly created dispatch queue.
 * 新创建的调度队列。
 */