- [ARM最小系统设计详解](#arm最小系统设计详解)
    - [一、什么是最小系统](#一什么是最小系统)
      - [最小系统结构框图](#最小系统结构框图)
      - [最小系统例板](#最小系统例板)
      - [嵌入式最小系统硬件功能](#嵌入式最小系统硬件功能)
    - [二、时钟和功率管理](#二时钟和功率管理)
      - [( 一 ) 时钟管理](#-一--时钟管理)
        - [1、时钟电路结构](#1时钟电路结构)
        - [2、锁相环 PLL](#2锁相环-pll)
      - [( 二 ) 功率管理](#-二--功率管理)
        - [正常模式](#正常模式)
        - [空闲模式](#空闲模式)
        - [低速模式](#低速模式)
        - [掉电模式](#掉电模式)
    - [三、电源电路设计](#三电源电路设计)
    - [四、复位电路设计](#四复位电路设计)
    - [五、JTAG电路](#五jtag电路)
    - [六、存储器扩展](#六存储器扩展)
      - [特性](#特性)
      - [存储器映射](#存储器映射)
      - [Bank0总线宽度](#bank0总线宽度)
      - [nWAIT引脚操作](#nwait引脚操作)
      - [nXBREQ/nXBACK](#nxbreqnxback)
      - [总线宽度和等待控制寄存器BWSCON](#总线宽度和等待控制寄存器bwscon)
      - [ROM Memory Interface Examples](#rom-memory-interface-examples)
      - [SRAM Memory Interface Examples](#sram-memory-interface-examples)
      - [SDRAM Memory Interface Examples](#sdram-memory-interface-examples)
      - [SDRAM 电路图](#sdram-电路图)
      - [BANK控制寄存器(BANKCONn: nGCS0-nGCS5)](#bank控制寄存器bankconn-ngcs0-ngcs5)
      - [BANK控制寄存器(BANKCONn: nGCS6-nGCS7)](#bank控制寄存器bankconn-ngcs6-ngcs7)
    - [七、NAND Flash和NOR Flash](#七nand-flash和nor-flash)
      - [NAND Flash和NOR Flash的比较](#nand-flash和nor-flash的比较)
        - [性能比较](#性能比较)
        - [接口差别](#接口差别)
        - [容量和成本](#容量和成本)
        - [可用性和耐用性](#可用性和耐用性)
        - [软件支持](#软件支持)
      - [ARM处理器与NOR Flash的接口](#arm处理器与nor-flash的接口)
      - [Nor Flash 接口方式](#nor-flash-接口方式)
        - [（1）双Flash独立片选](#1双flash独立片选)
        - [（2）双Flash统一片选](#2双flash统一片选)
    - [八、嵌入式系统的启动架构](#八嵌入式系统的启动架构)
      - [（1）从Nor Fash启动](#1从nor-fash启动)
        - [启动架构](#启动架构)
        - [单独使用Nor Flash](#单独使用nor-flash)
        - [Nor Flash和Nand Flash配合使用](#nor-flash和nand-flash配合使用)
      - [（2）从Nand Flash启动](#2从nand-flash启动)
    - [九、S3C2410 NAND Flash控制器](#九s3c2410-nand-flash控制器)
      - [特性](#特性-1)
      - [NAND Flash控制器的结构框图](#nand-flash控制器的结构框图)
      - [PIN CONFIGURATION](#pin-configuration)
      - [NAND Flash的工作方式](#nand-flash的工作方式)
      - [NAND Flash存储器的时序](#nand-flash存储器的时序)
      - [NAND FLASH MEMORY MAPPING](#nand-flash-memory-mapping)
      - [SPECIAL  FUNCTION  REGISTERS](#special--function--registers)
      - [ARM处理器与Nand Flash接口技术](#arm处理器与nand-flash接口技术)
        - [（1）运用GPIO方式](#1运用gpio方式)
        - [（2）运用逻辑运算方式进行连接](#2运用逻辑运算方式进行连接)
        - [（3）直接芯片使能](#3直接芯片使能)


# ARM最小系统设计详解

### 一、什么是最小系统 

嵌入式微处理器芯片自己是不能独立工作的，需要一些必要的外围元器件给它提供基本的工作条件。

一个 ARM 最小系统一般包括：

+ ARM 微处理器芯片
+ 电源电路、复位电路，晶振电路， 
+ 存储器（ FLASH 和 SDRAM ）， 
+ UART（RS232及以太网）接口电路。 
+ JTAG 调试接口。

#### 最小系统结构框图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091007808.png)

#### 最小系统例板

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091032500.png)

#### 嵌入式最小系统硬件功能  

+ 微处理器：S3C2410是系统工作和控制中心； 
+ 电源电路：为S3C2410核心部分提供所需的1.80V工作电压，为部分外围芯片提供3.0V的工作电压；
+ 晶振电路：为微处理器及其他电路提供工作时钟，及系统中S3C2410芯片使用32KHz或32.768KHz无源晶振；
+ Flash存储器：存放嵌入式操作系统、用户应用程序或者其他在系统掉电后需要保存的用户数据等；
+ SDRAM：作为系统运行时的主要区域，系统及用户数据、堆栈均位于该存储器中；
+ 串行接口：用于系统与其他应用系统的短距离双向串行通信和构建交叉编译环境；     
+ JTAG接口：对芯片内部所有部件进行访问，通过该接口对系统进行调试、编程等；
+ 系统总线扩展：引出地址总线、数据总线和必须的控制总线，便于用户根据自身的特定需求，扩展外围电路。

在嵌入式系统中，最小系统虽然简单，但是作为整个系统正常运行的基本条件，因此其稳定可靠的运行是至关重要的。因此，在嵌入式系统中，往往将最小系统制成一个核心板，其他的各种接口和外围扩展设备都制成一个接口板来组成一个系统。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091144376.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091159951.png)

### 二、时钟和功率管理 

时钟和功率管理模块由三部分组成：时钟控制，USB控制和功率控制。

S3C2410A的时钟控制逻辑能够产生系统所需要的时钟，包括 CPU的FCLK，AHB总线接口的HCLK，和 APB总线接口的PCLK。

S3C2410A有两个PLL（MPLL和UPLL） ，一个MPLL用于FCLK,HCLK,PCLK，另一个UPLL用于USB模块（48MHZ）。时钟控制逻辑能够由软件控制不将 PLL连接到各接口模块以降低处理器时钟频率，从而降低功耗。

FCLK用于 ARM920T；

HCLK用于 AHB总线（包括 ARM920T，存储控制器，中断控制器，LCD控制器，DMA和 USB主机）；

PCLK 用于APB总线 （包括外设如WDT,IIS,I2C,PWM, PWM，TIMER, MMC, ADC, UART, GPIO, RTC, SPI）。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091307473.png)

#### ( 一 ) 时钟管理

##### 1、时钟电路结构

时钟架构的方块图如下图所示：主时钟源由一个外部晶振或者外部时钟产生。时钟发生器包括连接到一个外部晶振的振荡器和两个 PLL（MPLL和UPLL）用于产生系统所需的高频时钟。

时钟源选择

下表描述了模式控制引脚(OM3和OM2)和选择时钟源之间的对应关系。OM[3:2]的状态由OM3和 OM2引脚的状态在 nRESET的上升沿锁存得到。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091350608.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091401818.png)

##### 2、锁相环 PLL 

位于时钟信号发生器的内部 MPLL 用于将输出信号和相关输入信号在相位和频率上同步起来。它包括如下图所示的一些基本模块：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091429093.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091452286.png)

PLL的工作原理：

根据 DC 电压产生相应比例关系频率的压控振荡器(VCO)，除数 P(对输入频率 Fin 进行 P 分频)，除数 M(对VCO 的输出频率进行 M 分频，分频后输入到相位频率探测器 PFD)，除数 S（对MPLL 输出频率 Mpll 进行分频），相差探测器，charge  pump，loop  filter。MPLL的时钟输出 Mpll和输入时钟 Fin的关系如下式所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091519458.png)

PLL控制寄存器(MPLLCON/UPLLCON) 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091550843.png)

USB时钟控制

USB 主机接口和 USB 设备接口需要 48MHz 的时钟。在 S3C2410 中，是通过UPLL来产生这一时钟的，UCLK只有在 UPLL配置好后才会生效。 

PLL选择表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091628138.png)

注：

1. 默认值下MPLL为Fin的10倍频，UPLL为Fin的4倍频
2. 尽管可以根据公式设置 PLL，但是推荐仅使用 推荐表里面的值。 
3. 如果要同时设置 UPLL 和 MPLL，请先设置 UPLL，然后设置 MPLL，且至少要间隔7个时钟周期。 

上电复位（XTIpll）时钟锁定过程

下图显示了上电复位时的时钟行为。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091726348.png)


晶振在几毫秒内开始振荡。当 OSC 时钟稳定后，PLL 根据默认 PLL 设置开始生效，但是通常这个时候是不稳定的，因此在软件重新配置 PLLCON 寄存器之前 FCLK 直接使用 Fin 而不是 MPLL，即使用户不希望改变PLLCON的默认值，用户也应该执行一遍写 PLLCON操作。FCLK在软件配置好 PLLCON之后锁定一段时间后连接到Mpll。

正常情况下改变 MPLL设置

正常模式下，用户可以通过写 P/M/S的值来改变 FCLK的频率，此时将会自动插入一段时间延迟，在这段延迟内 FCLK将停止，其时序如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102091754046.png)

FCLK,HCLK,PCLK频率确定

S3C2410支持三者之间的比率可选，这个比率是由CLKDIVN寄存器的 HDIVN和 PDIVN决定的。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092054889.png)

设置好 PMS 的值后，需要设置 CLKDIVN 寄存器。CLKDIVN 寄存器的值将在PLL锁定时间之后生效，在复位和改变功率模式后也是有效的。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092109504.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092120304.png)

#### ( 二 ) 功率管理

​      S3C2410A有各种针对不同任务提供的最佳功率管理策略，功率管理模块能够使系统工作在如下 4种模式：正常模式，低速模式，空闲模式和掉电模式。

​      在 S3C2410 中，功率管理模块通过软件控制系统时钟来达到降低功耗的目的。这些策略牵涉到 PLL，时钟控制逻辑和唤醒信号。图显示了 S3C2410的时钟分配。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092159229.png)

##### 正常模式 

​      正常模式下，所有的外设和基本的功能模块，包括功率管理模块，CPU 核心，总线控制器，存储控制器，中断控制器，DMA 和外部控制器都可以完全操作。但是除了基本的模块之外，其他模块都可以通过关闭其时钟的方法来降低功耗。

##### 空闲模式 

​       空闲模式下，除了总线控制器、存储控制器、中断控制器、功率管理模块以外的 CPU 时钟都被停止。EINT[23:0]、RTC 中断或者其他中断都可以将 CPU从空闲模式下唤醒。

##### 低速模式 

​     低速模式通过降低 FCLK和关闭 PLL来实现降低功耗。此时 FCLK是外部时钟(XTIpll  or  EXTCLK)的 n 分频。分频数由 CLKSLOW 寄存器的 SLOW_VAL 和CLKDIVN寄存器决定。 
​    在低速模式下，PLL 是关闭的。当用户需要从低速模式切换到正常模式时，PLL 需要一个时钟稳定时间(PLL 锁定时间)。PLL 稳定时间是由内部逻辑自动插入的，大概需要150us，在这段时间内，FCLK还是使用低速模式下的时钟。     

低速时钟控制寄存器(CLKSLOW) 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092246980.png)

时钟控制寄存器 CLKCON 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092321907.png)

##### 掉电模式 

​     功率管理模块断开内部电源。因此除CPU和唤醒逻辑单元以外的外设都不会产生功耗。要执行掉电模式需要有两个独立的电源，其中一个给唤醒逻辑单元供电，另一个给包括 CPU在内的其他模块供电。在掉电模式下，第二个电源将被关掉。掉电模式可以由外部中断 EINT[15:0]或 RTC中断唤醒。

### 三、电源电路设计

有很多DC-DC转换器可完成到3.3V的转换，如Linear Technology的LT108X系列。常见的型号和对应的电流输出如下：

+ LT1083 		7.5A
+ LT1084 		5A
+ LT1085 		3A
+ LT1086 		1.5A

有很多DC-DC转换器可完成到2.5V的转换，常用的如Linear Technology的LT1761。

电源电路设计－3.3V

需要使用3.3V的直流稳压电源，系统电源电路如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092432797.png)

电源电路设计－2.5V

需要使用2.5V的直流稳压电源，系统电源电路如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092530441.png)

电源电路

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092553677.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092603038.png)

### 四、复位电路设计 

S3C2410的nRESET管脚上，持续4个FCLK以上的低电平，将使其进入复位状态。

S3C2410的复位电路一般由复位芯片来实现。MAX811或IMP811芯片就是常用的复位芯片，它只有4个管脚。利用

该芯片可以同时上电复位和手动复位，其复位时间不小于140ms。其引脚分布如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092807107.png)

引脚说明

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092829621.png)

当Vcc信号低于门限电压时，IMP811的复位信号为低电平，而IMP812的复位信号则为高电平。并且在Vcc已经升至该门限之上后，保持这个信号最少140ms。

MR端的逻辑低电平将IMP811的RESET端设为低电平，而IMP812的复位则设为高电平。MR在内部通过一个20kΩ电阻被拉至高电平并可由TTL/CMOS门或集电极/漏极开路输出驱动。MR不用时可为开路。

MR可用一个常开开关连接到地而无需外部去抖动电路。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092913249.png)

IMP811有六种电压门限以支持3V至5V系统：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092938084.png)

其应用电路如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102092953053.png)

### 五、JTAG电路 

JTAG(Joint Test Action Group，联合测试行动小组1985 年制定的检测PCB 测试的一个标准， 1990 年被修改后成为IEEE 的一个标准， 即IEEE1149.1-1990。IEEE 1149.1 标准就是由JTAG 这个组织最初提出的，最终由IEEE 批准并且标准化的。所以，这个IEEE 1149.1 这个标准一般也俗称JTAG 调试标准。

一个含有JTAG Debug接口模块的CPU，只要时钟正常，就可以通过JTAG接口访问CPU的内部寄存器和挂在CPU总线上的设备，如FLASH，RAM，SOC内置模块的寄存器，像UART，Timers，GPIO等等的寄存器 

在理论上，通过JTAG可以访问CPU总线上的所有设备，所以应该可以写FLASH，但是FLASH写入方式和RAM大不相同，需要特殊的命令，而且不同的FLASH擦除，编程命令不同，而且块的大小，数量也不同，很难提供这一项功能。所以一般调试软件像AXD等不提供写Flash功能，或者仅支持少量几种Flash。 

接口的主要信号接口就是这 5 个。

+ Test Clock Input (TCK) 

  TCK 为 TAP 的操作提供了一个独立的、基本的时钟信号，TAP 的所有操作都是通过这个时钟信号来驱动的。TCK在 IEEE 1149.1 标准里是强制要求的。 

+ Test Mode Selection Input (TMS) 

  TMS 信号用来控制 TAP 状态机的转换。通过 TMS 信号，可以控制 TAP 在不同的状态间相互转换。TMS信号在 TCK的上升沿有效。TMS在 IEEE 1149.1 标准里是强制要求的。 

+ Test Data Input (TDI) 

  TDI是数据输入的接口。 所有要输入到特定寄存器的数据都是通过 TDI 接口一位一位串行输入的（由 TCK驱动） 。TDI在 IEEE 1149.1 标准里是强制要求的。 

+ Test Data Output (TDO) 

  TDO是数据输出的接口。所有要从特定的寄存器中输出的数据都是通过 TDO接口一位一位串行输出的（由 TCK驱动） 。TDO在 IEEE 1149.1 标准里是强制要求的。 

+ Test Reset Input (TRST) 

  TRST可以用来对TAP Controller进行复位 （初始化） 。 不过这个信号接口在IEEE 1149.1标准里是可选的，并不是强制要求的。因为通过 TMS也可以对 TAP Controller进行复位（初始化） 。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093049725.png)

### 六、存储器扩展 

S3C2410A的存储器控制器提供访问外部存储器所需要的存储器控制信号。 

#### 特性

+ 支持小/大端（通过软件选择）
+ 地址空间：每bank有128M字节（总共有8个banks，共1G字节）
+ 除bank0（只能是16/32位宽）之外，其他bank都具有可编程的访问大小（可以是8/16/32位宽）
+ 总共有8个存储器banks（bank0~bank7）
  + 其中6个banks用于ROM，SRAM等
  + 剩下2个banks用于ROM，SRAM，SDRAM等
  + 7个固定的存储器bank（bank0~bank6）起始地址
  + 最后一个bank（bank7）的起始地址是可调整的
  + 最后两个bank（bank6~bank7）的大小是可编程的
+ 所有存储器bank的访问周期都是可编程的
+ 总线访问周期可以通过插入外部等待来延长
+ 支持SDRAM的自刷新和掉电模式 

#### 存储器映射 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093136296.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093153160.png)

#### Bank0总线宽度

BOOT ROM 在地址上位于ARM 处理器的Bank0 区，它可具有多种数据总线宽度16位或32位，这个宽度是可以通过硬件设定的，即通过OM[1:0]引脚上的逻辑电平进行设定，如下表所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093206562.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093214259.png)

#### nWAIT引脚操作

在S3C2410A的存储器访问期间，nWAIT信号有效（低电平）将使得其访问周期相应（nOE或者new信号有效时间）的延长。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093230302.png)

#### nXBREQ/nXBACK 

当nXBREQ信号有效（低电平）时，S3C2410A将通过使nXBACK信号有效作出响应。同时，将使地址数据总线和存储器控制信号处于高阻（Hi-Z）状态，直到nXBREQ 信号无效为止。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093315572.png)

#### 总线宽度和等待控制寄存器BWSCON

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093325722.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093331424.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093338319.png)

#### ROM Memory Interface Examples

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093404472.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093433256.png)

8-bit ROM ×4

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093442616.png)

16-bit ROM

#### SRAM Memory Interface Examples

16-bit SRAM

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093513090.png)

16-bit SRAM ×2

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093522302.png)

#### SDRAM Memory Interface Examples

16-bit SDRAM(8MB: 1Mb ×16 ×4banks)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093547906.png)

16-bit SDRAM (16MB: 1Mb ×16 ×4banks ×2ea)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093555709.png)

#### SDRAM 电路图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093609819.png)

#### BANK控制寄存器(BANKCONn: nGCS0-nGCS5)

![image-20230102093625895](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093625895.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093636272.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093641723.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093647844.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093653767.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093659201.png)

#### BANK控制寄存器(BANKCONn: nGCS6-nGCS7)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093711445.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093719567.png)

### 七、NAND Flash和NOR Flash 

NOR和NAND是现在市场上两种主要的非易失闪存技术。Intel于1988年首先开发出NOR flash技术，彻底改变了原先由EPROM和EEPROM一统天下的局面。紧接着，1989年，东芝公司发表了NAND flash结构，强调降低每比特的成本，更高的性能，并且象磁盘一样可以通过接口轻松升级。 

NOR的特点是芯片内执行(XIP, eXecute In Place)，这样应用程序可以直接在flash闪存内运行，不必再把代码读到系统RAM中。NOR的传输效率很高，在1～4MB的小容量时具有很高的成本效益，但是很低的写入和擦除速度大大影响了它的性能。 

NAND结构能提供极高的单元密度，可以达到高存储密度，并且写入和擦除的速度也很快。应用NAND的困难在于flash的管理和需要特殊的系统接口。 

Flash闪存是非易失存储器，可以对称为块的存储器单元块进行擦写和再编程。任何flash器件的写入操作只能在空或已擦除的单元内进行，所以大多数情况下，在进行写入操作之前必须先执行擦除。NAND器件执行擦除操作是十分简单的，而NOR则要求在进行擦除前先要将目标块内所有的位都写为0。 执行擦除时块尺寸的不同进一步拉大了NOR和NADN之间的性能差距。 

#### NAND Flash和NOR Flash的比较

##### 性能比较 

+ NOR的读速度比NAND稍快一些。
+ NAND的写入速度比NOR快很多。
+ NAND的4ms擦除速度远比NOR的5s快。
+ 大多数写入操作需要先进行擦除操作。
+ NAND的擦除单元更小，相应的擦除电路更少 

##### 接口差别 

NOR flash带有SRAM接口，有足够的地址引脚来寻址，可以很容易地存取其内部的每一个字节。

NAND器件使用复杂的I/O口来串行地存取数据，各个产品或厂商的方法可能各不相同。8个引脚用来传送控制、地址和数据信息。

NAND读和写操作采用512字节的块，这一点有点像硬盘管理此类操作，很自然地，基于NAND的存储器就可以取代硬盘或其他块设备。

##### 容量和成本 

NAND flash的单元尺寸几乎是NOR器件的一半，由于生产过程更为简单，NAND结构可以在给定的模具尺寸内提供更高的容量，也就相应地降低了价格。 

NOR flash占据了容量为1～16MB闪存市场的大部分，而NAND flash只是用在8～128MB的产品当中，这也说明

NOR主要应用在代码存储介质中，NAND适合于数据存储，NAND在CompactFlash、Secure Digital、PC Cards和MMC存储卡市场上所占份额最大。 

##### 可用性和耐用性 

采用flahs介质时一个需要重点考虑的问题是可用性。对于需要扩展MTBF的系统来说，Flash是非常合适的存储方案。可以从寿命(耐用性)、位交换和坏块处理三个方面来比较NOR和NAND的可用性。 

寿命(耐用性) 在NAND闪存中每个块的最大擦写次数是一百万次，而NOR的擦写次数是十万次。NAND存储器除了具有10比1的块擦除周期优势，典型的NAND块尺寸要比NOR器件小8倍，每个NAND存储器块在给定的时间内的删除次数要少一些。 

位交换 所有flash器件都受位交换现象的困扰。在某些情况下(很少见，NAND发生的次数要比NOR多)，一个比特位会发生反转或被报告反转了。 一位的变化可能不很明显，但是如果发生在一个关键文件上，这个小小的故障可能导致系统停机。如果只是报告有问题，多读几次就可能解决了。 当然，如果这个位真的改变了，就必须采用错误探测/错误更正(EDC/ECC)算法。位反转的问题更多见于NAND闪存，NAND的供应商建议使用NAND闪存的时候，同时使用EDC/ECC算法。 这个问题对于用NAND存储多媒体信息时倒不是致命的。当然，如果用本地存储设备来存储操作系统、配置文件或其他敏感信息时，必须使用EDC/ECC系统以确保可用性。 
坏块处理  NAND器件中的坏块是随机分布的。以前也曾有过消除坏块的努力，但发现成品率太低，代价太高，根本不划算。 NAND器件需要对介质进行初始化扫描以发现坏块，并将坏块标记为不可用。在已制成的器件中，如果通过可用的方法不能进行这项处理，将导致高故障率。 

##### 软件支持 

可以非常直接地使用基于NOR的闪存，可以像其他存储器那样连接，并可以在上面直接运行代码。 在NAND器件上进行同样操作时，通常需要驱动程序，也就是内存技术驱动程序(MTD)，NAND和NOR器件在进行写入和擦除操作时都需要MTD。 使用NOR器件时所需要的MTD要相对少一些，许多厂商都提供用于NOR器件的更高级软件。 驱动还用于对DiskOnChip产品进行仿真和NAND闪存的管理，包括纠错、坏块处理和损耗平衡。 

#### ARM处理器与NOR Flash的接口

Nor Flash 带有SRAM接口,有足够的地址引脚，可以很容易的对存储器内部的存储单元进行直接寻址。在实际的系统中，可以根据需要选择ARM处理器与Nor Flash的连接方式。下图给出了嵌入式最小系统在包含两块Nor Flash的情况下，ARM处理器与Nor Flash两种不同的连接方式。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093909826.png)

####  Nor Flash 接口方式 

##### （1）双Flash独立片选 

该方式是把两个Nor Flash芯片各自作为一个独立的单元进行处理。根据不同的应用需要，可以在一块Flash中存放启动代码，而在另一块Flash中建立文件系统，存放应用代码。该方式操作方便，易于管理。 

##### （2）双Flash统一片选 

该方式是把两个Nor Flash芯片合为一个单元进行处理，ARM处理器将它们作为一个并行的处理单元来访问，本例是将两个8bit的Nor Flash芯片SST39VF1601用作一个16bit单元来进行处理。对于N（N>2）块Flash的连接方式可以此作为参考。 

NOR FLASH 电路图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102093938867.png)

采用 AMD 公司的 nor flash，型号为 AM29LV160DB，容量 2Mbyte，兼容 Intel E28F128J3A/16Mbyte。

### 八、嵌入式系统的启动架构 

嵌入式系统在启动时，引导代码、操作系统的运行和应用程序的加载主要有两种架构，一种是直接从Nor Flash启动的架构，另一种是直接从Nand Flash启动的架构。 

#### （1）从Nor Fash启动 

 Nor Flash具有芯片内执行（XIP eXecute In Place ） 的特点，在嵌入式系统中常做为存放启动代码的首选。从Nor Flash启动的架构又可细分为只使用Nor Flash的启动架构和Nor Flash与Nand Flash配合使用的启动架构。下图 给出了这两种启动架构的原理框图。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094014541.png)

##### 启动架构 

##### 单独使用Nor Flash 

在该架构中，引导代码、操作系统和应用代码共存于同一块Nor Flash中。系统上电后，引导代码首先在Nor Flash中执行，然后把操作系统和应用代码加载到速度更高的SDRAM中运行。另一种可行的架构是，在Nor Flash中执行引导代码和操作系统，而只将应用代码加载到SDRAM中执行。 

该架构充分利用了Nor Flash芯片内执行的特点，可有效提升系统性能。不足在于随着操作系统和应用代码容量的增加，需要更大容量昂贵的Nor Flash来支撑。 

##### Nor Flash和Nand Flash配合使用 

Nor Flash的单独使用对于代码量较大的应用程序会增加产品的成本投入，一种的改进的方式是采用Nor Flash 和Nand Flash配合使用的架构。在该架构中附加了一块Nand Flash。Nor Flash（2M或4M）中存放启动代码和操作系统（操作系统可以根据代码量的大小选择存放于Nor Flash或者Nand Flash），而Nand Flash中存放应用代码，根据存放的应用代码量的大小可以对Nand Flash容量做出相应的改变。

系统上电后，引导代码直接在Nor Flash中执行，把Nand Flash中的操作系统和应用代码加载到速度更高的SDRAM中执行。也可以在Nor Flash中执行引导代码和操作系统，而只将Nand Flash中的应用代码加载到SDRAM中执行。该架构是当前嵌入式系统中运用最广泛的启动架构之一。

#### （2）从Nand Flash启动 

SamSung公司的ARM920T系列处理器S3C2410支持从Nand Flash启动的模式，它的工作原理是将NandFlash中存储的前4KB代码装入一个称为Steppingstone（BootSRAM）的地址中，然后开始执行该段引导代码，从而完成对操作系统和应用程序的加载。这个过程不需要程序干涉，而是由内部控制器来完成的。

需要注意的是：你需要编写一个长度小于4K的引导程序,作用是将启动代码剩余部分拷贝到SDRAM中运行(NF地址不是线性的,程序不能直接运行,必须拷贝到线性RAM中) ，同时完成完成S3C2410的核心配置。 

### 九、S3C2410 NAND Flash控制器 

相对于SDRAM 和 NAND flash，NOR flash价格越来越高，许多用户将启动代码放在NAND flash，而主程序代码放在SDRAM中。为了支持 NAND flash bootloader, S3C2410X 装配了NAND flash控制器以及4KB 的内部SRAM 缓冲区，这个缓冲区叫做 “Steppingstone”。当开始启动时， NAND flash 的前 4KB将被装入“Steppingstone” SDRAM ，同时利用硬件ECC 检查这些数据的有效性，装入完成之后，开始执行这些存放于SDRAM中的主程序。

#### 特性 

+ 支持读/擦除/编程NAND Flash存储器。
+ 自动启动模式：复位后，启动代码被传送到Stepping stone中。传送完毕后，启动代码在Stepping stone中执行。
+ NAND Flash启动以后，4KB的内部SRAM缓冲器Stepping stone可以作为其他用途使用。
+ 具备硬件ECC（校验码，Error Correction Code）生成模块（硬件生成校验码，通过软件校验）。
+ NAND Flash控制器不能通过DMA访问，可以使用LDM/STM指令来代替DMA操作。 

####  NAND Flash控制器的结构框图 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094140200.png)

#### PIN CONFIGURATION

+ I/O[7:0] : Data/Command/Address In/Out Port (shared with the data bus)
+ CLE : Command Latch Enable (Output)
+ ALE : Address Latch Enable (Output)
+ nCE : NAND Flash Chip Enable (Output)
+ nRE : NAND Flash Read Enable (Output)
+ nWE : NAND Flash Write Enable (Output)
+ R/nB:  NAND Flash Ready/nBusy (Input)

####  NAND Flash的工作方式  

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094202372.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094209090.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094214846.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094221830.png)

####   NAND Flash存储器的时序 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094233943.png)

#### NAND FLASH MEMORY MAPPING

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094246039.png)

#### SPECIAL  FUNCTION  REGISTERS

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094258469.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094304302.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094310715.png)

#### ARM处理器与Nand Flash接口技术 

Nand Flash接口信号比较少，地址，数据和命令总线复用。Nand Flash的接口本质上是一个I/O接口，系统对Nand Flash进行数据访问的时候，需要先向Nand Flash发出相关命令和参数，然后再进行相应的数据操作。ARM处理器与Nand Flash的连接主要有三种方式，如下图所示： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094324609.png)

Nand Flash 接口方式 

##### （1）运用GPIO方式 

运用GPIO管脚方式去控制Nand Flash的各个信号，在速度要求相对较低的时候，能够较充分的发挥NAND设备的性能。它在满足NAND设备时域需求方面将会有很大的便利，使得ARM处理器可以很容易的去控制NAND设备。该方式需要处理器提供充足的GPIO。 

##### （2）运用逻辑运算方式进行连接 

在该方式下，处理器的读和写使能信号通过与片选信号CS进行逻辑运算后去驱动NAND设备对应的读和写信号。图中b例为SamSung公司ARM7TDMI系列处理器S3C44B0与Nand Flash K9F2808U0C的连接方式。 

##### （3）直接芯片使能 

有些ARM处理器如S3C2410内部提供对NAND设备的相应控制寄存器，通过控制寄存器可以实现ARM处理器对NAND设备相应信号的驱动。该方式使得ARM处理器与NAND设备的连接变得简单规范，图中c例给出了ARM处理器S3C2410与Nand Flash  K9F2808U0C的连接方式。 

NAND FLASH 电路图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230102094401673.png)

16Mbyte NAND FLASH，型号为 K9F2808UOB



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)