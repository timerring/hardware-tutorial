- [状态机设计中的关键技术](#状态机设计中的关键技术)
  - [状态编码](#状态编码)
    - [格雷码](#格雷码)
    - [独热码(one-hot编码)](#独热码one-hot编码)
  - [如何消除输出端产生的毛刺](#如何消除输出端产生的毛刺)
    - [1.具有流水线输出的Mealy状态机](#1具有流水线输出的mealy状态机)
    - [2.在状态位里编码输出的Moore状态机](#2在状态位里编码输出的moore状态机)
  - [如何使用One-hot编码方案设计状态机](#如何使用one-hot编码方案设计状态机)


# 状态机设计中的关键技术

## 状态编码

在使用Verilog HDL描述状态机时，通常用参数定义语句parameter指定状态编码。状态编码方案一般有三种：自然二进制编码、格雷(Gray)编码和独热码(one-hot编码)。对应于图所示的状态图的各种编码方案如表所示。

有限状态机的编码方案

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209095432780.png)

状态机编码对状态机速度和面积关系重大

常用编码

+ 二进制码（binary）
+ 格雷码（Gray）
+ 独热码（one-hot）

二进制码与格雷码是压缩状态编码，使用最少的状态位进行编码。

二进制编码的优点是使用的状态向量最少，但从一个状态转换到相邻状态时，可能有多个比特位发生变化，瞬变次数多，易产生毛刺。 

### 格雷码

特点是当前状态改变时，状态向量中仅一位发生变化，因此当系统的状态变化是基于异步的输入信号时，格雷编码能够避免进入错误的状态。

格雷码既可以消除状态转换时多状态信号传输延迟产生的毛刺，又可降低功耗。

### 独热码(one-hot编码) 

N个状态使用N个触发器(FF)

+ 减少了状态寄存器之间的组合逻辑级数，因此提高了运行速度 ；
+ 触发器(FF)数量增加，组合逻辑电路减少；
+ 任何状态都可以直接添加/删除等修改而不会影响状态机的其余部分；
+ 由于译码简单，可提高速度，且易于修改。

独热码(one-hot编码)的特点是：状态数等于触发器(FF)的数目，冗余的触发器带来的好处是译码电路的简单化，因此它的速度非常快，此外由于FPGA器件内部触发器的数量是固定的且比较丰富，所以one-hot编码非常适合于FPGA设计。

独热码的缺点

+ 变化的状态位越多，组合输出稳定前所需的时间就越长，产生的毛刺就越多 ；
+ 多个寄存器可能受异步输入的影响，使得亚稳态发生的概率有所增加 ；

状态机复杂状态跳转的分支很多时，要合理的分配状态编码，保证每个状态跳转都仅有1位发生变化，这是很困难的事情。 

不管使用哪种编码，状态机中的各个状态都应该使用符号常量，而不应该直接使用编码数值，赋予各状态有意义的名字对于设计的验证和代码的可读性都是有益的。

| **编码方法**                   | **面积** | **速度** | **状态数量**       |
| ------------------------------ | -------- | -------- | ------------------ |
| **Binary**  **（顺序二进制）** | **较好** | **较差** | **Log2(state  N)** |
| **One-hot**                    | **较差** | **较好** | **States  Number** |
| **Gray**                       | **较好** | **较差** | **Log2(state  N)** |

## 如何消除输出端产生的毛刺

前面介绍的普通状态机由组合逻辑电路决定电路的输出.当组合逻辑较大时，若状态触发器的值发生变化或者输入信号发生变化，由于各信号在组合逻辑内部经过的路径不一样，就容易在输出端产生毛刺。

下面介绍两种常用消除毛刺的方法：

### 1.具有流水线输出的Mealy状态机

为了消除毛刺，可以在普通Mealy的输出逻辑后加一组输出寄存器，将寄存器的输出值作为输出向量，这种Mealy状态机的等效方框如图所示。

![具有流水线输出的Mealy 状态机](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209095851933.png)

### 2.在状态位里编码输出的Moore状态机

这种方法的指导思想是将状态寄存器和输出向量统一进行编码，即将状态位本身作为输出信号，其等效状态框图如下所示。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209095921348.png)

下面以图所示的状态图说明在状态位里编码输出的方法。图中，状态机共有三个状态：IDLE，START和WAIT，输入信号为：input_1，input_2，input_3，input_4。这些输入信号的不同逻辑组合就构成了状态之间跳转的条件。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209095941652.png)

该状态机需要控制两个输出信号：output_1和output_2。可以采用4bits的状态编码，其中高两位表示当前的状态，末尾两位控制output_1和output_2的输出。IDLE状态编码为4’b0000，START状态编码为4’b0101，WAIT状态编码为 4’b1011。

参考程序如下所示：

```verilog
module  FSM1 (nRST, CP, input_1, input_2, input_3, input_4, output_1, output_2) ;
	input input_1, input_2, input_3, input_4; //定义输入变量
	input nRST, CP;
            output output_1, output_2 ; //定义输出变量
	wire output_1, output_2; 
	reg [ 3 : 0 ] Current_state, Next_state;
	//状态参量的定义，根据前面所述的全译码状态编码
parameter [ 3 : 0 ] IDLE = 4'b0000,  START = 4'b0101, WAIT = 4'b1011;
//The first always block, sequential state transition
always @(posedge CP or negedge nRST) 
    if (!nRST)        //当系统复位时，状态寄存器置为IDLE状态
        Current_state <= IDLE;  //设置初态(IDLE)
    else  //状态寄存器进行状态存储，将下一状态存储到状态寄存器成为当前状态
        Current_state <= Next_state;   
// The second always block, combinational condition judgment
always @(Current_state or input_1 or input_2 or input_3 or input_4)	
  case(Current_state) //根据当前状态和状态转换条件进行译码
     IDLE:
          if(input_1 && input_2)  Next_state = START;
          else  Next_state = IDLE;
     START:
          if(input_3)  Next_state = WAIT;
          else  Next_state = START;  
     WAIT:  
           if(input_4)  Next_state = IDLE;
           else Next_state = WAIT; 
     default:  Next_state = IDLE;
   endcase
//状态机的输出逻辑
assign  output_1 = Current_state[1]; 
assign  output_2 = Current_state[0];
endmodule
```

## 如何使用One-hot编码方案设计状态机

对状态机的各个状态赋予一组特定的二进制数称为状态编码。比较常用的有自然二进制码、格雷码和One-hot编码。自然二进制码和格雷码的编码方案使用的触发器较少，其编码效率较高，但负责根据当前状态和状态转换条件进行译码的组合电路会比较复杂，其逻辑规模也较大，使得次态逻辑在传输过程中需要经过多级逻辑，从而影响电路的工作速度。

One-hot编码方案使用n位状态触发器表示具有n个状态的状态机，每个状态与一个独立的触发器相对应，并且在任何时刻其中只有一个触发器有效（其值为1）。虽然这种方案会使用较多的触发器，但它的编码方式非常简单，可有效地简化组合电路，并换得工作可靠性和工作速度的提高。在大规模可编程逻辑器件如FPGA中，触发器数量较多而门逻辑相对较少，One-hot编码方案有时反而更有利于提高器件资源的利用率。

定义当前状态向量state为一个5-bits向量，末尾的两位表示状态机输出，state[2]为1表示状态IDLE，state[3]为1表示状态START，state[4]为1表示状态WAIT。

下面是基于One-Hot编码方式的状态机实现代码：

```verilog
module  FSM2 (nRST, CP, input_1, input_2, input_3, input_4, output_1, output_2) ;
	input input_1, input_2, input_3, input_4; //定义输入变量
	input nRST, CP;
            output output_1, output_2 ; //定义输出变量
	wire output_1, output_2; 
	reg [ 4 : 0 ] state, Next_state;
    parameter [ 4 : 0 ] IDLE  = 5’b001_00, //状态参量，末尾两位表示对应的输出
         START = 5’b010_01,
         WAIT   = 5’b100_11;
 //状态对应在state中的表示位置,One-hot
parameter [2:0] IDLE_POS    = 3'd2,  // IDLE POSition
                            START_POS = 3'd3,  // START POSition
                            WAIT_POS   = 3'd4;  // WAIT POSition

always @(posedge CP or negedge nRST)     //状态存储
     if (!nRST)  state <= IDLE;
     else             state <= Next_state; 
always @(input_1 or input_2 or input_3 or input_4)//状态转移逻辑
    begin
        Next_state  =  IDLE; //设置初态
        case(1’b1)                   //One-Hot编码实现状态转移时,
           //每次取state的一位与1比较
        state[IDLE_POS]:
               if(input_1 && input_2)
                          Next_state = START;
               else     Next_state = IDLE;
        state[START_POS]:
               if(input_3)
                          Next_state = WAIT;
               else     Next_state = START;  
        state[WAIT_POS]:  
               if(input_4)
                        Next_state = IDLE;
              else    Next_state = WAIT; 
        default:   Next_state = IDLE;
     endcase
end
//状态机的输出逻辑
assign  output_1 = state[1];
assign  output_2 = state[0];
endmodule
```

One-hot编码特点：指定各个状态在状态编码中的表示位，采用参量定义方式指定One-hot状态编码；使用always语句描述状态寄存器的状态存储；使用敏感表和case语句描述状态转换逻辑，在case语句中只采用一位寄存器比较方式；使用assign语句描述状态编码控制的状态机输出。

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)