╰─ sudo dtrace -n 'objc$target:ObjCViewController::entry' -p `pgrep VCTransitions`
Password:
dtrace: description 'objc$target:ObjCViewController::entry' matched 9 probes
CPU     ID                    FUNCTION:NAME
  3 417250       -pushVCButtonTapped::entry
  4 417251 -customPushVCButtonTapped::entry




// 只显示OC的属性
// NSObject 不再推断 @objc 。 Swift 不会为动态代码创建 Objective-C 符号。
╰─ sudo dtrace -ln 'objc$target::*cool*Test*:entry' -p `pgrep VCTransitions`
   ID   PROVIDER            MODULE                          FUNCTION NAME
417253  objc26689 ObjCViewController               -coolViewDTraceTest entry
417255  objc26689 ObjCViewController            -coolBooleanDTraceTest entry




// 这是使用 objc_msgSend 而不是 objc$target 探针的另一个原因，因为对 objc_msgSend 的调用将捕获动态执行的 Swift 代码，而 objc$target 将错过它们。
╰─ sudo dtrace -n 'pid$target::*cool*Test*:entry' -p `pgrep VCTransitions`
dtrace: description 'pid$target::*cool*Test*:entry' matched 18 probes
CPU     ID                    FUNCTION:NAME
  4 417745 -[ObjCViewController coolViewDTraceTest]:entry
  4 417746 -[ObjCViewController coolBooleanDTraceTest]:entry
  4 417748 @objc SwiftViewController.coolViewDTraceTest.getter:entry
  4 417749 SwiftViewController.coolViewDTraceTest.getter:entry
  4 417756 @objc SwiftViewController.coolBooleanDTraceTest.getter:entry
  4 417757 SwiftViewController.coolBooleanDTraceTest.getter:entry




(lldb) lookup SwiftViewController
(lldb) lookup ObjCViewController
// 列出 LLDB 在 VCTransitions 可执行文件中生成的所有函数
(lldb) lookup VCTransitions
****************************************************
283 hits in: VCTransitions
****************************************************
___lldb_unnamed_symbol1$$VCTransitions

___lldb_unnamed_symbol2$$VCTransitions

___lldb_unnamed_symbol3$$VCTransitions

___lldb_unnamed_symbol4$$VCTransitions

___lldb_unnamed_symbol5$$VCTransitions





// 这将查询 VCTransitions 进程以获取包含 ObjCViewController 模块的探测器计数，这是 DTrace 引用 Objective-C 类的方式。
╰─ sudo dtrace -ln 'objc$target:ObjCViewController::' -p `pgrep VCTransitions`
Password:
   ID   PROVIDER            MODULE                          FUNCTION NAME
418677  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: return
418678  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: entry
418679  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 0
418680  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 1
418681  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 4
418682  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 8
418683  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: c
418684  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 10
418685  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 18
418686  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 1c
418687  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 1f
418688  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 24
418689  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 28
418690  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 2f
418691  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 32
418692  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 38
418693  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 3a
418694  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 3c
418695  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 40
418696  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 45
418697  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 49
418698  objc27074 ObjCViewController -executeLotsOfMethodsButtonTapped: 4a
418699  objc27074 ObjCViewController              -pushVCButtonTapped: return
418700  objc27074 ObjCViewController              -pushVCButtonTapped: entry
418701  objc27074 ObjCViewController              -pushVCButtonTapped: 0
418702  objc27074 ObjCViewController              -pushVCButtonTapped: 1
418703  objc27074 ObjCViewController              -pushVCButtonTapped: 4
418704  objc27074 ObjCViewController              -pushVCButtonTapped: 8
418705  objc27074 ObjCViewController              -pushVCButtonTapped: c
418706  objc27074 ObjCViewController              -pushVCButtonTapped: 10
418707  objc27074 ObjCViewController              -pushVCButtonTapped: 18
418708  objc27074 ObjCViewController              -pushVCButtonTapped: 1c
418709  objc27074 ObjCViewController              -pushVCButtonTapped: 1f
418710  objc27074 ObjCViewController              -pushVCButtonTapped: 24
418711  objc27074 ObjCViewController              -pushVCButtonTapped: 28
418712  objc27074 ObjCViewController              -pushVCButtonTapped: 2f
418713  objc27074 ObjCViewController              -pushVCButtonTapped: 32
418714  objc27074 ObjCViewController              -pushVCButtonTapped: 38
418715  objc27074 ObjCViewController              -pushVCButtonTapped: 3b
418716  objc27074 ObjCViewController              -pushVCButtonTapped: 40
418717  objc27074 ObjCViewController              -pushVCButtonTapped: 47
418718  objc27074 ObjCViewController              -pushVCButtonTapped: 4e
418719  objc27074 ObjCViewController              -pushVCButtonTapped: 51
418720  objc27074 ObjCViewController              -pushVCButtonTapped: 54
418721  objc27074 ObjCViewController              -pushVCButtonTapped: 57
418722  objc27074 ObjCViewController              -pushVCButtonTapped: 5b
418723  objc27074 ObjCViewController              -pushVCButtonTapped: 61
418724  objc27074 ObjCViewController              -pushVCButtonTapped: 64
418725  objc27074 ObjCViewController              -pushVCButtonTapped: 69
418726  objc27074 ObjCViewController              -pushVCButtonTapped: 6d
418727  objc27074 ObjCViewController              -pushVCButtonTapped: 71
418728  objc27074 ObjCViewController              -pushVCButtonTapped: 74
418729  objc27074 ObjCViewController              -pushVCButtonTapped: 7a
418730  objc27074 ObjCViewController              -pushVCButtonTapped: 7e
419399  objc27074 ObjCViewController              -pushVCButtonTapped: 85
419400  objc27074 ObjCViewController              -pushVCButtonTapped: 88
419401  objc27074 ObjCViewController              -pushVCButtonTapped: 8e
419402  objc27074 ObjCViewController              -pushVCButtonTapped: 91
419403  objc27074 ObjCViewController              -pushVCButtonTapped: 96
419404  objc27074 ObjCViewController              -pushVCButtonTapped: 9a
419405  objc27074 ObjCViewController              -pushVCButtonTapped: a1
419406  objc27074 ObjCViewController              -pushVCButtonTapped: a4
419407  objc27074 ObjCViewController              -pushVCButtonTapped: a7
419408  objc27074 ObjCViewController              -pushVCButtonTapped: ac
419409  objc27074 ObjCViewController              -pushVCButtonTapped: b0
419410  objc27074 ObjCViewController              -pushVCButtonTapped: b6
419411  objc27074 ObjCViewController              -pushVCButtonTapped: ba
419412  objc27074 ObjCViewController              -pushVCButtonTapped: bd
419413  objc27074 ObjCViewController              -pushVCButtonTapped: c3
419414  objc27074 ObjCViewController              -pushVCButtonTapped: c5
419415  objc27074 ObjCViewController              -pushVCButtonTapped: c7
419416  objc27074 ObjCViewController              -pushVCButtonTapped: cb
419417  objc27074 ObjCViewController              -pushVCButtonTapped: ce
419418  objc27074 ObjCViewController              -pushVCButtonTapped: d3
419419  objc27074 ObjCViewController              -pushVCButtonTapped: d5
419420  objc27074 ObjCViewController              -pushVCButtonTapped: d7
419421  objc27074 ObjCViewController              -pushVCButtonTapped: db
419422  objc27074 ObjCViewController              -pushVCButtonTapped: e0
419423  objc27074 ObjCViewController              -pushVCButtonTapped: e4
419424  objc27074 ObjCViewController              -pushVCButtonTapped: e5
419425  objc27074 ObjCViewController        -customPushVCButtonTapped: return
419426  objc27074 ObjCViewController        -customPushVCButtonTapped: entry
419427  objc27074 ObjCViewController        -customPushVCButtonTapped: 0
419428  objc27074 ObjCViewController        -customPushVCButtonTapped: 1
419429  objc27074 ObjCViewController        -customPushVCButtonTapped: 4
419430  objc27074 ObjCViewController        -customPushVCButtonTapped: 8
419431  objc27074 ObjCViewController        -customPushVCButtonTapped: c
419432  objc27074 ObjCViewController        -customPushVCButtonTapped: 10
419433  objc27074 ObjCViewController        -customPushVCButtonTapped: 18
419434  objc27074 ObjCViewController        -customPushVCButtonTapped: 1c
419435  objc27074 ObjCViewController        -customPushVCButtonTapped: 1f
419436  objc27074 ObjCViewController        -customPushVCButtonTapped: 24
419437  objc27074 ObjCViewController        -customPushVCButtonTapped: 28
419438  objc27074 ObjCViewController        -customPushVCButtonTapped: 2f
419439  objc27074 ObjCViewController        -customPushVCButtonTapped: 32
419440  objc27074 ObjCViewController        -customPushVCButtonTapped: 38
419441  objc27074 ObjCViewController        -customPushVCButtonTapped: 3b
419442  objc27074 ObjCViewController        -customPushVCButtonTapped: 40
419443  objc27074 ObjCViewController        -customPushVCButtonTapped: 47
419444  objc27074 ObjCViewController        -customPushVCButtonTapped: 4e
419445  objc27074 ObjCViewController        -customPushVCButtonTapped: 51
419446  objc27074 ObjCViewController        -customPushVCButtonTapped: 54
419447  objc27074 ObjCViewController        -customPushVCButtonTapped: 57
419448  objc27074 ObjCViewController        -customPushVCButtonTapped: 5b
419449  objc27074 ObjCViewController        -customPushVCButtonTapped: 61
419450  objc27074 ObjCViewController        -customPushVCButtonTapped: 64
419451  objc27074 ObjCViewController        -customPushVCButtonTapped: 69
419452  objc27074 ObjCViewController        -customPushVCButtonTapped: 6d
419453  objc27074 ObjCViewController        -customPushVCButtonTapped: 71
419454  objc27074 ObjCViewController        -customPushVCButtonTapped: 74
419455  objc27074 ObjCViewController        -customPushVCButtonTapped: 7a
419456  objc27074 ObjCViewController        -customPushVCButtonTapped: 7e
419457  objc27074 ObjCViewController        -customPushVCButtonTapped: 85
419458  objc27074 ObjCViewController        -customPushVCButtonTapped: 88
419459  objc27074 ObjCViewController        -customPushVCButtonTapped: 8d
419460  objc27074 ObjCViewController        -customPushVCButtonTapped: 93
419461  objc27074 ObjCViewController        -customPushVCButtonTapped: 97
419462  objc27074 ObjCViewController        -customPushVCButtonTapped: 9e
419463  objc27074 ObjCViewController        -customPushVCButtonTapped: a1
419464  objc27074 ObjCViewController        -customPushVCButtonTapped: a7
419465  objc27074 ObjCViewController        -customPushVCButtonTapped: aa
419466  objc27074 ObjCViewController        -customPushVCButtonTapped: af
419467  objc27074 ObjCViewController        -customPushVCButtonTapped: b3
419468  objc27074 ObjCViewController        -customPushVCButtonTapped: ba
419469  objc27074 ObjCViewController        -customPushVCButtonTapped: bd
419470  objc27074 ObjCViewController        -customPushVCButtonTapped: c0
419471  objc27074 ObjCViewController        -customPushVCButtonTapped: c5
419472  objc27074 ObjCViewController        -customPushVCButtonTapped: c9
419473  objc27074 ObjCViewController        -customPushVCButtonTapped: cf
419474  objc27074 ObjCViewController        -customPushVCButtonTapped: d3
419475  objc27074 ObjCViewController        -customPushVCButtonTapped: d6
419476  objc27074 ObjCViewController        -customPushVCButtonTapped: dc
419477  objc27074 ObjCViewController        -customPushVCButtonTapped: de
419478  objc27074 ObjCViewController        -customPushVCButtonTapped: e0
419479  objc27074 ObjCViewController        -customPushVCButtonTapped: e4
419480  objc27074 ObjCViewController        -customPushVCButtonTapped: e7
419481  objc27074 ObjCViewController        -customPushVCButtonTapped: ec
419482  objc27074 ObjCViewController        -customPushVCButtonTapped: ee
419483  objc27074 ObjCViewController        -customPushVCButtonTapped: f0
419484  objc27074 ObjCViewController        -customPushVCButtonTapped: f4
419485  objc27074 ObjCViewController        -customPushVCButtonTapped: f9
419486  objc27074 ObjCViewController        -customPushVCButtonTapped: fd
419487  objc27074 ObjCViewController        -customPushVCButtonTapped: fe
419488  objc27074 ObjCViewController                    -anEmptyMethod return
419489  objc27074 ObjCViewController                    -anEmptyMethod entry
419490  objc27074 ObjCViewController                    -anEmptyMethod 0
419491  objc27074 ObjCViewController                    -anEmptyMethod 1
419492  objc27074 ObjCViewController                    -anEmptyMethod 4
419493  objc27074 ObjCViewController                    -anEmptyMethod 8
419494  objc27074 ObjCViewController                    -anEmptyMethod c
419495  objc27074 ObjCViewController                    -anEmptyMethod d
419496  objc27074 ObjCViewController               -coolViewDTraceTest return
419497  objc27074 ObjCViewController               -coolViewDTraceTest entry
419498  objc27074 ObjCViewController               -coolViewDTraceTest 0
419499  objc27074 ObjCViewController               -coolViewDTraceTest 1
419500  objc27074 ObjCViewController               -coolViewDTraceTest 4
419501  objc27074 ObjCViewController               -coolViewDTraceTest 8
419502  objc27074 ObjCViewController               -coolViewDTraceTest c
419503  objc27074 ObjCViewController               -coolViewDTraceTest 10
419504  objc27074 ObjCViewController               -coolViewDTraceTest 17
419505  objc27074 ObjCViewController               -coolViewDTraceTest 1b
419506  objc27074 ObjCViewController               -coolViewDTraceTest 1c
419507  objc27074 ObjCViewController           -setCoolViewDTraceTest: return
419508  objc27074 ObjCViewController           -setCoolViewDTraceTest: entry
419509  objc27074 ObjCViewController           -setCoolViewDTraceTest: 0
419510  objc27074 ObjCViewController           -setCoolViewDTraceTest: 1
419511  objc27074 ObjCViewController           -setCoolViewDTraceTest: 4
419512  objc27074 ObjCViewController           -setCoolViewDTraceTest: 8
419513  objc27074 ObjCViewController           -setCoolViewDTraceTest: c
419514  objc27074 ObjCViewController           -setCoolViewDTraceTest: 10
419515  objc27074 ObjCViewController           -setCoolViewDTraceTest: 14
419516  objc27074 ObjCViewController           -setCoolViewDTraceTest: 18
419517  objc27074 ObjCViewController           -setCoolViewDTraceTest: 1c
419518  objc27074 ObjCViewController           -setCoolViewDTraceTest: 23
419519  objc27074 ObjCViewController           -setCoolViewDTraceTest: 26
419520  objc27074 ObjCViewController           -setCoolViewDTraceTest: 29
419521  objc27074 ObjCViewController           -setCoolViewDTraceTest: 2c
419522  objc27074 ObjCViewController           -setCoolViewDTraceTest: 31
419523  objc27074 ObjCViewController           -setCoolViewDTraceTest: 35
419524  objc27074 ObjCViewController           -setCoolViewDTraceTest: 36
419525  objc27074 ObjCViewController            -coolBooleanDTraceTest return
419526  objc27074 ObjCViewController            -coolBooleanDTraceTest entry
419527  objc27074 ObjCViewController            -coolBooleanDTraceTest 0
419528  objc27074 ObjCViewController            -coolBooleanDTraceTest 1
419529  objc27074 ObjCViewController            -coolBooleanDTraceTest 4
419530  objc27074 ObjCViewController            -coolBooleanDTraceTest 8
419531  objc27074 ObjCViewController            -coolBooleanDTraceTest c
419532  objc27074 ObjCViewController            -coolBooleanDTraceTest 10
419533  objc27074 ObjCViewController            -coolBooleanDTraceTest 17
419534  objc27074 ObjCViewController            -coolBooleanDTraceTest 1a
419535  objc27074 ObjCViewController            -coolBooleanDTraceTest 1d
419536  objc27074 ObjCViewController            -coolBooleanDTraceTest 20
419537  objc27074 ObjCViewController            -coolBooleanDTraceTest 21
419538  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: return
419539  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: entry
419540  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 0
419541  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 1
419542  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 4
419543  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 8
419544  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: c
419545  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: f
419546  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 12
419547  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 15
419548  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 19
419549  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 20
419550  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 22
419551  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 25
419552  objc27074 ObjCViewController        -setCoolBooleanDTraceTest: 26
419553  objc27074 ObjCViewController                    -.cxx_destruct return
419554  objc27074 ObjCViewController                    -.cxx_destruct entry
419555  objc27074 ObjCViewController                    -.cxx_destruct 0
419556  objc27074 ObjCViewController                    -.cxx_destruct 1
419557  objc27074 ObjCViewController                    -.cxx_destruct 4
419558  objc27074 ObjCViewController                    -.cxx_destruct 8
419559  objc27074 ObjCViewController                    -.cxx_destruct a
419560  objc27074 ObjCViewController                    -.cxx_destruct c
419561  objc27074 ObjCViewController                    -.cxx_destruct 10
419562  objc27074 ObjCViewController                    -.cxx_destruct 14
419563  objc27074 ObjCViewController                    -.cxx_destruct 18
419564  objc27074 ObjCViewController                    -.cxx_destruct 1f
419565  objc27074 ObjCViewController                    -.cxx_destruct 22
419566  objc27074 ObjCViewController                    -.cxx_destruct 25
419567  objc27074 ObjCViewController                    -.cxx_destruct 28
419568  objc27074 ObjCViewController                    -.cxx_destruct 2d
419569  objc27074 ObjCViewController                    -.cxx_destruct 31
419570  objc27074 ObjCViewController                    -.cxx_destruct 32





(lldb) p/x [UIView class]
(Class) $0 = 0x00007fff804345d8 UIView
(lldb) po class_getName(0x00007fff804345d8)
0x00007fff6038a803

(lldb) po (char *)class_getName(0x00007fff804345d8)
"UIView"






╰─ sudo dtrace -n 'pid$target:::entry' -p `pgrep VCTransitions`
Password:
dtrace: description 'pid$target:::entry' matched 887827 probes
(lldb) po (char *)class_getName(0x00007fff804345d8)
CPU     ID                    FUNCTION:NAME
  5 438478              class_getName:entry
  4 511783             start_wqthread:entry
  0 511783             start_wqthread:entry
  5 438469 objc_class::demangledName(bool):entry
  7 511783             start_wqthread:entry
  4 511815          _pthread_wqthread:entry
  7 511815          _pthread_wqthread:entry
  0 511815          _pthread_wqthread:entry
  0 501582 _dispatch_kevent_worker_thread:entry
  4 501583 _dispatch_workloop_worker_thread:entry
  2 510024               kdebug_trace:entry
  0 511786        pthread_getspecific:entry
  4 511786        pthread_getspecific:entry
  2 510022          kdebug_is_enabled:entry
  2 510024               kdebug_trace:entry
  2 510022          kdebug_is_enabled:entry
  0 512002 _pthread_setspecific_static:entry
  2 510216    voucher_mach_msg_revert:entry
  4 512002 _pthread_setspecific_static:entry
  0 502066 _dispatch_introspection_thread_add:entry
  0 511786        pthread_getspecific:entry
  4 502066 _dispatch_introspection_thread_add:entry
  2 501813    voucher_mach_msg_revert:entry
  4 511786        pthread_getspecific:entry
  0 511786        pthread_getspecific:entry
  1 511843     _pthread_wqthread_exit:entry
  0 512002 _pthread_setspecific_static:entry
  4 511786        pthread_getspecific:entry
  0 511786        pthread_getspecific:entry
  4 512002 _pthread_setspecific_static:entry
  0 512002 _pthread_setspecific_static:entry
  2 510217     voucher_mach_msg_adopt:entry
  0 512002 _pthread_setspecific_static:entry
  0 511786        pthread_getspecific:entry
  2 501812     voucher_mach_msg_adopt:entry
  1 511909              _pthread_exit:entry
  2 510024               kdebug_trace:entry
  2 510022          kdebug_is_enabled:entry
  4 502106 _dispatch_introspection_runtime_event:entry
  0 502106 _dispatch_introspection_runtime_event:entry
  4 512002 _pthread_setspecific_static:entry
  0 512002 _pthread_setspecific_static:entry
  1 510197     __disable_threadsignal:entry
  1 511845 _pthread_setcancelstate_exit:entry
  4 501738 _dispatch_event_loop_merge:entry
  0 501738 _dispatch_event_loop_merge:entry
  2 511775         pthread_mutex_lock:entry
  0 511786        pthread_getspecific:entry
  4 511786        pthread_getspecific:entry
  1 511846       _pthread_tsd_cleanup:entry
  0 511538 _platform_memmove$VARIANT$Haswell:entry
  4 511538 _platform_memmove$VARIANT$Haswell:entry
  4 501739     _dispatch_kevent_drain:entry
  0 501739     _dispatch_kevent_drain:entry
  7 424772         thread_terminating:entry
  0 501772 _dispatch_kevent_mach_msg_drain:entry
  4 501774     _dispatch_kevent_merge:entry
  0 501776 _dispatch_kevent_mach_msg_recv:entry
  2 511776 _pthread_mutex_lock_init_slow:entry
  7 424812                   lockLock:entry
  2 511778 _pthread_mutex_firstfit_lock_slow:entry
  0 501766 _dispatch_mach_notification_merge_msg:entry
  4 426670        _NSPrintForDebugger:entry
  4 438774 objc_opt_respondsToSelector:entry




                                                             调用过程中
    寄存器                        用处                      要不要保护

    %rax          临时寄存器；参数可变时传递关于 SSE 寄存器        不要
                  用量的信息；第 1 个返回值寄存器

    %rbx          被调者保存的寄存器；或用作基指针                 要

    %rcx          用来给函数传递第 4 个整数参数                   不要

    %rdx          用来给函数传递第 3 个整数参数                   不要

    %rsp          栈指针                                       要

    %rbp          被调者保存的寄存器；或用作帧指针                 要

    %rsi          用来给函数传递第 2 个参数                      不要

    %rdi          用来给函数传递第 1 个参数                      不要

    %r8           用来给函数传递第 5 个参数                      不要

    %r9           用来给函数传递第 6 个参数                      不要

    %r10          临时寄存器，用来传递函数的静态链指针              不要

    %r11          临时寄存器                                   不要

  %r12-r15        被调者保存的寄存器                             要

 %xmm0–%xmm1      用来传递和返回浮点参数                         不要
   
 %xmm2–%xmm7      用来传递浮点参数                              不要

 %xmm8–%xmm15     临时寄存器                                   不要
  
 %mmx0–%mmx7      临时寄存器                                   不要
   
    %st0          临时寄存器；用来返回 long double 参数          不要

  %st1–%st7       被调者保存的寄存器                            不要

    %fs           留给系统用（作线程特定数据寄存器）               不要


寄存器
一个x86-64的CPU包含16个64位的寄存器，允许操作寄存器的64位-低32位-低16位-低8位：
rsp-esp-sp-spl : 栈指针
rax-eax-ax-al : 返回值
rdi-edi-di-dil : 第1个参数
rsi-esi-si-sil : 第2个参数
rdx-edx-dx-dxl : 第3个参数
rcx-ecx-cx-cxl : 第4个参数
rbx-ebx-bx-bl : 被调用者保存
rbp-ebp-bp-bpl : 被调用者保存
r10-r10d-r10w-r10b : 被调用者保存
r11-r11d-r11w-r11b : 被调用者保存
r12-r12d-r12w-r12b : 被调用者保存
r13-r13d-r13w-r13b : 被调用者保存
r14-r14d-r14w-r14b : 被调用者保存
r15-r15d-r15w-r15b : 被调用者保存




(lldb) b objc_class::demangledName(bool)
Breakpoint 1: where = libobjc.A.dylib`objc_class::demangledName(bool), address = 0x00007fff20186bca
(lldb) exp -i0 -O -- class_getName([UIView class])
error: Execution was interrupted, reason: breakpoint 1.1.
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
(lldb) po $rdi
UIView


一个 C++ 函数，在调用对象函数的方式上，C++ 就像 Objective-C。 有一个隐式的第一个参数，它是调用函数的对象。


ptr：pointer 指针

libobjc.A.dylib`objc_class::demangledName:
->  0x7fff20186bca <+0>:   push   rbp
    0x7fff20186bcb <+1>:   mov    rbp, rsp
    0x7fff20186bce <+4>:   push   r15
    0x7fff20186bd0 <+6>:   push   r14
    0x7fff20186bd2 <+8>:   push   r13
    0x7fff20186bd4 <+10>:  push   r12
    0x7fff20186bd6 <+12>:  push   rbx
    0x7fff20186bd7 <+13>:  sub    rsp, 0x28 // 这一行之后，函数的序幕结束，下一行进入函数的实际内容
    0x7fff20186bdb <+17>:  mov    r12d, esi // r12d = 0，这是传入的布尔值 
    0x7fff20186bde <+20>:  mov    rbx, rdi // rbx = [UIView class] rdi是第一个参数，包含UIView类的引用
    0x7fff20186be1 <+23>:  mov    rax, qword ptr [rdi] // rax = *(rdi) rax:返回值  qword:八字节
    0x7fff20186be4 <+26>:  dec    rax // rax = rax - 1
    0x7fff20186be7 <+29>:  cmp    rax, 0xf
    0x7fff20186beb <+33>:  jb     0x7fff20186c12            ; <+72>
    0x7fff20186bed <+35>:  mov    rcx, qword ptr [rbx + 0x20] // rcx = *(rbx + 0x20)
    0x7fff20186bf1 <+39>:  movabs rax, 0x7ffffffffff8 // rax = 0x7ffffffffff8
    0x7fff20186bfb <+49>:  and    rax, rcx // rax = rax & rcx ; rax = 0x7ffffffffff8 & *(rbx + 0x20)
    0x7fff20186bfe <+52>:  mov    edx, dword ptr [rax]
    0x7fff20186c00 <+54>:  test   edx, edx
    0x7fff20186c02 <+56>:  js     0x7fff20186cd9            ; <+271>
    0x7fff20186c08 <+62>:  bt     edx, 0x1e
    0x7fff20186c0c <+66>:  jb     0x7fff20186cf5            ; <+299>
    0x7fff20186c12 <+72>:  mov    rdi, rbx
    0x7fff20186c15 <+75>:  call   0x7fff2017ce8e            ; objc_class::mangledName()
    0x7fff20186c1a <+80>:  mov    r14, rax
    0x7fff20186c1d <+83>:  mov    rdi, rax
    0x7fff20186c20 <+86>:  xor    esi, esi
    0x7fff20186c22 <+88>:  call   0x7fff2017cd1a            ; copySwiftV1DemangledName(char const*, bool)


This grabs the char* class name from any instance whose class has already been loaded into your process.
Once you’ve entered this into your LLDB console, give it a go on the known-to-work UIView: