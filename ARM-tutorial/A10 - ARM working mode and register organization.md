- [ARM的工作模式与寄存器组织](#arm的工作模式与寄存器组织)
  - [特权模式](#特权模式)
    - [处理器启动时的模式转换图](#处理器启动时的模式转换图)
  - [ARM的寄存器组织](#arm的寄存器组织)
    - [ARM寄存器组成概述](#arm寄存器组成概述)
    - [ARM状态下的寄存器组织](#arm状态下的寄存器组织)
    - [Thumb状态下的寄存器组织](#thumb状态下的寄存器组织)


# ARM的工作模式与寄存器组织

CPSR（当前程序状态寄存器）的低5位用于定义当前操作模式 ,    如图示

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210105218688.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210105230923.png)

## 特权模式

除用户模式外的其他6种模式称为特权模式。 特权模式中除系统模式以外的5种模式又称为异常模式，即 

+ FIQ（Fast Interrupt Request）
+ IRQ（Interrupt ReQuest）
+ SVC（Supervisor）
+ 中止（Abort）
+ 未定义（Undefined）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210105305508.png)

大多数应用程序在用户模式下执行，当处理器工作在用户模式时，正在执行的程序不能访问某些被保护的系统资源，也不能改变模式，除非异常发生，这允许操作系统来控制系统资源的使用。

当特定的异常出现时，进入相应的模式，每种模式都有某些附加的寄存器，以避免异常出现时，用户模式的状态不可靠。

不能由任何异常模式进入系统模式，它与用户模式有完全相同的寄存器，并且它是特权模式，不受任何用户模式的限制。它供需要访问系统资源的操作系统任务使用，但避免了使用与异常模式有关的附加寄存器，这就使得当任何异常出现时，都不会使任务的状态不可靠。

### 处理器启动时的模式转换图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210105339073.png)

## ARM的寄存器组织

### ARM寄存器组成概述

ARM处理器总共有37个寄存器，可以分为以下两类寄存器 

31个通用寄存器（包括程序计数器PC） 

+ R0～R15（PC）；
+ R13_svc、R14_svc；
+ R13_abt、R14_abt；
+ R13_und、R14_und；
+ R13_irq、R14_irq；
+ R8_frq-R14_frq。 

6个状态寄存器 

+ CPSR；SPSR_svc、SPSR_abt、SPSR_und、SPSR_irq和SPSR_fiq 

### ARM状态下的寄存器组织	

1. ARM状态的寄存器简介 

   ARM状态下的寄存器组织

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210105606233.png)

2) ARM状态的通用寄存器 

  **不分组寄存器**（The unbanked registers）：R0~R7 

  **分组寄存器**（The banked registers）：R8~R14 

  **程序计数器**：R15（PC） 

  **不分组寄存器R0~R7** 

  R0~R7是不分组寄存器。这意味着在所有处理器模式下，它们每一个都访问的是同一个物理寄存器。它们是真正并且在每种状态下都统一的通用寄存器。 

  未分组寄存器没有被系统用于特别的用途，任何可采用通用寄存器的应用场合都可以使用未分组寄存器，但必须注意对同一寄存器在不同模式下使用时的数据保护 

  **分组寄存器R8-R14** 

  + 分组寄存器R8-R12
    FIQ模式分组寄存器R8~R12 
    FIQ以外的分组寄存器R8~R12 
  + 分组寄存器R13、R14
    寄存器R13通常用做堆栈指针SP 
    寄存器R14用作子程序链接寄存器（Link Register－LR），也称为LR 

  **程序计数器R15** 

  + 寄存器R15被用作程序计数器，也称为PC 
  + R15值的改变将引起程序执行顺序的变化，这有可能引起程序执行中出现一些不可预料的结果 
  + ARM处理器采用多级流水线技术，因此保存在R15的程序地址并不是当前指令的地址 
  + 一些指令对于R15的用法有一些特殊的要求

3) ARM程序状态寄存器

   + 所有处理器模式下都可以访问当前的程序状态寄存器CPSR。CPSR包含条件码标志、中断禁止位、当前处理器模式以及其它状态和控制信息。
   + 在每种异常模式下都有一个对应的物理寄存器——程序状态保存寄存器SPSR。当异常出现时，SPSR用于保存CPSR的状态，以便异常返回后恢复异常发生时的工作状态。
   + CPSR和SPSR的格式 
   + ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210110023317.png)

### Thumb状态下的寄存器组织 

Thumb状态下的寄存器集是ARM状态下寄存器集的子集。程序员可以直接访问8个通用的寄存器（R0~R7），程序计数器PC、堆栈指针SP、连接寄存器LR和当前状态寄存器CPSP。每一种特权模式都各有一组SP，LR和SPSR。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210110105606.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221210110125204.png)



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)