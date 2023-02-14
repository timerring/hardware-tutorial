# 简单数据搬移

## 一、实验目的

熟悉实验开发环境，掌握简单ARM汇编指令的使用方法。

## 二、实验环境

硬件：PC机

软件：ADS1.2 集成开发环境

## 三、实验内容

熟悉开发环境并使用LDR/STR，MOV等指令访问寄存器或存储单元； 

使用ADD/SUB/LSL/LSR/AND/ORR等指令，完成基本数学/逻辑运算。

## 四、实验要求

（1）按照2.3节介绍的方法, 在ADS下创建一个工程asmlab1，定义两个变量x,y和堆栈地址0x1000，将变量x的内容存到堆栈顶，然后计算x+y,并将和存到堆栈的下一个单元。通过AXD查看寄存器和memory和寄存器中数据变化。

（2）在指令后面加上适当注释,说明指令功能。

（3）指出程序执行完成后各相关寄存器及存储器单元的具体内容。

## 五、实验完成情况

1、实验源代码（含注释）：

```assembly
AREA Init,CODE,READONLY  ;伪指令AREA定义名为Init,属性为只读或的代码片段
  ENTRY  ;伪指令ENTRY声明程序入口
  CODE32 ;声明以下代码为 32 位 ARM 指令
x EQU 45
y EQU 64 ;定义两个变量 x,y
stack_top EQU 0x1000 ;定义堆栈地址 0x1000
start MOV SP, #stack_top  ;设置栈顶地址
      MOV R0, #x  ;把x的值赋给R0
      STR R0, [SP]  ;R0中的内容入栈
MOV R0, #y  ;把y的值赋给R0
LDR R1, [SP]  ; 数据出栈，放入R1，即R1中放x的值
      ADD R0, R0, R1  ;R0=R0+R1
      STR R0, [SP,#4] ;先执行SP+4(ARM为32位指令集)，再将R0内容复制到SP指向的寄存器
      B .
END  ;程序结束
```

2、实验过程（含结果截图及相应文字解释）：

根据代码可知，

1.首先执行start MOV SP, #stack_top 通过该语句设置了栈顶地址为0x1000。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145117856.png)

2.然后执行MOV R0, #x，把x的值赋值给了R0寄存器，此时R0寄存器的值变成45，由于是十六进制存储的，因此显示为2D。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145129493.png)

3.然后执行STR R0, [SP]，将R0的值入栈，由于前面已经设置了栈顶地址为0x1000，因此可以查看到内存地址0x100处的数据变成了2D。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145826048.png)

4.然后执行MOV R0, #y，把y的值赋值给了R0寄存器，此时R0寄存器的值变成64，由于是十六进制存储的，因此显示为40。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145152762.png)

5.然后执行LDR R1, [SP]，该数据出栈，将数据赋值给R1，此时R1中保存的值为2D。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145201302.png)

6.然后执行ADD R0, R0, R1，其含义相当于R0=R0+R1，因此R0寄存器的值为2D+40 = 6D。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145210393.png)

7.最后执行STR R0, [SP, #4]，先执行SP+4，将指针进行偏移，再将R0的值复制到此时SP指向的地址0x1004，该数据赋值为6D。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145219696.png)

最后程序执行完成后各相关寄存器及存储器单元的具体内容如下：

寄存器：  

+ R0内容为0x6D，
+ R1内容为0x2D，
+ SP内容为0x1000，

存储器单元:

+ 0x1000内容为0x2D，
+ 0x1004内容为0x6D。

练习题

编写程序实现对一段数据的最大值最小值搜索,最大值存于max变量之中,最小值存于min变量之中。

提示: 数据的定义采用伪指令:DCD来实现,如:

```assembly
DataBuf DCD 11,-2,35,47,96,63,128,-23
```

搜索最大值和最小值可以利用两个寄存器R1，R2来存放。用到的比较指令为CMP,用到的条件标识符小于为LT,大于为GT。

基本思路为：利用R0做基地址，将R1，R2分别存入第一个单元的内容，利用R3做循环计数器，利用R4遍历读取第2至最后一个数据，如果R1的数据小于新读入的R4数据则将R4的内容存入R1， 如果R2的内容大于R4的内容则将R4的内容存入R2。遍历完成之后，R1将存放最大数据，R2将存放最小数据。

```assembly
 AREA comp,CODE,READONLY ;定义CODE片段comp 只读
 ENTRY           ;进入程序
 CODE32          ;以下为32位的ARM程序
START         
  LDR R0, = DAT      ;加载数据段中DAT的数据的地址到R0
  LDR R1, [R0]       ;加载R0的内容到R1
  LDR R2, [R0]       ;加载R0的内容到R1
  MOV R3,#1        ;设置循环变量R3并初始化为1
LOOP
  ADD R0,R0,#4       ;每次循环R0+4
  LDR R4,[R0]      ;R4存入R0的数据
  CMP R1,R4        ;比较R1,R4
  MOVLT R1,R4      ;如果R1<R4 就把R4存入R1
  CMP R2,R4        ;比较R2，R4
  MOVGT R2,R4      ;如果R2>R4 就把R4存入R2
  ADD R3,R3,#1       ;每次循环R3值加一
  CMP R3,#8        ;判断R3与8
  BLT LOOP         ;如果R3 < 8则跳转到LOOP执行
 B .           ;退出
 AREA D,DATA,READONLY  ;定义一个数据段D，读写
DAT DCD 11,-2,35,47,96,63,128,-23
 END
```

实验结果如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230214145928589.png)

程序的基本思路是将DataBuf的首地址装载到R0中，再通过首地址将第一个数据装载到R1和R2中，设定R3为循环变量，并且初始化为1。然后进入循环，通过循环比较，将比较过程中得到的最大值放在R1中，最小值放在R2中，每一次循环R3中的值加1，当R3=8时，比较循环结束。



[返回首页](https://github.com/timerring/hardware-tutorial)
