### setLineJoin(_:)

Sets the style for the joins of connected lines in a graphics context.

设置图形上下文中的连接线的样式。

``` swift
// A line join value—CGLineJoin.miter (the default), CGLineJoin.round, or CGLineJoin.bevel. See CGPath.
func setLineJoin(_ join: CGLineJoin)
```

### CGLineJoin.miter

A join with a sharp (angled) corner. Core Graphics draws the outer sides of the lines beyond the endpoint of the path, until they meet. If the length of the miter divided by the line width is greater than the miter limit, a bevel join is used instead. This is the default. To set the miter limit, see setMiterLimit(_:).

具有尖锐（倾斜）角的连接。Core Graphics将线条的外侧画到路径的端点之外，直到它们相遇。如果斜线的长度除以线宽大于斜线限制，就会使用斜面连接代替。这是默认的。要设置割线极限，请参见setMiterLimit(_:)。

sharp 尖的

### CGLineJoin.round

A join with a rounded end. Core Graphics draws the line to extend beyond the endpoint of the path. The line ends with a semicircular arc with a radius of 1/2 the line’s width, centered on the endpoint.

一个有圆点的连接。Core Graphics绘制的线条延伸到路径的端点之外。线的末端是一个半径为线宽1/2的半圆弧，以端点为中心。

### CGLineJoin.bevel

A join with a squared-off end. Core Graphics draws the line to extend beyond the endpoint of the path, for a distance of 1/2 the line’s width.

一个带有方形端点的连接点。Core Graphics绘制的线条会延伸到路径的端点之外，距离为线条宽度的1/2。





# 设置有多个颜色的渐变色

``` swift
let topColor = UIColor(red: 249/255.0, green: 91/255.0, blue: 158/255.0, alpha: 0.3)
let middleColor = UIColor(red: 0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 0.3)
let bottomColor = UIColor(red: 0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 0.26)
let gradientColors = [topColor.cgColor, middleColor.cgColor, bottomColor.cgColor]
let gradientLayer = CAGradientLayer()
gradientLayer.colors = gradientColors
gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
gradientLayer.endPoint = CGPoint(x: 0.99, y: 0.99)
gradientLayer.locations = [0, 0.62, 1]
gradientLayer.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
layer.insertSublayer(gradientLayer, at: 0)
```

