- [ARM异常中断指令SWI、BKPT、CLZ详解](#arm异常中断指令swibkptclz详解)
  - [SWI](#swi)
    - [二进制编码](#二进制编码)
    - [汇编格式](#汇编格式)
  - [断点指令（BKPT—仅用于v5T体系）](#断点指令bkpt仅用于v5t体系)
    - [二进制编码](#二进制编码-1)
    - [汇编格式](#汇编格式-1)
  - [前导0计数](#前导0计数)
    - [二进制编码](#二进制编码-2)
    - [汇编格式](#汇编格式-2)


# ARM异常中断指令SWI、BKPT、CLZ详解

异常中断指令可以分为一下两种：

+ 软件中断指令（SWI） 
+ 断点指令（BKPT—仅用于v5T体系）

软件中断指令SWI用于产生SWI异常中断，用来实现在用户模式下对操作系统中特权模式的程序的调用；断点中断指令BKPT主要用于产生软件断点，供调试程序用。 

## SWI

SWI（SoftWare Interrupt）代表“软件中断”，用于用户调用操作系统的系统例程，常称为“监控调用”。它将处理器置于监控（SVC）模式，从地址0x08开始执行指令。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221225085817256.png)

SWI指令用于产生软件中断，以便用户程序能调用操作系统的系统例程。操作系统在SWI的异常处理程序中提供相应的系统服务，指令中24位的立即数指定用户程序调用系统例程的类型，相关参数通过通用寄存器传递。

当指令中24位的立即数被忽略时，用户程序调用系统例程的类型由通用寄存器R0的内容决定，同时，参数通过其他通用寄存器传递。 

例如： 

```assembly
MOV R0, #’A’   ;将’A’调入到R0中… …
SWI   SWI_WriteC    ;……打印它
```

### 汇编格式

```assembly
   SWI {<cond>}	<24位立即数> 
```

如果条件通过，则指令使用标准的ARM异常入口程序进入监控（SVC）程序（管理模式），这时处理器的行为是：

+ 将SWI后面指令的地址保存到R14_svc 。
+ 将CPSR保存到SPSR_svc 。 
+ 进入监控模式，将CPSR[4：0]设置为0b10011和将CPSR[7]设置为1，以便禁止IRQ（但不是FIQ）。
+ 将PC设置为0x08，并且从这里开始执行指令。

## 断点指令（BKPT—仅用于v5T体系） 

断点指令用于软件调试；它使处理器停止执行正常指令（使处理器中止预取指）而进入相应的调试程序。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221225085958491.png)

### 汇编格式

```assembly
BKPT   { immed_16} 
```

> 注：immed_16为表达式，其值为0～65536，该立即数被调试软件用来保存额外的端点信息。另外，该指令是无条件的。并且V5T体系结构的微处理器才支持BKPT。

举例：

```assembly
       BKPT  ；
       BKPT  0xF02C ;
```

## 前导0计数

前导0计数（CLZ—仅用于V5T体系）用来实现数字归一化。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221225090030397.png)

说明：本指令将Rd设置为Rm中为1的最高有效位的位置数，即对Rm中的前导0的个数进行计数，并将计数结果放到Rd中。

### 汇编格式

```assembly
CLZ   { <cond>}Rd,Rm 
```

> 注:Rd不允许是R15（PC）。

举例：

```assembly
       MOV  R2,#0x17F00  
       CLZ   R3,R2 ;  R3=15 
```



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)