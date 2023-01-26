- [ARM存储器组织、协处理器及片上总线](#arm存储器组织协处理器及片上总线)
  - [ARM存储器组织](#arm存储器组织)
    - [ARM存储数据类型和存储格式](#arm存储数据类型和存储格式)
    - [ARM的存储器层次简介](#arm的存储器层次简介)
    - [存储器管理单元MMU](#存储器管理单元mmu)
  - [ARM协处理器](#arm协处理器)
  - [ARM片上总线AMBA](#arm片上总线amba)


# ARM存储器组织、协处理器及片上总线

## ARM存储器组织

### ARM存储数据类型和存储格式

ARM处理器支持以下6种数据类型 

+ 8位有符号和无符号字节。
+ 16位有符号和无符号半字，它们以两字节的边界定位。
+ 32位有符号和无符号字，它们以4字节的边界定位。 

存储器组织 

在以字节为单位寻址的存储器中有“小端”和“大端”两种方式存储字，这两种方式是根据最低有效字节与相邻较高有效字节相比是存放在较低的还是较高的地址来划分的，两种存储方式如图所示。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105428057.png)

### ARM的存储器层次简介

+ 寄存器组 : 存储器层次的顶层，典型为32个32位寄存器，访问时间为几个ns

+ 片上RAM ：和片上寄存器组具有同级的读写速度。成本较高。

+ 片上Cache ：容量为8~32KB，访问时间大概为10ns。

+ 主存储器 ：可能在几兆到1G的动态存储器。访问时间大约50ns。

+ 硬盘：后援存储器，容量从几百兆到几十GB，访问时间为几十ms。

  > 嵌入式系统通常没有硬盘，因此也不采用页方式，但是许多嵌入式系统采用cache，ARM CPU采用了多种Cache结构。

### 存储器管理单元MMU 

在复杂的嵌入式系统设计时，越来越多的会选用带有存储管理单元（MMU）的微处理器芯片。

MMU完成的主要功能有：

+ 将主存地址从虚拟存储空间映射到物理存储空间。
+ 存储器访问权限控制。
+ 设置虚拟存储空间的缓冲特性等。

虚拟地址存储系统示意图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105604420.png)

## ARM协处理器 

ARM通过增加硬件协处理器来支持对其指令集的通用扩展，通过未定义指令陷阱支持这些协处理器的软件仿真。简单的ARM核提供板级协处理器接口，因此协处理器可以作为一个独立的元件接入。

最常使用的协处理器是用于控制片上功能的系统协处理器，例如控制ARM720上的高速缓存Cache和存储器管理单元MMU等。ARM也开发了浮点协处理器，也可以支持其它的片上协处理器。ARM体系结构支持通过增加协处理器来扩展指令集的机制。 

## ARM片上总线AMBA 

IC设计方法从以功能设计为基础转变到了以功能整合为基础。

+ SoC设计以IP的设计复用和功能组装、整合来完成。SoC设计的重点是系统功能的分析与划分、软硬件的功能划分，IP的选择与使用，多层次验证环境和外界设计咨询服务等。
+ 片上总线OCB（On-Chip Bus）使得片上不同IP核的连接实现标准化。
+ 3种总线标准：IBM的CoreConnect、ARM的AMBA（Advanced Microcontroller Bus Architecture）和Silicore的Wishbone。 

**一个微处理器系统可能含有多条总线**

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105742102.png)

原因：

+ 数据宽度：高速总线通常提供较宽的数据连接。
+ 成本：高速总线通常采用更昂贵的电路和连接器。
+ 桥允许总线独立操作，这样在I/O操作中可提供某些并行性。

多总线系统

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105907415.png)



![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105827064.png)

嵌入式系统总线

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213105946527.png)

ARM片上总线AMBA 

+ AMBA是ARM公司公布的总线标准，AMBA定义了3种总线： 
+ ASB（Advanced System Bus）：是目前ARM常用的系统总线，用于连接高性能系统模块，它支持突发数据传输模式。
+ AHB（Advanced High-performance Bus）：用于连接高性能系统模块。它支持突发数据传输方式及单个数据传输方式，所有时序参考同一个时钟沿。在高性能ARM系统（如：ARM1020E）中，AHB有逐步取代ASB的趋势。
+ APB（Advance Peripheral Bus）：是一个简单接口支持低性能的外围接口。

通过AMBA组成的系统如下图所示： 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213110037954.png)

基于AMBA总线的典型系统

AMBA总线 － S3C44b0X

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221213110104645.png)



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)