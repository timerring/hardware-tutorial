# FPGA：Verilog HDL程序的基本结构

## 简单Verilog HDL程序实例

Verilog使用大约100个预定义的关键词定义该语言的结构

1. Verilog HDL程序由模块构成。每个模块的内容都是嵌在两个关键词module和endmodule之间。每个模块实现特定的功能。

2. 每个模块先要进行端口的定义，并说明输入（input) 、输出（output) 和双向（inout)，然后对模块功能进行描述。

3. 除了endmodule外，每个语句后必须有英文的分号(;)。

4. 可以用/* --- */和//…..，对Verilog HDL程序的任何部分做注释。

### 半加器程序实例

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230125094944033.png)

```verilog
/* Gate-level description of a half adder */
module HalfAdder_GL(A, B, Sum, Carry);
  input  A ,B ;		//输入端口声明
  output  Sum, Carry ;      //输出端口声明
  wire A ,B , Sum ,Carry ; 
  
  xor X1 (Sum, A, B );
  and A1 (Carry, A, B);  
endmodule
```

```verilog
/* Dataflow description of a half adder */
module HalfAdder_DF(A, B, Sum, Carry);
  input  A ,B ;	 	 
  output  Sum ,Carry ; 
  wire A ,B，Sum ,Carry ; 
  assign   Sum = A ^ B; 
  assign   Carry = A & B; 
endmodule
```

```verilog
/* Behavioral description of a half adder */
module HalfAdder_BH(A, B, Sum, Carry);
  input  A ,B ;	 	  
  output  Sum ,Carry ; 
  reg Sum ,Carry ;        //声明端口数据类型为寄存器
  always @(A or B)  begin
	Sum = A ^ B;	      //用过程赋值语句描述逻辑功能
	Carry = A & B;
  end
endmodule
```

### 2选1数据选择器的程序实例

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230125095030979.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230125095104680.png)

```verilog
module mux2to1(a, b, sel, out);
  input a, b, sel;   //定义输入信号
  output out;        //定义输出信号
  wire selnot,a1,b1; //定义内部节点信号数据类型
 //下面对电路的逻辑功能进行描述
  not U1(selnot, sel);
  and U2(a1, a, selnot);
  and U3(b1, b, sel);
  or  U4(out, a1, b1); 
endmodule
```

```verilog

module mux2_1(out, a, b, sel) ;
    output   out;
    input  a, b;
    input sel;
     reg out;

    always @(sel or a or b)
       begin
          if (sel) 
                      out = b;
          else     out = a;
       end
endmodule
```

行为描述：

```verilog
module mux2_1(out, a, b, sel) ;
    output   out;
    input  a, b;
    input sel;
    reg out;
    always @(sel or a or b)
       begin
          case (sel)
              1’b0 :  out = a;
              1’b1 :  out = b;
          endcase
       end
endmodule
```



## Verilog HDL程序的基本结构

模块定义的一般语法结构如下：

```verilog
module模块名(端口名1，端口名2，端口名3,…) ;
	端口类型说明(input, output, inout);
	参数定义(可选);
	数据类型定义(wire, reg等);

	实例化低层模块和基本门级元件;
	连续赋值语句(assign);
	过程块结构(initial和always)
		行为描述语句;
endmodule
```

几种描述方式小结：

结构描述（门级描述）方式：

一般使用Primitive（内部元件）、自定义的下层模块对电路描述。主要用于层次化设计中。

数据流描述方式：

一般使用assign语句描述，主要用于对组合逻辑电路建模。

行为描述方式：

一般使用下述语句描述，可以对组合、时序逻辑电路建模。

+ initial 语句
+ always 语句