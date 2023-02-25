(lldb) frame variable
(UIImageView) base = 0x00007fa567e174b0 {
  baseUIView@0 = {
    baseUIResponder@0 = {
      baseNSObject@0 = {
        isa = UIImageView
      }
    }
    _constraintsExceptingSubviewAutoresizingConstraints = 0x0000000000000000
    _cachedTraitCollection = some {
      some = 0x00006000015b8c30 {
        baseNSObject@0 = {
          isa = UITraitCollection
        }
        _clientDefinedTraits = 0x0000000000000000
        _environmentWrapper = 0x0000000000000000
      }
    }
...


// 查看所有私有变量的一种更简单的方法。 它使用 -F 选项，代表“flat”。 这将保持缩进为 0，并且只在 当前类 中打印出关于 self 的信息
(lldb) frame variable -F self
self.base = 0x00007fa567e174b0
self.base.isa = UIImageView
self.base._constraintsExceptingSubviewAutoresizingConstraints = 0x0000000000000000
self.base._cachedTraitCollection = some
self.base._cachedTraitCollection.some = 0x00006000015b8c30
self.base._cachedTraitCollection.some.isa = UITraitCollection
self.base._cachedTraitCollection.some._clientDefinedTraits = 0x0000000000000000
self.base._cachedTraitCollection.some._environmentWrapper = 0x0000000000000000
self.base._animationInfo = 0x0000000000000000
self.base._layer = some
self.base._layer.some = 0x0000600002ef7d20
self.base._layer.some.isa = CALayer
self.base._layerRetained = 0x0000000000000000
self.base._gestureRecognizers = 0x0000000000000000
self.base._window = some
self.base._window.some = 0x00007fa567d0aaf0
...


