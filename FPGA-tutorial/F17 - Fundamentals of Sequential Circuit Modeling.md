- [时序电路建模基础](#时序电路建模基础)
  - [阻塞型赋值语句与非阻塞型赋值语句](#阻塞型赋值语句与非阻塞型赋值语句)
    - [赋值运算符](#赋值运算符)
    - [过程赋值语句有阻塞型和非阻塞型](#过程赋值语句有阻塞型和非阻塞型)
    - [阻塞型过程赋值与非阻塞型过程赋值](#阻塞型过程赋值与非阻塞型过程赋值)
  - [事件控制语句](#事件控制语句)
    - [电平敏感事件（如锁存器）](#电平敏感事件如锁存器)
    - [边沿敏感事件（如触发器）](#边沿敏感事件如触发器)


# 时序电路建模基础

Verilog行为级描述用关键词initial或always，但initial是面向仿真，不能用于逻辑综合。always是无限循环语句，其用法为： 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　     　

```verilog
always＠(事件控制表达式（或敏感事件表)）
　begin　
　块内局部变量的定义；
　过程赋值语句；
end　　　　　　　　　　　　　
```

## 阻塞型赋值语句与非阻塞型赋值语句

在always语句内部的过程赋值语句有两种类型：

+ 阻塞型赋值语句（Blocking Assignment Statement）
+ 非阻塞型赋值语句（Non-Blocking Assignment Statement）

### 赋值运算符

赋值运算符(＝)   ：阻塞型过程赋值算符

+ 前一条语句没有完成赋值过程之前，后面的语句不可能被执行。

赋值运算符(<＝) ：非阻塞型过程赋值算符

+ 一条非阻塞型赋值语句的执行，并不会影响块中其它语句的执行。

### 过程赋值语句有阻塞型和非阻塞型

阻塞型用“＝”表示，多条语句顺序执行。

```verilog
   begin
        B = A;
        C = B+1;
   end
```

非阻塞型用“<=”表示，语句块内部的语句并行执行。

```verilog
  begin
        B <= A;
        C <= B+1;
   end
```

### 阻塞型过程赋值与非阻塞型过程赋值

```verilog
//Blocking (=) 
initial
  begin
    #5   a = b;
    #10 c = d;
  end
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202123338646.png)

```verilog
//Nonblocking (<=)
initial
  begin
    #5     a <= b;
    #10    c <= d;
  end
```

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202123435063.png)

注意：

+ 在可综合的电路设计中，一个语句块的内部不允许同时出现阻塞型赋值语句和非阻塞型赋值语句。
+ 在组合电路的设计中，建议采用阻塞型赋值语句。
+ 在时序电路的设计中，建议采用非阻塞型赋值语句。

## 事件控制语句

用always语句描述硬件电路的逻辑功能时，在always语句中@符号之后紧跟着“事件控制表达式”。

逻辑电路中的敏感事件通常有两种类型：电平敏感事件和边沿触发事件。

在组合逻辑电路和锁存器中，输入信号电平的变化通常会导致输出信号变化，在Verilog HDL中，将这种输入信号的电平变化称为电平敏感事件。

在同步时序逻辑电路中，触发器状态的变化仅仅发生在时钟脉冲的上升沿或下降沿，Verilog HDL中用关键词posedge（上升沿）和 negedge（下降沿）进行说明，这就是边沿触发事件。

敏感事件分为电平敏感事件和边沿触发事件

### 电平敏感事件（如锁存器）

```verilog
   always＠(sel or a or b）
   always＠(sel,a,b）
```

 sel、a、b中任意一个电平发生变化，后面的过程赋值语句将执行一次。

### 边沿敏感事件（如触发器） 

```verilog
　always＠(posedge CP or negedge CR）
```

CP的上升沿或CR的下降沿来到，后面的过程语句就会执行。

在always后面的边沿触发事件中，有一个事件必须是时钟事件，还可以有多个异步触发事件，多个触发事件之间用关键词 or 进行连接，例如，语句

```verilog
always @ (posedge CP or negedge Rd_ or negedge Sd_)
```

在Verilog 2001标准中，可以使用逗号来代替or。例如，

```verilog
always @ (posedge CP, negedge Rd_, negedge Sd_)
```

`posedge CP` 是时钟事件， `negedge Rd_`和`negedge Sd_`是异步触发事件。如果没有时钟事件，只有异步事件，就会出现语法错误。



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)