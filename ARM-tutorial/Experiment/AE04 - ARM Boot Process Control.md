# ARM启动过程控制实验

## 一、实验目的

（1） 掌握建立基本完整的ARM 工程，包含启动代码，C语言程序等；

（2） 了解ARM启动过程，学会编写简单的C 语言程序和汇编启动代码并进行调试；

（3） 掌握如何指定代码入口地址与入口点；

（4） 掌握通过memory/register/watch/variable 窗口分析判断结果。

## 二、实验环境

硬件：PC机。

软件：ADS1.2 集成开发环境

## 三、实验内容

使用汇编语言编写初始化程序，并引导至C语言main函数，用汇编语言编写延时函数实现毫秒级的延时，在C语言中调用延时函数,实现1s钟定时。

## 四、实验要求

(1) 在ADS下创建一个工程armasmc，编写3个文件，如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164645184.png)

其中一个初始化汇编语言文件Init.s，该文件中主要完成异常矢量表的建立，模式堆栈初始化，并将程序引导至C语言的main函数。

C语言程序保存为armasmc.c。 C语言中调用汇编语言文件delay.s中的毫秒延时程序delayxms，C语言将延时的毫秒数通过参数传递到汇编语言，汇编语言完成延时，然后返回C语言函数。

通过AXD运用单步执行方式调试程序。观察程序执行过程中的寄存器及存储器的变化情况。

（2）实验过程中请记录并思考以下内容：

  1）如何建立异常矢量入口表？

  2）如何在汇编语言中切换至C语言的main函数？。

  3）如何在C语言中调用汇编语言函数，并完成参数传递？

  4）汇编语言函数中用到的寄存器如何保护与恢复，为什么要保护参考程序中的R11？

  5）将delay.s中的R11改成R4，并将两条R11 的保护与恢复语句stmfd sp!,{r11} 和ldmfd sp!,{r11}删掉，在C语言程序中的语句i--处设置端点，观察运行过程中变量i的变化情况，并解释其中的原因。

## 五、实验情况

1、实验源代码（含注释）：

Init.s代码：

```assembly
;************************ entry.s ****************************
 IMPORT Main  ;在汇编程序调用该c程序前要在汇编语言程序中使用IMPORT伪操作来声明该c程序

  area Init,code,readonly   ;定义CODE片段Init 只读 
  entry     ;设置程序入口伪指令
  code32   ;以下为32位的ARM程序
; *********** Setup interrupt/exception vector *******************
start              b Reset_Handler        ;异常矢量表，根据异常矢量表进入不同模式的中断程序      
Undefined_Handler  b Undefined_Handler
SWI_Handler        b SWI_Handler
Prefetch_handler   b Prefetch_handler
Abort_Handler      b Abort_Handler
                   nop   ;Reserved vector
IRQ_Handler        b IRQ_Handler
FIQ_Handler        b FIQ_Handler

Reset_Handler     ;Reset中断，为整个中断的实际入口点        
             bl initstack    ;初始化各模式下的堆栈指针
                             
             ;切换至用户模式堆    
             msr cpsr_c,#0xd0    ;110  10000
                 
             bl Main

halt  b halt

initstack    mov r0,lr   ;r0<--lr,因为各种模式下r0是相同的而各个模式?                            
                                   
             ;设置管理模式堆栈
             msr cpsr_c,#0xd3    ;110  10011  
             ldr sp,stacksvc
               
             ;设置中断模式堆栈
             msr cpsr_c,#0xd2    ;110  10010
             ldr sp,stackirq  
             
             ;设置快速中断模式堆栈
             msr cpsr_c,#0xd1    ;110  10001
             ldr sp,stackfiq
                                
             ;设置中止模式堆栈      
             msr cpsr_c,#0xd7    ;110  10111
             ldr sp,stackabt
                                    
            ;设置未定义模式堆栈   
             msr cpsr_c,#0xdb    ;110  11011
             ldr sp,stackund
   
             ;设置系统模式堆栈    
             msr cpsr_c,#0xdf    ;110  11111
             ldr sp,stackusr
             
             mov pc,r0 ;返回
         
  LTORG      

stackusr     dcd  usrstackspace+128
stacksvc     dcd  svcstackspace+128
stackirq     dcd  irqstackspace+128
stackfiq     dcd  fiqstackspace+128
stackabt     dcd  abtstackspace+128
stackund     dcd  undstackspace+128

  area Interrupt,data,READWRITE  ;分配堆栈空间
usrstackspace space 128
svcstackspace space 128
irqstackspace space 128
fiqstackspace space 128
abtstackspace space 128
undstackspace space 128
     
       end
```

delay.s代码：

```assembly
;************************* delay.s *****************************
  EXPORT delayxms ；EXPORT伪指令用于在程序中声明一个全局的标号，该标号可在其他的文件中引用
  area delay,code,readonly  ;定义code片段delay只读
  code32  ;以下为32位的ARM程序
  
;下面是延时若干ms的子程序      
delayxms
     stmfd sp!,{r11} ; 寄存器入栈
     sub r0,r0,#1 ;r0=r0-1
     ldr r11,=1000 ；加载至r11中
loop2
     sub r11,r11,#1 ；每次将r11自减一
     cmp r11,#0x0 ;将r11与0比较
     bne loop2  ;比较的结果不为0，则继续调用loop2  
     cmp r0,#0x0    ;将r0与0比较
     bne delayxms   ;比较的结果不为0，则继续调用delayxms
     ldmfd sp!,{r11};
     mov pc,lr;返回
     
     end
```

armasmc.c代码：

```assembly
//*************************armasmc.c******************************
#include <stdio.h>
int Main()
{  
  extern void delayxms(int xms);  //在C程序调用汇编程序之前需要在C语言程序中使用extern关键词来声明该汇编程序
  
  int i=100;
  
  while(1)
  {
     delayxms(1000); // 调用delayxms汇编程序
     i--;
     if(i==0)
       i=100;
  }
  return 0;
}
```

2、实验过程（含结果截图及相应文字解释）：

1.如何建立异常矢量入口表？

答：建立异常矢量入口表需要设置中断类型号，并且要设置中断服务子程序段地址，以根据异常矢量表进入不同模式的中断程序。在实验程序中也有定义：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164750525.png)

2.如何在汇编语言中切换至C语言的main函数？

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164800573.png)

答：由上代码可知，为保证程序调用时参数的正确传递，汇编程序设计要遵守ATPCS（ARM-Thumb Produce Call Standard）,它是ARM程序和Thumb程序中子程序调用的基本规则，目的是为了使单独编译的C语言程序和汇编程序之间能够相互调用。这些基本规则包括子程序调用过程中寄存器的使用规则、数据栈的使用规则和参数的传递规则。在C程序中不需要任何关键字来声明将被汇编语言调用的C程序，但需要在汇编语言程序之前使用IMPORT伪操作来声明该C程序。在汇编程序中通过BL指令来调用子程序。同时，汇编程序可以通过地址间接访问在C语言程序中声明的全局变量。通过使用IMPORT关键词引入全局变量，并利用LDR和STR指令根据全局变量的地址可以访问它们。

3.如何在C语言中调用汇编语言函数，并完成参数传递？

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164818655.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164824557.png)

答：为了保证程序调用时参数的正确传递，汇编程序设计要遵守ATPCS。在汇编程序中需要使用EXPORT伪操作来声明，同时，在C程序中调用该汇编程序之前需要在C语言程序中使用extern关键词来声明该汇编程序。

4.汇编语言函数中用到的寄存器如何保护与恢复，为什么要保护参考程序中的R11？

答：汇编语言函数中用到的寄存器通过压栈来保护，出栈来恢复。根据ATPCS规则，R11对应ARM 状态局部变量寄存器8，R11中含有循环次数的重要参量，因此要保护R11避免在程序运行与调用过程中受到影响而导致程序异常。

 

5.将delay.s中的R11改成R4，并将两条R11 的保护与恢复语句stmfd sp!,{r11} 和ldmfd sp!,{r11}删掉，在C语言程序中的语句i--处设置端点，观察运行过程中变量i的变化情况，并解释其中的原因。

修改程序如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230217164908542.png)

答：由上可知R4对应局部变量寄存器1，即变量i，因此在子程序delay.s中，R4的值减为0，若不进行保护，则返回C程序后自减-1，导致变量i的值变为-1，此时将无法满足0的条件，也就无法执行if，导致i会一直递减下去，最终无法停止。

## 六、总结

本次有关汇编与C语言相互调用的部分，建立异常矢量入口表的方法，即需要设置中断类型号，并且要设置中断服务子程序段地址，以根据异常矢量表进入不同模式的中断程序。此外，还有ARM程序和Thumb程序中子程序调用的基本规则ATPCS（ARM-Thumb Produce Call Standard），目的是为了使单独编译的C语言程序和汇编程序之间能够相互调用。这些基本规则包括子程序调用过程中寄存器的使用规则、数据栈的使用规则和参数的传递规则，为调用提供了相关的规范。其中汇编程序访问全局C变量的方法是：汇编程序可以通过地址间接访问在C语言程序中声明的全局变量。通过使用IMPORT关键词引入全局变量，并利用LDR和STR指令根据全局变量的地址可以访问它们。在C语言程序中调用汇编程序的方法是：在汇编程序中需要使用EXPORT伪操作来声明，使得本程序可以被其它程序调用。同时，在C程序调用该汇编程序之前需要在C语言程序中使用extern关键词来声明该汇编程序。而在汇编程序中调用C语言程序的方法是：在C程序中不需要使用任何关键字来声明将被汇编语言调用的C程序，但是在汇编程序调用该C程序之前需要在汇编语言程序中使用IMPORT伪操作来声明该C程序。在汇编程序中通过BL指令来调用子程序。





[返回首页](https://github.com/timerring/hardware-tutorial)