### UITextView delegate

方式1

``` swift
numberTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe { [weak self] _ in
                self?.updateContactNumber()
            }.disposed(by: rx.disposeBag)
```

方式2

``` swift 

extension Reactive where Base: UITextField {

   public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
      return RxTextFieldDelegateProxy.proxy(for: base)
   }

   public var editingDidEnd: Observable<String> {
      return delegate.sentMessage(#selector(UITextFieldDelegate.textFieldDidEndEditing(_:))).map { value in
         guard let textField = value[0] as? UITextField else { return "" }
         return textField.text!   }
   }

}

class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {

   init(textField: UITextField) {
      super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
   }

   static func registerKnownImplementations() {
      self.register { RxTextFieldDelegateProxy(textField: $0)}
   }

   static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
      return object.delegate
   }

   static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
         object.delegate = delegate
      }
}

// 使用
textView.rx.editingDidEnd.subscribe(onNext: { value in
         debugPrint(value)
      }).disposed(by: bag)
```



### NotificationCenter

``` swift

public extension Notification.Name {
    static var kReloadTabbarWithIndex: Notification.Name {
        return Notification.Name("kReloadTabbarWithIndex")
    }
}

// 订阅通知
NotificationCenter.default.rx.notification(.kSwitchScreenRotation, object: nil).subscribe(onNext: { [weak self] noti in
    guard let self = self, let rotation = noti.userInfo?["rotation"] as? String else { return }
    
}).disposed(by: rx.disposeBag)

// 发送通知
NotificationCenter.default.post(name: .kSwitchScreenRotation, object: nil, userInfo: ["rotation": "landscape"])

```



