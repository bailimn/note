# Widget

- SafeArea 安全距离（滚动到安全区域会被遮挡）
- SliverSafeArea Sliver安全距离（滚动到安全区域不会被遮挡）
- SliverPadding（滚动到顶部padding不会被遮挡）
- SliverAppBar
    - false 向上滚动的时候，可以把顶部的AppBar顶上去。
    - true 可以实现下拉，显示占位图，上划显示AppBar。

## ClipRRect

设置圆角，比如给图片设置圆角

``` dart
ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12)
  ),
  child: 
)
```



## Opacity

透明度

## Transform

形变

## Container

就是一个盒子

``` dart
Container(
  width: 300.px, // 可以设置为 double.infinity 占据全部宽度
  padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px), // 可以设置水平或垂直间距
  decoration: BoxDecoration(
    color: Colors.black54,
    borderRadius: BorderRadius.circular(6.px)
  ),
  child: 
)
```





## BottomNavigationBar

BottomNavigationBarItem

https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

``` dart
```



## CircleAvatar

包裹一个Widget为圆形

``` dart
CircleAvatar(
    child: 
)
```



## AppBar

``` dart
// 右上方点击按钮
AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  if (detailsProvider.faved) {
                    detailsProvider.removeFav();
                  } else {
                    detailsProvider.addFav();
                  }
                },
                icon: Icon(
                  detailsProvider.faved ? Icons.favorite : Feather.heart,
                  color: detailsProvider.faved
                      ? Colors.red
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () => _share(),
                icon: Icon(
                  Feather.share,
                ),
              ),
            ],
          )
```



## TextField

decoration：装饰

``` dart
TextField(
    obscureText: !showPassword, // 密码
    decoration: InputDecoration(
        labelText: "账号",
        hintText: "请输入账号",
        prefixIcon: Icon(Icons.person),
    ),
)
```



### 获取TextField的值

``` dart
TextEditingController
controller.text
```





## Text



## SafeArea



## ListView

### 可以代替Column，解决软键盘遮挡问题



# Button



# FutureBuilder（可以实现异步UI刷新）

``` dart
FutureBuilder<List<LFCategoryModel>>(
    future: JsonParse.getCategoryData(), // 这是一个异步的请求
    builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        if (snapshot.error != null) return Center(child: Text("请求失败"),);

        final data = snapshot.data ?? [];
        return Text("请求成功的页面")
    },
);
```



