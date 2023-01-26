- [ARM中断系统设计全解](#arm中断系统设计全解)
    - [一、ARM9的异常事件管理](#一arm9的异常事件管理)
    - [二、ARM的中断原理](#二arm的中断原理)
      - [1. S3C2410的56个中断源](#1-s3c2410的56个中断源)
      - [2. S3C2410中断处理的步骤](#2-s3c2410中断处理的步骤)
        - [(1) 保存现场](#1-保存现场)
        - [(2) 模式切换](#2-模式切换)
        - [(3) 获取中断源](#3-获取中断源)
        - [(4) 中断处理](#4-中断处理)
        - [(5) 中断返回，恢复现场](#5-中断返回恢复现场)
    - [三、S3C2410A的中断控制器](#三s3c2410a的中断控制器)
      - [1. 中断控制器使用的寄存器](#1-中断控制器使用的寄存器)
      - [2. INTMOD寄存器](#2-intmod寄存器)
      - [3. SRCPND/ SUBSRCPND寄存器](#3-srcpnd-subsrcpnd寄存器)
      - [4. INTMSK/ INTSUBMSK 寄存器](#4-intmsk-intsubmsk-寄存器)
      - [5. 优先级生成模块](#5-优先级生成模块)
      - [6. PRIORITY寄存器](#6-priority寄存器)
      - [7. 中断挂起寄存器INTPND 寄存器](#7-中断挂起寄存器intpnd-寄存器)
      - [8. INTPND 寄存器](#8-intpnd-寄存器)
      - [9. INTOFFSET寄存器](#9-intoffset寄存器)
      - [10. 外部中断控制寄存器](#10-外部中断控制寄存器)
    - [四、中断编程实例](#四中断编程实例)


# ARM中断系统设计全解

### 一、ARM9的异常事件管理

ARM920T能处理有8个异常，他们分别是：Reset，Undefined instruction，Software Interrupt，Abort (prefetch)，Abort (data)，Reserved，IRQ，FIQ ，它们的矢量表是：

Address                Instruct
0x00000000:                 b        Handle_Reset
0x00000004:                 b        HandleUndef
0x00000008:                 b        HandleSWI
0x0000000C:                 b        HandlePrefetchAbort
0x00000010:                 b        HandleDataAbort
0x00000014:                 b        HandleNotUsed
0x00000018:                 b        HandleIRQ
0x0000001C:                 b        HandleFIQ

ARM920T的异常向量表有两种存放方式，一种是低端存放（从0x00000000处开始存放），另一种是高端存放（从0xfff000000处开始存放）。 

异常矢量表的生成一般由一段汇编程序完成：

```assembly
_start:
    b        Handle_Reset
    b        HandleUndef
    b        HandleSWI
    b        HandlePrefetchAbort
    b        HandleDataAbort
    b        HandleNotUsed
    b        HandleIRQ
    b        HandleFIQ
    …..
    …
    ..
    other codes
    …
    ..
```

这部分片段一般出现在一个名叫“head.s”的汇编文件的里，“b        Handle_Reset”这条语句就是系统上电之后运行的第一条语句。 

我们可以看到每条指令占用了4个字节。

上电后，PC指针会跳转到Handle_Reset处开始运行。以后系统每当有异常出现，则CPU会根据异常号，从内存的0x00000000处开始查表做相应的处理，比如系统触发了一个IRQ异常，IRQ为第6号异常，则CPU将把PC指向0x00000018地址（4*6=24=0x00000018）处运行，该地址的指令是跳转到“中断异常服务例程”（HandleIRQ）处运行。 

### 二、ARM的中断原理 

S3C2410共有56个中断源，可以产生32个中断请求，这些中断源来自两部分：一部分来自片内外设（如DMA、UART等），一部分来自于外部引脚。

ARM920T内核共具有2种类型的中断模式:FIQ和IRQ。IRQ和FIQ之间的区别是：对于FIQ必须尽快处理事件并离开这个模式；IRQ可以被FIQ中断，但IRQ不能中断FIQ；为了使FIQ更快,FIQ模式具有更多的私有寄存器。通过设置将56个中断源分别映射到内核中的FIQ或IRQ，引起内核的中断处理。

当多个中断请求同时发生时，由硬件优先级逻辑确定应该有哪个中断得到服务，同时将仲裁结果写入中断挂起寄存器，以便用户识别中断类型。

#### 1. S3C2410的56个中断源  

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103085834925.png)

#### 2. S3C2410中断处理的步骤  

处理中断的步骤如下：

##### (1) 保存现场

保存当前的PC值到R14，保存当前的程序运行状态到SPSR。

##### (2) 模式切换

根据发生的中断类型，进入IRQ模式或FIQ模式。

##### (3) 获取中断源

以异常向量表保存在低地址处为例，若是IRQ中断，则PC指针跳到0x18处；若是FIQ中断，则跳到0x1C处。IRQ或FIQ的异常向量地址处一般保存的是中断服务子程序的地址，所以接下来PC指针跳入中断服务子程序处理中断。--这些工作都是由硬件自动完成

##### (4) 中断处理

为各种中断定义不同的优先级别，并为每一个中断设置一个中断标志位。当发生中断时，通过判断中断优先级以及访问中断标志位的状态来识别到底哪一个中断发生了。进而调用相应的函数进行中断处理。

##### (5) 中断返回，恢复现场

当完成中断服务子程序后，将SPSR中保存的程序运行状态恢复到CPSR中，R14中保存的被中断程序的地址恢复到PC中，进而继续执行被中断的程序--这些工作必须由用户在中断处理函数中实现。  

### 三、S3C2410A的中断控制器 

中断控制器的角色，就是响应来自片内或片外的中断源的中断请求，向ARM920T提出FIQ(快速中断请求)或IRQ(普通中断请求)的中断请求，请求内核对该中断进行处理。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103085912187.png)

#### 1. 中断控制器使用的寄存器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103085930354.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103085942703.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103090036916.png)

#### 2. INTMOD寄存器 

有效位为32位，每一位与SRCPND中各位相对应，它的作用是指定该位相应的中断源处理模式（IRQ还是FIQ）。若某位为0，则该位相对应的中断按IRQ模式处理，为1则以FIQ模式进行处理，该寄存器初始化值为0x00000000,即所有中断皆以IRQ模式进行处理。 

![image-20230103090024476](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103090024476.png)

#### 3. SRCPND/ SUBSRCPND寄存器 

这两个寄存器在功能上是相同的，它们是中断源引脚寄存器，在一个中断异常处理流程中，中断信号传进中断异常处理模块后首先遇到的就是SRCPND/ SUBSRCPND,这两个寄存器的作用是用于标示出哪个中断请求被触发。
SRCPND的有效位为32，SUBSRCPND 的有效位为11，它们中的每一位分别代表一个中断源，每个位的初始值皆为0。假设现在系统触发了TIMER0中断，则第10bit将被置1，代表TIMER0中断被触发，该中断请求即将被处理（若该中断没有被屏蔽的话）。

这两个寄存器的各个位的置1是由相应的中断源自动引起的，而在中断服务程序中必须将其清0，否则CPU将认为是又一次中断的到来。
SRCPND（地址为0X4A000000）为主中断源挂起寄存器，SUBSRCPND（地址为0X4A000018）为副（次）中断源挂起寄存器 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103090954359.png)

SUB SOURCE PENDING (SUBSRCPND) REGISTER

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091010083.png)

#### 4. INTMSK/ INTSUBMSK 寄存器 

中断屏蔽寄存器 ，**INTMSK**为主中断屏蔽寄存器，**INTSUBMSK**为副中断屏蔽寄存器。**INTMSK**有效位为32，**INTSUBMSK**有效位为11，这两个寄存器各个位与**SRCPND**和**SUBSRCPND**分别对应。

它们的作用是决定该位相应的中断请求是否被处理。若某位被设置为1，则该位相对应的中断产生后将被忽略（CPU不处理该中断请求），设置为0则对其进行处理。

这两个寄存器初始化后的值是0xFFFFFFFF和0x7FF，既**默认情况下所有的中断都是被屏蔽的**。

#### 5. 优先级生成模块  

CPU某个时刻只能对一个中断源进行中断处理，如果现在有3个中断同时发生了，那CPU要按什么顺序处理这个3个中断呢？这正是引入优先级判断的原因所在，通过优先级判断，CPU可以按某种顺序逐个处理中断请求。3sc2410的优先级判断分为两级。
如下图所示，SRCPND寄存器对应的32个中断源总共被分为6个组，每个组由一个ARBITER（0\~5）寄存器对其进行管理。中断必须先由所属组的ARBITER（0\~5）进行第一次优先级判断（第一级判断）后再发往ARBITER6进行最终的判断（第二级判断）。
我们能够控制的是某个组里面各个中断的优先级顺序。怎么控制？通过PRIORITY寄存器进行控制。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091117844.png)

![image-20230103091124147](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091124147.png)

#### 6. PRIORITY寄存器 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091150840.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091157476.png)

PRIORITY寄存器内部各个位被分为两种类型，一种是ARB_MODE,另一种为ARB_SEL, ARB_MODE类型有7组对应ARBITER（0\~6），ARB_SEL类型有7组对应ARBITER（7\~20）。现在我将以ARBITER2为例，讲解中断组与PRIORITY寄存器中ARB_SEL, ARB_MODE之间的相互关系。 

首先我们看到ARBITER2寄存器管理的该组中断里包括了6个中断，分别是INT_TIMER0，INT_TIMER1，INT_TIMER2，INT_TIMER3，INT_TIMER4，INT_UART2，它们的默认中断请求号分别为REQ0，REQ1，REQ2，REQ3，REQ4，REQ5。

我们先看PRIORITY寄存器中的ARB_SEL2，该参数由两个位组成，初始值为00。从该表可以看出00定义了一个顺序 0-1-2-3-4-5 ，这个顺序就是这组中断组的优先级排列，这个顺序指明了以中断请求号为0（REQ0）的INT_TIMER0具有最高的中断优先级，其次是INT_TIMER1，INT_TIMER2…。

假设现在ARB_SEL2的值被我们设置为01。则一个新的优先级次序将被使用，01对应的优先级次序为0-2-3-4-1-5，从中可以看出优先级最高和最低的中断请求和之前没有变化，但本来处于第2优先级的INT_TIMER1中断现在变成了第5优先级。

从ARB_SEL2被设置为00,01,10,11各个值所出现的情况我们可以看出，除最高和最低的优先级不变以外，其他各个中断的优先级其实是在做一个旋转排列（rotate）。为了达到对各个中断平等对待这一目标，我们可以让优先级次序在每个中断请求被处理完之后自动进行一次旋转，如何自动让它旋转呢？我们可以通过ARB_MODE2达到这个目的，该参数只有1个 bit，置1代表开启对应中断组的优先级次序旋转，0则为关闭。事实上当该位置为1之后，每处理完某个组的一个中断后，该组的ARB_SEL便递增在1（达到11后恢复为00）。 

#### 7. 中断挂起寄存器INTPND 寄存器

INTPND 寄存器可能是整个中断处理过程中我们要特别注意的一个寄存器了，他的操作比较特别 。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091300962.png)

INTPND 寄存器与SRCPND长得一模一样，但他们在中断异常处理中却扮演着不同的角色，如果说SRCPND是中断信号进入中断处理模块后所经过的第一个场所的话，那么INTPND 则是中断信号在中断处理模块里经历的最后一个寄存器。

SRCPND是中断源挂起寄存器，某个位被置1表示相应的中断被触发，但我们知道在同一时刻内系统可以触发若干个中断，只要中断被触发了，SRCPND的相应位便被置1，也就是说SRCPND 在同一时刻可以有若干位同时被置1，然而INTPND则不同，他在某一时刻只能有1个位被置1，INTPND 某个位被置1（该位对应的中断在所有已触发的中断里具有最高优先级且该中断没有被屏蔽），则表示CPU即将或已经在对该位相应的中断进行处理。

总结：SRCPND说明了有什么中断被触发了，INTPND说明了CPU即将或已经在对某一个中断进行处理。 

#### 8. INTPND 寄存器 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091331760.png)

特别注意：

每当某一个中断被处理完之后，我们必须手动地把SRCPND/SUBSRCPND , INTPND三个寄存器中与该中断相应的位由1设置为0。

INTPND的操作很特别，它的特别之处就在于对当我们要把该寄存器中某个值为1的位设置为0时，我们不是往该位置0，而是往该位置1。

假设SRCPND=0x00000003，INTPND=0x00000001,该值说明当前0号中断和1号中断被触发，但当前正在被处理的是0号中断，处理完毕后我们应该这样设置INTPND和SRCPND：

```c
SRCPND=0x00000002             //位0被置为0
INTPND=0x00000001             //位0被置为0（方法是往该位写入1）
```

#### 9. INTOFFSET寄存器

它的作用只是用于表明哪个中断正在被处理。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091434582.png)

若当前INT_TIMER0被触发了，则该寄存器的值为10，以此类推。 

#### 10. 外部中断控制寄存器

24个外部中断占用GPF0\~GPF7(EINT0\~EINT7)、GPG0\~GPG15(EINT8\~EINT23)。用这些脚做中断输入，则必须配置引脚为中断，并且不要上拉。 

EXTINT0\~EXTINT2寄存器：设定EINT0\~EINT23的触发方式。 

EINTFLT0~EINTFLT3寄存器：控制滤波时钟和滤波宽度。 

EINTPEND寄存器：这个是中断挂起寄存器，清除时要写1。当一个外部中断(EINT4\~EINT23)发生后，那么相应的位会被置1。为什么没有EINT0\~EINT3，看看SRCPND就知道了.

EINTMASK寄存器：屏蔽中断用的，某位为1时，此次中断无效。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230103091521663.png)

### 四、中断编程实例

举例:通过定时器1中断控制CPU板的LED1和LED2实现轮流闪烁。

1．对定时器1初始化，并设定定时器的中断时间为1秒。

```c
void Timer1_init(void){
    rGPGCON = rGPGCON & 0xfff0ffff | 0x00050000; //配置GPG口为输出口
    rGPGDAT = rGPGDAT | 0x300;
    rTCFG0  = 255;      
    rTCFG1  = 0 << 4;   
    //在pclk=50MHZ下，1秒钟的记数值rTCNTB1 =50000000/4/256=48828; 
    rTCNTB1 = 48828; 
    rTCMPB1 = 0x00;
    rTCON   = (1 << 11) | (1 << 9) | (0 << 8); //禁用定时器1，手动加载
    rTCON   = (1 << 11) | (0 << 9) | (1 << 8); //启动定时器1，自动装载
}
```

2．为了使CPU响应中断，在中断服务子程序执行之前，必须打开ARM920T的CPSR中的I位，以及相应的中断屏蔽寄存器中的位。

```c
void Timer1INT_Init(void){ //定时器接口使能
    if ((rINTPND & BIT_TIMER1)){
    	rSRCPND |= BIT_TIMER1;
    }
    //写入定时器1中断服务子程序的入口地址
    pISR_TIMER1 = (int)Timer1_ISR; 
    rINTMSK  &= ~(BIT_TIMER1);  //开中断；    
}
```

3．等待定时器中断，通过一个死循环如“while(1)；”实现等待过程。 

4．根据设置的定时时间，将产生定时器中断。定时器中断发生后，首先进行现场保护，接下来转入中断的入口代码处执行，该部分代码通常使用汇编语言书写。在执行中断服务程序之前，首先要确保HandleIRQ地址处保存中断分发程序IsrIRQ的入口地址。

```assembly
	ldr	r0,=HandleIRQ      
    ldr	r1,=IsrIRQ          		
	str	r1,[r0]
```

接下来将执行IsrIRQ中断分发程序，具体代码如下：

```assembly
IsrIRQ  
	sub	sp,sp,#4       		;为保存PC预留堆栈空间
	stmfd	sp!,{r8-r9}     
	ldr	r9,=INTOFFSET       
	ldr	r9,[r9]		     ;加载INTOFFSET寄存器值到r9
	ldr	r8,=HandleEINT0		;加载中断向量表的基地址到r8
	add	r8,r8,r9,lsl #2		;获得中断向量
	ldr	r8,[r8]		;加载中断服务程序的入口地址到r8
	str	r8,[sp,#8]	;保存sp，将其作为新的pc值
	ldmfd	sp!,{r8-r9,pc}	;跳转到中断服务子程序执行
```

5．执行中断服务子程序，该子程序实现将LED1和LED2灯熄灭或点亮，从现象中看到LED1和LED2灯闪烁一次，则说明定时器发生了一次中断。

```c
int flag;
void __irq Timer1_ISR( void ){ 
 	if (flag == 0) {
           rGPGDAT = rGPGDAT & 0xeff | 0x200;
 	    flag = 1;
 	}
 	else{
    	    rGPGDAT = rGPGDAT & 0xdff | 0x100;
 	    flag = 0;
 	}
   	rSRCPND |= BIT_TIMER1;
   	rINTPND |= BIT_TIMER1;
}
```

6．从中断返回，恢复现场，跳转到被中断的主程序继续执行，等待下一次中断的到来。



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)