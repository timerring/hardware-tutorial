- [Verilog HDL行为级建模](#verilog-hdl行为级建模)
  - [行为级建模基础](#行为级建模基础)
    - [1. always语句的一般用法](#1-always语句的一般用法)
    - [2. 条件语句（ if语句）](#2-条件语句-if语句)
    - [3. 多路分支语句（case语句）](#3-多路分支语句case语句)
    - [4. for循环语句](#4-for循环语句)


# Verilog HDL行为级建模

行为级建模就是描述数字逻辑电路的功能和算法。

在Verilog中，行为级描述主要使用由关键词initial或always定义的两种结构类型的语句。一个模块的内部可以包含多个initial或always语句。 

initial语句是一条初始化语句，仅执行一次，经常用于测试模块中，对激励信号进行描述，在硬件电路的行为描述中，有时为了仿真的需要，也用initial语句给寄存器变量赋初值。

initial语句主要是一条面向仿真的过程语句，不能用于逻辑综合 。这里不介绍它的用法。

在always结构型语句内部有一系列过程性赋值语句，用来描述电路的功能（行为）。

## 行为级建模基础

下面介绍行为级建模中经常使用的语句：
1. always语句结构及过程赋值语句
2. 条件语句（if-else）
3. 多路分支语句（case-endcase）
4. for循环语句（例如 for等）

### 1. always语句的一般用法

```
always @(事件控制表达式)
begin：块名
   块内局部变量的定义;
   过程赋值语句（包括高级语句）;
end
```

 “@”称为事件控制运算符，用于挂起某个动作，直到事件发生。“事件控制表达式”也称为敏感事件表，它是后面begin和end之间的语句执行的条件。当事件发生或某一特定的条件变为“真”时，后面的过程赋值语句就会被执行。

begin…end 之间只有一条语句时，关键词可以省略；

begin…end 之间的多条语句被称为顺序语句块。可以给语句块取一个名字，称为有名块。

### 2. 条件语句（ if语句）

条件语句就是根据判断条件是否成立，确定下一步的运算。

Verilog语言中有3种形式的if语句：

（1）  if (condition_expr) true_statement;

（2）  if (condition_expr) true_statement;
            else false_ statement;

（3）   if (condition_expr1)        true_statement1;
             else if (condition_expr2) true_statement2;
             else if (condition_expr3) true_statement3;
             ……
             else default_statement;

if后面的条件表达式一般为逻辑表达式或关系表达式。执行if语句时，首先计算表达式的值，若结果为0、x或z，按“假”处理；若结果为1，按“真”处理，并执行相应的语句。 

例：使用if-else语句对4选1数据选择器的行为进行描述

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230130103330365.png)

```
module mux4to1_bh(D, S, Y);  
   input [3:0] D;  //输入端口
   input [1:0] S;  //输入端口
   output reg Y;  //输出端口及变量数据类型
   always @(D, S) //电路功能描述,或@(D or S) 
     if (S == 2’b00)      Y = D[0];  
     else if (S== 2’b01)  Y = D[1];
     else if (S== 2’b10)  Y = D[2];
     else                 Y = D[3];
endmodule 
```

注意，过程赋值语句只能给寄存器型变量赋值，因此，输出变量Y的数据类型定义为reg。

### 3. 多路分支语句（case语句）

是一种多分支条件选择语句，一般形式如下

```
case (case_expr)
       item_expr1: statement1;
       item_expr2: statement2;
        ……
      default: default_statement; //default语句可以省略
endcase
```

注意：当分支项中的语句是多条语句，必须在最前面写上关键词begin，在最后写上关键词end，成为顺序语句块。

另外，用关键词casex和casez表示含有无关项x和高阻z的情况。  

例：对具有使能端En 的4选1数据选择器的行为进行Verilog描述。当En=0时，数据选择器工作，En=1时，禁止工作，输出为0。 

```
module mux4to1_bh (D, S, En,Y); 
  input [3:0] D，[1:0] S；  input  En;
  output  reg  Y；
  always @(D, S, En)  //2001, 2005 syntax；或@(D or S or En) 
  begin
   if (En==1)  Y = 0; //En=1时，输出为0
   else                        //En=0时，选择器工作
     case (S) 
       2’d0: Y = D[0];
       2’d1: Y = D[1];
       2’d2: Y = D[2];
       2’d3: Y = D[3];
     endcase
  end
endmodule 
```

### 4. for循环语句

一般形式如下

```
for (initial_assignment; condition; step_assignment)  
           statement；
```

initial_assignment 为循环变量的初始值。

condition为循环的条件，若为真，执行过程赋值语句statement，若不成立，循环结束，执行for后面的语句。

step_assignment为循环变量的步长，每次迭代后，循环变量将增加或减少一个步长。



**试用Verilog语言描述具有高电平使能的3线-8线译码器.** 

```
module decoder3to8_bh(A,En,Y);
       input [2:0] A，En; 
       output reg  [7:0] Y;
       integer k;                //声明一个整型变量k
       always @(A, En)   // 2001, 2005 syntax
          begin
               Y = 8’b1111_1111;     //设译码器输出的默认值
              for(k = 0; k <= 7; k = k+1) //下面的if-else语句循环8次
                     if ((En==1) && (A== k) ) 
                          Y[k] = 0;   //当En=1时，根据A进行译码
                     else
                          Y[k] = 1;   //处理使能无效或输入无效的情况
          end
endmodule
```

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)
