- [状态机设计举例](#状态机设计举例)
	- [汽车尾灯控制电路设计](#汽车尾灯控制电路设计)
	- [应用算法状态机设计十字路口交通灯控制电路](#应用算法状态机设计十字路口交通灯控制电路)
		- [1.ASM图的状态框、判断框和输出框。](#1asm图的状态框判断框和输出框)
		- [2.ASM图中各种逻辑框之间的时间关系](#2asm图中各种逻辑框之间的时间关系)
		- [3.十字路口交通灯控制电路设计举例](#3十字路口交通灯控制电路设计举例)
	- [状态机设计准则](#状态机设计准则)
	- [FSM输出方法](#fsm输出方法)
	- [有限状态机HDL描述规则](#有限状态机hdl描述规则)
	- [可靠性与容错性](#可靠性与容错性)



# 状态机设计举例

## 汽车尾灯控制电路设计

重点介绍构造状态图的两种方法：一是试探法，二是基于算法状态机构造状态图的方法。

例 (试探法)汽车尾灯发出的信号主要是给后面行驶汽车的司机看的，通常汽车驾驶室有刹车开关（HAZ）、左转弯开关(LEFT)和右转弯开关(RIGHT)，司机通过操作这3个开关给出车辆的行驶状态。假设在汽车尾部左、右两侧各有3个指示灯，分别用LA、LB、LC、RA、RB、RC表示，如图所示。这些灯的亮、灭规律如下：

1. 汽车正常行驶时，尾部两侧的6个灯全部熄灭。
2. 刹车时，汽车尾灯工作在告警状态，所有6个灯按一定频率闪烁（或一直保持常亮状态）。
3. 左转弯时，左侧3个灯轮流顺序点亮（或按一定频率闪烁），其规律如图（a）所示，右侧灯全灭。
4. 右转弯时，右侧3个灯轮流顺序点亮（或按一定频率闪烁），其规律如图（b）所示，左侧灯全灭。

假设电路的输入时钟信号为CP，CP的频率对于汽车尾灯所要求的闪烁频率。试根据上述要求设计出一个时钟同步的状态机来控制汽车的尾灯。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100305424.png)

（1）画出原始状态图

选择Moore机设计该电路，则尾灯的亮、灭直接由状态译码就可以得到。由设计要求可知：汽车左转弯时，右边的灯不亮而左边的灯依次循环点亮，即0个、1个、2个或3个灯亮，分别用L0、L1、L2、L3表示，状态机在4个状态中循环。同理，汽车右转弯时，状态机也会在4个状态中循环，即左边灯不亮而右边的灯有0个、1个、2个或3个灯亮，分别用R0、R1、R2、R3表示。由于L0和R0都表示6个灯不亮，所以合起来用IDLE表示。将6个灯都亮的状态用LR3表示。可得原始的状态图就画出来了，如图所示。

分析一下下图，就会发现一个没有考虑到的实际问题，即如果多个输入同时有效，状态机如何工作呢？下图解决了多个输入同时有效的问题，并将LEFT和RIGHT同时有效的情况处理成告警状态。经过改进且具有这一特性的状态图如下所示。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100358100.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100447979.png)

（2）列出电路的输出

由于电路的输出信号较多，不便于写在状态图中，所以单独列出输出逻辑真值表，如表所示。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100518283.png)

（3）选择一种编码方案，对上述状态图进行状态分配，然后用Verilog HDL描述状态图和输出逻辑。

状态图完成后，必须进行完备性和互斥性的检查。

①完备性的检查方法是：对于每一个状态，将所有脱离这一状态的条件表达式进行逻辑或运算，如果结果为1就是完备的。否则不完备，也就是说状态图进入某状态后，却不能跳出该状态。

②互斥性的检查方法是：对于每一个状态，将所有脱离这一状态的条件表达式找出来，然后任意两个表达式进行逻辑与运算，如果结果为0就是互斥的。也就是要保证在任何时候不会同时激活两个脱离状态的转换，即从一个状态跳到两个状态。

## 应用算法状态机设计十字路口交通灯控制电路

算法状态机ASM（Algorithmic State Machine）图是描述数字系统控制算法的流程图。应用ASM图设计数字系统，可以很容易将语言描述的设计问题变成时序流程图的描述，根据时序流程图就可以得到电路的状态图和输出函数，从而得出相应的硬件电路。

### 1.ASM图的状态框、判断框和输出框。

ASM图中有三种基本的符号，即状态框、判断框和输出框。数字系统控制序列中的状态用状态框表示，如图（a）所示。图（b）为状态框实例。图中的箭头表示系统状态的流向。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100611098.png)

判断框表示状态变量对控制器工作的影响，如图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100651666.png)


条件输出框如下图所示，条件框的入口必定与判断框的输出相连。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100700314.png)

### 2.ASM图中各种逻辑框之间的时间关系

从表面上来看ASM图与程序流程图很相似，但实际上有很大的差异。程序流程图只表示事件发生的先后顺序，没有时间概念，而ASM图则不同，它表示事件的精确时间间隔顺序。在ASM图中每一个状态框表示一个时钟周期内的系统状态，状态框和与之相连的判断框，条件输出框所规定的操作，都是在一个共同的时钟周期实现的，同时系统的控制器从现在状态（现态）转移到下一个状态（次态）。因此，可以很容易将图（a）所示的ASM图转换成状态图，如图（b）所示，其中E和F为状态转换条件。与ASM图不同，状态图无法表示寄存器操作。

图（c）给出了ASM图的各种操作及状态转换的时间图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100751091.png)

### 3.十字路口交通灯控制电路设计举例

例(基于算法状态机构造状态图的方法)图4.4.10表示位于主干道和支干道的十字路口交通灯系统，支干道两边安装有传感器S(Sensor)，试设计一个主干道和支干道十字路口的交通灯控制电路，其技术要求如下： 

1. 一般情况下，保持主干道畅通，主干道绿灯亮、支干道红灯亮，并且主干道绿灯亮的时间不得少于60秒。
2. 主干道车辆通行时间已经达到60秒，且支干道有车时，则主干道红灯亮、支干道绿灯亮，但支干道绿灯亮的时间不得超过30秒。
3. 每次主干道或支干道绿灯变红灯时，黄灯先亮5秒钟。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100850473.png)

 设计步骤：

1. 明确系统的功能，进行逻辑抽象
2. 确定系统方案并画出ASM图

![交通灯系统框图](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209100944234.png)

交通灯控制单元的控制过程分为四个阶段，对应的输出有四种状态，分别用S0, S1, S2和S3表示：

S0状态：主干道绿灯亮支干道红灯亮，此时若支干道有车等待通过，而且主干道绿灯已亮足规定的时间间隔TL(60s)，控制器发出状态转换信号ST，控制器从状态S0转换到S1。

S1状态：主干道黄灯亮，支干道红灯亮，进入此状态，黄灯亮足规定的时间间隔TY(5s)时，控制器发出状态转换信号ST，控制器从状态S1转换到S2。

S2状态：支干道绿灯亮，主干道红灯亮，若此时支干道继续有车，则继续保持此状态，但支干道绿灯亮的时间不得超过TS(30s)时间间隔，否则控制单元发出状态转换信号ST，控制器转换到S3状态。

S3状态：支干道黄灯亮，主干道红灯亮，此时状态与S1状态持续的时间间隔相同，均为TY(5s) ，时间到时，控制器发出ST信号，控制器从状态S3回到S0状态。

对上述S0、S1、S2和S3四种状态按照格雷码进行状态编码，分别为00，01，11和10，由此得到交通灯控制单元的ASM图如图所示。依此类推得出所示的状态图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209101040730.png)

（3）交通灯控制器各功能模块电路的框架设计

通过分析交通灯控制电路的要求可知，系统主要由传感器S(Sensor)、时钟脉冲产生器(CLK )、定时器(TL, TS, TY)、控制器及译码器构成，传感器S在有车辆通过时发出一个高电平信号。

①设计控制器

根据交通灯控制单元的ASM图，得出其状态图如图4.4.13所示。ASM图中的状态框与状态图中的状态相对应，判断框中的条件是状态转换的输入条件，条件输出框与控制单元状态转换的输出相对应。状态图是描述状态之间的转换。

②设计定时器

定时器由与系统秒脉冲同步的计数器构成，时钟脉冲上升沿到来时，在控制信号ST作用下，计数器从零开始计数，并向控制器提供模M5、M30和M60信号，即TY、TS和TL定时时间信号。

③设计译码器

当交通灯控制电路处于不同工作状态时，交通信号灯按一定的规律与之对应。

（4）用Verilog HDL描述交通灯控制电路

根据以上设计思路，可以写出交通灯控制电路的Verilog HDL代码如下：

```verilog
//--------------- controller.v ---------------
// Traffic Signal Controller
//State definition     HighWay   Country
`define S0   2'b00  //GREEN	     RED，采用宏定义方式给出状态编码
`define S1   2'b01  //YELLOW RED，不建议采用此方法
`define S2   2'b11  //RED	    GREEN
`define S3   2'b10  //RED	    YELLOW
module controller (CLK, S, nRESET, HG, HY, HR, FG, FY, FR, TimerH, TimerL);
//I/O ports
input CLK, S, nRESET;  //if S=1, indicates that there is car on the country road
output HG, HY, HR, FG, FY, FR; 
//declared output signals are registers
reg    HG, HY, HR, FG, FY, FR;
output [3:0] TimerH;
output [3:0] TimerL;
reg    [3:0] TimerH, TimerL;
//Internal state variables
wire Tl, Ts, Ty; //timer output signals
reg St;           //state translate signal
reg [1:0] CurrentState, NextState;    //FSM state register

/*===== Description of the timer block =====*/
always @(posedge CLK or negedge nRESET )
begin:  counter
    if (~nRESET)  {TimerH, TimerL} <= 8'h00; 
    else if (St)         {TimerH, TimerL} <= 8'h00; 
    else if ((TimerH == 5) & (TimerL == 9)) 
        begin {TimerH, TimerL} <= {TimerH, TimerL}; end
    else if (TimerL == 9) 
        begin TimerH <= TimerH + 1;  TimerL <= 0; end
    else 
        begin TimerH <= TimerH; TimerL <= TimerL + 1; end
end  // BCD counter
assign  Ty = (TimerH==0)&(TimerL==4);
assign  Ts = (TimerH==2)&(TimerL==9);
assign  Tl = (TimerH==5)&(TimerL==9);

/*===== Description of the signal controller block =====*/
//FSM register:State change only at positive edge of clock
always @(posedge CLK or negedge nRESET )
    begin:  statereg
	if (~nRESET)    //Signal controller starts in S0 state
	 	CurrentState  <=  `S0;
	else      CurrentState  <=  NextState;
     end   //statereg

// FSM combinational block: state machine using case statements
always @(S or CurrentState or Tl or Ts or Ty )
   begin: fsm
	  case(CurrentState)
	  	`S0: begin      //S0是用define定义的，在引用时要加右撇号(反撇号)
                 NextState = (Tl && S) ? `S1 :`S0;
				St = (Tl && S) ? 1:0;
			  end
	  	`S1:       begin
				NextState = (Ty) ? `S2 :`S1;
				St = (Ty) ? 1:0;
			  end
	  	`S2:       begin
				NextState = (Ts || ~S) ? `S3 :`S2;
				St = (Ts || ~S) ? 1:0;
			  end
	  	`S3:       begin
				NextState = (Ty) ? `S0 :`S3;
				St = (Ty) ? 1:0;
              end
	 endcase	
end  //fsm
/*===== Description of the decoder block =====*/
//Compute values of main signal and country signal
always @(CurrentState)
    begin
        case (CurrentState)
	`S0: begin
	          {HG, HY, HR} = 3'b100; //Highway signal is green
	          {FG, FY, FR}   = 3'b001; //Country signal is red 
                    end
            `S1: begin
	          {HG, HY, HR} = 3'b010; //Highway signal is yellow
			  {FG, FY, FR}  = 3'b001;    //Country signal is red
	         end
	 `S2: begin
	           {HG, HY, HR} = 3'b001;   //Highway signal is red
	           {FG, FY, FR}   = 3'b100;   //Country signal is green
	         end
	 `S3: begin
	          {HG, HY, HR} = 3'b001;   //Highway signal is red
	          {FG, FY, FR}   = 3'b010;   //Country signal is yellow
	         end
           endcase
   end
endmodule
```

## 状态机设计准则

状态机要安全，是指FSM不会进入死循环，特别是不会进入非预知的状态，而且由于某些扰动进入非设计状态，也能很快的恢复到正常的状态循环中来。这里面有两层含意：

其一要求该FSM的综合实现结果无毛刺等异常扰动；

其二要求FSM要完备，即使受到异常扰动进入非设计状态，也能很快恢复到正常状态。

状态机的设计要满足设计的面积和速度的要求;

状态机的设计要清晰易懂、易维护. 

## FSM输出方法

ONE HOT编码

使用N位状态寄存器表达具有Ng 状态的FSM，每个状态具有独立的寄存器位。任意时刻只有1位寄存器为1，即hot point。此为one hot。

One hot 编码方程用简单的次态方程驱动，减少了状态寄存器之间的组合逻辑级数，因此提高了运行速度。同时是以牺牲寄存器逻辑资源和提高成本为代价的。

目标器件具有较多寄存器资源，寄存器之间组合逻辑较少时比较适用。

## 有限状态机HDL描述规则

单独用一个模块来描述一个有限状态机。这样易于简化状态的定义、调试和修改；同时，也可使用EDA工具来进行综合与优化。

使用代表状态名的参数（parameter）来给状态赋值，不使用宏定义（define)。宏定义产生全局定义，参数则仅仅定义一个模块内的局部定义常量。不宜产生冲突。

在always组合块中使用阻塞赋值，在always时序块中使用非阻塞赋值。

## 可靠性与容错性

状态机应该有一个默认（default）状态，当转移条件不满足，或者状态发生了突变时，要能保证逻辑不会陷入“死循环” ；

状态机剩余状态的设置（3个去向）：

a) 转入空闲状态，等待下一个工作任务的到来；

b) 转入指定的状态，去执行特定任务；

c) 转入预定义的专门处理错误的状态，如预警状态。



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月

[返回首页](https://github.com/timerring/hardware-tutorial)