- [万字详解通信接口设计](#万字详解通信接口设计)
- [UART接口](#uart接口)
  - [UART的工作原理](#uart的工作原理)
  - [UART的功能和组成](#uart的功能和组成)
    - [S3C2410A的UART](#s3c2410a的uart)
    - [UART 操作](#uart-操作)
      - [（1）数据发送](#1数据发送)
      - [（2）数据接收](#2数据接收)
      - [（3）自动流控制](#3自动流控制)
      - [（4）非自动流控制](#4非自动流控制)
        - [（a）接收数据操作](#a接收数据操作)
        - [（b）发送数据操作](#b发送数据操作)
      - [（5）中断/DMA请求的产生](#5中断dma请求的产生)
      - [（6）UART错误状态FIFO](#6uart错误状态fifo)
      - [（7）UART波特率的产生](#7uart波特率的产生)
      - [（8）回环模式](#8回环模式)
      - [（9）红外模式](#9红外模式)
        - [红外与普通UART的对比（发送）](#红外与普通uart的对比发送)
        - [红外与普通UART的对比（接收）](#红外与普通uart的对比接收)
      - [与UART相关的寄存器](#与uart相关的寄存器)
    - [UART编程实例](#uart编程实例)
- [IIC接口](#iic接口)
  - [I2C总线概述](#i2c总线概述)
  - [I2C总线操作](#i2c总线操作)
    - [（1）起始条件和停止条件](#1起始条件和停止条件)
    - [（2）数据传输格式](#2数据传输格式)
    - [（3）应答ACK信号](#3应答ack信号)
    - [（4）读/写操作](#4读写操作)
    - [（5）总线仲裁](#5总线仲裁)
    - [（6）异常中断条件](#6异常中断条件)
    - [（7）配置I2C总线](#7配置i2c总线)
    - [（8）操作步骤](#8操作步骤)
- [IIS接口](#iis接口)
    - [音频录放的实现原理](#音频录放的实现原理)
    - [S3C2410A的IIS总线接口](#s3c2410a的iis总线接口)
      - [功能描述](#功能描述)
      - [音频串行接口格式](#音频串行接口格式)
      - [采样频率和主时钟](#采样频率和主时钟)
      - [与IIS相关的寄存器](#与iis相关的寄存器)
    - [音频录放的编程实例](#音频录放的编程实例)
- [USB接口](#usb接口)
  - [USB接口及编程简介](#usb接口及编程简介)
  - [S3C2410A的USB设备控制器](#s3c2410a的usb设备控制器)
  - [USB设备收发数据编程实例](#usb设备收发数据编程实例)
- [以太网接口](#以太网接口)
  - [以太网接口简介](#以太网接口简介)
    - [10M以太网接口CS8900简介](#10m以太网接口cs8900简介)
      - [CS8900简介](#cs8900简介)
        - [引脚类型](#引脚类型)
        - [引脚说明](#引脚说明)
          - [ISA总线接口引脚](#isa总线接口引脚)
          - [EEPROM 和 Boot PROM接口引脚](#eeprom-和-boot-prom接口引脚)
          - [介质接口引脚](#介质接口引脚)
          - [一般接口引脚](#一般接口引脚)
    - [10M以太网接口RTL8019AS简介](#10m以太网接口rtl8019as简介)
      - [RTL8019AS简介](#rtl8019as简介)
      - [引脚类型](#引脚类型-1)
        - [ISA总线接口引脚](#isa总线接口引脚-1)
          - [AEN](#aen)
          - [INT7-0](#int7-0)
          - [IOCHRDY](#iochrdy)
          - [IOCS16B\[SLOT16\]](#iocs16bslot16)
          - [IORB](#iorb)
          - [IOWB](#iowb)
          - [RSTDRV](#rstdrv)
          - [SA19-0](#sa19-0)
          - [SD15-0](#sd15-0)
          - [SMEMRB/SMEMWB](#smemrbsmemwb)
        - [存储器接口引脚](#存储器接口引脚)
          - [BCSB](#bcsb)
          - [EECS](#eecs)
          - [BA21-14](#ba21-14)
          - [BD7-0](#bd7-0)
          - [\[EESK\]与BD5引脚复用](#eesk与bd5引脚复用)
          - [\[EEDI\]与BD6引脚复用](#eedi与bd6引脚复用)
          - [\[EESK\]与BD7引脚复用](#eesk与bd7引脚复用)
          - [\[PNP\]与BA21引脚复用](#pnp与ba21引脚复用)
          - [\[BS4-0\]与BA16-20引脚复用](#bs4-0与ba16-20引脚复用)
          - [\[IOS3-0\]与BD0-3引脚复用](#ios3-0与bd0-3引脚复用)
          - [IO基地址的选择](#io基地址的选择)
          - [\[IRQS2-0\]与BD4-6引脚复用](#irqs2-0与bd4-6引脚复用)
          - [IRQ的选择](#irq的选择)
          - [\[PL1-0\]与BD7,BA14引脚复用](#pl1-0与bd7ba14引脚复用)
          - [网络介质类型的选择](#网络介质类型的选择)
          - [JP](#jp)
        - [介质接口引脚](#介质接口引脚-1)
          - [AUI](#aui)
          - [CD+,CD-](#cdcd-)
          - [RX+,RX-](#rxrx-)
          - [TX+,TX-](#txtx-)
          - [TPIN+,TPIN-](#tpintpin-)
          - [TPOUT+,TPOUT-](#tpouttpout-)
          - [X1](#x1)
          - [X2](#x2)
        - [LED输出引脚](#led输出引脚)
          - [LEDBNC](#ledbnc)
          - [LED0 \[LED\_COL\] \[LED\_LINK\]](#led0-led_col-led_link)
          - [LED1,LED2](#led1led2)
  - [以太网接口编程](#以太网接口编程)
    - [TCP/IP协议层次](#tcpip协议层次)
    - [网络接口层](#网络接口层)
      - [CS8900A的PACKETPAGE 结构](#cs8900a的packetpage-结构)
      - [CS8900A的复位与初始化过程](#cs8900a的复位与初始化过程)
      - [CS8900A 的默认配置](#cs8900a-的默认配置)
      - [CS8900A的工作模式介绍](#cs8900a的工作模式介绍)
      - [CS8900A的驱动程序设计](#cs8900a的驱动程序设计)
      - [CS8900A的初始化程序设计](#cs8900a的初始化程序设计)


# 万字详解通信接口设计

常用的通信接口

# UART接口

## UART的工作原理  

UART（Universal Asynchronous Receiver and Transmitter，通用异步收发器）是广泛使用的串行数据传输方式。 

RS232C是通用的串行数据传输接口 标准，其DB9引脚定义如下： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108134845953.png)

 RS-232C接口的基本连接方式 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108134907938.png)

## UART的功能和组成 

UART的主要功能是将数据以字符为单位，按照先低位后高位的顺序进行逐位传输。根据发送方和接收方是否使用同一个时钟，通讯方式分成同步和异步两种。

UART主要由数据线接口、控制逻辑、配置寄存器、波特率发生器、发送部分和接收部分组成。UART以字符为单位进行数据传输，每个字符的传输格式如下： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108134929210.png)

### S3C2410A的UART  

S3C2410A的UART提供3个独立的异步串行I/O口（SIO），它们都可以运行于中断模式或DMA模式。通信速率可编程，最高可达230.4kbps。每个通道包含都有一个16字节的接收与发送FIFO缓冲区。支持红外发送和接收。 

S3C2410A的每个UART由波特率发生器、发送器、接收器以及控制单元组成。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108134953733.png)

### UART 操作

#### （1）数据发送

UART传送数据的数据帧是可编程的，它包含1个起始位、5~8个数据位，1个可选的奇偶位和1~2个停止位，由控制寄存器ULCONn定义。

#### （2）数据接收

UART接收数据的数据帧也是可编程的，它包含1个起始位、5~8个数据位，1个可选的奇偶位和1~2个停止位，由控制寄存器ULCONn定义。接收器可以发现各种数据接收错误，如：数据溢出错误、奇偶错误、帧的错误和断点条件，其中每一个都可在寄存器中置一个错误标志位。

#### （3）自动流控制

在自动流控制AFC（Auto Flow Control）模式下，UART的数据发送由nCTS（清除发送信号）控制，只有在该信号有效的情况下，UART的发送器才会将数据传送到FIFO，在UART接收数据之前，如果接收数据的FIFO有大于2字节的空间，则nRTS（发送请求信号）才有效。UART的AFC接口如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135100612.png)

#### （4）非自动流控制

在非自动流控制模式下，nCTS和nRTS由S/W控制。

#####   （a）接收数据操作

+ 选择接收模式。
+ 检查接收FIFO（RxFIFO）的计数值，如果小于15则将nRTS置为有效（使UMCONn[0]=1），否则，将nRTS置为无效。
+ 重复上一步。

#####   （b）发送数据操作

+ 选择发送模式。
+ 检查nCTS是否有效（UMSTAn[0]=1），如果有效，则向Tx缓冲器或TxFIFO中写数据。
+ 重复上一步。

#### （5）中断/DMA请求的产生

S3C2410的每个UART都有7个状态信号：接收FIFO/缓冲区数据准备好、发送FIFO／缓冲区空、发送移位寄存器空、溢出错误、奇偶校验错误、帧错误和中止，所有这些状态都由对应的UART状态寄存器(UTRSTATn/UERSTATn)中的相应位来表现。

当接收器要将接收移位寄存器的数据送到接收FIFO,它会激活接收FIFO满状态信号，如果控制寄存器中的接收模式选为中断模式，就会引发接收中断。

当发送器从发送FIFO中取出数据送到发送移位寄存器，那么FIFO空状态信号将会被激活。如果控制寄存器中的发送模式选为中断模式，就会引发发送中断。

如果是在DMA模式，则FIFO满和FIFO空会产生DMA请求信号。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135252322.png)

#### （6）UART错误状态FIFO

UART有一个错误状态FIFO，用来指出FIFO中的哪个数据在接收时出错，错误中断发生在有错误的数据被读取时。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135310713.png)

#### （7）UART波特率的产生

波特率发生器以FCLK作为时钟源 

每个UART的波特率发生器为传输提供了串行移位时钟。波特率时钟由通过时钟源的16分频和一个由UART波特率除数寄存器(UBRDIVn)指定的16位除数决定。

```c
UBRDIVn＝（取整）（PCLK／（波特率×16））-1 
UBRDIVn＝（取整）（UCLK／（波特率×16））-1
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135333083.png)

#### （8）回环模式

S3C2410的UART提供的一个测试模式。在这种模式下，发送出的数据会立即被接收。这一特性用于校验运行处理器内部发送和接收通道的功能，这种模式可以通过设置UART控制寄存器(UCONn)中的回送位来实现。

#### （9）红外模式

S3C2410的UART模块支持红外线（IR)发送和接收。可以通过设置UART控制寄存器(UCONn)中的红外模式位来选择这一模式。其工作原理如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135407037.png)

##### 红外与普通UART的对比（发送）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135422729.png)

##### 红外与普通UART的对比（接收）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135448910.png)

####  与UART相关的寄存器  

+ UART行控制寄存器（ULCONn）
+ UART控制寄存器（UCONn） 
+ UART FIFO控制寄存器（UFCONn） 
+ UART Modem控制寄存器（UMCONn） 
+ UART TX/RX状态寄存器（UTRSTATn）
+ UART错误状态寄存器（UERSTATn） 
+ UART FIFO状态寄存器（UFSTATn） 
+ UART MODEM状态寄存器（UMSTATn）
+ UART发送缓冲寄存器（UTXHn）
+ UART接收缓冲寄存器（URXHn）
+ UART波特率因子寄存器（UBRDIVn） 

### UART编程实例 

举例：从UART0接收数据，然后分别从UART0和UART1发送出去。 

1．定义与UART相关的寄存器。

```c
#define rULCON0     (*(volatile unsigned *)0x50000000) //UART0行控制寄存器
#define rUCON0      (*(volatile unsigned *)0x50000004) //UART0控制寄存器
#define rUFCON0     (*(volatile unsigned *)0x50000008) //UART0 FIFO控制寄存器
#define rUMCON0     (*(volatile unsigned *)0x5000000c) //UART0 Modem控制寄存器
#define rUTRSTAT0   (*(volatile unsigned *)0x50000010) //UART0 Tx/Rx状态寄存器
#define rUERSTAT0   (*(volatile unsigned *)0x50000014) //UART0 Rx错误状态寄存器
#define rUFSTAT0    (*(volatile unsigned *)0x50000018) //UART0 FIFO状态寄存器
#define rUMSTAT0    (*(volatile unsigned *)0x5000001c) //UART0 Modem状态寄存器
#define rUBRDIV0    (*(volatile unsigned *)0x50000028) //UART0波特率因子寄存器
… …
```

2．对串口进行初始化操作。参数pclk为时钟源的时钟频率，band为数据传输的波特率。  

```c
void Uart_Init(int pclk,int baud){
    int i;
    if(pclk == 0)
    pclk    = PCLK;
    rUFCON0 = 0x0;    //UART0 FIFO控制寄存器，FIFO禁止
    rUFCON1 = 0x0;    //UART1 FIFO控制寄存器，FIFO禁止
    rUFCON2 = 0x0;    //UART2 FIFO控制寄存器，FIFO禁止
    rUMCON0 = 0x0;   //UART0 MODEM控制寄存器，AFC禁止
    rUMCON1 = 0x0;   //UART1 MODEM控制寄存器，AFC禁止
    //UART0
    rULCON0 = 0x3;   //行控制寄存器：正常模式，无奇偶校验，1位停止位，8位数据位。
    rUCON0  = 0x245;                        //控制寄存器
        rUBRDIV0=( (int)(pclk/16./baud+0.5) -1 );      //波特率因子寄存器 
     … …
}
```

3．使用串口发送数据。其中whichUart为全局变量，指示当前选择的UART通道，使用串口发送一个字节的代码如下：

```c
void Uart_SendByte(int data){
    if(whichUart==0){
        if(data=='\n'){
            while(!(rUTRSTAT0 & 0x2));
            Delay(10);                 //延时，因为超级终端速度较慢
            WrUTXH0('\r');
        }
        while(!(rUTRSTAT0 & 0x2));   //等待直到发送状态就绪
        Delay(10);
        WrUTXH0(data);
    }
    else if(whichUart==1){  … …  }
    else if(whichUart==2){  … …  }
}
```

4．使用串口接收数据。如果没有接收到字符则返回0。 

```c
char Uart_GetKey(void){
    if(whichUart==0){ 
        if(rUTRSTAT0 & 0x1)    //UART0接收到数据
            return RdURXH0();
        else
            return 0;
    }
    else if(whichUart==1){  … …  }
  else if(whichUart==2){  … …  }
    else return 0;
}
```

5．书写主函数。实现的功能为从UART0接收字符，然后将接收到的字符再分别从UART0和UART1发送出去，其中Uart_Select（n）用于选择使用的传输通道为UARTn。

```c
void Main(void){
	char data;
	Target_Init();
         while(1){
             data = Uart_GetKey();   //接收字符
	    if (data != 0x0){
	        Uart_Select(0);     //从UART0发送出去
	        Uart_Printf("key =%c\n", data);
	        Uart_Select(1);     //从UART1发送出去
	        Uart_Printf("key =%c\n", data);
	        Uart_Select(0);
            }                                                   
        }	
 } 
```

# IIC接口  

## I2C总线概述

IIC(Inter－Integrated Circuit)是一种双向两线制的串行总线，由于它支持任何一种IC制造工艺，且能够提升硬件的效率和简化电路的设计，因此众多厂商都提供了IIC兼容芯片。

S3C2410内部也具有IIC总线接口模块，支持一个多主IIC-BUS串形接口，主S3C2410能发送或接收串形数据到从设备，并遵守标准的IIC协议。

IIC总线操作模式为：主发送模式、主接收模式、从发送模式、从接收模式。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135713359.png)

## I2C总线操作

### （1）起始条件和停止条件

起始条件发生在SCL信号为高时，SDA产生一个由高变低的电平变化处。

停止条件发生在SCL信号为高时，SDA产生一个由低变高的电平变化处。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135735560.png)

### （2）数据传输格式

  每个字节长度都是8位，每次传输中字节的数量没有限制。在起始条件后面的第一个字节是地址域，之后，每个传输的字节后面都有一个应答（ACK）位。传输中串行数据的MSB（字节的高位）首先发送。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135803428.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135809567.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135820836.png)

### （3）应答ACK信号

  接收器发送一个ACK位给发送器
  ACK脉冲信号在SCL线上第9个时钟处发出。
  当接收到ACK脉冲时，发送器应通过使SDA线变成高电平释放SDA线

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108135831874.png)

### （4）读/写操作

在发送模式下，发送完一个数据后，I2C将保持SCL线为低以等待CPU向IICDS (I2C 数据转移寄存器）写一个新的值，这时I2C将保持中断以标明数据传送的完成，CPU收到这样一个中断请求信号后，应该往IICDS寄存器里写一个新的数据，这时SCL线将释放。
在接收模式下，接收到一个数据后，I2C将保持SCL线为低以等待CPU从IICDS 读走这个数，这时I2C将保持中断以标明数据接收的完成，CPU收到这样一个中断请求信号后，应该从IICDS寄存器里读取一个数据，这时SCL线将释放。 

### （5）总线仲裁

如果SDA为高电平的一个主设备检测到另一个主设备的SDA为低电平，那么它将不能启动数据传送，仲裁程序将持续到SDA线变为高电平。

如果两个主设备在SDA线上同时为低电平，则每个主设备应进一步评估总线控制权是否属于自己，评估的方法是在发送地址位时进一步确定自己的发送电平和信号线上的实际电平是否一致，如果不一致则放弃总线控制权。如果地址第1位一致，再检测地址第2位，这个过程一致持续到地址发送完毕。 

### （6）异常中断条件

如果从设备不能对地址进行确认，则应使SDA保持高电平，这时，主设备应产生一个停止条件终止传送。

如果主设备涉入一个异常中断，则应在从从设备收到最后一个数据字节后，通过取消一个ACK信号来通知 从设备传送操作结束，而从设备这时应该释放SDA，允许主设备产生一个停止条件。 

### （7）配置I2C总线

为了控制SCL的频率，4位预分频器的值可以在IICCON内进行设置，I2C接口地址在I2C地址寄存器IICADD中（缺省时是未知的）进行设置。

### （8）操作步骤

在I2C地址寄存器IICADD中写入地址。

设置IICCON寄存器（确定SCL频率，设置中断允许以及应答ACK允许等）。

设置IICSTAT来选择通信模式并且使能串行输出。各模式的流程如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140001034.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140018024.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140034704.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140050220.png)

# IIS接口  

### 音频录放的实现原理  

声波是在时间上和幅度上都连续的模拟信号，我们称之为模拟音频信号。而计算机的内部是一个二进制的世界，二进制是计算机唯一能够识别的语言。因此为了让计算机能够对音频信号进行存储和处理，必须将模拟音频信号进行数字化。数字化的过程涉及到采样、量化和编码等步骤，我们把数字化后的音频信号称之为数字音频信号。 

录音过程：把模拟音频转换成数字音频的过程，通常通过AD转换器（ADC）实现。

放音过程：把数字音频转换成模拟音频的过程，该过程与AD转换过程相反，通常通过DA转换器（DAC）实现。 

![image-20230108140120921](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140120921.png)

### S3C2410A的IIS总线接口 

IIS总线是近年出现的一种面向多媒体计算机的音频总线，该总线专门用于音频设备之间的数据传输。IIS总线接口是为连接标准编解码器（CODEC）提供的外部接口。S3C2410A IIS（Inter-IC Sound）接口能用来连接一个外部8/16位立体声音频CODEC。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140202311.png)

#### 功能描述

总线接口、寄存器组和状态机（BRFC)：总线接口逻辑和 FIFO 访问控制.

5位双预定标 (IPSR): 其中一个用于产生IIS总线的主时钟，另一个用于产生外部CODEC时钟。

64-byte FIFOs (TxFIFO and RxFIFO): 发送时将待发送数据写入TxFIFO, 接收时，从RxFIFO读取所接收数据。

主IISCLK发生器(SCLKG): 在主模式下，产生串行时钟。
通道产生与状态机 (CHNC): 产生和控制IISCLK和 IISLRCK。

16-bit 移位寄存器 (SFTR): 在发送模式下，将并行输出数据转化成串行输出数据。在输入模式下，将串行输入数据转化成并行输入数据。

#### 音频串行接口格式

IIS-BUS FORMAT

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140233406.png)

#### 采样频率和主时钟

主时钟频率 (PCLK) 的选择由采样频率决定，如下表所示。由于PCLK由IIS预定标决定，预定标值和PCLK类型 (256 or 384fs) 应正确选择. 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140304725.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140312125.png)

####  与IIS相关的寄存器 

+ IIS控制寄存器（IISCON） 
+ IIS模式寄存器（IISMOD） 
+ IIS预分频寄存器（IISPSR） 
+ IIS FIFO控制寄存器（IISFCON） 
+ IIS FIFO寄存器（IISFIFO）

### 音频录放的编程实例 

举例：实现语音的实时录制和实时播放功能 

```c
//由于使用DMA方式进行语音录放，因此这里需要注册DMA中断
pISR_DMA2=(unsigned)TX_Done;
pISR_DMA1=(unsigned)RX_Done;
rINTMSK &=~(BIT_DMA1);
rINTMSK &=~(BIT_DMA2);
rxdata = (unsigned short *)malloc(0x80000); //384KB
for(i=0;i<0xffff0;i++)
	*(rxdata+i)=0;
 //录音过程，DMA1用于音频输入 
 rDMASKTRIG1 = (1<<2)|(0<<1); 
 //初始化DMA通道1
 rDISRC1 	= (U32)IISFIFO;  			//接收FIFO地址
 rDISRCC1 	= (1<<1)|(1<<0); 			//源=APB,地址固定
 rDIDST1 	= (U32)(rxdata);
 rDIDSTC1 	= (0<<1)|(0<<0);			//目标=AHB,地址增加
 rDCON1=(0<<31)|(0<<30)|(1<<29)|(0<<28)|(0<<27)|(2<<24)|(1<<23)|(1<<22)| (1<<20)|(0xffff0);
 //握手模式,与APB同步,中断使能,单元发送,单个服务模式,目标=I2SSDI
 //硬件请求模式,不自动重加载,半字
 rDMASKTRIG1 = (1<<1); 		//DMA1通道打开
 //初始化IIS，用于接收
 rIISCON=(0<<5)|(1<<4)|(1<<1);     
 //发送DMA请求禁止,接收DMA请求使能,IIS预分频器使能
 rIISMOD=(0<<8)|(1<<6)|(0<<5)|(0<<4)|(1<<3)|(0<<2)|(1<<0);
 //主模式,接收模式,IIS格式,16位,256fs,32fs
 rIISPSR 	= (8<<5)|(8<<0);      //50.7 / 9 = 5.6448
 rIISFCON	= (0<<15)|(1<<14)|(0<<13)|(1<<12);   
 //发送FIFO=正常，接收FIFO=DMA，发送FIFO禁止，接收FIFO使能
 rIISCON		|= (1<<0);  	//IIS使能
 while(!Rx_Done);
 Rx_Done = 0;
 //IIS停止
 Delay(10);                          //用于结束半字/字接收
 rIISCON     = 0x0;                  //IIS停止
 rDMASKTRIG1 = (1<<2);               //DMA1停止
 rIISFCON    = 0x0;                  //发送/接收FIFO禁止 
    //放音过程，DMA2用于音频输出
    rDMASKTRIG2 = (1<<2)|(0<<1);
    //初始化DMA通道2
    rDISRC2 = (U32)(rxdata);
    rDISRCC2 = (0<<1)|(0<<0); //源=AHB,地址增加
    rDIDST2 = (U32)IISFIFO;   //发送FIFO地址
    rDIDSTC2 = (1<<1)|(1<<0); //目标=APB,地址固定
    rDCON2 = (0<<31)|(0<<30)|(1<<29)|(0<<28)|(0<<27)|(0<<24)|(1<<23)|(1<<22)|(1<<20)|(0xffff0);
    //握手模式,与APB同步,中断使能,单元发送,单个服务模式,目标=I2SSDO
    //硬件请求模式,不自动重加载,半字
    rDMASKTRIG2 = (1<<1); 	//DMA2通道打开
    //初始化IIS,用于发送
    rIISCON=(1<<5)|(0<<4)|(1<<1);   
    //发送DMA请求使能,接收DMA请求禁止,IIS预分频器使能
    rIISMOD=(0<<8)|(2<<6)|(0<<4)|(1<<3)|(0<<2)|(1<<0);       
    //主模式，发送模式,IIS格式,16位,256fs,32fs
    rIISPSR=(8<<5)|(8<<0);  	//预分频值A=45Mhz/8,预分频值B=45Mhz/2
    rIISFCON=(1<<15)|(0<<14)|(1<<13)|(0<<12);    
    //发送FIFO=DMA,接收FIFO=正常,发送FIFO使能,接收FIFO禁止
    rIISCON|=(1<<0);
    while(!Tx_Done);
    Tx_Done=0;
    rIISCON     = 0x0;                  //IIS停止
    rDMASKTRIG2 = (1<<2);               //DMA2停止
    rIISFCON    = 0x0;                  //发送/接收FIFO禁止
```

# USB接口

## USB接口及编程简介 

USB（Universal Serial Bus）即通用串行总线，是现在非常流行的一种快速、双向、廉价、可以进行热插拨的接口。
在设计开发一个USB外设的时候,主要需要编写三部分的程序:①固件程序②USB驱动程序③客户应用程序。

S3C2410处理器内部集成了USB Host控制器，支持两个USB Host通信端口，该控制器的特点如下：

+ 符合OHCI1.0协议规范
+ 符合USB1.1协议
+ 同时支持USB低速和全速设备的连接
+ 支持控制，中断和DMA大量数据传送方式
+ 集成了5个可配置节点的64位FIFO存储收发器
+ 集成了USB收发器
+ 支持挂起和唤醒功能

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140457662.png)

## S3C2410A的USB设备控制器 

USB设备控制器连通DMA接口提供了一种高性能的全速控制器解决方案。USB设备控制器支持使用DMA的批量传输、中断传输和控制传输。

USB设备控制器具有以下特点：

+ 是全速USB设备控制器（12Mbps），兼容USB规范1.1
+ 具有用于批量传输的DMA接口
+ 具有集成的USB收发器
+ 具有带FIFO的五个端口：
+ 1个带16字节FIFO的双向控制端口（EP0）
+ 4个带64字节FIFO的双向大端口（EP1、EP2、EP3和EP4）
+ 支持DMA接口在大端口上的接收和发送（EP1、EP2、EP3和EP4）
+ 独立的64字节接收和发送FIFO使吞吐量达到最大化
+ 支持悬挂和远程唤醒功能

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140524259.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140537726.png)

## USB设备收发数据编程实例 

举例：编写固件程序。当目标板上的USB设备初始化完成后，在PC机运行应用程序usbhidio.exe，与目标板的USB设备进行数据的收发。  

1．通过函数Target_Init（）实现对S3C2410A硬件的初始化；
2．初始化USB设备控制器PDIUSBD12； 

```c
void InitD12 (){
    int i = 0;
	SETADDR  = 0xD0;
	SETDATA  = 0x80;
	SETADDR  = 0xF3;
	SETDATA  = 0x06;
	SETDATA  = 0x03;
	for (i=0; i<200000; i++);
	SETADDR  = 0xF3;
	SETDATA  = 0x16;
} 
```

3．初始化USB中断 

```c
void USBINT_Int(void){
    if (rSRCPND & BIT_EINT4_7){
        rEINTPEND |= 0x10;
        ClearPending(BIT_EINT4_7);
    }
    rINTMSK   = ~(BIT_EINT4_7);
    rEINTMASK =  0xffffe0;
    pISR_EINT4_7 = (int)USB_ISR;
} 
```

4．在主程序中，通过“while(1);”语句，实现循环等待，等待USB中断的发生。 

5．书写中断服务子程序USB_ISR()，中断服务子程序通过读PDIUSBD12的中断寄存器，判断USB令牌包的类型，然后执行相应的操作。 

```c
  if (iIrqUsb & 0x01){    //EP0输出
	      XmtBuff.out = 0;	      XmtBuff.in = 1;
	      SETADDR = 0x40;	      tmp = SETDATA;
	      if (tmp & 0x20) tx_0 ();
	      else{
		  SETADDR = 0x00;	// 选择端口0(指针指向0位置)
		  SETADDR = 0xF0;	// 读标准控制码
		  tmp = SETDATA;
		  tmp = SETDATA;
		  for (i = 0; i < 8; i++)   XmtBuff.b[i] = SETDATA;
		  if (bSetReport){
		          for (i = 0; i < 8; i++)
			          HIDData[i] = XmtBuff.b[i];
		          bSetReport = 0;
		  }
		  SETADDR = 0xF1; //应答SETUP包,使能(清OUT缓冲区、使能IN缓冲区)命令
		  SETADDR = 0xF2; //清OUT缓冲区
		  SETADDR = 0x01; //选择端口1(指针指向0位置)
		  SETADDR = 0xF1; //应答SETUP包,使能(清OUT缓冲区、使能IN缓冲区)命令
              }
}
  if (iIrqUsb & 0x01){    //EP0输出
	      XmtBuff.out = 0;	      XmtBuff.in = 1;
	      SETADDR = 0x40;	      tmp = SETDATA;
	      if (tmp & 0x20) tx_0 ();
	      else{
		  SETADDR = 0x00;	// 选择端口0(指针指向0位置)
		  SETADDR = 0xF0;	// 读标准控制码
		  tmp = SETDATA;
		  tmp = SETDATA;
		  for (i = 0; i < 8; i++)   XmtBuff.b[i] = SETDATA;
		  if (bSetReport){
		          for (i = 0; i < 8; i++)
			          HIDData[i] = XmtBuff.b[i];
		          bSetReport = 0;
		  }
		  SETADDR = 0xF1; //应答SETUP包,使能(清OUT缓冲区、使能IN缓冲区)命令
		  SETADDR = 0xF2; //清OUT缓冲区
		  SETADDR = 0x01else if (iIrqUsb & 0x02){    //EP0输入
	       XmtBuff.in = 1;
	       SETADDR = 0x41;	//读IN最后状态
 	       tmp = SETDATA;
	       rx_0 ();
   }
   else if (iIrqUsb & 0x04){    //EP1输出
	       XmtBuff.out = 2;
	       XmtBuff.in = 3;
	       SETADDR = 0x42;	//读OUT最后状态
	       tmp = SETDATA;
	       tx_1 ();
   }
   else if (iIrqUsb & 0x08){    //EP1输入
	       XmtBuff.in = 3;
	       SETADDR = 0x43;	//读IN最后状态
	       tmp = SETDATA;
	       XmtBuff.b[0] = 5;
	       XmtBuff.wrLength = 8;
	       XmtBuff.p = HIDData;
	       rx_0 ();
   } 
   … …	
; //选择端口1(指针指向0位置)
		  SETADDR = 0xF1; //应答SETUP包,使能(清OUT缓冲区、使能IN缓冲区)命令
              }
}

```

# 以太网接口

## 以太网接口简介 

要实现小型嵌入式设备的Internet接入，TCP/IP首先要解决的是底层硬件问题，即协议的物理层。Ethernet具有成熟的技术、低廉的网络产品、丰富的开发工具和技术支持，当现场总线的发展遇到阻碍时，以太网控制网络技术以其明显的优势得到了迅猛的发展，并逐渐形成了现场总线的新标准——Ethernet。考虑到国内局域网大部分是以太网，随着交换式网络、宽带网络的发展，基于以太网的嵌入式设备Internet接入应用有着现实意义。  

S3C2410X本身并无网络控制器,实现以太网接入需增加独立的以太网控制器。在嵌入式网络接口设计中，主要有10M以太网和100M以太网两种接口，分别采用Cirrus Logic公司 生产的CS8900芯片(10M) 、 REALTEK公司公司生产的RTL8019AS (10M) 和DAVICOM公司生产的DM9000芯片（10/100M自适应）作为控制器接口芯片。 

### 10M以太网接口CS8900简介 

#### CS8900简介

 CS8900芯片是Cirrus Logic公司生产的一种局域网处理芯片，在嵌入式领域中使用非常常见。它的封装是100-pin TQFP，内部集成了在片RAM、10BASE-T收发滤波器，并且提供8位和16位两种接口。CS8900与ARM芯片按照16位方式连接，网卡芯片复位后默认工作方式为I/O连接，基址是300H。

CS8900A还提供其它性能和配置选择.它独特的Packet Page结构可自动适应网络通信量模式的改变和现有系统资源,从而提高系统效率。

MCU与CS8900A的数据传输有三种模式:I/O模式,存储器模式和DMA模式.本设计采用CS8900A默认的I/O模式,因为I/O模式简单易用. 在I/O模式下,通过访问8个16位的寄存器来访问PacketPage结构,这8个寄存器被映射到2410地址空间的16个连续地址。当CS8900A上电后,寄存器默认的基址为0x300h。

CS8900A 主要性能为： 

（1）符合Ethernet II与IEEE802.3（10Base5、10Base2、10BaseT）标准； 
（2）全双工，收发可同时达到10Mbps的速率； 
（3）内置SRAM，用于收发缓冲，降低对主处理器的速度要求； 
（4）支持16位数据总线，4个中断申请线以及三个DMA 请求线； 
（5）8个I/O 基地址，16位内部寄存器，IO Base 或 Memory Map 方式访问； 
（6）支持UTP、AUI、BNC 自动检测，还支持对10BaseT 拓扑结构的自动极性修正； 
（7）LED 指示网络激活和连接状态； 
（8）100脚的LQFP 封装，缩小了PCB 尺寸。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140749164.png)

##### 引脚类型

ISA总线接口引脚 

EEPROM 和 Boot PROM接口引脚 

介质接口引脚 

一般接口引脚 

##### 引脚说明

###### ISA总线接口引脚

+ SA[0:19] – 系统地址总线, 输入， PINS 37-48, 50-54, 58-60
      24-bit 系统地址总线的低 20 bits，用于访问 CS8900A的I/O 和存储空间

+ SD[0:15] – 系统数据总线, 双向三态 输出， PINS 65-68, 71-74, 27-24, 21-18.
      双向16-bit系统数据总线用于和主机通信。

+ RESET – 复位, 输入，PIN 75.
      高有效，至少保持400 ns 才有效。

+ AEN – 地址使能, 输入，PIN 63

+ MEMR- 存储器读,输入，PIN 29.

+ MEMW – 存储器写, 输入，PIN 28

+ MEMCS16- 存储器选择 16-bit, 漏极开路输出， PIN 34.
     当ISA总线上的地址属于CS8900A 所分配的存储空间时，该信号有效。无效时处
     于三态状态。

+ REFRESH – 刷新, 输入，PIN 49
      当DRAM处于刷新周期时，该信号有效，这时所有的存储器操作信号CS8900A 都
      应不予响应。

+ IOR- I/O 读, 输入， PIN 61

  当该信号有效，并且给定一个有效的输入地址时，从CS8900A内给定的I/O寄存器中读出数据

+ IOW-I/O 写, 输入，PIN 62

  当该信号有效，并且给定一个有效的输入地址时，向CS8900A内给定的I/O寄存器写入数据

+ IOCS16 - I/O 片选 16-bit, 漏极开路输出， PIN 33

  当ISA总线上的地址属于CS8900A 所分配的I/O空间时，该信号有效。无效时处于三态状态

+ IOCHRDY - I/O 通道Ready,漏极开路输出， PIN 64

  可用于扩展 CS8900A的 I/O 读和存储器读周期。

+ INTRQ[0:3] – 中断请求, 三态， PINS 30-32, 35. 

+ DMARQ[0:2] - DMA 请求, 三态，PINS 11, 13, and 15

+ DMACK[0:2] - DMA 响应, 输入， PINS 12, 14, and 16

+ CHIPSEL - 片选, 输入，PIN 7

###### EEPROM 和 Boot PROM接口引脚

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140840959.png)

###### 介质接口引脚

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140853355.png)

###### 一般接口引脚

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140906371.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140916080.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108140926068.png)

### 10M以太网接口RTL8019AS简介 

#### RTL8019AS简介

RTL8019AS是台湾REALTEK公司生产的一种基于ISA总线的高度集成的以太网控制器。它实现了以太网媒介访问层(MAC)和物理层(PHY)的全部功能，包括MAC数据帧的收发、地址识别、循环冗余检验(Cyclic Redundancy Check，CRC)编码／校验、曼彻斯特编解码、超时重传、链路完整性测试、信号极性检测与纠正等。RTL8019AS与主处理器有3种接口模式，跳线模式(Jumper)，即插即用模式(PnP)和免跳线模式(Jumperless)。它的主要特点包括:

+ 符合 Ether2net Ⅱ与IEEE802 . 3标准 ;
+ 全双工 ,收发可同时达到10 Mbit / s的速率 
+ 支持 UTP、 AUI、 BNC 自动检测 ,还支持对 10BaseT拓扑结构的自动极性修正;

+ 允许 4 个诊断LED引脚编程输出。
+ 8 条IRQ 总线和16 条基本地址总线为大资源情况下提供了宽松的环境。 
+ RTL8019AS内部有 2 块 RAM 区 ,1 块 16 kB ,地址为 0x4000～0x7fff ;1块 32 字节 ,地址为 0x0000～0x001f。RAM 按页存储 ,每 256 字节为一页。
+ 100-pin PQFP

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108141005869.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108141021886.png)

#### 引脚类型

##### ISA总线接口引脚 

###### AEN

IO类型： I 
引脚描述： 
地址使能（Address Enable） 
该引脚保持低电平，才能保证IO命令有效 
接口设计： 
与S3C2410的nGCS5引脚相连 
S3C2410的nGCS5用作RTL8019的片选信号 
尽量不使用nGCS6和nGCS7，因为只有这两个引脚可以用作SDRAM的片选信号 

###### INT7-0

IO类型： O 
引脚描述： 
中断请求线（Interrupt Request Lines） 
INT7-0被分别映射到IRQ15，IRQ12，IRQ11，IRQ10，IRQ5，IRQ4，IRQ3，IRQ2/9 
每次只能使用其中一根线来反映中断请求，其它线保持高阻状态 
这些线也用作输入，来监视ISA总线上相应中断请求线的实际状态。结果保存在INTR寄存器中，软件可以使用这些结果来检测中断冲突 
接口设计： 
分别与EINT9-2相连 

###### IOCHRDY

IO类型：O 
引脚描述： 
IO CHannel ReaDY 
该ISA总线信号保持低电平时，表明外设数据还没准备好。主设备需要在当前读写周期插入等待周期，等待外设准备数据。 
接口设计： 
空接 

###### IOCS16B[SLOT16]

IO类型：O 
引脚描述： 
8位/16 位数据选择引脚，高电平选择16位数据总线，低电平选择8位数据总线 
外接27K欧姆下拉电阻选择低电平，外接300欧姆上拉电阻选择高电平（Datasheet描述为27KW下拉电阻和300W上拉电阻，可能是笔误） 
接口设计： 
通过27K欧姆下拉电阻接地，从而选择使用8位数据总线 

###### IORB

IO类型：I 
引脚描述： 
Host I/O read command 
接口设计： 
接S3C2410的nOE信号

###### IOWB

IO类型：I 
引脚描述： 
Host I/O write command 
接口设计： 
接S3C2410的nWE信号

###### RSTDRV

IO类型： I 
引脚描述： 
芯片重启信号，高有效 
高电平信号保持800ns，则系统重启 
接口设计： 
通过10K下拉电阻接地 

###### SA19-0

IO类型：I 
引脚描述： 
主机地址总线（Host address bus） 
8019AS 共 32 个IO地址，地址偏移量为 00H--1FH。其中： 00H－0FH 共 16 个地址，为寄存器地址。 10H－17H 共 8 个地址，为 DMA 地址。 18H－1FH 共 8 个地址，为复位端口。 
接口设计： 
低10位分别跟S3C2410的ADDR9-0连接，高10位接地。 
由于默认IO基址是300h，所以通常ADDR8、ADDR9应该输入高电平 

###### SD15-0

IO类型：I/O 
引脚描述： 
主机数据总线（Host data bus） 
接口设计： 
和S3C2410的DATA15-0相连 

###### SMEMRB/SMEMWB

IO类型：I 
引脚描述： 
主机存储器读/写信号（Host Memory Read/Write Command） 
配合BROM使用 
BOOTROM: BOOTROM插座也就是常说的无盘启动ROM接口，其是用来通过远程启动服务构造无盘工作站的。远程启动服务(Remoteboot，通常也叫RPL) 使通过使用服务器硬盘上的软件来代替工作站硬盘引导一台网络上的工作站成为可能。网卡上必须装有一个RPL(Remote Program Load远程初始程序加载)ROM芯片才能实现无盘启动，每一种RPL ROM芯片都是为一类特定的网络接口卡而制作的，它们之间不能互换。带有RPL的网络接口卡发出引导记录请求的广播(broadcasts)，服务器自动的建立一个连接来响应它，并加载MS-DOS启动文件到工作站的内存中。此外，在BOOTROM插槽中心一般还有一颗93C46、93LC46或93c56的EEPROM芯片(93C56是128\*16bit的EEPROM，而93C46是64\*16bit的EEPROM)，它相当于网卡的BIOS，里面记录了网卡芯片的供应商ID、子系统供应商ID、网卡的MAC地址、网卡的一些配置，如总线上PHY的地址，BOOTROM的容量，是否启用BOOTROM引导系统等内容。主板板载网卡的EEPROM信息一般集成在主板BIOS中。

接口设计： 接高电平 

##### 存储器接口引脚 

###### BCSB

IO类型：O 
引脚描述： 
BROM片选信号（BROM chip select） 
接口设计： 
空接 

###### EECS

IO类型： O 
引脚描述： 
9346片选信号（9346 chip select） 
接口设计： 
接9346 EEPROM的CS引脚 

###### BA21-14

IO类型：O 
引脚描述： 
BROM地址 
接口设计： 
空接 

###### BD7-0

IO类型：I/O 
引脚描述： 
BROM数据 
接口设计： 
空接 

###### [EESK]与BD5引脚复用 

IO类型：O 
引脚描述： 
9346串行数据时钟 
接口设计： 
接9346 EEPROM的SK引脚 

######  [EEDI]与BD6引脚复用 

IO类型：O 
引脚描述： 
9346串行数据输入 
接口设计： 
接9346 EEPROM的DI引脚

###### [EESK]与BD7引脚复用 

IO类型： I 
引脚描述： 
9346串行数据输出 
接口设计： 
接9346 EEPROM的DO引脚 

###### [PNP]与BA21引脚复用 

IO类型：I 
引脚描述： 
处于无跳线模式下时，若该引脚为高，则RTL8019AS进入PNP（即插即用）模式，而不理会9346 EEPROM中的内容 
内置100K下拉电阻（如果空接，则保持低电平） 
接口设计： 
空接 

###### [BS4-0]与BA16-20引脚复用 

IO类型：I 
引脚描述： 
用于选择BROM大小和基地址 
接口设计： 
空接 

###### [IOS3-0]与BD0-3引脚复用 

IO类型：I 
引脚描述： 
用于选择IO基地址，默认值是300H 
内置100K欧姆下拉电阻 
接口设计： 
经过跳线和10K欧姆的上拉电阻，与5V电源相连 
注意：这组引脚确定的IO基地址必须和SA19-0确定的地址一致，例如： 如果IOS3-0均为默认值0，则对应的IO基址是300H，那么SA8、SA9应该为高电平。 

###### IO基地址的选择 

| **IOS3** | **IOS2** | **IOS1** | **IOS0** | **IO****基地址** |
| -------- | -------- | -------- | -------- | ---------------- |
| 0        | 0        | 0        | 0        | 300H             |
| 0        | 0        | 0        | 1        | 320H             |
| 0        | 0        | 1        | 0        | 340H             |
| 0        | 0        | 1        | 1        | 360H             |
| 0        | 1        | 0        | 0        | 380H             |
| 0        | 1        | 0        | 1        | 3A0H             |
| 0        | 1        | 1        | 0        | 3C0H             |
| 0        | 1        | 1        | 1        | 3E0H             |
| 1        | 0        | 0        | 0        | 200H             |
| 1        | 0        | 0        | 1        | 220H             |
| 1        | 0        | 1        | 0        | 240H             |
| 1        | 0        | 1        | 1        | 260H             |
| 1        | 1        | 0        | 0        | 280H             |
| 1        | 1        | 0        | 1        | 2A0H             |
| 1        | 1        | 1        | 0        | 2C0H             |
| 1        | 1        | 1        | 1        | 2E0H             |

###### [IRQS2-0]与BD4-6引脚复用 

IO类型：I 
引脚描述： 
从INT7-0中选择一条中断线（interrupt line） 
内置100K欧姆下拉电阻 

接口设计：经过跳线和10K欧姆的上拉电阻，与5V电源相连 

###### IRQ的选择

| **IRQ2** | **IRQ1** | **IRQ0** | **中断线** | **Assigned  ISA IRQ** |
| -------- | -------- | -------- | ---------- | --------------------- |
| 0        | 0        | 0        | INT0       | IRQ2/9                |
| 0        | 1        | 0        | INT1       | IRQ3                  |
| 0        | 1        | 0        | INT2       | IRQ4                  |
| 0        | 1        | 1        | INT3       | IRQ5                  |
| 1        | 0        | 0        | INT4       | IRQ10                 |
| 1        | 1        | 0        | INT5       | IRQ11                 |
| 1        | 1        | 0        | INT6       | IRQ12                 |
| 1        | 1        | 1        | INT7       | IRQ15                 |

###### [PL1-0]与BD7,BA14引脚复用

IO类型：I 
引脚描述： 
用于选择网络介质类型（network medium type） 
内置100K欧姆下拉电阻
接口设计： 经过跳线和10K欧姆的上拉电阻，与5V电源相连

###### 网络介质类型的选择 

| **PL1** | **PL0** | **介质类型**                            |
| ------- | ------- | --------------------------------------- |
| 0       | 0       | TP/CX  自动检测     (支持10BaseT的检测) |
| 0       | 1       | 不支持10BaseT的检测                     |
| 1       | 0       | 10Base5                                 |
| 1       | 1       | 10Base2                                 |

###### JP

IO类型：I 
引脚描述： 
用于选择工作模式 
JP=1：跳线模式 
JP=0：非跳线模式       
接口设计： 
经过跳线和10K欧姆的上拉电阻，与5V电源相连

注： RTL8019AS有3种工作方式： 第一种为跳线方式，网卡的IO和中断由跳线决定；第二种为即插即用方式，由软件进行自动配置plug and play ；第三种为免跳线方式，网卡的IO和中断由外接的9346里的内容决定。 JP引脚为低电平时，8019工作在第2种或第3种方式，具体由9346里的内容决定。 JP引脚为高电平时，那么网卡的IO和中断就不是用9346的内容决定，这时不需要使用9346，可以不接9346。 这时需要用到AUI（64），IRQ2-0（80，79，78），IOS3-0（85，84，82，81）等引脚。 

##### 介质接口引脚 

###### AUI

IO类型：I 
引脚描述： 
用于检查AUI接口上是否有外部MAU 
AUI=1：使用AUI接口（Disable the BNC） 
AUI=0：使用BNC接口 
如果不使用该引脚，则该引脚接地 
接口设计： 接地 

###### CD+,CD-

IO类型： I 
引脚描述： 这一对AUI冲突信号输入引脚对用来接收从MAU输入的差动冲突信号 
接口设计： 空接 

###### RX+,RX- 

IO类型： I 
引脚描述： 这一对AUI接收信号输入引脚对用来接收从MAU输入的差动冲突信号 
接口设计： 空接 

###### TX+,TX- 

IO类型：O 
引脚描述： 这一对AUI发送信号输出引脚对用来接收从MAU输入的差动冲突信号 
接口设计： 空接 

###### TPIN+,TPIN-

IO类型： I 
引脚描述： 这一对TP接收信号输入引脚对用来接收从MAU输入的差动冲突信号 
接口设计： 接20F001N的TPIN+，TPIN-引脚 

###### TPOUT+,TPOUT-

IO类型： I 
引脚描述： 这一对TP发送信号输出引脚对用来接收从MAU输入的差动冲突信号 
接口设计： 接20F001N的TPOUT+,TPOUT-引脚 

###### X1

IO类型：I 
引脚描述： 20MHz晶振输入引脚 
接口设计： 接晶振 

###### X2

IO类型： O 
引脚描述： 晶振反馈输出（Crystal feedback output） 
接口设计： 接晶振 

##### LED输出引脚 

###### LEDBNC

IO类型：O 
引脚描述： 当RTL8019AS的介质类型被设置成10Base2模式或自动检测连接失败模式时，输出高电平 
接口设计： 空接 

###### LED0 [LED_COL] [LED_LINK]

IO类型：O 
引脚描述： 

LEDS0=0：LED0=LED_COL（Collision LED ） 
LEDS0=1：LED0=LED_LINK 

接口设计： 接网口黄色指示灯 

###### LED1,LED2

IO类型：O 
引脚描述： 
LEDS1=0：LED1= LED_RX, LED2=LED_TX 
LEDS1=1：LED1= LED_CRS（Carrier Sense LED）, LED2=MCSB 
The MCSB signal is defined to put the local buffer SRAM into standby 
mode while DMA is not in progress and thus save powers. 
接口设计： LED1接网口绿色指示灯 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108142132310.png)

## 以太网接口编程 

### TCP/IP协议层次

TCP/IP 协议采用分层结构，共分为四层，每一层独立完成指定功能，如下图所示： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108142151940.png)

### 网络接口层

网络接口层在这里就是实现以太网的接口协议IEEE802 . 3。在嵌入式系统应用中都由专用接口芯片CS8900A或RTL8019来实现。应用者所要完成的工作就是对这些芯片进行初始化，并编写相应的读写等驱动程序，以供高层协议软件使用。

CS8900A的驱动程序应编写成应用程序接口形式，以供网络协议实现时调用。CS8900A 的结构的核心是提供高效访问方法的内部寄存器和缓冲内存。    

#### CS8900A的PACKETPAGE 结构 

PacketPage 是 CS8900A 中集成的 RAM。它可以用作接收帧和待发送帧的缓冲区，除此之外还有一些其他的用途。PacketPage为内存或I/O 空间提供了一种统一的访问控制方法，减轻了CPU 的负担，降低了软件开发的难度。此外，它还提供一系列灵活的配置选项，允许开发者根据特定的系统需求设计自己的以太网模块。PacketPage 中可以供用户操作的部分可以划分为以下几个部分：

+ 0000h——0045h     总线接口寄存器 
+ 0100h——013Fh     状态与控制寄存器 
+ 0140h——014Fh     发送初始化寄存器 
+ 0150h——015Dh     地址过滤寄存器 
+ 0400h       接收帧地址 
+ 0A00h       待发送帧地址 

#### CS8900A的复位与初始化过程

引起CS8900A 复位的因素有很多种，有人为的需要，也有意外产生的复位。如外部复位信号（在RESET引脚加至少400ns的高电平）引起复位，上电自动复位，下电复位（电压低于2.5V） ，EEPROM校验失败引起复位以及软件复位等。复位之后，CS8900A 需要重新进行配置。 

每次复位之后（除EEPROM校验失败引起复位以外） ，CS8900A 都会检查EEDataIn 引脚，判断是否有外部的EEPROM存在。如果EEDI 是高电平，则说明EEPROM存在，CS8900A 会自动将EEPROM中的数据加载到内部寄存器中 ；如果EEDI 为低电平，则EEPROM不存在，CS8900A 会按照下表所示进行默认的配置。 

#### CS8900A 的默认配置

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108142541362.png)

#### CS8900A的工作模式介绍

CS8900A 有两种工作模式，一种是I/O 访问方式,一种是内存访问方式。网卡芯片复位后默认工作方式为I/O 连接，I/O 端口基址为300H，下面对它的几个主要工作寄存器进行介绍：

(1)  LINECTL(0112H)：决定 CS8900A 的基本配置和物理接口。初始值为 00d3H，选择物理接口为 10Base-T，并使能设备的发送和接受控制位。 

(2)  RXCTL(0104H)：控制 CS8900A 接受待定的数据报。初始值为 0d05H，接受网络上的广播或者目标地址同本地物理地址相同的正确数据报。 

(3)  RXCFG(0102H)：控制 CS8900A，接受特定的数据报后会引发中断。可控制为 0103H。  

(4)  BUSCT(0116H)：控制芯片的 I/O接口的一些操作。设置初始值为 8017H，打开 CS8900A的中断总控制位。 

(5)  ISQ(0120H)：ISQ 是 CS8900A 的中断状态寄存器，内部映射接受中断状态寄存器和发送中断状态寄存器的内容。 

(6)  PORT0(0000H)：发送和接受数据时，MCU通过 PORT0 传递数据。 

(7)  TXCMD(0004H)：发送控制寄存器，如果写入数据 00C0H，那么网卡在全部数据写入后开始发送数据。 

(8) TXLENG(0006H)：发送数据长度寄存器，发送数据时，首先写入发送数据长度，然后将数据通过 PORT0 写入芯片。 

系统工作时， 应首先对网卡芯片进行初始化， 即写寄存器LINECTL、 RXCTL、 RCCFG、 BUSCT。
发数据时，写控制寄存器TXCMD，并将发送数据长度写入TXLENG，然后将数据依次写入PORT0口，如将第一个字节写入 300H，第二个字节写入301H，第三个字节写入 300H，依此类推。网卡芯片将数据组织为链路层类型并添加填充位和CRC 校验送到网络同样， 处理器查询ISO 的数据，当有数据来到后，读取接收到的数据帧。

#### CS8900A的驱动程序设计

 CS8900A 的 I/O 模式访问有中断和查询 2 种方式。一般采用中断方式来处理 CS8900A的数据收发。
 网络驱动程序流程如下图所示：分为主程序和中断服务程序，主程序进行DM9000的初始化和网卡检测、网卡参数获取。中断服务程序以程序查询方式识别中断源，完成相应处理。   

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108142626197.png)

#### CS8900A的初始化程序设计

CS8900A 初始化步骤为：

检测CS8900A 芯片是否存在，然后软件复位 CS8900A；

如果使用 Memory Map 方式访问 CS8900A 芯片内部寄存，就设置CS8900A 内部寄存器基地址（默认为 IO 方式访问）；

设置 CS8900A 的 MAC 地址；

关闭事件中断（本例子使用查询方式，如果使用中断方式，则添加中断服务程序再打开CS8900A 中断允许位） ；

配置CS8900A 10BT，然后允许CS8900A 接收和发送，接收发送64-1518 字节的网络帧及网络广播帧

网络层、传输层

这些层一般由操作系统来管理。

应用层

应用层则由用户根据需要进行数据处理。

进行网络应用程序开发有两种方法：一是采用BSD Socket标准接口，程序移植能力强；二是采用专用接口直接调用对应的传输层接口，效率较高。

BSD Socket 接口编程方法 

Socket（套接字）是通过标准的文件描述符和其它程序通讯的一个方法。每一个套接字都用一个半相关描述：{协议，本地地址、本地端口}来表示；一个完整的套接字则用一个相关描述：{协议，本地地址、本地端口、远程地址、远程端口}，每一个套接字都有一个本地的由操作系统分配的唯一的套接字号。 

传输层专有接口编程方法 

网络协议都可以直接提供专有函数接口给上层或者跨层调用，用户可以调用每个协议代码中特有的接口实现快速数据传递。



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.

杨宗德.   嵌入式ARM系统原理与实例开发 [M]．北京：北京大学出版社，2007.

S3C2410 Datasheet



[返回首页](https://github.com/timerring/hardware-tutorial)