- [逻辑功能的仿真与验证](#逻辑功能的仿真与验证)
  - [例：2选1数据选择器的测试模块](#例2选1数据选择器的测试模块)
  - [测试激励块(TB)与设计块(Design Block)之间的关系](#测试激励块tb与设计块design-block之间的关系)
  - [仿真过程简介](#仿真过程简介)
  - [ModelSim仿真软件的使用](#modelsim仿真软件的使用)


# 逻辑功能的仿真与验证

HDL产生的最初动因就是为了能够模拟硬件系统，可以分析系统的性能，验证其功能是否正确。

要测试一个设计块是否正确，就要用Verilog再写一个测试模块(Test Bench)。这个测试模块应包括以下三个方面的内容：

+ 测试模块中要调用到设计块，只有这样才能对它进行测试；
+ 测试模块中应包含测试的激励信号源；
+ 测试模块能够实施对输出信号的检测，并报告检测结果；

写出测试模块的过程又称为搭建测试平台（Test Bench）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126094005962.png)

## 例：2选1数据选择器的测试模块

```
module test_mux;
  reg a,b,s; 
  wire out;
   
  mux2to1 u1(out, a, b, s);
  initial
  begin
    a=0; b=1; s=0;
#10 a=1; b=1; s=0;
#10 a=1; b=0; s=0;
#10 a=1; b=0; s=1;
#10 a=1; b=1; s=1;
#10 a=0; b=1; s=1;
#10 $finish;
   end
 initial
$monitor($time, “a=%b b=%b s=%b out=%b”, a,b,s,out);
endmodule
```

```
module mux2to1(out,a,b,sel);
 output out;
 input a,b,sel; 
 wire selnot,a1,b1;  
 not (selnot, sel);
 and (a1, a, selnot);
 and (b1, b, sel);
 or (out1, a1, b1);
endmodule
```

```

0  a=0 b=1 s=0 out=0
10 a=1 b=1 s=0 out=1
20 a=1 b=0 s=0 out=1
30 a=1 b=0 s=1 out=0
40 a=1 b=1 s=1 out=1
50 a=0 b=1 s=1 out=1
```

## 测试激励块(TB)与设计块(Design Block)之间的关系

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126094142053.png)

仿真时，信号线a、b、s上要加一组测试激励信号，这组激励信号的产生，是通过initial内部的过程语句产生的，而过程语句只能给reg型变量赋值。

仿真时，信号线a、b、s上的激励信号是不能消失的，需要有“寄存”效应，能够描述这种“寄存”行为的，只能是reg型。

端口连接时有关变量数据类型的一些规定

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126094207435.png)

## 仿真过程简介 

使用软件ModelSim-Altera 6.5b Starter Edition 进行仿真验证的大致过程 

![](../AppData/Roaming/Typora/typora-user-images/image-20230126094703361.png)

## ModelSim仿真软件的使用 

+ 创建一个工作目录 
+ 输入源文件 
+ 建立工作库

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126094804150.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126094807164.png)

编译设计文件

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126095052433.png)

装入设计文件到仿真器 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126095100369.png)

运行仿真器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126095115577.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230126095129330.png)



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)