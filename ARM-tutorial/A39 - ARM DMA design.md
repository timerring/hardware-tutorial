- [ARM的DMA设计](#arm的dma设计)
    - [一、DMA工作原理](#一dma工作原理)
      - [1. S3C2410结构框图](#1-s3c2410结构框图)
      - [2. DMA请求源](#2-dma请求源)
      - [3. DMA传输过程](#3-dma传输过程)
      - [4. S3C2410 DMA 的基本时序](#4-s3c2410-dma-的基本时序)
      - [5. DMA的服务模式](#5-dma的服务模式)
      - [6. S3C2410 DMA 的两种控制协议](#6-s3c2410-dma-的两种控制协议)
      - [7. S3C2410 DMA 的三种协议类型](#7-s3c2410-dma-的三种协议类型)
    - [二、S3C2410A的DMA控制器](#二s3c2410a的dma控制器)
      - [1. 6个DMA控制寄存器。](#1-6个dma控制寄存器)
      - [2. 3个DMA状态寄存器](#2-3个dma状态寄存器)
    - [三、DMA编程实例](#三dma编程实例)


# ARM的DMA设计

### 一、DMA工作原理 

所谓DMA方式，即直接存储器存取（Direct  Memory Acess），在DMA控制器的控制下，不通过CPU控制，高速地和I/O设备和存储器之间交换数据。

S3C2410具有一个4通道DMA控制器。该DMA控制器位于系统总线（AHB）和外设总线（APB)之间。每个DMA通道均能在系统总线和（或）外设总线之间执行一次数据搬移。这样可以有四种DMA数据搬移：

（1）源设备和目标都在系统总线AHB上 

（2）源设备在系统总线AHB，而目标设备位于外围总线APB 

（3）源设备在外围总线APB，而目标设备位于系统总线AHB 

（4）源设备和目标都在外围总线APB上 

DMA请求可以被软件、片内外设请求或者外部引脚请求来发起。    

#### 1. S3C2410结构框图 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104100735766.png)

####  2. DMA请求源

4通道DMA

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104100805785.png)

 这里nXDREQ0 和nXDREQ1表示两个外部源, I2SSDO 和I2SSDI表示IIS 的发送和接收。

#### 3. DMA传输过程

采用DMA方式进行数据传输的具体过程如下：
（1）外设向DMA控制器发出DMA请求；

（2）DMA控制器向CPU发出总线请求信号；

（3）CPU执行完现行的总线周期后，向DMA控制器发出响应请求的回答信号；

（4）CPU将控制总线、地址总线及数据总线让出，由DMA控制器进行控制；

（5）DMA控制器向外部设备发出DMA请求回答信号；

（6）进行DMA传送；

（7）数据传送完毕，DMA控制器通过中断请求线发出中断信号。CPU在接收到中断信号后，转入中断处理程序进行后续处理。

（8）中断处理结束后，CPU返回到被中断的程序继续执行。CPU重新获得总线控制权。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104100842626.png)

#### 4. S3C2410 DMA 的基本时序 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104100905018.png)

nXDREQ请求生效并经过2CLK周期同步后，nXDACK响应并开始生效，但至少还要经过3CLK的周期延迟，DMA控制器才可获得总线的控制权，并开始数据传输。 

#### 5. DMA的服务模式

共有两种服务模式，一种是单一服务模式（single service），另外一种是整体服务模式（whole service）。

在单一服务模式下，一次请求服务一次，服务完毕后等待DMA 请求再一次来临才能进行新的服务。这种模式下一次请求传输的数据量为：Data Size = Atomic transfer size （字节）


在整体服务模式下，使用DMA 计数器（TC），每传输一个原子传输该计数器减1，直到DMA计数器的值减为零，才等待下一次DMA请求。Data Size = Atomic transfer size × TC（字节） 

Atomic transfer：指的是DMA的单次原子操作，它可以是Unit模式（传输1个data size），也可以是burst模式（传输4个data size） 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101004836.png)

单次原子操作期间，总线将被Hold，其它DMA请求不被响应

#### 6. S3C2410 DMA 的两种控制协议 

+ 请求模式：If XnXDREQ remains asserted, the next transfer starts immediately. Otherwise it waits for XnXDREQ to be asserted. 
+ 握手模式：If XnXDREQ is deasserted, DMA deasserts XnXDACK in 2cycles. Otherwise it waits until XnXDREQ is deasserted. 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101059683.png)

#### 7. S3C2410 DMA 的三种协议类型

+ 单一服务请求
+ 单一服务握手
+ 整体服务握手：

### 二、S3C2410A的DMA控制器 

要进行DMA操作，首先要对S3C2410A的相关寄存器进行正确配置。每个DMA通道有9个控制寄存器，因此对于4通道的DMA控制器来说总共有36个寄存器。其中每个DMA通道的9个控制寄存器中有6个用于控制DMA传输，另外3个用于监控DMA控制器的状态。 

+ DMA初始源寄存器（DISRC） 
+ DMA初始源控制寄存器（DISRCC）
+ DMA初始目标地址寄存器（DIDST） 
+ DMA初始目标控制寄存器（DIDSTC） 
+ DMA控制寄存器（DCON）
+ DMA屏蔽触发寄存器（DMASKTRIG） 
+ DMA状态寄存器（DSTAT） 
+ DMA当前源寄存器（DCSRC） 
+ DMA当前目标寄存器（DCDST） 

#### 1. 6个DMA控制寄存器。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101143184.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101154298.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101201413.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101207143.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101213862.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101219683.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101226081.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101233205.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101238931.png)

#### 2. 3个DMA状态寄存器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101303497.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230104101311566.png)

### 三、DMA编程实例 

举例：使用DMA方式实现从存储器到串口0进行数据发送。

```c
#define  SEND_DATA   (*(volatile unsigned char *) 0x30200000)
#define  SEND_ADDR    ((volatile unsigned char *) 0x30200000)  //待发送数据的起始地址
void Main(void){
	volatile unsigned char* p = SEND_ADDR;
	int i;
	Target_Init();
	Delay(1000);
	SEND_DATA = 0x41; //初始化要发送的数据
	for (i = 0; i < 128; i++){
	    *p++ = 0x41 + i;
	} 
        rUCON0 = rUCON0 & 0xff3 | 0x8; //Uart设置成DMA形式
        rDISRC0 = (U32)(SEND_ADDR); //DMA0 初始化
        rDISRCC0 = (0<<1)|(0<<0); //源=AHB，传送后地址增加
        rDIDST0 = (U32)UTXH0;  //发送FIFO缓冲区地址
        rDIDSTC0 = (1<<1)|(1<<0); //目标=APB，地址固定
        //设置DMA0控制寄存器：握手模式,与APB同步,使能中断,单位传输,单个模式,目标=UART0,
        //硬件请求模式,不自动加载,半字,计数器初值＝50
        rDCON0=(0<<31)|(0<<30)|(1<<29)|(0<<28)|(0<<27)|(1<<24)|(1<<23)|(1<<22)|(0<<20)|(50);
        rDMASKTRIG0 = (1<<1); 	//打开DMA通道0
        while(1);
}
```


参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)