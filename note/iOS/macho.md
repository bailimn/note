
### otool -L XXX
查看macho文件依赖动态库

**依赖库**
- /System/Library/和/usr/lib/路径均为系统动态库
- @rpath/为自己封装到ipa中的动态库
``` shell
╰─ otool -L /Users/blf/Library/Developer/Xcode/DerivedData/iOS_Boss_Offer-gdhhzdmccyibdmbupdhzgvcdepjo/Build/Products/Debug-iphoneos/iOS_Boss_Offer_Example.app/iOS_Boss_Offer_Example
/Users/blf/Library/Developer/Xcode/DerivedData/iOS_Boss_Offer-gdhhzdmccyibdmbupdhzgvcdepjo/Build/Products/Debug-iphoneos/iOS_Boss_Offer_Example.app/iOS_Boss_Offer_Example:
	/usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 1200.3.0)
	/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.11)
	/System/Library/Frameworks/AVFoundation.framework/AVFoundation (compatibility version 1.0.0, current version 2.0.0)
	/System/Library/Frameworks/Accelerate.framework/Accelerate (compatibility version 1.0.0, current version 4.0.0, weak)
	@rpath/Alamofire.framework/Alamofire (compatibility version 1.0.0, current version 1.0.0)
	@rpath/Boss.framework/Boss (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/CFNetwork.framework/CFNetwork (compatibility version 1.0.0, current version 1312.0.0)
	@rpath/CleanJSON.framework/CleanJSON (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/CoreData.framework/CoreData (compatibility version 1.0.0, current version 1132.0.0)
	/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics (compatibility version 64.0.0, current version 1548.1.3, weak)
	/System/Library/Frameworks/CoreImage.framework/CoreImage (compatibility version 1.0.0, current version 5.0.0)
	/System/Library/Frameworks/CoreLocation.framework/CoreLocation (compatibility version 1.0.0, current version 2663.0.3)
	/System/Library/Frameworks/CoreMotion.framework/CoreMotion (compatibility version 1.0.0, current version 2663.0.3)
	/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony (compatibility version 1.0.0, current version 0.0.0)
	/System/Library/Frameworks/CoreText.framework/CoreText (compatibility version 1.0.0, current version 1.0.0)
	@rpath/CryptoSwift.framework/CryptoSwift (compatibility version 1.0.0, current version 1.0.0)
	@rpath/FBSDKCoreKit.framework/FBSDKCoreKit (compatibility version 1.0.0, current version 1.0.0)
	@rpath/FBSDKLoginKit.framework/FBSDKLoginKit (compatibility version 1.0.0, current version 1.0.0)
	@rpath/FBSDKShareKit.framework/FBSDKShareKit (compatibility version 1.0.0, current version 1.0.0)
	@rpath/FCUUID.framework/FCUUID (compatibility version 1.0.0, current version 1.0.0)
	@rpath/FlexLayout.framework/FlexLayout (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Foundation.framework/Foundation (compatibility version 300.0.0, current version 1854.0.0, weak)
	/System/Library/Frameworks/GLKit.framework/GLKit (compatibility version 1.0.0, current version 126.0.0)
	/System/Library/Frameworks/ImageIO.framework/ImageIO (compatibility version 1.0.0, current version 1.0.0)
	@rpath/JXPhotoBrowser.framework/JXPhotoBrowser (compatibility version 1.0.0, current version 1.0.0)
	@rpath/Kingfisher.framework/Kingfisher (compatibility version 1.0.0, current version 1.0.0)
	@rpath/MOAnalytics.framework/MOAnalytics (compatibility version 1.0.0, current version 1.0.0)
	@rpath/MOMessaging.framework/MOMessaging (compatibility version 1.0.0, current version 1.0.0)
	@rpath/MORichNotification.framework/MORichNotification (compatibility version 1.0.0, current version 1.0.0)
	@rpath/MarqueeLabel.framework/MarqueeLabel (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Metal.framework/Metal (compatibility version 1.0.0, current version 257.25.0)
	@rpath/MoEngage.framework/MoEngage (compatibility version 1.0.0, current version 1.0.0)
	@rpath/MoEngageCore.framework/MoEngageCore (compatibility version 1.0.0, current version 1.0.0)
	@rpath/Moya.framework/Moya (compatibility version 1.0.0, current version 1.0.0)
	@rpath/NSObject_Rx.framework/NSObject_Rx (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/OpenGLES.framework/OpenGLES (compatibility version 1.0.0, current version 1.0.0)
	@rpath/PPBadgeViewSwift.framework/PPBadgeViewSwift (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Photos.framework/Photos (compatibility version 1.0.0, current version 402.5.140)
	/System/Library/Frameworks/PhotosUI.framework/PhotosUI (compatibility version 1.0.0, current version 402.5.140)
	@rpath/PinLayout.framework/PinLayout (compatibility version 1.0.0, current version 1.0.0)
	@rpath/PresentController.framework/PresentController (compatibility version 1.0.0, current version 1.0.0)
	@rpath/QYPageController.framework/QYPageController (compatibility version 1.0.0, current version 1.0.0)
	@rpath/QiyeeTatsi.framework/QiyeeTatsi (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/QuartzCore.framework/QuartzCore (compatibility version 1.2.0, current version 1.11.0, weak)
	@rpath/Rswift.framework/Rswift (compatibility version 1.0.0, current version 1.0.0)
	@rpath/RxCocoa.framework/RxCocoa (compatibility version 1.0.0, current version 1.0.0)
	@rpath/RxGesture.framework/RxGesture (compatibility version 1.0.0, current version 1.0.0)
	@rpath/RxRelay.framework/RxRelay (compatibility version 1.0.0, current version 1.0.0)
	@rpath/RxSwift.framework/RxSwift (compatibility version 1.0.0, current version 1.0.0)
	@rpath/RxTheme.framework/RxTheme (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Security.framework/Security (compatibility version 1.0.0, current version 60157.12.1, weak)
	@rpath/SnapKit.framework/SnapKit (compatibility version 1.0.0, current version 1.0.0)
	@rpath/SwifterSwift.framework/SwifterSwift (compatibility version 1.0.0, current version 1.0.0)
	@rpath/SwiftyJSON.framework/SwiftyJSON (compatibility version 1.0.0, current version 1.0.0)
	@rpath/SwiftyRSA.framework/SwiftyRSA (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/SystemConfiguration.framework/SystemConfiguration (compatibility version 1.0.0, current version 1163.10.2)
	@rpath/Toaster.framework/Toaster (compatibility version 1.0.0, current version 1.0.0)
	@rpath/UICKeyChainStore.framework/UICKeyChainStore (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/UIKit.framework/UIKit (compatibility version 1.0.0, current version 5067.3.107, weak)
	@rpath/URLNavigator.framework/URLNavigator (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/UserNotifications.framework/UserNotifications (compatibility version 1.0.0, current version 1.0.0, weak)
	/System/Library/Frameworks/UserNotificationsUI.framework/UserNotificationsUI (compatibility version 1.0.0, current version 1.0.0)
	@rpath/WMPageController.framework/WMPageController (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/WatchConnectivity.framework/WatchConnectivity (compatibility version 1.0.0, current version 200.0.0)
	/System/Library/Frameworks/WebKit.framework/WebKit (compatibility version 1.0.0, current version 612.1.27)
	@rpath/ZLPhotoBrowser.framework/ZLPhotoBrowser (compatibility version 1.0.0, current version 1.0.0)
	@rpath/iOS_Boss_Analysis.framework/iOS_Boss_Analysis (compatibility version 1.0.0, current version 1.0.0)
	@rpath/iOS_Boss_BaseService.framework/iOS_Boss_BaseService (compatibility version 1.0.0, current version 1.0.0)
    ...
	@rpath/iOS_Com_Refresh.framework/iOS_Com_Refresh (compatibility version 1.0.0, current version 1.0.0)
	@rpath/iOS_Com_UILib.framework/iOS_Com_UILib (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Accounts.framework/Accounts (compatibility version 1.0.0, current version 1.0.0, weak)
	/System/Library/Frameworks/AdSupport.framework/AdSupport (compatibility version 1.0.0, current version 1.0.0, weak)
	/System/Library/Frameworks/AppTrackingTransparency.framework/AppTrackingTransparency (compatibility version 1.0.0, current version 1.0.0, weak)
	/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox (compatibility version 1.0.0, current version 1000.0.0, weak)
	/System/Library/Frameworks/Social.framework/Social (compatibility version 1.0.0, current version 87.0.0, weak)
	/usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1311.0.0)
	/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation (compatibility version 150.0.0, current version 1854.0.0, weak)
	/usr/lib/swift/libswiftCoreMIDI.dylib (compatibility version 1.0.0, current version 5.0.0, weak)
	/usr/lib/swift/libswiftDataDetection.dylib (compatibility version 1.0.0, current version 694.0.0, weak)
	/usr/lib/swift/libswiftFileProvider.dylib (compatibility version 1.0.0, current version 374.1.2, weak)
	/usr/lib/swift/libswiftUniformTypeIdentifiers.dylib (compatibility version 1.0.0, current version 718.0.0, weak)
	/usr/lib/swift/libswiftWebKit.dylib (compatibility version 1.0.0, current version 612.1.27, weak)
	@rpath/libswiftAVFoundation.dylib (compatibility version 
	...
	@rpath/libswiftsimd.dylib (compatibility version 1.0.0, current version 9.0.0, weak)
```