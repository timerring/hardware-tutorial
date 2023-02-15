# 字符串拷贝

## 一、实验目的

通过实验掌握使用 LDB/STB，b等指令完成较为复杂的存储区访问和程序分支，学习使用条件码

## 二、实验环境

硬件：PC机

软件：ADS1.2 集成开发环境

## 三、实验内容

熟悉开发环境的使用并完成一块存储区的拷贝。

完成分支程序设计，要求判断参数，根据不同参数，调用不同的子程序。

## 四、实验要求

1. 按照2.3节介绍的方法, 在ADS下创建一个工程asmlab2，定义两个数据存储区Src和Dst，Src用于存放原字符串，Dst用于存放目的字符串。堆栈地址0x400，将变量原字符串的内容拷贝到目的字符串中，要能判断原字符串的结束符（0），并统计字符串中字符的个数。通过AXD查看寄存器和memory和寄存器中数据变化。
2. 在指令后面加上适当注释,说明指令功能。
3. 指出程序执行完成后各相关寄存器及存储器单元的具体内容。

## 五、实验完成情况：

1、实验源代码（含注释）：

```assembly
AREA Init,CODE,READONLY ;定义CODE片段Init 只读
 ENTRY                ;进入程序
 CODE32              ;以下为32位的ARM程序
start
  MOV SP, #0x400     ; 设置堆栈地址为0x400
  LDR R0, =Src        ; 先将原字符串地址加载到R0
  LDR R1, =Dst        ; 将目的字符串地址加载到R1
  MOV R3,#0         ; 定义R3中的内容为0
strcopy
  LDRB R2,[R0],#1     ; 将R0的内容读入寄存器R2，并将R0R0+1
  CMP R2,#0         ; 比较R2和0是否相等，主要检测字符串是否结束
  BEQ endcopy       ; 等于0则跳转至endcopy
  STRB R2,[R1],#1     ; 先将R2中的字节数据写入R1中，并把地址R1+1的值存入R1
  ADD R3,R3,#1       ; R3自加一，用于记录字符个数
  B strcopy           ; 循环
endcopy
  LDR R0, =ByteNum   ; 将字符数的地址加载到R0
  STR R3,[R0]         ; 将R3的内容存在R0中
  B .
  AREA Datapool,DATA,READWRITE  ; 定义DATA类型的Datapool
Src  DCB  "string",0  ; 初始化字符串的存储空间
Dst DCB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   ; 目的字符串存储空间
ByteNum DCD 0 ; 初始化字符数
 END
```

2、实验过程（含结果截图及相应文字解释）：

定义两个数据存储区Src和Dst，Src用于存放原字符串，Dst用于存放目的字符串。堆栈地址0x400，将变量原字符串的内容拷贝到目的字符串中，要能判断原字符串的结束符（0），并统计字符串中字符的个数。通过AXD查看寄存器和memory和寄存器中数据变化。

通过存储器可见，内容正在逐渐地进行拷贝。过程如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173113443.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173134446.png)

直到拷贝过程结束，实验结束后存储单元中的内容如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173140994.png)

相关寄存器中的具体内容如下所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173151628.png)

练习题：

编写程序循环对R4～R11 进行累加8 次赋值，R4～R11 起始值为1～8，每次加操作后把 R4～R11 的内容放入SP 栈中，SP 初始设置为0x800。最后把R4～R11清空赋值为0。

提示：多字的加载与存储使用多寄存器寻址，使用的指令为LDM和STM。如：

```assembly
LDMIA R0!, {R4-R11}
STMIA R1!, {R4-R11}
```

编写实验代码如下：

```assembly
  AREA Init,CODE,READONLY ;定义CODE片段Init 只读
 ENTRY    ;进入程序
 CODE32    ;以下为32位的ARM程序
main NOP
NUM EQU 8     ; 定义NUM为8，即一共经过8次循环           
start
 MOV SP,#0X800    ；设置栈顶指针为0X800
 LDR R0,=src            ; 将src的地址加载到R0
 MOV R2,#NUM         ; 将循环次数赋给R2
 MOV R4,#1				 ; 设置寄存器R4的初始值
 MOV R5,#2				; 设置寄存器R5的初始值
 MOV R6,#3				; 设置寄存器R6的初始值
 MOV R7,#4				; 设置寄存器R7的初始值
 MOV R8,#5				; 设置寄存器R8的初始值
 MOV R9,#6				; 设置寄存器R9的初始值
 MOV R10,#7			; 设置寄存器R10的初始值
 MOV R11,#8			; 设置寄存器R11的初始值    
loop
 ADD R4,R4,#1			; 将寄存器的值加一，下同
 ADD R5,R5,#1
 ADD R6,R6,#1
 ADD R7,R7,#1
 ADD R8,R8,#1
 ADD R9,R9,#1
 ADD R10,R10,#1
 ADD R11,R11,#1    
 STMFD SP!,{R4-R11}      ;多寄存器寻址，把R4~R11的内容放入SP栈中
 SUBS R2,R2,#1           ;将R2的内容，即循环次数减一
 BNE loop                ;如果不为0则跳转到loop继续循环    
 LDMIA R0!,{R4-R11}      ;将以R0起始地址的值存入R4-R11，即把R4~R11清空赋值为0.
Stop
 B Stop
 LTORG                   ; 声明数据缓冲池
src DCD 0,0,0,0,0,0,0,0       ; 初始化
 END
```

实验初始时，寄存器中内容如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173253315.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173300701.png)

实验结束后，寄存器中的内容如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230215173326499.png)

[返回首页](https://github.com/timerring/hardware-tutorial)