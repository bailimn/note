

- Swift 包管理支持（SPM）



1.DDLog（整个框架的基础）
 2.DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
 3.DDTTYLoyger（发送日志语句到Xcode控制台）
 4.DDFIleLoger（把日志写入本地文件）

``` objective-c
[DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode 控制台
[DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs 苹果系统日志

// 创建本地日志文件
DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
fileLogger.rollingFrequency = 60 * 60 * 24; // 每24小时创建一个新文件
fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 最多允许创建7个文件
[DDLog addLogger:fileLogger];

...

DDLogVerbose(@"Verbose");
DDLogDebug(@"Debug");
DDLogInfo(@"Info");
DDLogWarn(@"Warn");
DDLogError(@"Error");
```

``` swift
DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs

let fileLogger: DDFileLogger = DDFileLogger() // File Logger
fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
fileLogger.logFileManager.maximumNumberOfLogFiles = 7
DDLog.add(fileLogger)

...

DDLogVerbose("Verbose");
DDLogDebug("Debug");
DDLogInfo("Info");
DDLogWarn("⚠️");
DDLogError("Error");
```

