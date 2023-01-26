- [S3C2410与S3C2440的区别](#s3c2410与s3c2440的区别)
  - [S3C2410A微处理器概述](#s3c2410a微处理器概述)
  - [S3C2410A微处理器组成](#s3c2410a微处理器组成)
    - [S3C2410A微处理器组成](#s3c2410a微处理器组成-1)
    - [AHB总线连接的控制器简介](#ahb总线连接的控制器简介)
      - [存储器控制器](#存储器控制器)
      - [Nand Flash控制器](#nand-flash控制器)
      - [中断控制器](#中断控制器)
      - [LCD控制器](#lcd控制器)
      - [USB主控制器](#usb主控制器)
      - [时钟与电源管理](#时钟与电源管理)
      - [ExtMaster](#extmaster)
    - [APB总线连接的部件简介](#apb总线连接的部件简介)
    - [操作电压、频率和封装](#操作电压频率和封装)
  - [3C2410A芯片封装](#3c2410a芯片封装)
    - [S3C2410A芯片封装形式](#s3c2410a芯片封装形式)
  - [3C2440简介](#3c2440简介)


# S3C2410与S3C2440的区别

## S3C2410A微处理器概述

SAMSUNG公司的S3C2410A芯片是一款16/32位的RISC微处理器芯片，芯片内使用了ARM公司的ARM920T内核，采用了称为AMBA（Advanced Microcontroller Bus Architecture，先进微处理器总线结构）的总线结构。

S3C2410A芯片组成介绍如下：

+ ARM920T，内部包含两个协处理器、单独16KB指令Cache和MMU、单独16KB数据Cache和MMU等
+ 存储器控制器，产生对SDRAM/Nor Flash/SRAM存储器芯片的控制和片选逻辑
+ Nand Flash控制器
+ 中断控制器
+ LCD控制器，支持STN及TFT液晶显示器
+ 带有外部请求引脚的4通道DMA
+ 3通道通用异步收发器（UART）,支持红外传输
+ 2通道SPI（Serial Peripheral Interface，串行外设接口）
+ 1通道多主IIC总线控制器，1通道IIS总线控制器
+ MMC/SD/SDIO主控制器
+ 2端口USB主控制器，1端口USB设备控制器（Ver 1.1）
+ 4通道脉宽调制（PWM）定时器与1通道内部定时器
+ 看门狗定时器
+ 117位GPIO端口，其中24通道可用作24路外部中断源
+ 电源管理，支持NORMAL、SLOW、IDLE和Power_OFF模式
+ 8通道10位ADC与触摸屏接口
+ 带日历功能的RTC
+ 带锁相环（PLL）的片内时钟发生器

## S3C2410A微处理器组成

### S3C2410A微处理器组成

S3C2410A组成框图如图所示：   

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101145834579.png)

图中，S3C2410A片内组成可以分为三部分：ARM920T、连接在AHB总线上的控制器，以及连接在APB总线上的控制器或外设。

AHB（Advanced High_performance Bus，先进高性能总线）是一种片上总线，用于连接高时钟频率和高性能的系统模块，支持突发传输、支持流水线操作，也支持单个数据传输，所有的时序都是以单一时钟的前沿为基准操作。

APB（Advanced Peripheral Bus，先进外设总线）也是一种片上总线，为低性能、慢速外设提供了较为简单的接口，不支持流水线操作。

4通道DMA与总线桥支持存储器到存储器、I/O到存储器、存储器到I/O、I/O到I/O的DMA传输；它将AHB/APB的信号转换为合适的形式，以满足连接到APB上设备的要求。桥能够锁存地址、数据及控制信号，同时进行二次译码，选择相应的APB设备。

### AHB总线连接的控制器简介

#### 存储器控制器

· 支持小端/大端数据存储格式
· 全部寻址空间为1GB，分为8个banks，每个128MB
· bank1~bank7支持可编程的8/16/32位数据总线宽度，bank0支持可编程的16/32位数据总线宽度
· bank0~bank7支持ROM/SRAM，其中bank6和bank7也支持SDRAM

· 每个bank存储器访问周期可编程
· 对ROM/SRAM，支持外部等待信号（nWAIT）扩展总线周期
· 在Power_down，支持SDRAM自己刷新（self_refresh）模式
· 支持使用Nor Flash、EEPROM等作为引导ROM
· 支持存储器与I/O端口统一寻址

#### Nand Flash控制器

· 支持从Nand Flash存储器进行引导
· 有4KB SRAM内部缓冲区，用于引导时保存从Nand Flash读出的程序
· 支持Nand Flash存储器4KB（引导区）以后的区域作为一般Nand Flash使用

#### 中断控制器

· 支持55个中断源，包括S3C2410A芯片外部，由引脚引入的24个中断源；其余为芯片内部中断源，看门狗（1个）、定时器（5个）、UART（9个）、DMA（4个）、RTC（2个）、ADC（2个）、IIC（1个）、SPI（2个）、SDI（1个）、USB（2个）、LCD（1个）以及电源失效（1个）
· 外部中断源通过编程，可选择中断请求信号使用电平或边沿触发方式
· 电平或边沿触发信号极性可编程
· 对于非常紧急的中断请求，支持快速中断请求FIQ

#### LCD控制器

LCD控制器支持STN LCD显示以及TFT LCD显示，显示缓冲区使用系统存储器（内存），支持专用LCD DMA将显示缓冲区数据传送到LCD控制器缓冲区。
STN LCD显示特点：
    · 支持4位双扫描、4位单扫描、8位单扫描显示类型STN LCD面板
    · 支持单色、4灰度级、16灰度级、256色、4096色STN LCD显示

· 支持多种屏幕尺寸，典型的有640×480、320×240、160×160等
· 最大虚拟屏显示存储器空间为4MB，在256色模式，支持的虚拟屏尺寸有4096×1024、2048×2048、1024×4096等

TFT LCD显示特点：
 · 支持1、2、4或8 BPP（Bit Per Pixel）面板彩色显示
 · 支持16 BPP真彩显示
 · 在24 BPP模式，支持最大16M色
 · 支持多种屏幕尺寸，典型的有640×480、320×240、160×160等
 · 最大虚拟屏显示存储器空间为4MB，在64K色模式，支持的虚拟屏尺寸有2048×1024等

#### USB主控制器

· 2个端口的USB主（Host）控制器
· 兼容OHCI Rev 1.0
· 兼容USB V 1.1
· 支持低速和全速设备

#### 时钟与电源管理

· S3C2410A片内有MPLL（Main Phase Locked Loop，主锁相环）和UPLL（USB PLL，USB锁相环）
· UPLL产生的时钟用于USB主/设备控制器操作
· MPLL产生的时钟在内核供电电压为2.0V时，最大频率为266MHz
· 时钟信号能够通过软件有选择地送到（或不送）每个功能模块
· 电源管理支持NORMAL、SLOW、IDLE和Power_OFF模式
· 由EINT[15:0]或RTC报警中断，能够从Power_OFF模式中将MCU唤醒

#### ExtMaster

对由S3C2410A芯片外部另一个总线主设备提出，并送到S3C2410A的请求控制局部总线的请求，以及S3C2410A的响应，进行管理。

### APB总线连接的部件简介

1. 通用异步收发器（UART 0、1、2）
   · 3通道UART，支持基于查询、基于DMA或基于中断方式操作
   · 支持5/6/7/8位串行数据发送/接收（Tx/Rx）
   · 支持外部时钟（UEXTCLK）用于UART操作
   · 可编程的波特率
   · 支持红外通信协议IrDA 1.0
2. 通用I/O端口（GPIO）
   · GPIO端口共有117位，其中24位可用于外部中断请求源
   · 通过编程，可以将各端口的不同位，设置为不同功能
3. 定时器/脉宽调制
   · 4通道16位脉宽调制定时器，1通道16位内部定时器，均支持基于DMA或基于中断方式操作
4. 实时时钟（RTC）
5. 看门狗定时器（WDT）
6. A/D转换器与触摸屏
7. IIC（Intel Integrated Circuit，内部集成电路）总线接口
8. IIS（Intel IC Sound，集成电路内部声音）总线接口
9. SPI（Serial Peripheral Interface，串行外设接口）
10. MMC/SD/SDIO主控制器
11. USB设备控制器

### 操作电压、频率和封装

1. 操作电压
   + 内核：1.8V，用于S3C2410A-20，最高200MHz
              2.0V，用于S3C2410A-26，最高266MHz
   + 存储器与I/O：3.3V
2. 操作频率
   + 最高到266MHz
3. 芯片封装

## 3C2410A芯片封装

### S3C2410A芯片封装形式

S3C2410A芯片有272个引脚，FBGA封装。

每个引脚所在行、列对应的字母、数字，是分配给该引脚的编号，例如左下引脚为A1，左上引脚为U1。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152008235.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152020635.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152050420.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152111685.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152129021.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152148520.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152203268.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152215233.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152225205.png)

特殊功能寄存器（Special Function Registers，SFR），有时也称特殊寄存器或专用寄存器。占用存储器空间地址为0x48000000~0x5FFFFFFF的一片区域，称为SFR Area（特殊功能寄存器区域），这些寄存器均在S3C2410A芯片内部，它们的含义和功能在第5章~第13章中分别讲述。

## 3C2440简介

S3C2440A以 ARM920T为核心，采用0.13um CMOS标准单元和存储器编译器开发。

S3C2440A的CPU内核ARM920T是一高性能的32位RISC处理器，内部实现了MMU，AMBA总线，和哈佛缓存架构与独立的16KB指令和16KB数据高速缓存。

它的低功耗，简单，优雅和全静态设计特别适合于成本和功耗敏感的应用。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230101152258768.png)



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)