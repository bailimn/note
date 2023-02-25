### 第三方

RSKPlaceholderTextView：https://github.com/ruslanskorb/RSKPlaceholderTextView

layoutSubviews对subviews重新布局

layoutSubviews方法调用先于drawRect

setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews

layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的

 layoutIfNeeded遍历的不是superview链，应该是subviews链

drawRect是对receiver的重绘，能获得context

setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘



```swift
/* Geometry used to provide, for example, a correction rect. */
/* 用来提供例如修正矩形的几何图形。*/

// Returns a rectangle to draw the caret at a specified insertion point.
// 返回一个矩形，在指定的插入点画出光标。

// caret 插入符号
open override func caretRect(for position: UITextPosition) -> CGRect {
```

``` swift
// return 'best' size to fit given size. does not actually resize view. Default is return existing view size
// 返回适合给定尺寸的'最佳'尺寸。实际上并不调整视图的尺寸。默认是返回现有的视图尺寸。

// Asks the view to calculate and return the size that best fits the specified size.
// 要求视图计算并返回最适合指定尺寸的尺寸。

/********** Parameters */
// The size for which the view should calculate its best-fitting size.
// 视图应计算其最适合的尺寸。

/********** Return Value */
// A new size that fits the receiver’s subviews.
// 一个适合接收器的子视图的新尺寸。

/********** Discussion */
// The default implementation of this method returns the existing size of the view. Subclasses can override this method to return a custom value based on the desired layout of any subviews. For example, a UISwitch object returns a fixed size value that represents the standard size of a switch view, and a UIImageView object returns the size of the image it is currently displaying.
// 该方法的默认实现返回视图的现有尺寸。子类可以覆盖此方法，根据任何子视图的期望布局返回一个自定义值。例如，UISwitch对象返回一个固定的尺寸值，代表一个开关视图的标准尺寸，UIImageView对象返回它当前显示的图像的尺寸。

// This method does not resize the receiver.
// 这个方法不会调整接收器的大小。

open override func sizeThatFits(_ size: CGSize) -> CGSize {
```

``` swift
// calls sizeThatFits: with current view bounds and changes bounds size.
// 调用sizeThatFits:与当前视图的边界，并改变边界的大小。

/** Discussion 
Call this method when you want to resize the current view so that it uses the most appropriate amount of space. Specific UIKit views resize themselves according to their own internal needs. In some cases, if a view does not have a superview, it may size itself to the screen bounds. Thus, if you want a given view to size itself to its parent view, you should add it to the parent view before calling this method.

You should not override this method. If you want to change the default sizing information for your view, override the sizeThatFits(_:) instead. That method performs any needed calculations and returns them to this method, which then makes the change.

当你想调整当前视图的大小，使其使用最合适的空间时，调用此方法。特定的UIKit视图会根据自己的内部需要调整自己的大小。在某些情况下，如果一个视图没有一个超级视图，它可能会将自己的大小调整到屏幕的边界。因此，如果你想让一个给定的视图根据它的父视图来调整自己的大小，你应该在调用这个方法之前把它添加到父视图中。

你不应该重写这个方法。如果你想改变视图的默认尺寸信息，请覆盖sizeThatFits(_:)来代替。该方法会执行任何需要的计算并将其返回给该方法，然后由该方法进行更改。
*/

// 调用该方法会触发 sizeThatFits
open override func sizeToFit() {
```



``` swift
// translates Autoresizing Mask Into Constraints
// 将自动调整大小的掩码翻译成约束条件

// A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
// 一个布尔值，决定视图的自动调整大小掩码是否被转化为自动布局约束。

/** Discussion
If this property’s value is true, the system creates a set of constraints that duplicate the behavior specified by the view’s autoresizing mask. This also lets you modify the view’s size and location using the view’s frame, bounds, or center properties, allowing you to create a static, frame-based layout within Auto Layout.

Note that the autoresizing mask constraints fully specify the view’s size and position; therefore, you cannot add additional constraints to modify this size or position without introducing conflicts. If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false, and then provide a non ambiguous, nonconflicting set of constraints for the view.

By default, the property is set to true for any view you programmatically create. If you add views in Interface Builder, the system automatically sets this property to false.

如果这个属性的值为真，系统就会创建一组约束，重复视图的自动调整大小掩码所指定的行为。这也允许你使用视图的框架、边界或中心属性来修改视图的大小和位置，允许你在自动布局中创建一个静态的、基于框架的布局。

请注意，自动调整大小的遮罩约束完全指定了视图的大小和位置；因此，如果不引入冲突，就不能添加额外的约束来修改这个大小或位置。如果你想使用自动布局来动态计算视图的大小和位置，你必须将此属性设置为false，然后为视图提供一套不含糊、不冲突的约束。

默认情况下，对于你以编程方式创建的任何视图，该属性都被设置为true。如果你在Interface Builder中添加视图，系统会自动将该属性设置为false。
*/
var translatesAutoresizingMaskIntoConstraints: Bool { get set }

```



``` swift
// The inset of the text container's layout area within the text view's content area.
// 文本容器的布局区域在文本视图的内容区域中的嵌入。

/** Discussion
This property provides text margins for text laid out in the text view. By default the value of this property is (8, 0, 8, 0).
此属性为文本视图中布置的文本提供文本边距。默认情况下，该属性的值为（8, 0, 8, 0）。
*/
var textContainerInset: UIEdgeInsets { get set }
```





### layoutSubviews在以下情况下会被调用：

1、init初始化不会触发layoutSubviews

  但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发

2、addSubview会触发layoutSubviews

3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化

4、滚动一个UIScrollView会触发layoutSubviews

5、旋转Screen会触发父UIView上的layoutSubviews事件

6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

在苹果的官方文档中强调:

   You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.

 layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。

反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。

 刷新子对象布局

-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
-setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
-layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）

如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局

在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]

重绘

-drawRect:(CGRect)rect方法：重写此方法，执行重绘任务
-setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
-setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘

 

sizeToFit会自动调用sizeThatFits方法；

sizeToFit不应该在子类中被重写，应该重写sizeThatFits

sizeThatFits传入的参数是receiver当前的size，返回一个适合的size

sizeToFit可以被手动直接调用

sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己