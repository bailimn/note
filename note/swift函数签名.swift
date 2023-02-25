
// getter 方法的签名
(lldb) f
frame #0: 0x000000010dbd4a50 Kingfisher`KingfisherCompatible.kf.getter(self=<unavailable>) at Kingfisher.swift:73
   70  	extension KingfisherCompatible {
   71  	    /// Gets a namespace holder for Kingfisher compatible types.
   72  	    public var kf: KingfisherWrapper<Self> {
-> 73  	        get {
   74  	            return KingfisherWrapper(self)
   75  	            
   76  	        }


// init 方法签名
frame #0: 0x000000010dbd48c0 Kingfisher`KingfisherWrapper.init(base=0x0000000000000305) at Kingfisher.swift:57
// 用于 KingfisherWrapper 的类型元数据访问器 at <编译器生成>
frame #0: 0x000000010dbd49d0 Kingfisher`type metadata accessor for KingfisherWrapper at <compiler-generated>:0
frame #0: 0x000000010db690f0 Kingfisher`__swift_instantiateGenericMetadata at <compiler-generated>:0
// 用于 KingfisherWrapper 的类型元数据实例化函数
frame #0: 0x000000010dbd4f80 Kingfisher`type metadata instantiation function for KingfisherWrapper at <compiler-generated>:0
// 类型元数据完成函数
frame #0: 0x000000010dbd4fa0 Kingfisher`type metadata completion function for KingfisherWrapper at <compiler-generated>:0
// 用KingfisherWrapper的副本概述init
frame #0: 0x000000010dbd49e0 Kingfisher`outlined init with copy of KingfisherWrapper<A> at <compiler-generated>:0
// 概述了 KingfisherWrapper 的销毁
frame #0: 0x000000010dbd4a20 Kingfisher`outlined destroy of KingfisherWrapper<A> at <compiler-generated>:0


// setter 方法的函数签名
frame #0: 0x000000010dc56a30 Kingfisher`KingfisherWrapper<Base>.indicatorType.setter(newValue=image, self=<unavailable>) at ImageView+Kingfisher.swift:457
frame #0: 0x000000010db61960 Kingfisher`__swift_instantiateConcreteTypeFromMangledName at <compiler-generated>:0
frame #0: 0x000000010dc90570 Kingfisher`type metadata accessor for KingfisherParsedOptionsInfo at <compiler-generated>:0
frame #0: 0x000000010dc9e5b0 Kingfisher`type metadata completion function for KingfisherParsedOptionsInfo at <compiler-generated>:0
frame #0: 0x000000010dc9e840 Kingfisher`type metadata accessor for StorageExpiration? at <compiler-generated>:0
frame #0: 0x000000010db777e0 Kingfisher`type metadata accessor for StorageExpiration at <compiler-generated>:0
frame #0: 0x000000010db78160 Kingfisher`type metadata completion function for StorageExpiration at <compiler-generated>:0
frame #0: 0x000000010db78d00 Kingfisher`type metadata accessor for ExpirationExtending at <compiler-generated>:0
frame #0: 0x000000010db78d60 Kingfisher`type metadata completion function for ExpirationExtending at <compiler-generated>:0
frame #0: 0x000000010db777e0 Kingfisher`type metadata accessor for StorageExpiration at <compiler-generated>:0
frame #0: 0x000000010dc56eb0 Kingfisher`outlined init with copy of IndicatorType at <compiler-generated>:0
frame #0: 0x000000010dc03150 Kingfisher`type metadata accessor for ActivityIndicator at <compiler-generated>:0



final class ActivityIndicator: Indicator {
    init() {
frame #0: 0x000000010dc00980 Kingfisher`ActivityIndicator.__allocating_init() at Indicator.swift:138
frame #0: 0x000000010dc009b0 Kingfisher`ActivityIndicator.init(self=0x000000010dcc3830) at Indicator.swift:138





(lldb) breakpoint set --all-files -p . -s Kingfisher -C "frame info" -G1
Breakpoint 4: 5382 locations.