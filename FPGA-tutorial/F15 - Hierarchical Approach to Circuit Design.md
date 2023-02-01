- [分层次的电路设计方法](#分层次的电路设计方法)
  - [设计方法](#设计方法)
    - [全加器电路设计举例](#全加器电路设计举例)
      - [一位半加器的描述](#一位半加器的描述)
      - [一位全加器的描述](#一位全加器的描述)
      - [四位全加器的描述](#四位全加器的描述)
  - [模块实例引用语句](#模块实例引用语句)


# 分层次的电路设计方法

## 设计方法

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230130103739077.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230130103747281.png)

使用自下而上的方法（bottom-up） ： 

+ 实例引用基本门级元件xor、and定义底层的半加器模块halfadder；
+ 实例引用两个半加器模块halfadder和一个基本或门元件or组合成为1位全加器模块fulladder；
+ 实例引用4个1位的全加器模块fulladder构成4位全加器的顶层模块。 

### 全加器电路设计举例

#### 一位半加器的描述

```
//************ 一位半加器的描述 ************
module halfadder (S,C,A,B);  //IEEE 1364—1995 Syntax
   input A,B;   //输入端口声明
   output S,C;  //输出端口声明
   xor (S,A,B);  //实例引用逻辑门原语
   and (C,A,B);
endmodule  

```

#### 一位全加器的描述

```
//************ 一位全加器的描述 ************
module fulladder (Sum,Co,A,B,Ci);
   input A,B,Ci;         output Sum,Co;
   wire S1,D1,D2;           //内部节点信号声明
    halfadder HA1 (.B(B),.S(S1),.C(D1),.A(A));          //实例引用底层模块halfadder
    halfadder HA2 (.A(S1),.B(Ci), .S(Sum),.C(D2));  //端口信号按照名称对应关联
    or g1(Co,D2,D1);
endmodule
```

#### 四位全加器的描述

```
//************四位全加器的描述************
module _4bit_adder (S,C3,A,B,C_1);
   input [3:0] A,B;
   input C_1;
   output [3:0] S; 
   output C3;
   wire C0,C1,C2;  //声明模块内部的连接线
   fulladder  U0_FA (S[0],C0,A[0],B[0],C_1); //实例引用模块fulladder
   fulladder  U1_FA (S[1],C1,A[1],B[1],C0);  //端口信号按照位置顺序对应关联
   fulladder  U2_FA (S[2],C2,A[2],B[2],C1); 
   fulladder  U3_FA (S[3],C3,A[3],B[3],C2);
endmodule 
```

## 模块实例引用语句

模块实例引用语句的格式如下：

```
module_name  instance_name（port_associations）；
```

（port_associations）**父、子模块端口的关联方式**：

+ 位置关联法: 父模块与子模块的端口信号是按照位置（端口排列次序）对应关联的

+ 名称关联法:

  ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230130104336295.png)

关于模块引用的几点注意事项：

1. 模块只能以实例引用的方式嵌套在其他模块内，嵌套的层次是没有限制的。但不能在一个模块内部使用关键词module和endmodule去定义另一个模块，也不能以循环方式嵌套模块，即不能在always语句内部引用子模块。

2. 实例引用的子模块可以是一个设计好的Verilog HDL设计文件（即一个设计模块），也可以是FPGA元件库中一个元件或嵌入式元件功能块，或者是用别的HDL语言（如VHDL、AHDL等）设计的元件，还可以是IP（Intellectual Property，知识产权）核模块。

3. 在一条实例引用子模块的语句中，不能一部分端口用位置关联，另一部分端口用名称关联，即不能混合使用这两种方式建立端口之间的连接。 

4. 关于端口连接时有关变量数据类型的一些规定。

   ![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230130104425902.png)





参考文献：

1. Verilog HDL与FPGA数字系统设计，罗杰，机械工业出版社，2015年04月
2. Verilog HDL与CPLD/FPGA项目开发教程(第2版), 聂章龙, 机械工业出版社, 2015年12月
3. Verilog HDL数字设计与综合(第2版), Samir Palnitkar著，夏宇闻等译, 电子工业出版社, 2015年08月
4. Verilog HDL入门(第3版), J. BHASKER 著 夏宇闻甘伟 译, 北京航空航天大学出版社, 2019年03月



[返回首页](https://github.com/timerring/hardware-tutorial)