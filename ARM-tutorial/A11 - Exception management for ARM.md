- [ARM的异常管理](#arm的异常管理)
  - [ARM的异常中断响应过程](#arm的异常中断响应过程)
  - [从异常中断处理程序中返回](#从异常中断处理程序中返回)
  - [异常中断向量表](#异常中断向量表)
  - [异常中断的优先级](#异常中断的优先级)


# ARM的异常管理

在ARM体系结构中，异常中断用来处理软件中断、未定义指令陷阱及系统复位功能和外部事件，这些“不正常”事件都被划归“异常”，因为在处理器的控制机制中，它们都使用同样的流程进行异常处理。 

## ARM的异常中断响应过程

ARM处理器对异常中断的响应过程如下

将CPSR的内容保存到将要执行的异常中断对应的SPSR中 设置当前状态寄存器CPSR中的相应位 

将引起异常指令的下一条指令的地址保存到新的异常工作模式的R14 
给程序计数器（PC）强制赋值 

每个异常模式对应有两个寄存器R13\_<mode>、R14\_<mode>分别保存相应模式下的堆栈指针、返回地址；堆栈指针可用来定义一个存储区域保存其它用户寄存器，这样异常处理程序就可以使用这些寄存器。
FIQ模式还有额外的专用寄存器R8_fiq～R12_fiq，使用这些寄存器可以加快快速中断的处理速度。 

## 从异常中断处理程序中返回

从异常中断处理程序中返回时，需要执行以下四个基本操作。

所有修改过的用户寄存器必须从处理程序的保护堆栈中恢复（即出栈）。

将SPSR_mode寄存器内容复制到CPSR中，使得CPSR从相应的SPSR中恢复，即恢复被中断的程序工作状态；

根据异常类型将PC变回到用户指令流中相应指令处
最后清除CPSR中的中断禁止标志位I/F。 

## 异常中断向量表

中断向量表中指定了各异常中断与其处理程序的对应关系。 

每个异常中断对应的中断向量表的4个字节的空间中存放一个跳转指令或者一个向PC寄存器中赋值的数据访问指令。 

存储器的前8个字中除了地址0x00000014之外，全部被用作异常矢量地址。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221211200616352.png)

## 异常中断的优先级 

当几个异常中断同时发生时，在ARM中通过给各异常中断赋予一定的优先级来实现处理次序。 

+ 复位（最高优先级）；
+ 数据异常中止；

+ FIQ；
+ IRQ；
+ 预取指异常中止；
+ SWI，未定义指令（包括缺协处理器）。 



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)