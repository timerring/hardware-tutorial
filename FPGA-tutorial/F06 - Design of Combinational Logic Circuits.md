- [组合逻辑电路的设计](#组合逻辑电路的设计)
  - [组合逻辑电路的设计步骤](#组合逻辑电路的设计步骤)
  - [组合逻辑电路的设计举例](#组合逻辑电路的设计举例)
    - [例1](#例1)
    - [例2](#例2)


# 组合逻辑电路的设计

根据实际逻辑问题，求出所要求逻辑功能的最简单逻辑电路。

## 组合逻辑电路的设计步骤 

1.逻辑抽象：根据实际逻辑问题的因果关系确定输入、输出变量，并定义逻辑状态的含义；

2.根据逻辑描述列出真值表；

3.由真值表写出逻辑表达式。根据所用器件，简化和变换逻辑表达式。

4.根据逻辑表达式画出逻辑图。

## 组合逻辑电路的设计举例 

### 例1

某雷达站有A、B、C三部雷达，其中A和B消耗功率相等，C的消耗功率是A的两倍。这些雷达由两台发电机X和Y供电，发电机X的最大输出功率等于雷达A的功率消耗，发电机Y的最大输出功率是X的3倍。要求用与、或、非门设计一个逻辑电路，利用各雷达的起动和关闭信号，以最节约电能的方式起、停发电机。

解：（1） 逻辑抽象。

A、B、C是事件产生的原因，应定为输入变量；两台发电机 X 和 Y 是事件产生的结果，定为输出变量。

设输入变量A、B、C为1表示雷达起动，为0雷达关闭。输出变量X、Y为1，表示发电机起动；为0，表示发电机停止。

 (2) 根据题意列出真值表

| **输 入** | **输 入** | **输 入** | **输 出**  |
| --------- | --------- | --------- | ---------- |
| **A**     | **B**     | **C**     | **X    Y** |
| **0**     | **0**     | **0**     | **0  0**   |
| **0**     | **0**     | **1**     | **0  1**   |
| **0**     | **1**     | **0**     | **1  0**   |
| **0**     | **1**     | **1**     | **0  1**   |
| **1**     | **0**     | **0**     | **1  0**   |
| **1**     | **0**     | **1**     | **0  1**   |
| **1**     | **1**     | **0**     | **0  1**   |
| **1**     | **1**     | **1**     | **1  1**   |

(3) 由真值表可画出卡诺图,用卡诺图简化得简化后的逻辑表达式。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113112119352.png)

$X=\bar{A} B \bar{C}+A \bar{B} \bar{C}+A B C$

$Y=A B+C$

(4) 根据简化后的逻辑表达式画出逻辑图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113112209383.png)

### 例2

电热水器内部容器示意图中，A、B、C为三个水位检测元件。当水面低于检测元件时，检测元件输出高电平；水面高于检测元件时，检测元件输出低电平。试用与非门设计一个热水器水位状态显示电路，要求当水面在A、B之间的正常状态时，绿灯G亮；水面在B、C间或A以上的异常状态时，黄灯Y亮；水面在C以下的危险状态时，红灯R亮。

1.当水面在A、B之间的正常状态时，绿灯G亮；

2.水面在B、C间或A以上的异常状态时，黄灯Y亮；

3.水面在C以下的危险状态时，红灯R亮。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113112239815.png)

(1) 逻辑抽象

输入变量（A、B、C ）：为三个检测仪的输出。
逻辑1：水位低于水位检测仪；
逻辑0：水位高于水位检测仪。

输出变量为绿灯G、黄灯Y、红灯R。
逻辑1：灯亮；
逻辑0：灯灭。

(2) 根据逻辑功能的要求，列出真值表。

1.当水面在A、B之间的正常状态时，绿灯G亮；
2.水面在B、C间或A以上的异常状态时，黄灯Y亮；
3.水面在C以下的危险状态时，红灯R亮。

在具体分析时，发现当逻辑变量被赋予特定含义后，有一些变量的取值组合根本就不会出现，这些最小项应被确定为无关项。  

| **A** | **B** | **C** | **G** | **Y** | **R** |
| ----- | ----- | ----- | ----- | ----- | ----- |
| **0** | **0** | **0** | **0** | **1** | **0** |
| **0** | **0** | **1** | **×** | **×** | **×** |
| **0** | **1** | **0** | **×** | **×** | **×** |
| **0** | **1** | **1** | **×** | **×** | **×** |
| **1** | **0** | **0** | **1** | **0** | **0** |
| **1** | **0** | **1** | **×** | **×** | **×** |
| **1** | **1** | **0** | **0** | **1** | **0** |
| **1** | **1** | **1** | **0** | **0** | **1** |

（3）由真值表可画出卡诺图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113112342570.png)

根据器件要求(与非门)，需将逻辑表达式两次求反，变换为与非-与非式

$\begin{array}{l}
G=A \bar{B}=\overline{\overline{A \bar{B}}} \\
Y=\bar{A} \bar{B}+B \bar{C}=\overline{\overline{\bar{A} \bar{B}+B \bar{C}}}=\overline{\overline{\bar{A} \bar{B}} \cdot \overline{B \bar{C}}} \\
R=C
\end{array}$

（4）依据逻辑函数式，可画出由与非门构成的逻辑图。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113112427909.png)



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)