# 逻辑函数的卡诺图化简法

## 最小项与最小项表达式

### 最小项的定义

 n  个变量  $X_{1} X_{2} \ldots X_{n}$  的最小项是  n  个因子的乘积，每个变量 都以它的原变量或非变量的形式在乘积项中出现，且仅出 现一次。一般  n  个变量的最小项应有  $2^{n}$  个。

例如，  A ， B 、 C  三个逻辑变量的最小项有  $\left(2^{3}=\right) 8$  个， 即  $\bar{A} \bar{B} \bar{C}, \bar{A} \bar{B} C, \bar{A} B \bar{C}, \bar{A} B C, A \bar{B} \bar{C}, A \bar{B} C 、 A B \bar{C} 、 A B C$。 $\bar{A} B 、 A \bar{B} C \bar{A} 、 A(B+C)$  等则不是最小项。

### 最小项的性质 

三个变量的所有最小项的真值表 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113104512168.png)

对于任意一个最小项，只有一组变量取值使得它的值为1；

对于变量的任一组取值，任意两个最小项的乘积为0；

对于变量的任一组取值，全体最小项之和为1。

### 逻辑函数的最小项表达式 

逻辑函数的最小项表达式：

$L(A B C)=A B C+A B \bar{C}+\bar{A} B C+A \bar{B} C$

为“与-或”逻辑表达式； 

在“与-或”式中的每个乘积项都是最小项。

示例：

将  $L(A, B, C)=A B+\bar{A} C$  化成最小项表达式。

$\begin{aligned}
L(A, B, C) & =A B(C+\bar{C})+\bar{A}(B+\bar{B}) C \\
& =A B C+A B \bar{C}+\bar{A} B C+\bar{A} \bar{B} C \\
& =\boldsymbol{m}_{7}+\boldsymbol{m}_{6}+\boldsymbol{m}_{\mathbf{3}}+\boldsymbol{m}_{\mathbf{1}} \\
& =\sum m(7,6,3,1)
\end{aligned}$

示例：

将  $L(A, B, C)=\overline{(A B+\bar{A} \bar{B}+\bar{C}) \overline{A B}}$  化成最小项表达式。
a.去掉非号 b.去括号 

$\begin{array}{l}
L(A, B, C)=\overline{(A B+\bar{A} \bar{B}+\bar{C})}+A B \\
=(\overline{A B} \cdot \overline{\bar{A} \bar{B}} \cdot C)+A B \\
=(\bar{A}+\bar{B})(A+B) C+A B \\
=\bar{A} B C+A \bar{B} C+A B \\
=\bar{A} B C+A \bar{B} C+A B(C+\bar{C}) \\
=\bar{A} B C+A \bar{B} C+A B C+A B \bar{C} \\
=m_{3}+m_{5}+m_{7}+m_{6}=\sum m(3,5,6,7) \\
\end{array}$

代数法化简在使用中遇到的困难：

1.逻辑代数与普通代数的公式易混淆，化简过程要求对所	有公式熟练掌握；

2.代数法化简无一套完善的方法可循，它依赖于人的经验	和灵活性；

3.用这种化简方法技巧强，较难掌握。特别是对代数化简	后得到的逻辑表达式是否是最简式判断有一定困难。

### 卡诺图化简法

卡诺图法可以比较简便地得到最简的逻辑表达式，但是其逻辑变量的个数受限。

## 用卡诺图表示逻辑函数

### 卡诺图的引出

卡诺图：将n变量的全部最小项都用小方块表示，并使具有逻辑相邻的最小项在几何位置上也相邻地排列起来，这样,所得到的图形叫n变量的卡诺图。

逻辑相邻的最小项：如果两个最小项只有一个变量互为反变量，那么，就称这两个最小项在逻辑上相邻。

如最小项  $m_{6}=A B \bar{C}$ 与  $m_{7}=A B C$ 在逻辑上相邻。 

### 两变量卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105101824.png)

### 三变量卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105123556.png)

### 四变量卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105137739.png)

卡诺图的特点:各小方格对应于各变量不同的组合，而且上下左右在几何上相邻的方格内只有一个因子有差别，这个重要特点成为卡诺图化简逻辑函数的主要依据。 

### 已知逻辑函数真值表，画卡诺图

逻辑函数真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105322532.png)

$\begin{array}{l}
L=\bar{A} \bar{B} C+\bar{A} B C+A \bar{B} \bar{C}+A \bar{B} C+A B C \\
=m_{1}+m_{3}+m_{4}+m_{5}+m_{7}
\end{array}$

逻辑函数的卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105354725.png)

### 已知逻辑函数画卡诺图

当逻辑函数为最小项表达式时，在卡诺图中找出和表达式中最小项对应的小方格填上1，其余的小方格填上0（有时也可用空格表示），就可以得到相应的卡诺图。任何逻辑函数都等于其卡诺图中为1的方格所对应的最小项之和。

示例：

画出下列逻辑函数的卡诺图。

$L(A, B, C, D)=\sum m(\mathbf{0}, \mathbf{1}, \mathbf{2}, \mathbf{3}, \mathbf{4}, \mathbf{8}, \mathbf{1 0}, \mathbf{1 1}, \mathbf{1 4}, \mathbf{1 5})$

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105529905.png)

示例：

画出下式的卡诺图

$\begin{aligned}
L(A, B, C, D)= & (\bar{A}+\bar{B}+\bar{C}+\bar{D})(\bar{A}+\bar{B}+C+\bar{D})(\bar{A}+B+\bar{C}+D) \\
& (A+\bar{B}+\bar{C}+D)(A+B+C+D)
\end{aligned}$

解：

1.将逻辑函数化为最小项表达式

$\begin{aligned}
\bar{L} & =A B C D+A B \bar{C} D+A \bar{B} C \bar{D}+\bar{A} B C \bar{D}+\bar{A} \bar{B} \bar{C} \bar{D} \\
& =\sum m(\mathbf{0 , 6 , 1 0 , 1 3 , 1 5})
\end{aligned}$

2.填写卡诺图

相应的小方格内填写0（反逻辑），其余填写1.

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105647058.png)

示例：

已知 L = ABCD + B，画出卡诺图。

解：

容易发现利用吸收律 L = B , 即B 等于1的方格填1，其他方格填0。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105806072.png)

## 用卡诺图化简逻辑函数 

### 化简的依据

+ $ \bar{A} \bar{B} \bar{C} D+\bar{A} \bar{B} C D=\bar{A} \bar{B} D $
+ $ \bar{A} B \bar{C} D+\bar{A} B C D=\bar{A} B D $
+ $ \bar{A} \bar{B} D+\bar{A} B D=\bar{A} D $
+ $ A \bar{B} D+A B D=A D $
+ $ \bar{A} D+A D=D $

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113105905904.png)

### 化简的步骤

用卡诺图化简逻辑函数的步骤如下：

(1)将逻辑函数写成最小项表达式;

(2)按最小项表达式填卡诺图，凡式中包含了的最小项，其对应方格填1，其余方格填0;

(3)合并最小项，即将相邻的1方格圈成一组(包围圈)，每一组含$2^n$个方格，对应每个包围圈写成一个新的乘积项;

(4)将所有包围圈对应的乘积项相加。

画包围圈时应遵循的原则： 

(1)包围圈内的方格数一定是$2^n$个，且包围圈必须呈矩形;

(2)循环相邻特性包括上下底相邻，左右边相邻和四角相邻;

(3)同一方格可以被不同的包围圈重复包围多次，但新增的包围圈中一定要有原有包围圈未曾包围的方格;

(4)一个包围圈的方格数要尽可能多,包围圈的数目要可能少。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110057209.png)

示例：

用卡诺图法化简下列逻辑函数

$L(A, B, C, D)=\sum m(0,2,5,7,8,10,13,15)$

解：

(1) 由L 画出卡诺图。

(2) 画包围圈合并最小项，得最简与-或表达式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110155105.png)

$L(A, B, C, D)=\sum m(0 \sim 3,5 \sim 7,8 \sim 11,13 \sim 15)$

$L=D+C+\bar{B} \\$

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110247520.png)

$\bar{L}=B \bar{C} \bar{D} \\$

$L=D+C+\bar{B}$

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110342446.png)

## 用卡诺图化简含无关项的逻辑函数

### 什么叫无关项

在真值表内对应于变量的某些取值下，函数的值可以是任意的，或者这些变量的取值根本不会出现，这些变量取值所对应的最小项称为无关项或任意项。

在含有无关项逻辑函数的卡诺图化简中，它的值可以取0或取1，具体取什么值，可以根据使函数尽量得到简化而定。

示例：

要求设计一个逻辑电路，能够判断1位十进制数是奇数还是偶数，当十进制数为奇数时，电路输出为1，当十进制数为偶数时，电路输出为0。

解:

(1)列出真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110440232.png)

(2)画出卡诺图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230113110452275.png)

(3) 卡诺图化简 L = D

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月