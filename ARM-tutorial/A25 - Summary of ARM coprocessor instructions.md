- [ARM协处理器指令总结](#arm协处理器指令总结)
  - [（一）协处理器的数据操作](#一协处理器的数据操作)
    - [二进制编码](#二进制编码)
    - [汇编格式](#汇编格式)
  - [（二）协处理器的数据存取](#二协处理器的数据存取)
    - [二进制编码](#二进制编码-1)
    - [汇编格式](#汇编格式-1)
  - [（三）协处理器的寄存器传送](#三协处理器的寄存器传送)
    - [二进制编码](#二进制编码-2)
    - [汇编格式](#汇编格式-2)
  - [未使用的指令空间](#未使用的指令空间)


# ARM协处理器指令总结

ARM支持16个协处理器，用于各种协处理器操作，最常使用的协处理器是用于控制片上功能的系统协处理器，例如控制ARM720上的高速缓存和存储器管理单元等，也开发了浮点ARM协处理器，还可以开发专用的协处理器。

当一个协处理器硬件不能执行属于它的协处理器指令时，将产生未定义指令异常中断。利用该异常中断处理程序可以软件模拟该硬件操作。

ARM协处理器指令根据其用途主要分为以下三类：

+ 用于ARM处理器初始化协处理器数据操作指令；
+ 用于ARM寄存器与协处理器间的数据传送指令；
+ 用于协处理器寄存器和内存单元间的数据传送指令。 

## （一）协处理器的数据操作 

协处理器数据操作完全是协处理器内部的操作，它完成协处理器寄存器的状态改变。如：在符点协处理器中2个寄存器相加，结果放在第3个寄存器。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221226095222876.png)

ARM对可能存在的任何协处理器提供这条指令。如果它被一个协处理器接受，则ARM继续执行下一条指令，如果它没有被接受，则将产生一个未定义中止异常中断。通常与协处理器号CP#一致的协处理器将接受指令。

协处理器执行由Cop1和Cop2域定义的操作，使用CRn和CRm作为源操作数，并将结果放到CRd。其中，Cop1和Cop2为协处理器操作码，CRn、CRm和CRd均为协处理器的寄存器。指令中不涉及ARM处理器的寄存器和存储器。

### 汇编格式

```assembly
CDP{<cond>} <CP#>, <Cop1>, CRd, CRn, CRm{，<Cop2>} 
```

举例：

```assembly
CDP  p5,2,C12,C10,C3,4    ;协处理器p5的操作初始化，
                          ; 其中操作码1为2，操作码2
                          ; 为4，目标寄存器为C12，源
                          ; 操作寄存器为C10和C3
```

注：这里Cop1、CRn、CRd、Cop2和CRm域的解释与协处理器有关。

## （二）协处理器的数据存取 

协处理器数据传送指令从存储器读取数据装入协处理器寄存器，或将协处理器寄存器的数据存入存储器。因为协处理器可以支持它自己的数据类型，因此，每个寄存器传送的字数与协处理器有关。ARM产生存储器地址，但协处理器控制传送字数。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221226095301821.png)

存储器地址计算在ARM内进行，使用ARM基址和8位立即数偏移量进行计算，8位立即数左移2位产生字偏移。

数据由CRd提供或者接受，由协处理器来控制存取字数，N位控制从2种可能长度中选择一种。

### 汇编格式

  前变址格式：

```assembly
LDC|STC{<cond>}{L} <CP#>，CRd，[Rn <offset>]{!}
```

  后变址格式：

```assembly
LDC|STC{<cond>}{L} <CP#>，CRd，[Rn]，<offset> 
```

> 注： 
>       L标志表明选择长数据类型（N=1）。
>      <offset>是#±<8位立即数>

举例：

```assembly
       LDC  p6,C0,[R1]
       STCEQL  p5,C1,[R0],#4
```

注意事项：

+ N和CRd域的解释与协处理器有关。
+ 如果地址不是字对齐的，则最后2位将忽略，有些ARM系统有可能产生异常。
+ 存取字数由协处理器控制，ARM将连续产生后续地址，直到协处理器指示存取结束为止。在数据存取的过程中，ARM将不响应中断请求。因此，为了防止存取过长的数据影响系统的中断响应时间，将最大存取长度限制到16个字。

## （三）协处理器的寄存器传送 

在ARM和协处理器寄存器之间传送数据有时是有用的。这些协处理寄存器传送指令使得协处理器中产生的整数能直接传送到ARM寄存器或者影响ARM条件码标志位。典型用法是：

浮点FIX操作，它把整数返回到ARM的一个寄存器。 

浮点比较，把比较的结果返回到ARM条件码标志位

从ARM寄存器中取一个整数，并传送给协处理器，在那里转换成浮点表示，并装入协处理器寄存器进行处理。

在一些较复杂的ARM CPU中，常使用系统控制协处理器来控制Cache和MMU功能。这类协处理器一般使用这些指令来访问和修改片上的控制寄存器。

### 二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221226095403806.png)

协处理器执行由Cop1和Cop2域定义的操作，使用CRn和CRm作为源操作数，并将32位整数结果返回到ARM，ARM再把它放到Rd。其中，Cop1和Cop2为协处理器操作码，CRn、CRm为协处理器的寄存器。

如果在从协处理器读取数据的指令中将PC定义为目的寄存器Rd，则由协处理器产生32位整数的最高4位将被放在CPSR中的N、Z、C和V标志位。

### 汇编格式

  （1）从协处理器传送到ARM寄存器： 

```assembly
MRC{<cond>} <CP#>，<Cop1>，Rd，CRn，CRm{，<Cop2>} 
```

  （2）从ARM寄存器传送到协处理器：

```assembly
MCR{<cond>} <CP#>，<Cop1>，Rd，CRn，CRm{，<Cop2>}  
```

举例：

```assembly
       MCR  p14,3,R0,C1,C2
       MRCCS  p2,4,R3,C3,C4,6
```

## 未使用的指令空间

ARM 32位指令编码并没有全部都做了定义，还有一些未使用的编码可以用来将来扩展指令集。并且算术运算指令、控制指令，Load/Store指令、协处理器指令等都有预留空间。



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)