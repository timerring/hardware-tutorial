- [交换指令之SWP,MRS,MSR](#交换指令之swpmrsmsr)
  - [存储器与寄存器交换指令（SWP）](#存储器与寄存器交换指令swp)
    - [二进制编码格式](#二进制编码格式)
    - [汇编格式](#汇编格式)
    - [举例](#举例)
  - [状态寄存器与通用寄存器之间的传送指令](#状态寄存器与通用寄存器之间的传送指令)
  - [MRS](#mrs)
    - [MRS的二进制编码](#mrs的二进制编码)
    - [汇编格式](#汇编格式-1)
  - [MSR](#msr)
    - [MSR的二进制编码](#msr的二进制编码)
    - [汇编格式](#汇编格式-2)


# 交换指令之SWP,MRS,MSR

## 存储器与寄存器交换指令（SWP）

交换指令把字或无符号字节的读取和存储组合在了一条指令中。这种组合指令通常用于不能被外部其他存储器访问（如：DMA访问）打断的存储器操作。一般用于处理器之间或处理器与DMA控制器之间共享信息的互斥访问。

### 二进制编码格式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221223093025077.png)

### 汇编格式

```assembly
SWP{<cond>} {B} Rd，Rm，[Rn] 
```

本指令将存储器中地址为Rn处的字（B=0）或无符号字节（B=1）读入寄存器Rd，同时，将Rm中同样类型的数据存入存储器中相同的位置。Rd和Rm可以相同，但与Rn应该不同。另外，PC不能出现在该指令中。

### 举例

```assembly
LDR  R0,SEMAPHORE
SWPB R1,R1,[R0] ；交换字节，将存储器单元[R0]中的字节数据读取到R1中，同时，将R1中的数据写入到存储器单元[R0]中 
SWP  R1,R2，[R3]; 交换字数据，将存储单元[R3]中的字数据读取到R1中，同时，将R2中的数据写入到存储单元[R3]中。               
```

## 状态寄存器与通用寄存器之间的传送指令

 ARM指令中有两条指令，用于在状态寄存器和通用寄存器之间传送数据。修改状态寄存器一般是通过“读取－修改－写回”三个步骤的操作来实现的。 这两条指令分别是：

+ 状态寄存器到通用寄存器的传送指令（MRS）
+ 通用寄存器到状态寄存器的传送指令（MSR） 

## MRS 

MRS指令用于将状态寄存器的内容传送到通用寄存器中，它主要用于以下3种场合：

1. 通过“读-修改-写”修改状态寄存器的内容。MRS用于将状态寄存器的内容读到通用寄存器中，以便修改。
2. 当异常中断允许嵌套时，需要在进入异常中断后，嵌套中断发生之前，保存当前处理器模式的SPSR。这是需要先通过MRS指令读出SPSR的值，然后用其他指令将SPSR的值保存起来。
3. 当进程切换时，也需要保存当前寄存器的值。

### MRS的二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221223093156570.png)

这里R用来区分是将CPSR还是SPSR拷贝到目的寄存器Rd，全部32位都被拷贝。

### 汇编格式

```assembly
MRS{<cond>} Rd，CPSR|SPSR 
```

举例：

```assembly
    MRS   R0，CPSR  ；将CPSR传送到R0 
    MRS  R3，SPSR   ；将SPSR传送到R3 
```

注意事项：

不能通过该指令修改CPSR中的T控制位，直接将程序状态切换到Thumb状态，必须通过BX等指令实现程序状态切换。

在用户或系统模式下没有可以访问的SPSR，所以SPSR形式在这些模式下不能用。

当修改CPSR或SPSR时，必须注意保存所有未使用位的值。
这条指令不影响条件标志码。

## MSR

### MSR的二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221223093247065.png)

操作数可以是一个寄存器Rm也可以是带循环移位的8位有效立即数，在域屏蔽的控制下传送到CPSR或SPSR。

域屏蔽控制PSR中4字节的更新，其中第16位控制PSR[7:0]是否更新，第17位控制PSR[15:8]，第18位控制PSR[23:16]，第19位控制PSR[31:24]。使用立即数时，只有PSR[31:24]可选择。

### 汇编格式

```assembly
MSR{<cond>} CPSR_f | SPSR_f，#<32-bit immediate>
MSR{<cond>} CPSR_<field> | SPSR_<field>，Rm 
```

这里的<field>表示下列情况之一：

+ c---控制域，对应PSR[7:0]
+ x---扩展域，对应PSR[15:8]（在当前ARM中未使用）
+ s---状态域，对应PSR[23:16]（在当前ARM中未使用）
+ f---标志位域，对应PSR[31:24]

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221223093315822.png)

举例：

1. 设置N、Z、C和V标志位

```assembly
         MSR    CPSR_f,#0xF0000000  ;设置所有标志位 
```

2. 仅设置C标志位，保存N、Z和V

```assembly
         MRS    R0,CPSR      ;将CPSR传送到R0
         ORR    R0,R0,#0x200000000 ;设置R0的第29位
         MSR    CPSR_f,R0    ;传送回CPSR
```

3. 从监控模式切换到IRQ模式

```assembly
         MRS   R0,CPSR       ;将CPSR传送到R0
         BIC   R0,R0,#0x1F   ;低5位清0
         ORR  R0,R0,#0x12  ;设置为IRQ模式
         MSR  CPSR_c,R0    ;传送回CPSR
```

注意事项：

在用户模式下不能对CPSR[23:0]做任何修改。

在用户或系统模式下没有SPSR，所以应尽量避免在这些模式下访问SPSR。

在嵌套的异常中断处理中，当退出中断处理程序时，通常通过MSR指令将事先保存了的SPSR内容恢复到当前程序状态寄存器CPSR中。

在修改的状态寄存器位域中包括未分配的位时，避免使用立即数方式的MSR指令。

不能通过该指令直接修改CPSR中的T控制位直接将程序状态切换到Thumb状态，必须通过BX等指令来完成程序状态的切换。



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)