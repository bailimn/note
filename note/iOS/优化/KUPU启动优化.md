### 第一次统计

``` shell
Total pre-main time: 970.70 milliseconds (100.0%)
         dylib loading time: 255.25 milliseconds (26.2%)
        rebase/binding time:  98.57 milliseconds (10.1%)
            ObjC setup time: 162.36 milliseconds (16.7%)
           initializer time: 454.33 milliseconds (46.8%)
           slowest intializers :
             libSystem.B.dylib :   9.58 milliseconds (0.9%)
     substitute-inserter.dylib : 114.48 milliseconds (11.7%)
    libMainThreadChecker.dylib :  43.87 milliseconds (4.5%)
         libMTLInterpose.dylib :  56.76 milliseconds (5.8%)
                         Realm :  20.18 milliseconds (2.0%)
                  RevealServer :  28.98 milliseconds (2.9%)
                          KUPU :  72.19 milliseconds (7.4%)

  total time: 4.9 seconds (100.0%)
  total images loaded:  628 (480 from dyld shared cache)
  total segments mapped: 576, into 75738 pages with 5700 pages pre-fetched
  total images loading time: 3.9 seconds (79.4%)
  total load time in ObjC: 162.36 milliseconds (3.2%)
  total debugger pause time: 3.7 seconds (74.3%)
  total dtrace DOF registration time:   0.17 milliseconds (0.0%)
  total rebase fixups:  929,218
  total rebase fixups time:  92.57 milliseconds (1.8%)
  total binding fixups: 708,027
  total binding fixups time: 309.68 milliseconds (6.2%)
  total weak binding fixups time:   5.95 milliseconds (0.1%)
  total redo shared cached bindings time: 309.63 milliseconds (6.2%)
  total bindings lazily fixed up: 0 of 0
  total time in initializers and ObjC +load: 454.33 milliseconds (9.1%)
                         libSystem.B.dylib :   9.58 milliseconds (0.1%)
                 substitute-inserter.dylib : 114.48 milliseconds (2.2%)
                libMainThreadChecker.dylib :  43.87 milliseconds (0.8%)
              libViewDebuggerSupport.dylib :  11.11 milliseconds (0.2%)
                     libMTLInterpose.dylib :  56.76 milliseconds (1.1%)
                              FBSDKCoreKit :   7.69 milliseconds (0.1%)
                                   Flutter :   5.87 milliseconds (0.1%)
                                     Realm :  20.18 milliseconds (0.4%)
                              RevealServer :  28.98 milliseconds (0.5%)
                             RongIMLibCore :   8.83 milliseconds (0.1%)
                                RongRTCLib :   8.25 milliseconds (0.1%)
                                      KUPU :  72.19 milliseconds (1.4%)
total symbol trie searches:    1611020
total symbol table binary searches:    0
total images defining weak symbols:  60
total images using weak symbols:  132
```



### 第二次统计

``` shell
Total pre-main time: 967.05 milliseconds (100.0%)
         dylib loading time: 280.17 milliseconds (28.9%)
        rebase/binding time:  96.61 milliseconds (9.9%)
            ObjC setup time: 154.49 milliseconds (15.9%)
           initializer time: 435.59 milliseconds (45.0%)
           slowest intializers :
             libSystem.B.dylib :  10.29 milliseconds (1.0%)
     substitute-inserter.dylib : 108.18 milliseconds (11.1%)
    libMainThreadChecker.dylib :  44.12 milliseconds (4.5%)
         libMTLInterpose.dylib :  43.49 milliseconds (4.4%)
                         Realm :  26.88 milliseconds (2.7%)
                  RevealServer :  31.31 milliseconds (3.2%)
                          KUPU :  77.31 milliseconds (7.9%)

  total time: 6.9 seconds (100.0%)
  total images loaded:  628 (480 from dyld shared cache)
  total segments mapped: 576, into 75738 pages with 5700 pages pre-fetched
  total images loading time: 5.9 seconds (85.6%)
  total load time in ObjC: 154.49 milliseconds (2.2%)
  total debugger pause time: 5.6 seconds (81.6%)
  total dtrace DOF registration time:   0.17 milliseconds (0.0%)
  total rebase fixups:  929,216 总变基修正
  total rebase fixups time:  91.45 milliseconds (1.3%)
  total binding fixups: 708,027
  total binding fixups time: 310.01 milliseconds (4.4%)
  total weak binding fixups time:   5.28 milliseconds (0.0%)
  total redo shared cached bindings time: 310.13 milliseconds (4.4%)
  total bindings lazily fixed up: 0 of 0
  total time in initializers and ObjC +load: 435.59 milliseconds (6.2%)
                         libSystem.B.dylib :  10.29 milliseconds (0.1%)
                 substitute-inserter.dylib : 108.18 milliseconds (1.5%)
                libMainThreadChecker.dylib :  44.12 milliseconds (0.6%)
              libViewDebuggerSupport.dylib :  11.05 milliseconds (0.1%)
                     libMTLInterpose.dylib :  43.49 milliseconds (0.6%)
                            AAILivenessSDK :   7.72 milliseconds (0.1%)
                              FBSDKCoreKit :   8.19 milliseconds (0.1%)
                                     Realm :  26.88 milliseconds (0.3%)
                              RevealServer :  31.31 milliseconds (0.4%)
                             RongIMLibCore :   7.23 milliseconds (0.1%)
                                      KUPU :  77.31 milliseconds (1.1%)
total symbol trie searches:    1611032
total symbol table binary searches:    0
total images defining weak symbols:  60
total images using weak symbols:  132
```



### 第三次统计

``` shell
Total pre-main time: 997.46 milliseconds (100.0%)
         dylib loading time: 251.51 milliseconds (25.2%)
        rebase/binding time:  91.10 milliseconds (9.1%)
            ObjC setup time: 163.40 milliseconds (16.3%)
           initializer time: 491.26 milliseconds (49.2%)
           slowest intializers :
             libSystem.B.dylib :   8.90 milliseconds (0.8%)
     substitute-inserter.dylib :  89.03 milliseconds (8.9%)
    libMainThreadChecker.dylib :  45.32 milliseconds (4.5%)
  libViewDebuggerSupport.dylib :  21.04 milliseconds (2.1%)
         libMTLInterpose.dylib : 120.48 milliseconds (12.0%)
                         Realm :  21.08 milliseconds (2.1%)
                  RevealServer :  29.26 milliseconds (2.9%)
                          KUPU :  73.25 milliseconds (7.3%)

  total time: 5.9 seconds (100.0%)
  total images loaded:  628 (480 from dyld shared cache)
  total segments mapped: 576, into 75738 pages with 5700 pages pre-fetched
  total images loading time: 4.9 seconds (82.2%)
  total load time in ObjC: 163.40 milliseconds (2.7%)
  total debugger pause time: 4.6 seconds (78.0%)
  total dtrace DOF registration time:   0.17 milliseconds (0.0%)
  total rebase fixups:  929,216
  total rebase fixups time:  85.39 milliseconds (1.4%)
  total binding fixups: 708,027
  total binding fixups time: 311.16 milliseconds (5.2%)
  total weak binding fixups time:   5.72 milliseconds (0.0%)
  total redo shared cached bindings time: 311.17 milliseconds (5.2%)
  total bindings lazily fixed up: 0 of 0
  total time in initializers and ObjC +load: 491.26 milliseconds (8.2%)
                         libSystem.B.dylib :   8.90 milliseconds (0.1%)
                 substitute-inserter.dylib :  89.03 milliseconds (1.4%)
                libMainThreadChecker.dylib :  45.32 milliseconds (0.7%)
              libViewDebuggerSupport.dylib :  21.04 milliseconds (0.3%)
                     libMTLInterpose.dylib : 120.48 milliseconds (2.0%)
                            AAILivenessSDK :   7.24 milliseconds (0.1%)
                              FBSDKCoreKit :   7.99 milliseconds (0.1%)
                                   Flutter :   6.06 milliseconds (0.1%)
                                     Realm :  21.08 milliseconds (0.3%)
                              RevealServer :  29.26 milliseconds (0.4%)
                             RongIMLibCore :   8.94 milliseconds (0.1%)
                                RongRTCLib :   8.45 milliseconds (0.1%)
                                      KUPU :  73.25 milliseconds (1.2%)
total symbol trie searches:    1611032
total symbol table binary searches:    0
total images defining weak symbols:  60
total images using weak symbols:  132
```



``` shell
Total pre-main time: 908.50 milliseconds (100.0%)
         dylib loading time: 251.80 milliseconds (27.7%)
        rebase/binding time:  97.73 milliseconds (10.7%)
            ObjC setup time: 166.30 milliseconds (18.3%)
           initializer time: 392.49 milliseconds (43.2%)
           slowest intializers :
             libSystem.B.dylib :  10.39 milliseconds (1.1%)
     substitute-inserter.dylib :  86.09 milliseconds (9.4%)
    libMainThreadChecker.dylib :  43.69 milliseconds (4.8%)
         libMTLInterpose.dylib :  41.90 milliseconds (4.6%)
                         Realm :  20.99 milliseconds (2.3%)
                  RevealServer :  29.25 milliseconds (3.2%)
                          KUPU :  73.71 milliseconds (8.1%)

  total time: 5.4 seconds (100.0%)
  total images loaded:  628 (480 from dyld shared cache)
  total segments mapped: 576, into 75738 pages with 5700 pages pre-fetched
  total images loading time: 4.5 seconds (82.2%)
  total load time in ObjC: 166.30 milliseconds (3.0%)
  total debugger pause time: 4.2 seconds (77.6%)
  total dtrace DOF registration time:   0.16 milliseconds (0.0%)
  total rebase fixups:  929,216
  total rebase fixups time:  91.88 milliseconds (1.6%)
  total binding fixups: 708,027
  total binding fixups time: 314.05 milliseconds (5.7%)
  total weak binding fixups time:   5.80 milliseconds (0.1%)
  total redo shared cached bindings time: 314.01 milliseconds (5.7%)
  total bindings lazily fixed up: 0 of 0
  total time in initializers and ObjC +load: 392.49 milliseconds (7.1%)
                         libSystem.B.dylib :  10.39 milliseconds (0.1%)
                 substitute-inserter.dylib :  86.09 milliseconds (1.5%)
                libMainThreadChecker.dylib :  43.69 milliseconds (0.7%)
              libViewDebuggerSupport.dylib :  11.95 milliseconds (0.2%)
                     libMTLInterpose.dylib :  41.90 milliseconds (0.7%)
                              FBSDKCoreKit :   7.99 milliseconds (0.1%)
                                   Flutter :   5.52 milliseconds (0.1%)
                                     Realm :  20.99 milliseconds (0.3%)
                              RevealServer :  29.25 milliseconds (0.5%)
                             RongIMLibCore :   8.45 milliseconds (0.1%)
                                RongRTCLib :   7.65 milliseconds (0.1%)
                                      KUPU :  73.71 milliseconds (1.3%)
total symbol trie searches:    1611026
total symbol table binary searches:    0
total images defining weak symbols:  60
total images using weak symbols:  132
```



``` shell
Total pre-main time: 950.20 milliseconds (100.0%)
         dylib loading time: 251.16 milliseconds (26.4%)
        rebase/binding time:  94.49 milliseconds (9.9%)
            ObjC setup time: 167.66 milliseconds (17.6%)
           initializer time: 436.71 milliseconds (45.9%)
           slowest intializers :
             libSystem.B.dylib :   9.40 milliseconds (0.9%)
     substitute-inserter.dylib : 104.02 milliseconds (10.9%)
    libMainThreadChecker.dylib :  44.65 milliseconds (4.6%)
         libMTLInterpose.dylib :  53.50 milliseconds (5.6%)
                         Realm :  29.74 milliseconds (3.1%)
                  RevealServer :  31.73 milliseconds (3.3%)
                          KUPU :  66.61 milliseconds (7.0%)

  total time: 6.2 seconds (100.0%)
  total images loaded:  628 (480 from dyld shared cache)
  total segments mapped: 576, into 75744 pages with 5700 pages pre-fetched
  total images loading time: 5.2 seconds (83.8%)
  total load time in ObjC: 167.66 milliseconds (2.6%)
  total debugger pause time: 4.9 seconds (79.8%)
  total dtrace DOF registration time:   0.16 milliseconds (0.0%)
  total rebase fixups:  929,213
  total rebase fixups time:  89.28 milliseconds (1.4%)
  total binding fixups: 708,028
  total binding fixups time: 309.59 milliseconds (4.9%)
  total weak binding fixups time:   5.27 milliseconds (0.0%)
  total redo shared cached bindings time: 309.66 milliseconds (4.9%)
  total bindings lazily fixed up: 0 of 0
  total time in initializers and ObjC +load: 436.71 milliseconds (6.9%)
                         libSystem.B.dylib :   9.40 milliseconds (0.1%)
                 substitute-inserter.dylib : 104.02 milliseconds (1.6%)
                libMainThreadChecker.dylib :  44.65 milliseconds (0.7%)
              libViewDebuggerSupport.dylib :  11.23 milliseconds (0.1%)
                     libMTLInterpose.dylib :  53.50 milliseconds (0.8%)
                              FBSDKCoreKit :   7.96 milliseconds (0.1%)
                                     Realm :  29.74 milliseconds (0.4%)
                              RevealServer :  31.73 milliseconds (0.5%)
                             RongIMLibCore :   8.04 milliseconds (0.1%)
                                      KUPU :  66.61 milliseconds (1.0%)
total symbol trie searches:    1611034
total symbol table binary searches:    0
total images defining weak symbols:  60
total images using weak symbols:  132
```





缺页中断优化前数据

![image-20220405225927775](/Users/blf/Library/Application Support/typora-user-images/image-20220405225927775.png)

##### Other C Flags

-fsanitize-coverage=func,trace-pc-guard

##### Other Swift Flags

-sanitize-coverage=func

-sanitize=undefined