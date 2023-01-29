- [逻辑运算及逻辑门](#逻辑运算及逻辑门)
  - [逻辑变量与逻辑函数](#逻辑变量与逻辑函数)
  - [逻辑运算](#逻辑运算)
    - [基本逻辑运算及对应的逻辑门](#基本逻辑运算及对应的逻辑门)
      - [１.与运算](#１与运算)
        - [与逻辑举例](#与逻辑举例)
        - [状态表与真值表](#状态表与真值表)
        - [与逻辑符号](#与逻辑符号)
        - [与逻辑表达式](#与逻辑表达式)
        - [与门电路](#与门电路)
      - [２. 或运算](#２-或运算)
        - [或逻辑举例](#或逻辑举例)
        - [电路状态表](#电路状态表)
        - [状态表与真值表](#状态表与真值表-1)
        - [或逻辑符号](#或逻辑符号)
        - [或逻辑表达式](#或逻辑表达式)
        - [或门电路](#或门电路)
      - [3.　非运算](#3非运算)
        - [非逻辑举例](#非逻辑举例)
        - [电路状态表](#电路状态表-1)
        - [状态表与真值表](#状态表与真值表-2)
        - [非逻辑符号](#非逻辑符号)
        - [非逻辑表达式](#非逻辑表达式)
        - [三极管实现的非门电路](#三极管实现的非门电路)
    - [常用复合逻辑运算及对应的逻辑门](#常用复合逻辑运算及对应的逻辑门)
      - [1. 与非运算](#1-与非运算)
        - [逻辑真值表](#逻辑真值表)
        - [与非逻辑符号](#与非逻辑符号)
        - [与非逻辑表达式](#与非逻辑表达式)
      - [2. 或非运算](#2-或非运算)
        - [逻辑真值表](#逻辑真值表-1)
        - [或非逻辑符号](#或非逻辑符号)
        - [或非逻辑表达式](#或非逻辑表达式)
      - [3. 异或逻辑](#3-异或逻辑)
        - [异或逻辑真值表](#异或逻辑真值表)
        - [异或逻辑符号](#异或逻辑符号)
        - [异或逻辑表达式](#异或逻辑表达式)
      - [4.同或运算](#4同或运算)
        - [同或逻辑真值表](#同或逻辑真值表)
        - [同或逻辑逻辑符号](#同或逻辑逻辑符号)
        - [同或逻辑表达式](#同或逻辑表达式)
    - [集成逻辑门电路简介](#集成逻辑门电路简介)
    - [三态门](#三态门)
      - [三态输出门电路逻辑符号](#三态输出门电路逻辑符号)
      - [三态输出门的真值表](#三态输出门的真值表)
      - [应用举例](#应用举例)
        - [(1) 构成总线传输结构](#1-构成总线传输结构)
        - [(2) 实现信号的双向传输](#2-实现信号的双向传输)


# 逻辑运算及逻辑门

## 逻辑变量与逻辑函数

逻辑是指事物因果之间所遵循的规律。为了避免用冗繁的文字来描述逻辑问题，逻辑代数采用逻辑变量和一套运算符组成逻辑函数表达式来描述事物的因果关系。

逻辑代数中的变量称为逻辑变量，一般用大写字母A、B、C…表示。逻辑变量的取值只有两种，即逻辑0和逻辑1。 0和1称为逻辑常量。这里0和1本身并没有数值意义，它仅仅是一种符号，代表事物矛盾双方的两种状态。
数字电路的输出与输入之间的关系是一种因果关系， 因此它可以用逻辑函数来描述，并称为逻辑电路。

对于任何一个电路，若输入逻辑变量A、 B、 C … 的取值确定后，其输出逻辑变量L的值也被唯一地确定了，则可以称L是A、 B、 C … 的逻辑函数， 并记为 
$$
\begin{array}{c}
L = f(A, B, C, \cdots)
\end{array}
$$

## 逻辑运算

当0和1表示逻辑状态时，两个二进制数码按照某种特定的因果关系进行的运算。

### 基本逻辑运算及对应的逻辑门

在逻辑代数中，有与、或、非三种基本的逻辑运算。还有 与非、或非、同或、异或等常用的复合逻辑运算。

逻辑运算的描述方式:逻辑代数表达式、真值表、逻辑图、卡诺图、波形图和硬件描述语言（HDL) 等。

#### １.与运算

(1)　与逻辑:只有当决定某一事件的条件全部具备时，这一事件才会发生。这种因果关系称为与逻辑关系。

##### 与逻辑举例

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162601848.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162620282.png)



##### 状态表与真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162742618.png)

##### 与逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162853544.png)

##### 与逻辑表达式

与逻辑：　
$$
L = A ·B= AB
$$

##### 与门电路 

实现与逻辑运算（即满足与逻辑真值表）的电子电路称为与门电路（简称与门） 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162946897.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109162955464.png)

#### ２. 或运算

只要在决定某一事件的各种条件中，有一个或几个条件具备时，这一事件就会发生。这种因果关系称为或逻辑关系。

##### 或逻辑举例

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163026076.png)

##### 电路状态表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163101973.png)

##### 状态表与真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163248973.png)

##### 或逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163307889.png)

##### 或逻辑表达式

或逻辑：　
$$
L = A +B
$$

##### 或门电路 

实现或逻辑运算（即满足或逻辑真值表）的电子电路称为或门电路（简称或门）。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163342591.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109163348277.png)

#### 3.　非运算

事件发生的条件具备时，事件不会发生；事件发生的条件不具备时，事件发生。这种因果关系称为非逻辑关系。

##### 非逻辑举例

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164133660.png)

##### 电路状态表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164216832.png)

##### 状态表与真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164245500.png)

##### 非逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164303195.png)

##### 非逻辑表达式

$$
L=\bar{A}
$$

##### 三极管实现的非门电路

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164530863.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164536318.png)

### 常用复合逻辑运算及对应的逻辑门

在逻辑代数中，有与、或、非三种基本的逻辑运算。还有 与非、或非、同或、异或等常用的复合逻辑运算。

逻辑运算的描述方式:逻辑代数表达式、真值表、逻辑图、卡诺图、波形图和硬件描述语言（HDL) 等。

#### 1. 与非运算

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164640042.png)

两输入变量与非

##### 逻辑真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164716704.png)

##### 与非逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164736790.png)

##### 与非逻辑表达式

$$
L=\overline{A \cdot B}
$$

#### 2. 或非运算

两输入变量或非

##### 逻辑真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164832316.png)

##### 或非逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109164846991.png)

##### 或非逻辑表达式

$$
L=\overline{A+B}
$$

#### 3. 异或逻辑

若两个输入变量的值相异，输出为1，否则为0。

##### 异或逻辑真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165118935.png)

##### 异或逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165035568.png)

##### 异或逻辑表达式

$$
L=\bar{A} B+A \bar{B}=A \oplus B
$$

#### 4.同或运算

若两个输入变量的值相同，输出为1，否则为0。

##### 同或逻辑真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165222222.png)

##### 同或逻辑逻辑符号

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165243410.png)

##### 同或逻辑表达式

$$
L=\bar{A} \bar{B}+A B=A \odot B
$$

### 集成逻辑门电路简介 

逻辑运算都可以用SSI集成电路实现 。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165343798.png)

### 三态门

#### 三态输出门电路逻辑符号

高电平有效的同相三态门

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165415152.png)

低电平使能的三态输出非门电路

![image-20230109165437827](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165437827.png)

#### 三态输出门的真值表

高电平使能的三态输出门的真值表

![image-20230109165620229](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165620229.png)

低电平使能的三态输出门的真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165632948.png)

#### 应用举例

##### (1) 构成总线传输结构

为了减少复杂的系统中各个单元电路之间的连线，数字系统中信号的传输常常采取一种称为“总线”（Bus）的结构形式，以达到在同一导线上分时传递若干路信号的目的。

工作时只要控制各个$EN_n$端的逻辑电平，保证在任何时刻仅有一个三态输出门电路被使能，就可以把各个输出信号按要求顺序送到总线上，而互不干扰。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165709173.png)

##### (2) 实现信号的双向传输

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230109165729777.png)

DIR (EN) 为传送控制信号。

当DIR=1时, G1工作，G2为高阻态，数据线DO/I上的数据经G1送到总线上;

当DIR=0时, G2工作, 而G1为高阻态，来自总线的数据经G2送到的DO/I线上。

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)