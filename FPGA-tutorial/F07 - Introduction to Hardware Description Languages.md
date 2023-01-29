- [硬件描述语言简介](#硬件描述语言简介)
  - [(1)  VHDL的起源与发展](#1--vhdl的起源与发展)
  - [(2)  Verilog HDL的起源与发展](#2--verilog-hdl的起源与发展)
  - [(3)  两种语言的比较](#3--两种语言的比较)
      - [能力（capability）](#能力capability)
      - [数据类型（data type）](#数据类型data-type)
      - [易学性（easiest to learn）](#易学性easiest-to-learn)
      - [效  率](#效--率)
  - [（4）VHDL语言的新进展](#4vhdl语言的新进展)
  - [（5）Verilog HDL语言的新进展](#5verilog-hdl语言的新进展)
  - [可编程逻辑器件及其发展趋势](#可编程逻辑器件及其发展趋势)
  - [PLD的集成度分类](#pld的集成度分类)
  - [四种SPLD器件的区别](#四种spld器件的区别)
  - [复杂PLD(CPLD与FPGA)](#复杂pldcpld与fpga)
  - [PLD的基本原理与结构](#pld的基本原理与结构)
  - [CPLD的原理与结构](#cpld的原理与结构)
  - [FPGA的原理与结构](#fpga的原理与结构)
  - [查找表原理](#查找表原理)
  - [FPGA器件的内部结构示意图](#fpga器件的内部结构示意图)
  - [典型FPGA的结构](#典型fpga的结构)
  - [Altera的Cyclone IV器件结构](#altera的cyclone-iv器件结构)
  - [按编程特点分类](#按编程特点分类)
  - [按编程元件和编程工艺分类](#按编程元件和编程工艺分类)


# 硬件描述语言简介

硬件描述语言HDL(Hardware Description Language )  类似于高级程序设计语言. 它是一种以文本形式来描述数字系统硬件的结构和行为的语言, 用它可以表示逻辑电路图、逻辑表达式，复杂数字逻辑系统的逻辑功能。用HDL编写设计说明文档易于存储和修改，并能被计算机识别和处理.

HDL是高层次自动化设计的起点和基础.目前， IEEE推出两种标准：VHDL和Verilog HDL

## (1)  VHDL的起源与发展

Very high speed integrated  Hardware Description Language (VHDL)它是70年代末和80年代初，起源于美国国防部提出的超高速集成电路VHSIC研究计划，目的是为了把电子电路的设计意义以文字或文件的方式保存下来，以便其他人能轻易地了解电路的设计意义 。 1981年6月成立了VHDL小组。

+ 1983年第三季度，由IBM公司、TI公司、Intermetric 公司成立开发小组。
+ 1986年3月，IEEE开始致力于VHDL的标准化工作，讨论VHDL语言标准。
+ IEEE于1987年12月公布了VHDL的标准版本（IEEE STD 1076/1987）；
+ 1993年VHDL修订，形成新的标准即IEEE STD 1076-1993)。

## (2)  Verilog HDL的起源与发展

+ 1981年Gateway Automation硬件描述语言公司成立；
+ 1983～84年间该公司发布“Verilog HDL”及其仿真器Verilog -XL ；
+ 1986年Phil Moorby提出快速门级仿真的XL算法并获得成功，Verilog语言迅速得到推广。 Verilog-XL较快，特别在门级，能处理万门以上的设计。
+ 1987年Synonsys公司开始使用Verilog行为语言作为它综合工具(DC – Design Compiler)的输入；
+ 1989年12月 Cadence公司并购了Gateway公司；
+ 1990年初Cadence公司把Verilog HDL和Verilog-XL分成单独产品，公开发布了Verilog HDL,与VHDL竞争。并成立Open Verilog International(OVI)组织，负责Verilog的发展和标准的制定。

+ 1993年 几乎所有ASIC厂商支持Verilog HDL,认为Verilog-XL是最好的仿真器。OVI推出2.0版本的Verilog HDL规范，IEEE接受了将OVI的Verilog2.0作为IEEE标准的提案。
+ 1995年12月，定出Verilog HDL的标准IEEE 1364。
+ 2001年3月IEEE正式批准了Verilog-2001标准（即IEEE 1364-2001）。
+ Verilog-2001标准在Verilog-1995的基础上有几个重要的改进。新标准有力地支持可配置的IP建模，大大提高了深亚微米（DSM）设计的精确性，并对设计管理作了重大改进。

## (3)  两种语言的比较

####   能力（capability）

VHDL

+ 结构建模
+ 抽象能力强
+ 系统级－算法级－RTL级－逻辑级－门级

Verilog

+ 结构建模
+ 具体物理建模能力强
+ 算法级－RTL级－逻辑级－门级－版图级

####  数据类型（data type）

VHDL是一种数据类型性极强的语言。支持用户定义的数据类型。当对象的数据类型不一样时必须用类型转换函数转换。可以使用抽象（比如枚举）类型为系统建模。能利用数据类型检查编程的错误。

Verilog 数据类型简单。只能由语言本身定义，不能由用户定义。适于硬件结构的建模，不适于抽象的硬件行为建模。

#### 易学性（easiest to learn）

VHDL是一种数据类型很强的语言，欠直观。加之同一种电路有多种建模方法，通常需要一定的时间和经验，才能高效的完成设计。

VHDL根植于ADA，有时简洁，有时冗繁，如行为描述简洁，结构描述冗繁。

Verilog：由于Verilog为直接仿真语言，数据类型较简单，语法很直观，故Verilog更易理解和好学。

Verilog更像C，约有50％的结构来自C，其余部分来自ADA。

####  效  率

VHDL：由于数据类型严格，模型必须精确定义和匹配数据类型，这造成了比同等的Verilog效率要低。

Verilog：不同位宽的信号可以彼此赋值，较小位数的信号可以从大位数信号中自动截取自己的位号。在综合过程中可以删掉不用的位，这些特点使之简洁，效率较高。

## （4）VHDL语言的新进展

   近年来，VHDL又有了一些新的发展。例如，为了大幅度提高EDA 工具的设计能力，出现了一系列对HDL语言的扩展。OO-VHDL(Object-Oriented VHDL，即面向对象的VHDL) 模型的代码比VHDL模型短30%～50%，缩短了开发时间，提高了设计效率。
   美国杜克大学扩展的DE-VHDL (Duke Extended VHDL)通过增加3条语句，使设计者可以在VHDL描述中调用不可综合的子系统（包括连接该子系统和激活相应功能）。杜克大学用DE-VHDL进行一些多芯片系统的设计，极大地提高了设计能力。

## （5）Verilog HDL语言的新进展

  OVI组织1999年公布了可用于模拟和混合信号系统设计的硬件描述语言Verilog-AMS语言参考手册的草案，Verilog-AMS语言是符合IEEE 1364标准的Verilog HDL子集。目前Verilog-AMS还在不断的发展和完善中。

结 论

HDL主要用于数字电路与系统的建模、仿真和自动化设计。目前有两种标准的硬件描述语言：Verilog和VHDL。由于Verilog简单易学，所以建议大家学习Verilog HDL语言。

我国国家技术监督局于1998年正式将《集成电路/硬件描述语言Verilog》列入国家标准，国家标准编号为GB/T18349-2001，从2001年10月1日起实施。相信该标准的制定对我国集成电路设计技术的发展有重要的推动作用。

## 可编程逻辑器件及其发展趋势

可编程逻辑器件简称PLD(Programable Logic Device)，它是EDA技术发展的一个重要支持点，也是实现电子系统非常重要的一种方法，PLD的发展推动了EDA工具的发展，也改变了电子系统的设计方法。

## PLD的集成度分类

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110032958.png)

## 四种SPLD器件的区别

| **器    件** | **与 阵 列** | **或 阵 列** | **输出电路** |
| ------------ | ------------ | ------------ | ------------ |
| **PROM**     | **固定**     | **可编程**   | **固定**     |
| **PLA**      | **可编程**   | **可编程**   | **固定**     |
| **PAL**      | **可编程**   | **固定**     | **固定**     |
| **GAL**      | **可编程**   | **固定**     | **可组态**   |

## 复杂PLD(CPLD与FPGA)

+ 1985年，美国Xilinx公司推出了现场可编程门阵列（FPGA，Field Programmable Gate Array）
+ CPLD（Complex Programmable Logic Device），即复杂可编程逻辑器件，是从Altera 的 EPLD 改进而来的。

## PLD的基本原理与结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110112800.png)

## CPLD的原理与结构

CPLD器件的结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110125303.png)

CPLD器件宏单元内部结构示意图 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110154714.png)

MAX 7000S器件的内部结构 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110205964.png)

 MAX 7000S器件的宏单元结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110216108.png)

## FPGA的原理与结构

 2输入或门真值表

| **A  B** | **F** |
| -------- | ----- |
| **0  0** | **0** |
| **0  1** | **1** |
| **1  0** | **1** |
| **1  1** | **1** |

用2输入查找表实现或门功能

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110242726.png)

3人表决电路的真值表

| **A  B   C** | **F** |
| ------------ | ----- |
| **0  0   0** | **0** |
| **0  0   1** | **0** |
| **0  1   0** | **0** |
| **0  1   1** | **1** |
| **1  0   0** | **0** |
| **1  0   1** | **1** |
| **1  1   0** | **1** |
| **1  1   1** | **1** |

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110258587.png)

用3输入的查找表实现3人表决电路 

## 查找表原理

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110321198.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110323623.png)

4输入LUT及结构 

## FPGA器件的内部结构示意图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110345203.png)

## 典型FPGA的结构

XC4000器件的CLB结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110359408.png)

## Altera的Cyclone IV器件结构

Cyclone IV器件的LE结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230124110410857.png)

## 按编程特点分类

PLD器件按照可以编程的次数可以分为两类：

+ 一次性编程器件(OTP，One Time Programmable )

  OTP类器件的特点是：只允许对器件编程一次，不能修改；

+ 可多次编程器件

  可多次编程器件允许对器件多次编程，适合于科研开发中使用。

## 按编程元件和编程工艺分类

**非易失性器件**

+ 熔丝（Fuse）
+ 反熔丝（Antifuse）编程元件
+ 紫外线擦除、电可编程，如EPROM。
+ 电擦除、电可编程方式，(EEPROM、快闪存储器(Flash Memory ) ) ，如多数CPLD。

**易失性器件**

+ 静态存储器（SRAM）结构，如多数FPGA。 



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)