# Verilog HDL函数与任务的使用

## 函数（function）说明语句

### 函数的定义

函数定义部分可以出现在模块说明中的任何位置，其语法格式如下：

```verilog
function <返回值类型或位宽> <函数名>；
    <输入参量与类型声明>
    <局部变量声明>
    行为语句；
endfunction
```

### 函数的调用

函数调用是表达式的一部分，其格式如下：

```verilog
<函数名> （<输入表达式1>，……<输入表达式n>）；
```

其中输入表达式的排列顺序必须与各个输入端口在函数定义结构中的排列顺序一致。

### 关于函数的几点说明

 1) 函数不能由时间控制语句甚至延迟运算符组成。
 2) 函数至少有一个输入参数声明。
 3) 函数可以由函数调用组成，但函数不能由任务组成。
 4) 函数在零模拟时间内执行，并在调用时返回单个值。
 5) 在编写可综合 RTL时，不建议使用函数。
 6) 函数用于编写行为或可仿真模型。
 7) 函数不应具有非阻塞赋值。

### 例 用定义fu3nction与调用function的方法完成4选1数据选择器设计。

（1）设计块(Design Block)代码如下：

```verilog
`timescale  1ns/1ns    //定义时间单位
module  SEL4to1  ( A, B, C, D, SEL, F );
    input  A, B, C, D;
    input  [1:0] SEL;
    output  F;
  assign F= SEL4to1FUNC ( A, B, C, D, SEL );//调用函数
    //定义函数
    function  SEL4to1FUNC;    //注意此行不需要端口名列表
      input  A1, B1, C1, D1;  //函数的输入参量声明
      input  [1:0] SEL1;      //函数的输入参量声明
      case(SEL1)
        2'd0: SEL4to1FUNC = A1;
        2'd1: SEL4to1FUNC = B1;
        2'd2: SEL4to1FUNC = C1;
        2'd3: SEL4to1FUNC = D1;
      endcase
    endfunction
endmodule
```

（2）激励块(Test Bench)

```verilog
`timescale  1ns/1ns    //定义时间单位
module Test_SEL4to1();
//declare variables to be connected to inputs
  reg IN0, IN1, IN2, IN3;
  reg [1:0]SEL;
  wire OUT;      //Declare output wire
//Instantiate the Design Block
  SEL4to1 mymux(.A(IN0), .B(IN1), .C(IN2), .D(IN3), .SEL(SEL), .F(OUT) );

//Stimulate the inputs
initial
  begin
    IN0 = 1;  IN1 = 0; IN2 = 0; IN3 = 0; //set input lines
    #10  $display ($time, "\t IN0= %b, IN1= %b, IN2= %b, 
                   IN3= %b \n", N0, IN1, IN2, IN3);  
    #10   SEL = 2'b00;   //choose IN0
    #30   SEL = 2'b01;   //choose IN1
    #30   SEL = 2'b10;   //choose IN2
    #100  SEL = 2'b11;   //choose IN3
    #100 $stop;          //总仿真时间为280ns
  end
 
always begin
       #5 IN2 = ~IN2;   //每隔 5ns，IN2改变一次状态
   end
always begin
       #10 IN3 = ~IN3;  //每隔10ns，IN3改变一次状态
   end
//Monitor the outputs
initial
      $monitor ($time,  "\t SEL=%b,  OUT = %b \n", SEL, OUT);
endmodule 
```

（3）仿真结果：

4选1数据选择器的仿真波形

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202161444211.png)

### 例：2选1数据选择器(Design Block)

```verilog
module MUX2_1(A,B,SEL,OUT);
    output OUT;
    input A,B,SEL;

    assign OUT = SEL2_1_FUNC(A,B,SEL); //调用函数
    
    //定义函数
    function SEL2_1_FUNC; //此行不需要端口名列表
      input A,B,SEL;      //函数的输入参量声明
	 if (SEL==0) 
	       SEL2_1_FUNC = A;
	 else  SEL2_1_FUNC = B;
    endfunction

endmodule
```

### 例：使用函数计数1的个数的模块。

```verilog
module count_one_function (data_in, out);
  input      [7:0] data_in;
  output reg [3:0] out;
  always @(data_in)
     out = count_1s_in_byte(data_in);

  // function declaration from here.
  function [3:0] count_1s_in_byte(input [7:0] data_in);
     integer i;
     begin
	count_1s_in_byte = 0;
	for(i=0; i<=7; i=i+1)
	  if(data_in[i] == 1)
	    count_1s_in_byte = count_1s_in_byte +1;
     end
  endfunction
endmodule	
```

## 任务（task）说明语句

### 任务的定义

```verilog
task <任务名>；
    端口与类型说明；
   变量声明；
   语句1；
   语句2；
   .....
   语句n；
endtask
```

### 任务的调用

一个任务由任务调用语句调用，任务调用语句给出传入任务的参数值和接收结果的变量值，其语法如下：

```verilog
<任务名>  （端口1，端口2，……，端口n）；
```

### 关于任务的几点说明

  1) 任务可以由时间控制语句甚至延迟操作符组成。
  2) 任务可以有输入和输出声明。
  3) 任务可以由函数调用组成，但函数不能由任务组成。
  4) 任务可以有输出参数，在调用时不用于返回值。
  5) 任务可用于调用其他任务。
  6) 在编写可综合RTL时，不建议使用任务。
  7) 任务用于编写行为或可仿真模型。

### 例：使用任务从给定字符串中计算1的个数。

```verilog
module count_one_task (data_in, out);
  input      [7:0] data_in;
  output reg [3:0] out;
  always @(data_in)
     count_1s_in_byte(data_in, out);

  // task declaration from here.
  task count_1s_in_byte(input      [7:0] data_in, 
                        output reg [3:0] count
                        );
     integer i;
     begin	           // task functional description
	count = 0;
	for(i=0; i<=7; i=i+1)
	  if(data_in[i] == 1)
	    count = count + 1;
     end
  endtask
endmodule	
```

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)
