- [逻辑函数的代数法化简](#逻辑函数的代数法化简)
  - [逻辑函数的最简形式](#逻辑函数的最简形式)
  - [逻辑函数的代数化简法](#逻辑函数的代数化简法)
      - [并项法](#并项法)
      - [吸收法](#吸收法)
      - [消去法](#消去法)
      - [配项法](#配项法)
      - [示例1](#示例1)
      - [示例2](#示例2)


# 逻辑函数的代数法化简

## 逻辑函数的最简形式

1．化简逻辑函数的意义

$\begin{aligned}
L & =A B+\bar{A} B+\bar{A} \bar{B} \\
& =(A+\bar{A}) B+\bar{A} \bar{B} \\
& =1 \cdot B+\bar{A} \bar{B} \\
& =B+\bar{A}
\end{aligned}$

![image-20230112105112065](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230112105112065.png)

两个电路的逻辑功能完全相同。但简化电路使用的逻辑门较少，体积小且成本低。

化简的意义：根据化简后的表达式构成的逻辑电路简单，可节省器件，降低成本，提高工作的可靠性。

2.逻辑函数的常见表达形式

$\begin{array}{rlrl}
L & =\frac{A C+\bar{C} D}{\overline{\overline{A C}} \cdot \overline{\bar{C}} D} & & \text { “与-或" 表达式 } \\
& & \text { “与非-与非" 表达式 } \\
& =(A+\bar{C})(C+D) & & \text { “或-与" 表达式 } \\
& =\overline{\overline{(A+\bar{C})}+\overline{(C+D)}} & & \text { “或非-或非" 表达式 } \\
& =\overline{\bar{A} C+\bar{C} \bar{D}} & & \text { “与-或-非" 表达式 }
\end{array}$

“与-或”表达式:也称为 “积之和 (Sum of Products，SOP)”表达式；

“或-与”表达式:也称为 “和之积(Products of Sum， POS)”表达式。

简化标准(最简的与-或表达式)

乘积项的个数最少(与门的个数少）;
每个乘积项中包含的变量数最少（与门的输入端个数少）。

化简的主要方法：

１．公式法（代数法）
        运用逻辑代数的基本定律和恒等式进行化简的方法。 
２．图解法（卡诺图法）
        逻辑变量的个数受限。

## 逻辑函数的代数化简法

方法：

#### 并项法

$A+\bar{A}=1$

+ $L=\bar{A} \bar{B} C+\bar{A} \bar{B} \bar{C}=\bar{A} \bar{B}(C+\bar{C})=\bar{A} \bar{B}$

#### 吸收法

$A+A B=A$

+ $L=\bar{A} B+\bar{A} B C D(E+F)=\bar{A} B$

#### 消去法

$A+\bar{A} B=A+B $

+ $\begin{aligned}
  L & =A B+\underline{\bar{A} C}+\underline{\bar{B} C}=A B+(\bar{A}+\bar{B}) C \\
  & =A B+\overline{A B C}=A B+C
  \end{aligned}$

#### 配项法

$A+\bar{A}=1$ 

+ $\begin{aligned}
  L & =A B+\bar{A} \bar{C}+\underline{B \bar{C}}=A B+\bar{A} \bar{C}+(A+\bar{A}) B \bar{C} \\
  & =\underline{A B}+\underline{\bar{A} \bar{C}}+\underline{A B \bar{C}}+\underline{\bar{A} B \bar{C}} \\
  & =(A B+A B \bar{C})+(\bar{A} \bar{C}+\bar{A} \bar{C} B) \\
  & =A B+\bar{A} \bar{C}
  \end{aligned}$

#### 示例1

已知逻辑函数表达式为$L=\bar{A} B \bar{D}+A \bar{B} \bar{D}+\bar{A} B D+A \bar{B} \bar{C} D+A \bar{B} C D$

要求：（1）最简的与-或逻辑函数表达式，并画出逻辑图；
            （2）仅用与非门画出最简表达式的逻辑图。

![image-20230112110057584](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230112110057584.png)

$\begin{aligned}
L & =\bar{A} B(\bar{D}+D)+A \bar{B} \bar{D}+A \bar{B}(\bar{C}+C) D \\
& =\bar{A} B+A \bar{B} \bar{D}+A \bar{B} D \\
& =\bar{A} B+A \bar{B}(D+\bar{D}) \\
& =\bar{A} B+A \bar{B} \text { (与-或表达式) } \\
& =\overline{\overline{\bar{A}} B+A \bar{B}} \\
& =\overline{\overline{\bar{A}} B \cdot \overline{A \bar{B}}} \text { (与非-与非表达式) }
\end{aligned}$

#### 示例2

试对逻辑函数表达式$L=\bar{A} \bar{B} C+A \bar{B} \bar{C}$ 进行变换，仅用或非门画出该表达式的逻辑图。

![image-20230112110249383](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230112110249383.png)

$\begin{aligned}
L & =\bar{A} \bar{B} C+A \bar{B} \bar{C}=\overline{\overline{\bar{A} \bar{B} C}}+\overline{\overline{A \bar{B} \bar{C}}} \\
& =\overline{A+B+\bar{C}+\overline{\bar{A}+B+C}} \\
& =\overline{\overline{\overline{A+B+\bar{C}}+\overline{\bar{A}+B+C}}}
\end{aligned}$

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)