- [SR锁存器与D锁存器设计与建模](#sr锁存器与d锁存器设计与建模)
	- [锁存器和触发器的基本特性](#锁存器和触发器的基本特性)
	- [锁存器(Latch)与触发器(Flip Flop)的区别](#锁存器latch与触发器flip-flop的区别)
	- [基本SR锁存器](#基本sr锁存器)
		- [用与非门构成的基本SR锁存器](#用与非门构成的基本sr锁存器)
	- [门控D锁存器](#门控d锁存器)
		- [门控D锁存器特性表和特性方程](#门控d锁存器特性表和特性方程)
			- [D锁存器的特性表](#d锁存器的特性表)
			- [卡诺图](#卡诺图)
		- [门控D锁存器波形图](#门控d锁存器波形图)
	- [门控D 锁存器的Verilog HDL建模](#门控d-锁存器的verilog-hdl建模)


# SR锁存器与D锁存器设计与建模

## 锁存器和触发器的基本特性

锁存器和触发器是构成时序逻辑电路的基本逻辑单元，它们具有存储数据的功能。
每个锁存器或触发器都能存储1位二值信息，所以又称为存储单元或记忆单元。
若输入信号不发生变化，锁存器和触发器必然处于其中一种状态，且一旦状态被确定，就能自行保持不变，即长期存储1位二进制数。
电路在输入信号的作用下，会从一种稳定状态转换成为另一种稳定状态。

## 锁存器(Latch)与触发器(Flip Flop)的区别

锁存器(Latch)—— 没有时钟输入端，对脉冲电平敏感的存储电路，在特定输入脉冲电平作用下改变状态。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202115115993.png)

触发器(Flip Flop)——每一个触发器有一个时钟输入端。对脉冲边沿敏感的存储电路，在时钟脉冲的上升沿或下降沿的变化瞬间改变状态。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202115145514.png)

## 基本SR锁存器

### 用与非门构成的基本SR锁存器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202115314242.png)

方框外侧输入端的小圆圈和信号名称上面的小横线均表示输入信号是低电平有效的，同时为了区别，这种锁存器有时也称为基本 SR 锁存器。

现态:  $\bar{R}$, $\bar{S}$  信号作用前Q端的状态， 现态用  $Q^{n}$  表示。

次态: $ \bar{R}$ 、 $\bar{S}$  信号作用后Q端的状态， 次态用  $Q^{n+1}$  表示。

a.电路图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121501593.png)

b.功能表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121523515.png)

约束条件:

$$
\bar{S}+\bar{R}=1
$$
例 当S、R的波形如下图虚线上边所示，试画出Q和 Q对应的波形（假设原始状态Q＝0 ）。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121611389.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121744022.png)

## 门控D锁存器

1.电路结构

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121852891.png)

国标逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202121920847.png)

当  $E=0$  时，  $\bar{S}=\bar{R}=1$  ，无论  D  取什么值，  Q  保持不变。
当  $E=\mathbf{1}$  时，使能信号有效

+ $D=\mathbf{1}$  时，  $\bar{S}=\mathbf{0}$ ， $\bar{R}=\mathbf{1}$ ， Q  被置 1 ；
+ $D=\mathbf{0}$  时，  $\bar{S}=1$， $\bar{R}=\mathbf{0}$ ， Q  被置 0 。

在  $E=\mathbf{1}$  期间，  D  值将被传输到输出端  Q  ，而当  E  由 1 跳变为 0 时，锁存器将保持跳变之前瞬间  D  的值。因此，  $\mathrm{D}$  锁存器常 被称为透明锁存器 (Transparent Latch)。

### 门控D锁存器特性表和特性方程 

#### D锁存器的特性表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122246198.png)

#### 卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122309875.png)
$$
Q^{n+1}=\bar{E} \cdot Q+E \cdot D
$$

### 门控D锁存器波形图

初始状态为Q =1 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122404725.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122417206.png)

## 门控D 锁存器的Verilog HDL建模

试对图所示的D锁存器进行建模。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122454323.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122507745.png)

```verilog
//版本1: Structural description of a D latch 
module Dlatch_Structural (E, D, Q, Q_);
    	input  E,  D ;
    	output Q,  Q_;
    	wire   R_, S_;
		nand N1(S_, D, E);
		nand N2(R_,~D, E);
		SRlatch_1 N3(S_, R_, Q, Q_);
endmodule
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202122555620.png)

```verilog
//Structural description of a SR-latch 
module SRlatch_1 (S_, R_, Q, Q_);
    	input  S_,R_;
    	output Q, Q_;
  	nand N1(Q, S_,Q_);
	nand N2(Q_,R_,Q );
endmodule
```

版本1的特点：

第一个版本根据图4.1.3使用基本的逻辑门元件，采用结构描述风格，编写了两个模块，这两个模块可以放在一个文件中，文件名为Dlatch_Structural.v。

在一个文件中可以写多个模块，其中有一个是主模块（或者称为顶层模块）。

文件名必须使用顶层模块名。本例中Dlatch_Structural是主模块，它调用SRlatch_1模块。

```verilog
//版本2: Behavioral description of a D latch 
module Dlatch_bh (E, D, Q, Q_);
    input  E, D;
    output Q, Q_;
    reg Q;
    assign Q_ = ~Q;
    always @(E or D)
	  if (E)  
		Q <= D; //当使能有效E=1时，输出跟随输入变化
	  else 
		Q <= Q; //当E=0时， Q保持不变
endmodule
```

版本2的特点：

第二个版本采用功能描述风格的代码，不涉及到实现电路的具体结构，靠“算法”实现电路操作。对于不太喜欢低层次硬件逻辑图的人来说，功能描述风格的Verilog HDL是一种最佳选择。其中“<=”为非阻塞赋值符，将在下一节介绍。 

注意：

+ always内部不能使用assign。
+ 在写可综合的代码时，**建议明确地定义if－else中所有可能的条件分支，否则，就会在电路的输出部分增加一个电平敏感型锁存器。** 



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)