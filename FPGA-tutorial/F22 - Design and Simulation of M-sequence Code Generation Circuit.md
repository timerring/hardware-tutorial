- [m序列码产生电路设计与仿真](#m序列码产生电路设计与仿真)


# m序列码产生电路设计与仿真

m 序列又叫做伪随机序列、伪噪声(pseudo noise，PN)码或伪随机码，是一种可以预先确定并可以重复地产生和复制、又具有随机统计特性的二进制码序列。

伪随机序列一般用二进制表示，每个码元（即构成m序列的元素）只有“0”或“1”两种取值，分别与数字电路中的低电平或高电平相对应。

m 序列是对最长线性反馈移位寄存器序列的简称，它是一种由带线性反馈的移位寄存器所产生的序列，并且具有最长周期。

图所示是一种3位m序列产生器，它将1,3两级触发器的输出通过同或门反馈到第一级的输入端。

其工作原理是：在清零后，3个触发器的输出均为0，于是同或门的输出为1，在时钟触发下，每次移位后各级寄存器状态都会发生变化。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202161913637.png)

分析该电路得到如图所示的仿真波形图，其中任何一级触发器（通常为末级）的输出都是一个周期序列（或者称为m序列），但各个输出端的m序列的初始相位不同。m序列的周期不仅与移位寄存器的级数有关，而且与线性反馈逻辑和初始状态有关。

此外，在相同级数的情况下，采用不同的线性反馈逻辑所得到的周期长度是不同的。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162041331.png)

该电路的状态转换图如图所示。

共有$2^3-1=7$个状态

![三位m序列状态转换图](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162154243.png)

通常，将类似于图所示结构的m序列产生器称为简单型码序列发生器（Simple Shift Register Generator，SSRG），它的一般结构如下图所示。

图中，各个触发器ai（i=1,2，…r）构成移位寄存器，代表异或运算，C0、C1、C2、……、Cr是反馈系数，也是特征多项式的系数。系数取值为1表示反馈支路连通，0表示反馈支路断开。

![SSRG电路的结构](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162306442.png)

对于SSRG结构的m序列发生器，其特征多项式的一般表达式为
$$
f(x)=C_{0} x^{0}+C_{1} x^{1}+C_{2} x^{2}+\cdots+C_{r} x^{r}
$$
特征多项式系数决定了一个m序列的特征多项式，同时也就决定了一个m序列。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162400516.png)

下表给出了部分m序列的反馈系数，系数的值是用八进制数表示的。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162430114.png)

根据多项式的系数可以产生m序列。

例如，想要产生一个码长为31的m序列，寄存器的级数r = 5，从表中查到反馈系数有三个，分别为45、67、75，可以从中选择反馈系数45来构成m序列产生器，因为使用45时，反馈线最少，构成的电路最简单。

45为八进制数，写成二进制数为100101，这就是特征多项式的系数，即 C5 C4 C3 C2 C1 C0=100101

表明C5、C2、C0三条反馈支路是连通的，另外三条反馈支路C4、C3、C1是断开的，其电路如图所示。

![五位 m 序列产生器](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162529793.png)

Verilog HDL程序如下：

```verilog
module m5(CLK, CLRN, OUT);
    input CLK, CLRN;   //输入端口
    output OUT;        //输出端口
    reg[4:0] Q;        //中间节点
    wire C0;
assign C0 = ~(Q[4] ^ Q[1]);  //反馈
assign OUT = Q[4];           //输出信号
always@(posedge CLK or negedge CLRN)
begin
    if(!CLRN )
         Q[4:0] <= 5'b00000;    //异步清零
    else
         Q[4:0] <= {Q[3:0],C0}; //移位
end
endmodule
```

仿真波形（m序列长度为31）：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162601823.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230202162605747.png)

参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)