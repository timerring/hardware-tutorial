- [ARM相关开发工具概述](#arm相关开发工具概述)
  - [JTAG仿真器](#jtag仿真器)
  - [J-LINK仿真调试器](#j-link仿真调试器)
    - [J-Link ARM主要特点](#j-link-arm主要特点)
  - [U-LINK仿真调试器](#u-link仿真调试器)
    - [ULINK2特点](#ulink2特点)
    - [ULINK和JLINK的比较](#ulink和jlink的比较)
  - [ADS1.2集成开发环境](#ads12集成开发环境)
    - [使用ADS创建工程](#使用ads创建工程)


# ARM相关开发工具概述

## JTAG仿真器  

JTAG(Joint Test Action Group；联合测试行动小组)是一种国际标准测试协议（IEEE 1149.1兼容），主要用于芯片内部测试及对系统进行仿真、调试。

JTAG 技术是一种嵌入式调试技术，它在芯片内部封装了专门的测试电路 TAP （ Test Access Port ，测试访问口），通过专用的 JTAG 测试工具对内部节点进行测试。

JTAG接口还常用于实现ISP（In-System Programmer，在系统编程），对FLASH等器件进行编程。

通常所说的JTAG大致分两类，一类用于测试芯片的电气特性，检测芯片是否有问题；一类用于Debug，一般支持JTAG的CPU内都包含了这两个模块。

一个含有JTAG Debug接口模块的CPU，只要时钟正常，就可以通过JTAG接口访问CPU的内部寄存器和挂在CPU总线上的设备，如FLASH，RAM，SOC（比如4510B，44Box，AT91M系列）内置模块的寄存器，象UART，Timers，GPIO等等的寄存器。 

现在多数的高级器件都支持JTAG协议，如：新型单片机如MSP430、ARM、DSP、FPGA器件等。

标准的JTAG接口是4线：TMS、TCK、TDI、TDO，分别为模式选择、时钟、数据输入和数据输出线。

标准的 JTAG 接口是 4 线： TMS 、 TCK 、 TDI 、 TDO ，分别为测试模式选择、测试时钟、测试数据输入和测试数据输出。如今 JTAG 接口的连接有两种标准，即 14 针接口和 20 针接口，其定义分别如下所示。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221228103453806.png)

14针的JTAG接口为老式接口。 

引脚信号说明

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221228103552738.png)

SAMSUNG ARM7 S3C44B0开发套件中的JTAG编程板电路如图 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221228103623561.png)

S3C2440的官方JTAG编程板 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221228103650187.png)

## J-LINK仿真调试器

J-Link是SEGGER公司为支持仿真ARM内核芯片推出的采用USB接口的JTAG仿真器。

配合IAR EWAR，ADS，KEIL，WINARM，RealView等集成开发环境支持所有ARM7/ARM9/ARM11,Cortex M0/M1/M3/M4, Cortex A4/A8/A9等内核芯片的仿真，与IAR,Keil等编译环境无缝连接，操作方便、连接方便、简单易学，是学习开发ARM最好最实用的开发工具。  

### J-Link ARM主要特点

IAR EWARM集成开发环境无缝连接的JTAG仿真器。

+ 支持CPUs: Any ARM7/9/11, Cortex-A5/A8/A9, Cortex-M0/M1/M3/M4, Cortex-R4, RX610, RX621, RX62N, RX62T, RX630, RX631, RX63N。
+ 下载速度高达1 MByte/s。
+ 最高JTAG速度15 MHz。
+ 目标板电压范围1.2V –3.3V,5V兼容。
+ 自动速度识别功能。
+ 监测所有JTAG信号和目标板电压。
+ 完全即插即用。
+ 使用USB电源（但不对目标板供电）
+ 带USB连接线和20芯扁平电缆。
+ 支持多JTAG器件串行连接。
+ 标准20芯JTAG仿真插头。
+ 选配14芯JTAG仿真插头。
+ 选配用于5V目标板的适配器。
+ 带J-Link TCP/IP server，允许通过TCP/ IP网络使用J-Link。

## U-LINK仿真调试器

Keil ULINK USB接口仿真器，是一款多功能ARM调试工具，可以通过JTAG 或 CODS 接口连接到目标系统，进行仿真或下载程序，目前已经成为国内主流的ARM开发工具。

Keil ULINK的软件环境为Keil uVision Keil系列软件具有良好的调试界面，优秀的编译效果，丰富的使用资料。使其深受国内嵌入式开发工程师的喜爱。

目前，ULINK已经停产，新用户推荐选择ULINK2或ULINKPro仿真器。 

ULINK2是ARM公司最新推出的配套RealView MDK使用的仿真器，是ULink仿真器的升级版本。

ULINK2不仅具有ULINK仿真器的所有功能，还增加了串行调试（SWD）支持，返回时钟支持和实时代理等功能。开发工程师通过结合使用RealView MDK的调试器和ULINK2，可以方便的在目标硬件上进行片上调试(使用on-chip JTAG， SWD和 OCDS)、Flash编程. 

### ULINK2特点

+ 支持ARM7，ARM9， Cortex-M，8051和C166设备 
+ JTAG速度高达10MHz 支持Cortex-M串行查看器（SWV）数据和时间跟踪，速度高达1Mbit/s（UART模式）
+ 执行、端口仿真和串行调试输出时的存储器读写实时代理
+ 与Keil μVision IDE和Debugger无缝隙集成
+ 宽目标电压，从2.7V – 5.5V可用
+ USB供电（无须电源）
+ 使用标准Windows USB设备，即插即用安装目标连接器

### ULINK和JLINK的比较

ULINK是KEIL公司开发的仿真器，专用于KEIL平台下使用，ADS,IAR下不能使用

JLINK是通用的开发工具，可以用于KEIL，IAR，ADS等平台速度，效率，功能均比ULINK强

ULINK2的下载速度和调试速度确实没有JLINK的快。

## ADS1.2集成开发环境

基于Windows操作系统平台的ARM ADS（ARM Developer Suite）软件下进行的，该软件是由ARM公司提供的专门用于ARM 处理器应用开发和调试的综合性工具软件，目前使用的ADS1.2版本。

ADS1.2主要包含CodeWarrior IDE、AXD两部分；CodeWarrior IDE工具主要用于工程的管理配置、源程序的编辑、编译和链接；AXD主要用于工程的下载和调试。

CodeWarrior 集成开发环境(IDE)为管理和开发项目提供了简单多样化的图形用户界面。 用户可以使用ADS 的CodeWarrior IDE 为ARM 和Thumb 处理器开发用C，C++，或ARM汇编语言的程序代码。通过提供下面的功能，CodeWarrior IDE 缩短了用户开发项目代码的周期。 

### 使用ADS创建工程

+ ARM Executabl Image：用于由ARM 指令的代码生成一个ELF 格式的可执行映像文件；
+ ARM Object Library：用于由ARM 指令的代码生成一个armar 格式的目标文件库； 
+ Empty Project ：用于创建一个不包含任何库或源文件的工程； 
+ Makefile  Importer  Wizard ：用于将Visual  C 的nmake  或 GNU    make 文件转入到CodeWarrior IDE 工程文件； 
+ Thumb ARM Executable Image：用于由ARM 指令和Thumb 指令的混和代码生成一个可执行的ELF 格式的映像文件； 
+ Thumb Executable image：用于由Thumb 指令创建一个可执行的ELF 格式的映像文件； 
+ Thumb Object Library ：用于由Thumb 指令的代码生成一个armar 格式的目标文件库。 


参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)