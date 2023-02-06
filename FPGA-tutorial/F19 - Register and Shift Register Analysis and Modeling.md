# 寄存器和移位寄存器分析与建模

## 寄存器及Verilog HDL建模

图中，$PD_3$~$PD_0$是4位数据输入端，

+ 当Load = 1时，在CP脉冲上升沿到来时，$Q_3 = PD_3$，$Q_2 = PD_2$，$Q_1 = PD_1$，$Q_0 = PD_0$，即输入数据$PD_3-PD_0$同时存入相应的触发器；
+ 当Load = 0时，即使CP上升沿到来，输出端Q 的状态将保持不变。可见，电路具有存储输入的4位二进制数据的功能。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154017076.png)

例 试对上图所示的寄存器进行建模。

```verilog
module Reg4bit (Q,PD,CP,CLR_,Load); 
   output reg [3:0] Q;
   input wire [3:0] PD;
   input CP,CLR_,Load;

   always @(posedge CP or negedge CLR_) 
     if (!CLR_)        // 异步复位
               Q <= 4'b0000;  
     else if (Load)    // 同步加载(置数)
               Q <= PD;
     else
               Q <= Q; // 数据保持
endmodule  
```

例 试对图所示任意位数(带参数)的寄存器进行建模。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154248604.png)

```verilog
module Register          //Verilog 2001, 2005 syntax
  #(parameter N = 8)     //定义参数 N = 8
   (output reg [N-1:0]Q, //数据输出端口及变量的数据类型声明
    input wire [N-1:0]PD,//并行数据输入
    input CP,            //输入端口声明
    input CLR_,
    input Load 
   );
 always @(posedge CP or negedge CLR_) 
   if (~CLR_)       // 异步复位
           Q <= 0;  
   else if (Load)   // 同步加载(置数)
           Q <= PD;
   else
           Q <= Q;  // 数据保持	
  endmodule 
```

## 移位寄存器及Verilog HDL建模

### (1) 移位寄存器

将若干个D触发器串接级联在一起构成的具有移位功能的寄存器，叫做移位寄存器。

移位寄存器的逻辑功能分类

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154330123.png)

### (2)  4位单向右移移位寄存器

#### 电路

![image-20230202154354049](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154354049.png)

#### 工作原理

写出激励方程:

$$
D_{0}=D_{\mathrm{SI}} \quad \boldsymbol{D}_{1}=\boldsymbol{Q}_{0}{ }^{n} \quad \boldsymbol{D}_{2}=\boldsymbol{Q}_{1}^{n} \quad \boldsymbol{D}_{3}=\boldsymbol{Q}_{2}^{n}
$$


写出状态方程:

$$
\begin{array}{ll}
Q_{0}{ }^{\mathrm{n}+1}=D_{\mathrm{SI}} & Q_{1}^{\mathrm{n}+1}=D_{1}=Q_{0}{ }^{\mathrm{n}} \\
Q_{2}{ }^{\mathrm{n}+1}=D_{2}=Q_{1}^{\mathrm{n}} & Q_{3}{ }^{\mathrm{n}+1}=D_{3}=Q_{2}^{\mathrm{n}}
\end{array}
$$
![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154514730.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154615978.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154623141.png)

$D_{SI} =11010000$,从高位开始输入

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154652503.png)

经过7个CP脉冲作用后，从DSI 端串行输入的数码就可以从DO 端串行输出。

### (3）多功能移位寄存器工作模式简图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154748573.png)

+ 右移:  $D_{\mathrm{IR}} \rightarrow Q_{0} \rightarrow Q_{1} \rightarrow Q_{2} \rightarrow Q_{3} \rightarrow D_{\mathrm{OR}}$  (左入右出)
+ 左移:  $D_{\mathrm{OL}} \leftarrow Q_{0} \leftarrow Q_{1} \leftarrow Q_{2} \leftarrow Q_{3} \leftarrow D_{\mathrm{I}}$  (右入左出)
+ 右移输入并行输出:  $D_{\mathrm{IR}} \rightarrow Q_{0} \rightarrow Q_{1} \rightarrow Q_{2} \rightarrow Q_{3}$  (4个CP)
+ 左移输入并行输出:  $Q_{0} \leftarrow Q_{1} \leftarrow Q_{2} \leftarrow Q_{3} \leftarrow D_{\text {II }}$(4  个CP  ) 
+ 并行输入并行输出、并行输入串行输出。

与普通移位寄存器的连接不同，输入端D连接两个不同的数据源，一个数据源为前级的输出，用于移位寄存器的操作；另一个数据来自于外部输入，作为并行操作的一部分。

控制信号Mode用来选择操作的模式，

+ 当Mode = 0时，电路实现移位操作；
+ 当Mode = 1时，则并行数据In3~In0便送到各自的输出端寄存。这两种操作都发生在时钟信号的上升沿时刻。

并行存取的移位寄存器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154914858.png)

将移位寄存器的$D_{SO}$（Q3）与$D_{IN}$相连，则构成环形计数器，如图所示。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202154956604.png)

若事先通过  $\overline{P E}$  端施加低电平脉冲, 将初始数据  $Q_{0} Q_{1} Q_{2} Q_{3}=1000$  置入触发器中,

在  CP  脉冲用下,  $Q_{0} Q_{1} Q_{2} Q_{3}$  将依次为  $1000 \rightarrow 0100 \rightarrow 0010 \rightarrow 0001 \rightarrow 1000 \rightarrow \cdots \cdots$ , 即每个触发器经 过4个时钟周期输出一个高电平脉冲, 并且该高电平脉冲 沿环形路径在触发器中传递。可见, 4个触发器只有4个计数状态。

### 约翰逊计数器（Johnson Counter）

如果将图4.4.3电路中的$\overline{Q_3}$与DIN相连，则构成扭环形计数器，亦称为约翰逊计数器（Johnson Counter），电路的状态将增加一倍。

![扭环形计数器](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155338566.png)

例 试对下图所示的右向移位寄存器进行建模。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155405170.png)

```verilog
module ShiftReg (Q,Din,CP,CLR_);
   input Din;            //Serial Data inputs      
   input CP, CLR_;       //Clock and Reset
   output reg [3:0] Q;   //Register output
  
  always @ (posedge CP or negedge CLR_)
   if (~CLR_)            //asynchronous clear
            Q <= 4'b0000;
   else begin            //Shift right
         Q[0] <= Din;
       Q[3:1] <= Q[2:0]; 
        end
endmodule 
```

例 一个4位的双向移位寄存器框图如图所示。该寄存器有两个控制输入端（S1、S0）、两个串行数据输入端（Dsl、Dsr）、4个并行数据输入端和4个并行输出端，要求实现5种功能：异步置零、同步置数、左移、右移和保持原状态不变，其功能如表所示。试用功能描述风格对其建模。

![双向移位寄存器框图](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155447567.png)

![双向移位寄存器的功能表](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155510252.png)

```verilog
module UniversalShift (S1,S0,Din,Dsl,Dsr,Q,CP,CLR_);
   input S1, S0;            //Select inputs
   input Dsl, Dsr;          //Serial Data inputs      
   input CP, CLR_;          //Clock and Reset
   input [3:0] Din;         //Parallel Data input
   output reg [3:0] Q;      //Register output

always @ (posedge CP or negedge CLR_)
   if (~CLR_)               //asynchronous clear
              Q <= 4'b0000;  
   else
      case ({S1,S0})
        2'b00: Q <= Q;            //No change
        2'b01: Q <= {Dsr,Q[3:1]}; //Shift right
        2'b10: Q <= {Q[2:0],Dsl}; //Shift left
        2'b11: Q <= Din;          //Parallel load input
      endcase
endmodule  
```

## 移位寄存器的应用电路

### (1) 开关去“抖动” 电路

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155607452.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155613667.png)

```verilog
module Debounce (Out,Btn_In,CLK,CLR_);
   input  [3:0] Btn_In;    //Button inputs      
   input        CLK, CLR_; //Clock and Reset
   output [3:0] Out;       //Register output
   reg [3:0] Delay0;  
   reg [3:0] Delay1;  
   reg [3:0] Delay2;  
 always @ (posedge CLK or negedge CLR_)
  begin
   if (~CLR_) begin      //asynchronous clear
      Delay0 <= 4’b0000;
      Delay1 <= 4’b0000;
      Delay2 <= 4’b0000;
      end
   else begin            //Shift right
      Delay0 <= Btn_In;
      Delay1 <= Delay0; 
      Delay2 <= Delay1; 
      end
     end
 assign Out = Delay0 & Delay1 & Delay2;

endmodule   
```

### (2) 单脉冲产生电路

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155642964.png)

（1）设计块：单脉冲产生电路的代码如下：

```verilog
module ClockPulse (Out, Btn_In,CLK,CLR_);
   input  Btn_In;     //Button inputs      
   input  CLK, CLR_;  //Clock and Reset
   output Out;        //Output
   reg Delay0;  
   reg Delay1;  
   reg Delay2;  
 always @ (posedge CLK or negedge CLR_)
  begin
   if (~CLR_)        //asynchronous clear
      {Delay0, Delay1, Delay2} <= 3’b000;
   else begin        //Shift right
       Delay0 <= Btn_In;
       Delay1 <= Delay0; 
       Delay2 <= Delay1; 
       end
   end
 assign Out = Delay0 & Delay1 & ~Delay2;
endmodule   
```

（2）激励块：给输入（CLR_、Btn_In和CLK）赋值，产生激励信号。

```verilog
module Test_ClockPulse ;
   reg  Btn_In;     //Button inputs      
   reg  CLK, CLR_;  //Clock and Reset
   wire Out;        //single  clock pulse output  
  
 ClockPulse U0(Out, Btn_In,CLK,CLR_);
  
 initial begin          // CLR_
    CLR_ = 1'b0;  
    CLR_ = #20 1'b1;
    #350 $stop;         //总仿真时间为370
  end
 
 always begin           // CLK
    CLK = 1'b0;
    CLK = #10 1'b1;
    #10;
    end   
```

```verilog
initial begin             // Btn_In
    Btn_In = 1'b0;
    Btn_In = #30 1'b1;
    Btn_In = #5 1'b0;
    Btn_In = #5 1'b1;
    Btn_In = #20 1'b0;  
    #100;
    Btn_In = 1'b1;
    Btn_In = #5 1'b0;
    Btn_In = #5 1'b1;
    Btn_In = #80 1'b0;        
  end 

endmodule
```

### (3) 仿真波形

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202155714265.png)

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)