# 同步计数器分析与建模

## 概  述

(1)  计数器的逻辑功能

计数器的基本功能是对输入时钟脉冲进行计数。它也可用于分频、定时、产生节拍脉冲和脉冲序列及进行数字运算等。

(2)  计数器的分类

按脉冲输入方式，分为同步和异步计数器

按进位体制，分为二进制、十进制和任意进制计数器

按逻辑功能，分为加法、减法和可逆计数器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160146568.png)

计数器运行时，依次遍历规定的各状态后完成一次循环，它所经过的状态总数称为计数器的“模”（Modulo），通常用M表示。

## 同步计数器的设计

例 用D触发器和逻辑门设计一个同步六进制计数器。要求有一个控制信号U，

+ 当U=1时，计数次序为递增计数0,1,2,3,4,5,0,1,2,…；
+ 当U=0时，计数次序为递减计数5,4,3,2,1,0,5,4,3,…。

另外，当递增计数到最大值5时，要求输出一个高电平CO=1；当递减计数到最小值0时，也要求输出一个高电平BO=1。

解：(1) 分析设计要求，画出总体框图。

根据要求，计数器共有6个状态，我们要用D触发器来表示或区分出这6个状态，需要多少个D触发器才够呢？由于3个D触发器能够存储3位二进制数，而3位2进制数能表示23=8个状态，即000,001,010,011,100,101,110,111，所以只需要3个触发器就能表示6个状态。

总体电路框图如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160235948.png)

左半部分是3个D触发器，用于记录计数器的当前状态。右半部分是组合逻辑，生成下一个状态信号并产生输出信号。由于下一个状态信号与触发器的D端相连接，因此，该信号也被称为触发器的激励信号。

(2) 画出状态转换图

![image-20230202160254624](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160254624.png)

(3)列出转换表

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160329309.png)

(4)确定下一个状态的逻辑表达式

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160341186.png)


$$
\begin{array}{l}
N S[0]=\overline{Q[1]} \cdot \overline{Q[0]}+\overline{Q[2]} \cdot \overline{Q[0]} \\
N S[1]=\bar{U} \cdot \overline{Q[2]} \cdot \overline{Q[1]} \cdot Q[0]+\bar{U} \cdot \overline{Q[2]} \cdot Q[1] \cdot \overline{Q[0]}+U \cdot \overline{Q[2]} \cdot Q[1] \cdot Q[0]+U \cdot Q[1] \cdot \overline{Q[1]} \cdot \overline{Q[0]} \\
N S[2]=\bar{U} \cdot \overline{Q[2]} \cdot Q[1] \cdot Q[0]+\bar{U} \cdot Q[2] \cdot \overline{Q[1]} \cdot \overline{Q[0]}+U \cdot \overline{Q[2]} \cdot \overline{Q[1]} \cdot \overline{Q[0]}+U \cdot Q[2] \cdot \overline{Q[1]} \cdot Q[0] \\
\end{array}
$$


同理， 得到
$$
\quad C O=\bar{U} \cdot Q[2] \cdot \overline{Q[1]} \cdot Q[0] \\
\quad B O=U \cdot \overline{Q[2]} \cdot \bar{Q}[1] \cdot \overline{Q[0]}
$$
(5) 画出逻辑图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160755912.png)

## 同步计数器的Verilog HDL建模

例  试用Verilog HDL对图所示电路建模

（1）设计块：

```verilog
module Counter6 (CP,CLR_,U,Q,CO,BO);
   input CP, CLR_, U;  
   output reg [2:0] Q;     //Data output
   output CO,BO;
 assign CO = U  & (Q == 3'd5);
 assign  BO = ~U & (Q == 3'd0) & (CLR_== 1 ' b1);
 always @ (posedge CP or negedge CLR_)
   if (~CLR_) Q <= 3'b000; //asynchronous clear
   else if (U==1)          //U=1,Up Counter
         Q <= (Q + 1'b1)%6; 
   else if (Q == 3'b000)
         Q <= 3'd5; 
   else                    //U=0,Down Counter
         Q <= (Q - 1'b1)%6;
endmodule
```

（2）激励块：给输入变量（CLR_、CLK和U）赋值，产生激励信号。

```verilog
module Test_Counter6 ;
    reg  U;           //Up/Down inputs      
    reg  CLK, CLR_;   //Clock and Reset
    wire  CO,BO;      //output  
    wire [2:0]  Q;    //Register output

Counter6 U0(CLK,CLR_,U,Q,CO,BO); //实例引用设计块
  
initial begin         // CLR_
    CLR_ = 1'b0;
    CLR_ = #10 1'b1;
    #360 $stop;
    end 
always begin    // CLK
    CLK = 1'b0;
    CLK = #10 1'b1;
    #10;
    end 
initial begin   //U
    U = 1'b0;
    #190;
    U = 1'b1;
    end 
endmodule
```

（3）仿真结果：

六进制计数器的仿真波形

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202160928164.png)

例 试用Verilog HDL描述一个带有异步置零和具有使能功能的同步十进制递增计数器。

```verilog
//Non-Binary counter with ENable 
module M10_counter (EN,CP,CLR_,Q); 
   input EN,CP,CLR_;
   output reg [3:0] Q;      //Data output
always @(posedge CP or negedge CLR_)
  if (!CLR_)                //异步清零
            Q <= 4'b0000; 
  else if (EN) begin 
       if (Q >= 4'b1001) 
            Q <= 4'b0000;   //出错处理
       else Q <= Q + 1'b1;  //递增计数
       end  
  else 
            Q <= Q;         //保持计数值不变
endmodule
```

例：请描述具有异步清零、同步置数的计数器，并要求具有可逆计数和保持的功能。

```verilog
module cntr(q, aclr, clk, func, d);
input aclr, clk;
input [7:0] d;
//Controls the functionality 
input [1:0] func; 
output [7:0] q;
reg [7:0] q;
always @(posedge clk or posedge aclr) begin
  if (aclr)   q <= 8'h00;
  else  case (func)
     2'b00: q <= d; // Loads the counter
     2'b01: q <= q + 1; // Counts up
     2'b10: q <= q - 1; // Counts down
     2'b11: q <= q;
   endcase
end
endmodule
```

例：假设有一个50 MHz时钟信号源，试用Verilog HDL设计一个分频电路，以产生1Hz的秒脉冲输出，要求输出信号的占空比为50%。

解：设计一个模数为$25*10^6$的二进制递增计数器，其计数范围是0~24999999，每当计数器计到最大值时，输出信号翻转一次，即可产生1Hz的秒脉冲。 

```verilog
module Divider50MHz(CR,CLK_50M, CLK_1HzOut);
  input	CR,CLK_50M; 
  output reg CLK_1HzOut;   
  reg [24:0] Count_DIV; //内部节点
parameter CLK_Freq = 50000000;
parameter OUT_Freq = 1;
always @(posedge CLK_50M or negedge CR)  begin
if(!CR)  begin
       CLK_1HzOut <= 0;
       Count_DIV     <= 0;
       end
else  begin
if( Count_DIV < (CLK_Freq/(2*OUT_Freq-1)) )
            Count_DIV <= Count_DIV+1'b1;  
 else begin
	 Count_DIV     <=	0; 		 CLK_1HzOut  <=  ~CLK_1HzOut; 
         end
 end
end
endmodule 
```

产生1Hz的秒脉冲输出分频电路

```verilog
always @(posedge CLK_50M or negedge CR) 
begin
  if(!CR)  begin
      	       CLK_1HzOut <= 0;
                    Count_DIV     <= 0;
  	  end
  else  begin
           if( Count_DIV < (CLK_Freq/2*OUT_Freq-1) )
                     Count_DIV <= Count_DIV+1'b1;  
           else begin
                     Count_DIV      <=	0; 		 
                     CLK_1HzOut  <=  ~CLK_1HzOut; 
           	      end
           end
end
endmodule 
```

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)
