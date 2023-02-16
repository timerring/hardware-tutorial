# ARM处理器工作模式

## 一、实验目的

（1） 通过实验掌握学会使用msr/mrs 指令实现ARM 处理器工作模式的切换，观察不同模式下的寄存器，加深对CPU 结构的理解；

（2） 通过实验掌握ld 中如何使用命令行指定代码段起始地址。

## 二、实验环境

硬件：PC机。

软件：ADS1.2 集成开发环境

## 三、实验内容

通过 ARM 汇编指令，在各种处理器模式下切换并观察各种模式下寄存器的区别；掌握ARM 不同模式的进入与退出。

## 四、实验要求

(1)按照2.3节介绍的方法, 在ADS下创建一个工程asmmodelab，完成各个模式下的堆栈初始化工作,并将R1-R12的内容存入当前模式下堆栈。通过AXD运用单步执行方式调试程序，验证工作模式的切换，注意观察CPSR寄存器中的变化。随着程序调试过程中在模式间的切换，使用寄存器观察器切换到不同的工作模式下观察SP（R13）的变化情况。

(2)实验过程中请记录并思考以下内容：

  1）程序复位之后系统处于什么模式？

  2）记录每种模式下的初始堆栈指针，以及执行R1-R12内容压栈后本模式堆栈相关内存单元的数值。并分析快速中断FIQ模式与其他模式存入的R1-R12有什么不同。

  3）切换成用户模式之后还能否从用户模式切换到其他模式（如系统模式）？

  4）用户模式下能否执行堆栈压栈操作？如果能得话，观察用户模式下压栈之前和压栈之后其堆栈区域的变化情况。

  5）观察本程序模式切换过程中SPSR有无变化，并解释其原因。

## 五、实验情况

1、实验源代码（含注释）：

```assembly
usr_stack_legth equ 64 ;定义各个模式的栈空间长度
svc_stack_legth equ 32
fiq_stack_legth equ 16
irq_stack_legth equ 64
abt_stack_legth equ 16
und_stack_legth equ 16               

  area reset,code,readonly ;定义code片段reset只读
  entry ;设置程序入口伪指令
  code32 ;定义后面的指令为32位的ARM指令

;设置各个寄存器中的内容
start    mov r0,#0
    mov r1,#1
    mov r2,#2
    mov r3,#3
    mov r4,#4
    mov r5,#5
    mov r6,#6
    mov r7,#7
    mov r8,#8
    mov r9,#9
    mov r10,#10
    mov r11,#11
    mov r12,#12
             
    bl initstack  ;跳转至initstack，并且初始化各模式下的堆栈指针，打开IRQ中断(将cpsr寄存器的i位清0)
                              
    mrs r0,cpsr        ;r0<--cpsr
    bic r0,r0,#0x80    ;cpsr的I位置0，开IRQ中断
    msr cpsr_cxsf,r0   ;cpsr<--r0
                                    
    ;切换到用户模式
    msr cpsr_c,#0xd0  ;设置11010000，其中I，F位置1，禁止IRQ和FIQ中断，T=0，ARM执行，M[4：0]为10000，切换到用户模式
    mrs r0,cpsr          ;r0<--cpsr
    stmfd sp!,{r1-r12}   ;将R1-R12入栈     
;观察用户模式能否切换到其他模式
    ;切换到管理模式
    msr cpsr_c,#0xdf    ;设置11011111，其中I，F位置1，禁止IRQ和FIQ中断，T=0，ARM执行，M[4：0]为11111，切换到系统模式
    mrs r0,cpsr			;r0<--cpsr
    stmfd sp!,{r1-r12}  ;将寄存器列表中的r1-r12寄存器存入堆栈

halt  b halt ;从halt跳转到halt循环

initstack  mov r0,lr   ; r0<--lr,因为各种模式下r0是相同的而各个模式不同       
                                   
    ;设置管理模式堆栈
    msr cpsr_c,#0xd3   ; 设置11010011 切换到管理模式
    ldr sp,stacksvc    ;设置管理模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置中断模式堆栈
    msr cpsr_c,#0xd2   ;设置11010010  切换到中断模式
    ldr sp,stackirq    ;设置中断模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置快速中断模式堆栈
    msr cpsr_c,#0xd1   ; 设置11010001  切换到快速中断模式
    ldr sp,stackfiq    ;设置快速中断模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置中止模式堆栈   
    msr cpsr_c,#0xd7   ; 设置11010111  切换到中止模式
    ldr sp,stackabt    ;设置中止模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置未定义模式堆栈   
    msr cpsr_c,#0xdb   ; 设置11011011  切换到未定义模式
    ldr sp,stackund    ;设置未定义模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置系统模式堆栈    
    msr cpsr_c,#0xdf   ; 设置11011111  切换到系统模式
    ldr sp,stackusr    ;设置系统模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    mov pc,r0 ;返回
    
    ;为各模式堆栈开辟一段连续的字存储空间
stackusr    dcd  usrstackspace+(usr_stack_legth-1)*4
stacksvc    dcd  svcstackspace+(svc_stack_legth-1)*4
stackirq    dcd  irqstackspace+(irq_stack_legth-1)*4
stackfiq    dcd  fiqstackspace+(fiq_stack_legth-1)*4
stackabt    dcd  abtstackspace+(abt_stack_legth-1)*4
stackund    dcd  undstackspace+(und_stack_legth-1)*4
	  ;定义data段并命名
      area reset,data,noinit,align=2
;为各模式堆栈分配存储区域
usrstackspace space usr_stack_legth*4
svcstackspace space svc_stack_legth*4
irqstackspace space irq_stack_legth*4
fiqstackspace space fiq_stack_legth*4
abtstackspace space abt_stack_legth*4
undstackspace space und_stack_legth*4
    end
```

2、实验过程（含结果截图及相应文字解释）：

实验过程中请记录并思考以下内容：

1）程序复位之后系统处于什么模式？

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172434148.png)

由上可知，系统复位后处于管理模式。

2）记录每种模式下的初始堆栈指针，以及执行R1-R12内容压栈后本模式堆栈相关内存单元的数值。并分析快速中断FIQ模式与其他模式存入的R1-R12有什么不同。

①管理模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172449005.png)

由上图可知，管理模式初始指针为0x8244。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172459007.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8214，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

②中断模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172509999.png)

由上图可知，中断模式初始指针为0x8344。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172520181.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8314，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

③快速中断模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172530582.png)

由上图可知，快速中断模式初始指针为0x8384。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172540224.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8354，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R7存储的数值对应，说明该模式下仅能压入R1-R7，因为快速中断模式有自己的R8-R12。

④中止模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172552215.png)

由上图可知，中止模式初始指针为0x83C4。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172604110.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8394，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

⑤未定义模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172615549.png)

由上图可知，未定义模式初始指针为0x8404。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172625583.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x83D4，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

⑥系统模式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172635438.png)

由上图可知，系统模式初始指针为0x81C4。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172645101.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8194，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

⑦用户模式：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172657646.png)

由上图可知，用户模式初始指针为0x8194。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172705997.png)

执行R1-R12内容压栈后本模式堆栈相关内存单元的数值如上图所示，可知压栈后，堆栈指针变为0x8164，离初始的堆栈指针0x30字节，即12个字(32位系统)，从内存单元的数值可以看到分别与R1-R12存储的数值对应。

 

3）切换成用户模式之后还能否从用户模式切换到其他模式（如系统模式）？

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172713999.png)

由上图可知，当进行切换管理模式时，模式仍是用户模式，因此可知切换成用户模式之后，不能操作CPSR返回到其他模式。

 

4）用户模式下能否执行堆栈压栈操作？如果能得话，观察用户模式下压栈之前和压栈之后其堆栈区域的变化情况。

压栈前：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172739431.png)

压栈后： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172749462.png)

压栈后存储单元情况：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230216172758958.png)

答：用户模式下可以执行堆栈压栈操作，且以4个字节（1个字）为单位进行压栈操作，压栈前堆栈区域情况如左图，压栈后如右图所示，对应的存储单元情况如上图。

5）观察本程序模式切换过程中SPSR有无变化，并解释其原因。

答：除了用户模式和系统模式，其余模式下都有一个私有SPSR保存状态寄存器. 用来保存切换到该模式之前的执行状态，SPSR是异常模式的程序状态保存寄存器, 当特定的异常中断发生时，这个寄存器存放CPSR的内容，在异常中断退出时，可以用SPSR来恢复CPSR，但是通过观察可知，整个切换过程中没有异常的发生，因此SPSR没有变化。

## 六、总结

ARM处理器模式分别是usr（用户模式），fiq（快速中断模式），irq（通用中断模式），svc（管理模式），abt（终止模式），sys（系统模式）以及und（未定义模式）。也通过ARM指令，实现了ARM不同模式的进入与退出，切换各种处理器模式，并观察各种模式下寄存器的区别。当特定的异常出现时，进入相应的模式。每种模式都有某些附加的寄存器，以避免异常出现时用户模式的状态不可靠。此外也使用状态寄存器到通用寄存器的传送指令（MRS）以及通用寄存器到状态寄存器的传送指令（MSR），修改状态寄存器通过“读取－修改－写回”三个步骤操作来实现。





[返回首页](https://github.com/timerring/hardware-tutorial)