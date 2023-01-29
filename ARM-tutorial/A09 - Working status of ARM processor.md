- [ARM处理器的工作状态](#arm处理器的工作状态)
  - [Thumb技术介绍](#thumb技术介绍)
    - [Thumb的技术概述](#thumb的技术概述)
    - [Thumb的技术实现](#thumb的技术实现)
    - [Thumb技术的特点](#thumb技术的特点)
  - [ARM处理器工作状态](#arm处理器工作状态)
    - [Thumb2技术介绍](#thumb2技术介绍)
      - [评价](#评价)


# ARM处理器的工作状态

## Thumb技术介绍 

ARM的RISC体系结构的发展中已经提供了低功耗、小体积、高性能的方案。而为了解决代码长度的问题，ARM体系结构又增加了Ｔ变种，开发了一种新的指令体系，这就是Thumb指令集，它是ARM技术的一大特色。

### Thumb的技术概述

Thumb是ARM体系结构的扩展。它从标准32位ARM指令集抽出来的36条指令格式，重新编成16位的操作码。这能带来很高的代码密度 
ARM7TDMI是第一个支持Thumb的核，支持Thumb的核仅仅是ARM体系结构的一种发展的扩展，所以编译器既可以编译Thumb代码，又可以编译ARM代码，支持Thumb的ARM体系结构的处理器状态可以方便的切换、运行到Thumb状态，在该状态下指令集是16位Thumb指令集 

### Thumb的技术实现	

在性能和代码大小之间取得平衡，在需要较低的存储代码时采用Thumb指令系统，但又比纯粹的16位系统有较高的实现性能，因为实际执行的是32位指令，用Thumb指令编写最小代码量的程序，却取得以ARM代码执行的最好性能

### Thumb技术的特点 

与ARM指令集相比．Thumb指令集具有以下局限 
完成相同的操作，Thumb指令通常需要更多的指令，因此在对系统运行时间要求苛刻的应用场合ARM指令集更为适合；Thumb指令集没有包含进行异常处理时需要的一些指令，因此在异常中断时，还是需要使用ARM指令，这种限制决定了Thumb指令需要和ARM指令配合使用。 

## ARM处理器工作状态

ARM处理器核可以工作在以下2种状态

+ ARM状态
  32位，ARM状态下执行字对准的32位ARM指令；
+ Thumb状态
  16位，Thumb状态下执行半字对准的16位Thumb指令。在Thumb状态下，程序计数器PC使用位1选择另一个半字。 

在程序执行的过程中，处理器可以在两种状态下切换 ARM处理器在开始执行代码时，只能处于ARM状态。ARM指令集和Thumb指令集都有相应的状态切换命令。 

ARM处理器在两种工作状态之间切换方法

+ 进入Thumb状态

  当操作数寄存器Rm的状态位bit［0］为1时，执行BX Rm指令进入Thumb状态（指令详细介绍见第三章）。如果处理器在Thumb状态进入异常，则当异常处理（IRQ，FIQ，Undef，Abort和SWI）返回时，自动切换到Thumb状态。

+ 进入ARM状态

  当操作数寄存器Rm的状态位bit［0］为0时，执行BX Rm指令进入ARM状态。如果处理器进行异常处理（IRQ，FIQ，Undef，Abort和SWI），在此情况下，把PC放入异常模式链接寄存器LR中，从异常向量地址开始执行也可以进入ARM状态。ARM和Thumb之间状态的切换不影响处理器的模式或寄存器的内容。

### Thumb2技术介绍

Thumb-2内核技术是ARM体系结构的新指令集，将为多种嵌入式应用产品提供更高的性能、更有效的功耗和更简短的代码长度，从而为其合作伙伴们在注重成本的嵌入式应用系统开发中提供了强大的发展潜能。

Thumb-2内核技术以Thumb技术为基础，延续了超高的代码压缩性能并可与现有的ARM技术方案完全兼容，同时提高了压缩代码的性能和功耗利用率。它是一种新的混合型指令集，兼有16位及32位指令，能更好地平衡代码密度和性能。

Thumb-2指令集在现有的Thumb指令的基础上做了扩充。

![image-20221209110030566](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221209110030566.png)

#### 评价

Thumb-2指令集增加32位指令就解决了之前Thumb指令集不能访问协处理器、特权指令和特殊功能指令（例如SIMD）的局限。Thumb-2指令集现在可以实现所有的功能，就不需要在ARM/Thumb状态之间反复切换了，代码密度和性能得到的显著的提高。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221209110056975.png)



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)