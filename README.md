> The repository contains Microprocessor Principles , ARM , FPGA , DSP , MCU-C51 , assembly and other hardware tutorials.

本仓库包含微处理器、ARM、FPGA、DSP、MCU-C51、汇编等硬件入门教程以及一名硬件工程师所需的必备知识。

### ARM

从嵌入式的基础概述讲起，引入ARM微处理器概述与编程模型，再到具体深入讲解ARM寻址方式及指令系统。此外还有嵌入式程序设计基础实践，内部可编程模块，接口技术等应用。

| chapter                                       | content                                                      |
| --------------------------------------------- | ------------------------------------------------------------ |
| chapter1 - 嵌入式系统概述                     | 1.1 [嵌入式系统概述及特点](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A01%20-%20Embedded%20system%20overview%20and%20characteristics.md) |
|                                               | 1.2 [嵌入式系统的开发概述](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A02%20-%20Overview%20of%20Embedded%20System%20Development.md) |
|                                               | 1.3 [嵌入式系统硬件概述](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A03%20-%20Embedded%20Systems%20Hardware%20Overview.md) |
|                                               | 1.4 [嵌入式系统软件架构](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A04%20-%20Embedded%20System%20Software%20Architecture.md) |
|                                               | 1.5 [嵌入式系统的应用与发展](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A05%20-%20Application%20and%20Development%20of%20Embedded%20System.md) |
| &emsp;                                        | &emsp;                                                       |
| chapter2 - ARM处理器编程模型                  | 2.1 [计算机体系结构及指令集](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A06%20-%20Computer%20Architecture%20and%20Instruction%20Set.md) |
|                                               | 2.2 [ARM体系结构详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A07%20-%20Detailed%20explanation%20of%20ARM%20architecture.md) |
|                                               | 2.3 [ARM系列处理器详解与性能对比](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A08%20-%20Detailed%20explanation%20and%20performance%20comparison%20of%20ARM%20series%20processors.md) |
|                                               | 2.4 [ARM处理器的工作状态](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A09%20-%20Working%20status%20of%20ARM%20processor.md) |
|                                               | 2.5 [ARM的工作模式与寄存器组织](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A10%20-%20ARM%20working%20mode%20and%20register%20organization.md) |
|                                               | 2.6 [ARM的异常管理](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A11%20-%20Exception%20management%20for%20ARM.md) |
|                                               | 2.7 [ARM流水线技术](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A12%20-%20ARM%20pipeline%20technology.md) |
|                                               | 2.8 [ARM存储器组织、协处理器及片上总线](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A13%20-%20ARM%20memory%20organization%2C%20coprocessor%20and%20on-chip%20bus.md) |
|                                               | 2.9 [ARM的IO访问与芯片选择](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A14%20-%20ARM%20IO%20access%20and%20chip%20selection.md) |
| &emsp;                                        | &emsp;                                                       |
| chapter3 - ARM寻址方式及指令系统              | 3.1 [ARM指令集分类及编码](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A15%20-%20ARM%20instruction%20set%20classification%20and%20encoding.md) |
|                                               | 3.2 [ARM立即寻址与寄存器寻址](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A16%20-%20ARM%20immediate%20addressing%20and%20register%20addressing.md) |
|                                               | 3.3 [ARM间接寻址、变址寻址与多寄存器寻址](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A17%20-%20ARM%20indirect%20addressing%2C%20indexed%20addressing%20and%20multiple%20register%20addressing.md) |
|                                               | 3.4 [堆栈寻址、相对寻址与ARM指令总结](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A18%20-%20ARM%20stack%20addressing%2C%20relative%20addressing%20and%20ARM%20instructions.md) |
|                                               | 3.5 [数据处理指令详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A19%20-%20Detailed%20Data%20Processing%20Instructions.md) |
|                                               | 3.6 [Load/Store之单寄存器的存取指令](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A20%20-%20Load%20and%20Store%20single%20register%20access%20instruction.md) |
|                                               | 3.7 [ARM多寄存器存取指令详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A21%20-%20Detailed%20explanation%20of%20ARM%20multi-register%20access%20instructions.md) |
|                                               | 3.8 [交换指令之SWP,MRS,MSR](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A22%20-%20SWP%2C%20MRS%2C%20MSR%20of%20exchange%20instruction.md) |
|                                               | 3.9 [ARM转移指令（分支指令）](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A23%20-%20ARM%20transfer%20instruction%20(branch%20instruction).md) |
|                                               | 3.10 [ARM异常中断指令SWI、BKPT、CLZ详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A24%20-%20Detailed%20Explanation%20of%20ARM%20Abnormal%20Interrupt%20Instructions%20SWI%2C%20BKPT%2C%20CLZ.md) |
|                                               | 3.11 [ARM协处理器指令总结](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A25%20-%20Summary%20of%20ARM%20coprocessor%20instructions.md) |
| &emsp;                                        | &emsp;                                                       |
| chapter4 - 嵌入式系统程序设计                 | 4.1 [ARM嵌入式系统开发流程概述](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A26%20-%20Overview%20of%20ARM%20Embedded%20System%20Development%20Process.md) |
|                                               | 4.2 [ARM常用开发编译软件介绍](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A27%20-%20ARM%20common%20development%20and%20compilation%20software%20introduction.md) |
|                                               | 4.3 [ARM相关开发工具概述](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A28%20-%20Overview%20of%20ARM-related%20development%20tools.md) |
|                                               | 4.4 [ARM符号定义伪操作详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A29%20-%20Detailed%20explanation%20of%20ARM%20symbol%20definition%20pseudo-operation.md) |
|                                               | 4.5 [ARM数据定义伪操作全总结](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A30%20-%20ARM%20data%20definition%20pseudo-operation%20full%20summary.md) |
|                                               | 4.6 [ARM 汇编控制伪操作](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A31%20-%20ARM%20assembler%20control%20pseudo-ops.md) |
|                                               | 4.7 [杂项汇编器伪指令](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A32%20-%20Miscellaneous%20assembler%20directives.md) |
|                                               | 4.8 [ARM汇编语言程序设计基础教程](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A33%20-%20ARM%20assembly%20language%20programming%20basic%20course.md) |
|                                               | 4.9 [什么是ATPCS](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A34%20-%20What%20is%20ATPCS.md) |
|                                               | 4.10 [ARM内嵌汇编及C和ARM汇编相互调用](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A35%20-%20ARM%20embedded%20assembly%20and%20mutual%20call%20between%20C%20and%20ARM%20assembly.md) |
| &emsp;                                        | &emsp;                                                       |
| chapter5 - 嵌入式系统内部可编程模块及接口技术 | 5.1 [S3C2410与S3C2440的区别](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A36%20-%20The%20difference%20between%20S3C2410%20and%20S3C2440.md) |
|                                               | 5.2 [ARM最小系统设计详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A37%20-%20Detailed%20ARM%20minimum%20system%20design.md) |
|                                               | 5.3 [ARM中断系统设计全解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A38%20-%20ARM%20interrupt%20system%20design%20solution.md) |
|                                               | 5.4 [ARM的DMA设计](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A39%20-%20ARM%20DMA%20design.md) |
|                                               | 5.5 [I/O接口扩展](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A40%20-%20IO%20interface%20expansion.md) |
|                                               | 5.6 [AD接口设计](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A41%20-%20AD%20interface%20design.md) |
|                                               | 5.7 [ARM定时器](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A42%20-%20ARM%20timer.md) |
|                                               | 5.8 [人机交互接口设计详解](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A43%20-%20Detailed%20explanation%20of%20human-computer%20interaction%20interface%20design.md) |
|                                               | 5.9 [万字详解通信接口设计](https://github.com/timerring/hardware-tutorial/blob/main/ARM-tutorial/A44%20-%20Communication%20interface%20design.md) |

### FPGA-tutorial

从逻辑代数等基础知识讲起，结合Verilog HDL语言学习与仿真，主要对组合逻辑电路与时序逻辑电路进行分析与设计，对状态机FSM进行剖析与建模。

| chapter                          | content                                                      |
| -------------------------------- | ------------------------------------------------------------ |
| chapter1 - 数字逻辑设计基础      | 1.1 [数字电路简介](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F01%20-%20Introduction%20to%20Digital%20Circuits.md) |
|                                  | 1.2 [逻辑运算及逻辑门](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F02%20-%20Logic%20Operations%20and%20Logic%20Gates.md) |
|                                  | 1.3 [逻辑代数的基本公式和规则](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F03%20-%20Basic%20Formulas%20and%20Rules%20of%20Logical%20Algebra.md) |
|                                  | 1.4 [逻辑函数的代数法化简](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F04%20-%20Algebraic%20Simplification%20of%20Logical%20Functions.md) |
|                                  | 1.5 [逻辑函数的卡诺图化简法](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F05%20-%20Karnaugh%20Map%20Simplification%20Method%20of%20Logic%20Function.md) |
|                                  | 1.6 [组合逻辑电路的设计](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F06%20-%20Design%20of%20Combinational%20Logic%20Circuits.md) |
| &emsp;                           | &emsp;                                                       |
| chapter2 - Verilog HDL入门与基础 | 2.1 [硬件描述语言简介](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F07%20-%20Introduction%20to%20Hardware%20Description%20Languages.md) |
|                                  | 2.2 [Verilog HDL程序的基本结构](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F08%20-%20Basic%20Structure%20of%20Verilog%20HDL%20Program.md) |
|                                  | 2.3 [逻辑功能的仿真与验证](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F09%20-%20Simulation%20and%20Verification%20of%20Logic%20Functions.md) |
|                                  | 2.4 [Verilog HDL仿真常用命令](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F10%20-%20Common%20Commands%20for%20Verilog%20HDL%20Simulation.md) |
|                                  | 2.5 [Verilog HDL基本语法规则](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F11%20-%20Verilog%20HDL%20Basic%20Grammar%20Rules.md) |
| &emsp;                           | &emsp;                                                       |
| chapter3 - 组合电路建模          | 3.1 [Verilog HDL门级建模](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F12%20-%20Verilog%20HDL%20Gate-level%20Modeling.md) |
|                                  | 3.2 [Verilog HDL数据流建模与运算符](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F13%20-%20Verilog%20HDL%20Data%20Flow%20Modeling%20and%20Operators.md) |
|                                  | 3.3 [Verilog HDL行为级建模](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F14%20-%20Verilog%20HDL%20Behavior-level%20Modeling.md) |
|                                  | 3.4 [分层次的电路设计方法](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F15%20-%20Hierarchical%20Approach%20to%20Circuit%20Design.md) |
| &emsp;                           | &emsp;                                                       |
| chapter4 - 时序逻辑电路建模      | 4.1 [SR锁存器与D锁存器设计与建模](https://github.com/timerring/hardware-tutorial/blob/main/FPGA-tutorial/F16%20-%20SR%20Latch%20and%20D%20Latch%20Design%20and%20Modeling.md) |
|                                  | ...                                                          |
| chapter5 - FSM                   | COMING SOON...                                               |

### MCU-C51



### Microprocessor Principles



### DSP



### 参考书籍

+ [孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.](https://github.com/timerring/hardware-tutorial/blob/main/reference/Embedded%20System%20Principles%20and%20Application%20Tutorial.pdf)
+ [杨宗德．嵌入式ARM系统原理与实例开发 [M]．北京：北京大学出版社，2007.](https://github.com/timerring/hardware-tutorial/blob/main/reference/Embedded%20ARM%20System%20Principle%20and%20Example%20Development.pdf)
+ S3C2410 Datasheet
+ [Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月](https://github.com/timerring/hardware-tutorial/blob/main/reference/VERILOG%20HDL%20and%20FPGA%20Digital%20System%20Design.pdf)
+ [Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月](https://github.com/timerring/hardware-tutorial/blob/main/reference/Verilog%20HDL%20and%20CPLDFPGA%20Project%20Development%20Tutorial.pdf)
+ [Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月](https://github.com/timerring/hardware-tutorial/blob/main/reference/Verilog%20HDL%20Digital%20Design%20and%20Synthesis.pdf)
+ [Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月](https://github.com/timerring/hardware-tutorial/blob/main/reference/Getting%20Started%20with%20Verilog%20HDL.pdf)

### ChangeLog

- v1.2完成初版 coming soon
- v1.1完成ARM 230126
- v1.0基础结构 230124

## 项目目录

coming soon...

## 关注更多

<div align=center>
<p>扫描下方二维码关注公众号：AIShareLab</p>
<img src="resources/qrcode.jpg" width = "180" height = "180">
</div>

&emsp;&emsp;AIShareLab，一个关注CV、AI、区块链、Web开发、硬件开发、5G通信等领域的热“AI”分享的社群，微信搜索公众号AIShareLab 一起交流更多相关知识，前沿算法，Paper解读，项目源码，面经总结。﻿


## LICENSE
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="知识共享许可协议" style="border-width:0" src="https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议</a>进行许可。
