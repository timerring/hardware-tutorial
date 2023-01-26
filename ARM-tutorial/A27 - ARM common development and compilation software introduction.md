- [ARM常用开发编译软件介绍](#arm常用开发编译软件介绍)
  - [编译器介绍](#编译器介绍)
  - [1、ADS1.2](#1ads12)
  - [2、ARM RealView Developer Suite (RVDS)](#2arm-realview-developer-suite-rvds)
  - [3、IAR EWARM](#3iar-ewarm)
  - [4、KEIL ARM-MDKARM](#4keil-arm-mdkarm)
  - [5、WIN ARM-GCC ARM](#5win-arm-gcc-arm)


# ARM常用开发编译软件介绍

## 编译器介绍

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221227105406508.png)

## 1、ADS1.2 

ADS（ARM Developer Suite），是在1993年由Metrowerks公司开发是ARM处理器下最主要的开发工具。 他的前身是SDT，SDT是ARM公司几年前的开发环境软件，目前SDT早已经不再升级。ADS包括了四个模块分别是：SIMULATOR；C 编译器；实时调试器；应用函数库。ADS对汇编、C/C++、java支持的均很好，是目前最成熟的ARM开发工具。很多ARM开发软件（例如Keil）也是借用的ADS的编译器。ADS在2006年版本已经发布到2.2。但国内大部分开发者使用的均是1.2版本 

ADS1.2提供完整的WINDOWS界面开发环境。C编译器效率高，支持c 以及c++。提供软件模拟仿真功能，使没有Emulators的学习者也能够熟悉ARM的指令系统。配合FFT-ICE使用，ADS1.2提供强大的实时调试跟踪功能,片内运行情况尽在掌握。ADS1.2需要硬件支持才能发挥强大功能。目前支持的硬件调试器有Multi-ICE以及兼容Multi-ICE的调试工具如FFT-ICE。

版本：ADS1.2 

软件大小：130M 

## 2、ARM RealView Developer Suite (RVDS) 

ARM RealView Developer Suite (RVDS) 是 ARM 公司继 ARM Developer Suite(ADS 1.2) 之后推出的新一代开发工具，是业界公认最好的 ARM 编译器之一。

它由 RealView 编译器 (RVCT) ，以及 RealView 调试器（ RV Debugger ）， CodeWarrior 集成开发环境和 ARMulator 指令集仿真器组成。可以支持所有标准 ARM 架构和内核，针对特定处理器进行代码优化，有多种可以灵活配置的优化选项以取得最小的代码尺寸和最好的性能。

RealView ICE主要特点：

+ 高性能的调试控制 
+ 通过 RealView Debugger 代码下载速度可达 1300 Kbytes/ 秒 
+ 高速单步执行 , 每秒可达 100 
+ 支持 JTAG 调试通信通道 (DCC) 
+ 支持多种 JTAG 时钟频率 , 从 2KH~50MHZ 
+ 更低的 JTAG 时钟频率 ( 低于 1KHZ), 支持 ASIC 外围电路调试 
+ 宽电压支持 1.0~5.0V 
+ 支持多核处理器调试 , 同步控制 
+ 配合 RealView Trace 模块插件可捕获支持 ETM 跟踪数据 
+ 通过 JTAG 访问 ETB 跟踪数据 
+ 兼容 GDB 与 KGDB 调试 
+ 支持 USB1.1 与 2.0 连接 
+ 支持网络连接调试 10/100baseT 
+ 支持的 ARM 处理器：ARM7 TM , ARM9 TM , ARM9E TM , ARM10 TM , ARM11 TM 和 Cortex TM 

RealView Trace 主要特性：

+ 非插入式的实时指令跟踪与数据跟踪，跟踪频率可高达 250MHZ ，高达 8 百万帧深度的跟踪缓冲区（高达 4 百万帧深度的 time stamp 缓冲区） 
+ 48 位 time stamp ， 10 纳秒分辨率，支持最长连续 32 天数据跟踪 
+ 4/8/16 位数据宽度跟踪端口 
+ 外部事件同步触发器 
+ 完全可变的触发位置 
+ 快速 on-the-fly 跟踪数据上传 
+ 与主机共享 RealView ICE 连接 
+ 支持 ETM 跟踪端口模式 
+ 支持 v1.x, v2.x, v3.x for ETM7TM ETM9TM, ETM10TM 与 ETM11TM 等 ETM 协议 
+ 单边沿和双边沿时钟触发 
+ 普通与多元的端口 

库创建工具

内容丰富的在线文档

版本：ARM RealView Developer2.2

软件大小：500M

## 3、IAR EWARM

Embedded Workbench for ARM 是IAR Systems 公司为ARM 微处理器开发的一个集成开发环境(下面简称IAR EWARM)。比较其他的ARM 开发环境，IAR EWARM 具有入门容易、使用方便和代码紧凑等特点。

EWARM 中包含一个全软件的模拟程序(simulator)。用户不需要任何硬件支持就可以模拟各种ARM 内核、外部设备甚至中断的软件运行环境。从中可以了解和评估IAR EWARM 的功能和使用方法。

最新版本是: IAR Embedded Workbench  for ARM version 4.30。

IAR EWARM 的主要特点如下：

+ 高度优化的IAR ARM C/C++ Compiler 
+ IAR ARM Assembler
+ 一个通用的IAR XLINK Linker
+ IAR XAR 和XLIB 建库程序和IAR DLIB C/C++运行库
+ 功能强大的编辑器
+ 项目管理器
+ 命令行实用程序
+ IAR C-SPY 调试器(先进的高级语言调试器)

版本：IAR EWARM 4.40a

软件大小：93M 

## 4、KEIL ARM-MDKARM

Keil公司已从事MCS-51开发平台uVision著名。近年来，Keil公司也将自己的领域扩展到了ARM的开发工具，即：keil arm，再后来keil真的被arm收购了，他的arm开发工具这一块就是现在的MDK系列。

Keil uVision调试器可以帮助用户准确地调试ARM器件的片内外围功能(I2C、CAN、UART、SPI、中断、I/O口、A/D转换器、D/A转换器和PWM模块等功能)。

Keil MDK-ARM最新版本4.54，安装包500多兆，包括ARM的编译器和uVision 4集成开发环境。 

MDK-ARM 具有四种版本：MDK-Lite、MDK 基础版、MDK 标准版和 MDK 专业版。所有版本都提供完整的 C/C++ 开发环境，MDK 专业版包括丰富的中间件库。 

Project/Target/Group/File的重叠管理模式，并可逐级设置；高度智能彩色语法显示；

特点

+ 完全支持 ARM Cortex™-M 系列、Cortex-R4、ARM7™ 和 ARM9™ 设备 
+ 行业领先的 ARM C/C++ 编译工具链 
+ µVision4 IDE、调试器和模拟环境 
+ 支持来自 20 多个供应商的 1200 多种设备 
+ Keil RTX 确定性、占用空间小的实时操作系统（具有源代码） 
+ TCP/IP 网络套件提供多个协议和各种应用程序 
+ USB 设备和 USB 主机堆栈配备标准驱动程序类 
+ ULINKpro支持对正在运行的应用程序进行即时分析并记录执行的每条 Cortex-M 指令 
+ 有关程序执行的完整代码覆盖率信息 
+ 执行性能分析器和性能分析器支持程序优化 
+ 大量示例项目可帮您快速熟悉强大的内置功能 
+ 符合 CMSIS Cortex 微控制器软件接口标准

多种流行编译工具选择 

+ Keil高效率C编译器；
+ ARM公司的ADS/RealView 编译器；
+ GNU GCC 编译器；
+ 后续厂商的编译器。

## 5、WIN ARM-GCC ARM

WINARM  是一个免费的开发工具。 

WinARM 里面除了包含 C/C++ 编译器——GCC，汇编、连接器——Binutils，调试器——GDB等工具，也包括了通过 GDB 使用 Wiggler JTAG 的软件——OCDRemote。所以，所需要的工具都包括在了这个 WinARM 发行版中，就比较省心。 



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)