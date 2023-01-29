- [Verilog HDL门级建模](#verilog-hdl门级建模)
  - [基本概念](#基本概念)
    - [基本门级元件（Primitive : 原语）](#基本门级元件primitive--原语)
  - [多输入门](#多输入门)
    - [and、nand真值表](#andnand真值表)
  - [多输出门](#多输出门)
    - [buf真值表](#buf真值表)
    - [not真值表](#not真值表)
  - [三态门](#三态门)
  - [门级建模举例](#门级建模举例)
    - [2选1数据选择器](#2选1数据选择器)
    - [1位全加器](#1位全加器)
  - [门级描述小结](#门级描述小结)


# Verilog HDL门级建模

## 基本概念

结构级建模:  就是根据逻辑电路的结构（逻辑图），实例引用Verilog HDL中内置的基本门级元件或者用户定义的元件或其他模块，来描述结构图中的元件以及元件之间的连接关系。

门级建模: Verilog HDL中内置了12个基本门级元件（Primitive，有的翻译为“原语”）模型，引用这些基本门级元件对逻辑图进行描述，也称为门级建模。  

### 基本门级元件（Primitive : 原语）

+ 多输入门：and、nand、or、nor、xor、xnor 
  + 只有单个输出, 1个或多个输入
+ 多输出门：not、buf 
  + 允许有多个输出, 但只有一个输入
+ 三态门：bufif0、bufif1、notif0、notif1
  + 有一个输出, 一个数据输入和一个控制输入
+ 上拉电阻pullup、下拉电阻pulldown

## 多输入门

多输入门的一般引用格式为：

```
Gate_ name  <instance> (OutputA, Input1, Input2,…, InputN);
```

Gate_ name共6个： and、nand、or、nor、xor、xnor

 特点：

+ 只有1个输出, 
+ 有多个输入。

| **原语名称**   | **图形符号**                                                 | **逻辑表达式** |
| -------------- | ------------------------------------------------------------ | -------------- |
| and（与门）    | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211630495.png) | L = A & B      |
| nand（与非门） | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211636297.png) | L = ~(A & B)   |
| or（或门）     | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211641771.png) | L =  A \| B    |
| nor（或非门）  | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211645819.png) | L =~( A \| B)  |
| xor（异或门）  | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211649365.png) | L =  A ^ B     |
| xnor（同或门） | ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211652929.png) | L =  A ~^ B    |

基本门的调用方法举例：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129211726498.png)

```
and    A1（out，in1，in2，in3）；
xnor  NX1（out，in1，in2，in3，in4）； 
```

对基本门级元件，调用名A1、NX1可以省略。 

若同一个基本门在当前模块中被调用多次，可在一条调用语句中加以说明，中间以逗号相隔。  

### and、nand真值表

| and   |      | 输入1 | 输入1 | 输入1 | 输入1 |
| ----- | ---- | ----- | ----- | ----- | ----- |
|       |      | 0     | 1     | x     | z     |
| 输入2 | 0    | 0     | 0     | 0     | 0     |
| 输入2 | 1    | 0     | 1     | x     | x     |
| 输入2 | x    | 0     | x     | x     | x     |
| 输入2 | z    | 0     | x     | x     | x     |

| nand  |       | 输入1 | 输入1 | 输入1 | 输入1 |
| ----- | ----- | ----- | ----- | ----- | ----- |
|       |       | **0** | **1** | **x** | **z** |
| 输入2 | **0** | **1** | **1** | **1** | **1** |
| 输入2 | **1** | **1** | **0** | **x** | **x** |
| 输入2 | **x** | **1** | **x** | **x** | **x** |
| 输入2 | **z** | **1** | **x** | **x** | **x** |

## 多输出门

允许有多个输出，但只有一个输入。 

```
buf  B1（out1，out2，…，in）；
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212439180.png)

### buf真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212513707.png)

```
not  N1（out1，out2，…，in）；
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212531471.png)

### not真值表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212548734.png)

## 三态门

有一个输出、一个数据输入和一个输入控制。如果输入控制信号无效，则三态门的输出为高阻态z。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212741162.png)

## 门级建模举例

### 2选1数据选择器

```
//Gate-level description
module _2to1muxtri (a,b,sel,out);
   input a,b,sel;
   output out;
   tri out;
   bufif1 (out,b,sel);
   bufif0 (out,a,sel);
 endmodule 
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212813978.png)

小结：门级建模就是列出电路图结构中的元件，并按网表连接 。

### 1位全加器

```
module addbit (a, b, ci, sum, co);           
input   a,  b,  ci;                           
output  sum,  co;                         
wire   a, b, ci, sum, co, n1, n2, n3; 
     xor   u0(n1, a, b)，               
              u1(sum, n1, ci);            
     and   u2(n2, a, b)，                  
              u3(n3, n1, ci);               
     or          (co, n2, n3);            

endmodule
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230129212848710.png)

若同一个基本门在当前模块中被调用多次，可在一条调用语句中加以说明，中间以逗号相隔。  

## 门级描述小结

1. 给电路图中的每个输入输出引脚赋以端口名。
2. 给电路图中每条内部连线 取上各自的连线名。
3. 给电路图中的每个逻辑元件取一个编号 (即“调用名”)。
4. 给所要描述的这个电路模块确定一个模块名。
5. 用module定义相应模块名的结构描述,并将逻辑图中所有的输入输出端口名列入端口名表项中,再完成对各端口的输入输出类型说明。
6. 依照电路图中的连接关系,确定各单元之间端口信号的连接,完成对电路图内部的结构描述。
7. 最后用endmodule结束模块描述全过程。





参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月


[返回首页](https://github.com/timerring/hardware-tutorial)