- [Verilog HDL仿真常用命令](#verilog-hdl仿真常用命令)
  - [系统任务（System Tasks）](#系统任务system-tasks)
    - [1．显示任务（Display Task）](#1显示任务display-task)
    - [2.\$monitor任务的参数格式与$display的相同.](#2monitor任务的参数格式与display的相同)
    - [3.仿真的中止 (Stopping) 和 完成(Finishing)任务](#3仿真的中止-stopping-和-完成finishing任务)
  - [编译指令(Compiler Directives)](#编译指令compiler-directives)
    - [时间尺度\`timescale](#时间尺度timescale)
    - [宏定义\`define](#宏定义define)
    - [文件包含指令\`include](#文件包含指令include)


# Verilog HDL仿真常用命令 

## 系统任务（System Tasks） 

### 1．显示任务（Display Task）

\$display是Verilog中最有用的任务之一，用于将指定信息（被引用的字符串、变量值或者表达式）以及结束符显示到标准输出设备上。其格式如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230127101107463.png)

### 2.\$monitor任务的参数格式与\$display的相同. 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230127101159207.png)

### 3.仿真的中止 (Stopping) 和 完成(Finishing)任务

+ \$stop；//在仿真期间，停止执行，未退出仿真环境。
+ \$finish；//仿真完成，退出仿真环境，并将控制权返回给操作系统。
+ 系统任务\$stop使得仿真进入交互模式，然后设计者可以进行调试。当设计者希望检查信号的值时，就可以使用\$stop使仿真器被挂起。然后可以发送交互命令给仿真器继续仿真。 

## 编译指令(Compiler Directives)

以 `（反撇号）开头的标识符就是编译指令，用来控制代码的整个过程。在Verilog代码编译的整个过程中，编译指令始终有效（编译过程可能跨越多个文件），直至遇到其他不同的编译指令为止。  

```verilog
`timescale  time_unit/time_precision
`include  " ../../header.v "
`define  WORD_SIZE  32      //定义文本宏 
`undef
`ifdef	
`ifndef	  
`else	  
`elseif   
`endif
```

### 时间尺度`timescale

\`timescale命令用于在文件中指明时间单位和时间精度，通常在对文件进行仿真时体现。EDA工具可以支持在一个设计中可根据仿真需要在不同模块里面指定不同的时间单位。如模块A仿真的时间单位为皮秒（ps），模块B仿真的时间单位为纳秒（ns）。

使用\`timescale命令语句格式如下：

+ \`timescale  <时间单位> / <时间精度>
+ 使用时注意: <时间单位>和<时间精度>必须是整数，且时间精度不能大于时间单位值。
+ 例如：\`timescale 1ns / 1ns

时间单位是定义仿真时间和延迟时间的基准单位；时间精度是定义模块仿真时间的精确程度的，又被称为取整精度（在仿真前，被用来对延迟的时间值进行取整操作）。如果在同一个设计中，出现多个\`timescale命令，工具会采用最小的时间精度值来决定仿真的时间单位。

\`timescale 1ns / 1ps：此命令已定义模块中的时间单位为1ns，即仿真模块中所有的延迟时间单位都是1ns的整数倍；定义了模块的时间精度为1ps，即仿真模块中延迟单位可以指定到小数点后3位，小数超过3位会进行取小数点后3位的操作。

### 宏定义\`define

在设计中，为了提高程序可读性和简化程序描述，可以使用指定的标识符来代替一个长的字符串，或者使用一个简单的名字来代替没有含义的数字或者符号，此时需使用到宏定义命令\`define。

使用\`define命令格式如下：

+ \`define  signal（宏名） string（宏内容）
+ 在设计中进行了以上声明后，在预编译处理时，在此命令后程序中所有的signal都替换成string，此过程称为“宏展开”。

```verilog
//例1 ：
`define LENGTH 16
  reg [ `LENGTH–1 : 0 ]   writedata;  
  //即定义reg[15:0] writedata;
//例2 ：
`define  expression  a+b+c
  assign data = `expression + d ; //经宏展开之后
                                   //assign  data = a+b+c+d;
//例3 ：
`define A  a+b
`define B  c+`A
 assign  data = `B ;   // 即data = c + a + b;
```

### 文件包含指令\`include

和C语言中声明头文件很类似。其一般形式为：

``include  “文件名”`

例：文件para.v中有一个宏定义 \`define  A   2+3, 在test.v文件中可以直接调用。

```verilog
`timescale 1ns/1ps
`include  "para.v"
`module test(    
	   input wire       clk,      
	output reg [7:0] result   
                    );  
   always@(posedge clk)
      begin      
	result <= `A + 10;    
      end
endmodule
```

关于文件包含的几点说明：

+ 一个\`include只能指定一个包含文件；
+ \`include中的文件名可以是相对路径，也可以是绝对路径（ISE中调用Modelsim仿真的时候得用绝对路径，否则Modelsim会报错）；
+ 如果文件1包含文件2，而文件2要用到文件3的内容，那么在文

 例：para.v 中 ：  \`define  A  2+3    para2.v 中：  \`define  B  \`A+2    test.v中：

```verilog
`timescale 1ns/1ps
`include  " para.v"
`include  " para2.v"
module test(     
	  input  wire        clk,       
	output  reg [7:0] result   
	              );  
    always@(posedge  clk)    
      begin      
	result <= `B+ 10;    
      end
endmodule
```



参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)
