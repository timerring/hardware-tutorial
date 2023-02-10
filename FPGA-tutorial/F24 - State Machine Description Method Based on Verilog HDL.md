- [基于Verilog HDL的状态机描述方法](#基于verilog-hdl的状态机描述方法)
  - [状态图的建立过程](#状态图的建立过程)
  - [状态图描述方法](#状态图描述方法)
    - [单个always块描述状态机的方法（尽量避免）](#单个always块描述状态机的方法尽量避免)
    - [两个always块描述状态机的方法（推荐写法！）](#两个always块描述状态机的方法推荐写法)
    - [使用三个always块分别描述](#使用三个always块分别描述)
    - [三种描述方法比较](#三种描述方法比较)


# 基于Verilog HDL的状态机描述方法

## 状态图的建立过程

设计一个序列检测器电路。功能是检测出串行输入数据Sin中的4位二进制序列0101（自左至右输入），当检测到该序列时，输出Out=1；没有检测到该序列时，输出Out=0。（注意考虑序列重叠的可能性，如010101，相当于出现两个0101序列）。

解：首先，确定采用米利型状态机设计该电路。因为该电路在连续收到信号0101时，输出为1，其他情况下输出为0，所以采用米利型状态机。

其次，确定状态机的状态图。根据设计要求，该电路至少应有四个状态，分别用S1、S2、S3、S4表示。若假设电路的初始状态用S0表示，则可用五个状态来描述该电路。根据分析，可以画出图(a)所示的原始状态图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209094448632.png)

观察该图可以看出，S2、S4为等价状态，可用S2代替S4，于是得到简化状态图。

然后，根据上面的状态图给出该状态机的输出逻辑。该状态机只有一个输出变量Out，其输出逻辑非常简单，直接标注在状态图中了。若输出变量较多，则可以列出输出逻辑真值表。

最后，就可以使用硬件描述语言对状态图进行描述了。

## 状态图描述方法

利用Verilog HDL语言描述状态图主要包含四部分内容：

1. 利用参数定义语句parameter描述状态机中各个状态的名称，并指定状态编码。例如，对序列检测器的状态分配可以使用最简单的自然二进制码，其描述如下：

   ```verilog
   parameter  S0=2'b00, S1=2'b01, S2 = 2'b10, S3 = 2'b11;
   ```

   或者，

   ```verilog
   parameter [1:0] S0=2'b00, S1=2'b01, S2 = 2'b10, S3 = 2'b11;
   ```

2.  用时序的always 块描述状态触发器实现的状态存储。
3. 使用敏感表和case语句(也可以采用if-else等价语句)描述的状态转换逻辑。
4. 描述状态机的输出逻辑。

描述状态图的方法多种多样，下面介绍几种：

### 单个always块描述状态机的方法（尽量避免）

用一个always块对该例的状态机进行描述，其代码如下：

```verilog
module Detector1 ( Sin, CP, nCR, Out) ;
	input Sin, CP, nCR;    //声明输入变量
	output Out ;                //声明输出变量
	reg Out; 
	reg [1:0] state;  
// 声明两个状态触发器变量state[1]和state[0]，记忆电路现态
//The state labels and their assignments
parameter [1:0] S0=2'b00, S1=2'b01, S2 = 2'b10, S3 = 2'b11;
always @(posedge CP or negedge nCR)   
begin
if (~nCR)
state <= S0;  //在nCR跳变为0时，异步清零
else
           case(state) 
	  S0: begin Out =1’b0; state <= (Sin==1)? S0 : S1; end
	  S1: begin Out = 1’b0; state <= (Sin==1)? S2 : S1; end
	  S2: begin Out = 1’b0; state <= (Sin==1)? S0 : S3; end	  
      S3: if (Sin==1)  begin Out =1’b1; state <=  S2; end
	        else               
		   begin Out =1’b0; state <= S1; end               	
	endcase
end
endmodule
```

严格地说，对序列检测器电路用单个always块的描述方法所描述的逻辑存在着一个隐含的错误，即输出信号Out的描述。

case语句中对输出向量的赋值应是下一个状态输出，这点易出错；状态向量与输出向量都由寄存器实现，面积大，不能实现异步米勒状态机。因此，单个always块描述状态机的写法仅仅适用于穆尔型状态机。单个always块写法的电路结构框图可以用下图进行概括。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209094750807.png)

### 两个always块描述状态机的方法（推荐写法！）

用两个always块对该例的状态机进行描述，其代码如下：

```verilog
module  Detector2 ( Sin, CP, nCR, Out) ;
input Sin, CP, nCR;    //定义输入变量
output Out ;                //定义输出变量
reg Out; 
reg [1:0] Current_state, Next_state;
parameter [1:0] S0=2'b00, S1=2'b01, S2 = 2'b10, S3 = 2'b11;
//状态转换，时序逻辑
  always @(posedge CP or negedge nCR ) 
begin
if (~nCR)
	Current_state <= S0;   //异步清零
else
     Current_state <= Next_state; 
     //在CP上升沿触发器状态翻转
   end

//下一状态产生和输出信号，组合逻辑
always @( Current_state or Sin) 
   begin	
     Next_state =2’bxx;                                                                                                                                                                                                                      
     Out=1’b 0;
   case(Current_state )
     S0: begin Out =1’b0; Next_state = (Sin==1)? S0 : S1; end
     S1: begin Out =1’b0; Next_state = (Sin==1)? S2 : S1; end
     S2: begin Out =1’b0; Next_state = (Sin==1)? S0 : S3; end	 
     S3: if (Sin==1)
	    	begin Out =1’b1; Next_state = S2; end
        else
			begin Out =1’b0; Next_state = S1; end	  
    endcase
  end	

endmodule
```

用两个always块描述状态机的写法是值得推荐的方法之一，两个always块写法的电路结构框图可以用下图进行概括。

两个always块写法的电路结构框图概括。

第一个always模块采用同步时序逻辑方式描述状态转移（中间方框）; 第二个always模块采用组合逻辑方式描述状态转移规律（第一个方框）和描述电路的输出信号（第三个方框）。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209094925478.png)

### 使用三个always块分别描述

即第一个always模块采用同步时序逻辑方式描述状态转移（中间方框）; 第二个always模块采用组合逻辑方式描述状态转移规律（第一个方框）; 第三个always模块描述电路的输出信号，**在时序允许的情况下，通常让输出信号经过一个寄存器再输出，保证输出信号中没有毛刺。**

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230209094947190.png)

用三个always块对该例的状态机进行描述，其代码如下：

```verilog
module  Detector3 ( Sin, CP, nCR, Out) ;
	input Sin, CP, nCR;    //定义输入变量
	output Out ;                //定义输出变量
	reg Out; 
	reg [1:0] Current_state, Next_state;
     parameter [1:0] S0=2'b00, S1=2'b01, S2 = 2'b10, S3 = 2'b11;
//状态转换，时序逻辑
always @(posedge CP or negedge nCR )
  begin
     if (~nCR)
       Current_state <= S0;                 //异步清零
     else
       Current_state <=  Next_state; //在CP上升沿触发器状态翻转
  end 
 //下一状态产生，组合逻辑
always @( Current_state or Sin) 
  begin	
       Next_state =2’bxx;                                                                                                                                                                                                                      
       case(Current_state )
     	S0: begin Next_state = (Sin==1)? S0 : S1; end
    	 S1: begin Next_state = (Sin==1)? S2 : S1; end
    	 S2: begin Next_state = (Sin==1)? S0 : S3; end	 
    	 S3: if (Sin==1)
	    		begin Next_state = S2; end
                    else
			begin Next_state = S1; end	  
       endcase
  end	
 /* 输出逻辑: 让输出信号经过一个寄存器再输出，可以消除Out信号中的毛刺，时序逻辑*/
always @ (posedge CP or negedge nCR )
    begin
	if (~nCR)    Out <= 1’b 0;
              else 
                      begin 
    	           case(Current_state )
	      	 S0, S1, S2:          Out <= 1’b0;	 
                              S3:               if (Sin==1)  
                                            	 Out <= 1’b1; 
		                      else             
                                                           Out <= 1’b0; 
         	            endcase
        	        end	
    end	
endmodule
```

### 三种描述方法比较

|                      | **1-always**     | **2-always**     | **3-always**   |
| -------------------- | ---------------- | ---------------- | -------------- |
| **结构化设计**       | **否**           | **是**           | **是**         |
| **代码编写/理解**    | **不宜，理解难** | **宜**           | **宜**         |
| **输出信号**         | **寄存器输出**   | **组合逻辑输出** | **寄存器输出** |
|                      | **不产生毛刺**   | **产生毛刺**     | **不产生毛刺** |
| **面积消耗**         | **大**           | **最小**         | **小**         |
| **时序约束**         | **不利**         | **有利**         | **有利**       |
| **可靠性、可维护性** | **低**           | **较高**         | **最高**       |
| **后端物理设计**     | **不利**         | **有利**         | **有利**       |

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月

[返回首页](https://github.com/timerring/hardware-tutorial)