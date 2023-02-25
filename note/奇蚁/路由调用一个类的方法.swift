
// 调用
BoRouter.shared.open(.allConversationsCount(callback: {[weak self] data in
            
    guard let count = data["count"] as? Int else{
        dPrint("getReciveIMMessage count err")
        return
    }
    DispatchQueue.main.async {
        self?.mainView.headerContentView.chatedView.titleLabel.text = count.toString()
    }
}))

RCModel
public func allConversationsCount() -> Int {



extension RCModel: QYRouterServiceProtocol {
    public static func invoking(context: RouterContext) {
        guard let event = context.event else {
            dPrint("RCModel err ")
            return
        }
        switch event {
        case "allConversationsCount":
            let count = RCModel.instance.allConversationsCount()
            context.block?(["count": count])
            if let url = context.parameters["url"] as? String {
                let parameter = context.parameters["parameter"] as? [String: Any]
                FlutterHelper().pushFlutter(url, parameter: parameter, isPush: true)
            }
        }
    }
}

///集中式注册的URL
public enum BoStaticService: CaseIterable {
    case allConversationsCount(callback: JsonBlock?)
    
    public typealias AllCases = [BoStaticService]
    
    
    private func generateUrl(path: String) -> String{
        "qiyee://com.kupu.standard/\(path)"
    }
    
    public static var allCases: [BoStaticService]{
        return [
            .allConversationsCount(callback: nil),
        ]
    }
    
    var regUrlString: String {
        var path = ""
        switch self {
        case .getReciveIMMessage:
            path = "getReciveIMMessage"
        case .allConversationsCount:
            path = "allConversationsCount"
        }
        
        return generateUrl(path: path)
    }
    
    
    var context: RouterContext {
        var context = RouterContext()
        switch self {
        case let .allConversationsCount(callback):
            context.event = "allConversationsCount"
            context.block = callback
        default:
            break
        }
        return context
    }
    
    private var baseModule: String {
        "KUPU."
    }
    
    var moduleEnter: String {
        switch self {
        case .allConversationsCount:
            return "iOS_Boss_IMBase." + "RCModel"
        }
    }
}


### 普通路由调用
``` swift
// 1. 准守 QYRouterProtocol 协议
// 2. 实现方法

// 如果实现了路由，还有直接创建的请款，那么久实现下面的方法
public convenience init() {
    self.init(arguments: [:])
}

// 解析路由传递的参数
public required init(arguments: [String : Any]) {
    super.init(nibName: nil, bundle: nil)
    if let role = arguments["roleType"] as? Int {
        loginViewModel.roleTypeFromChooseRole = RoleType(rawValue: role)
    }
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```
