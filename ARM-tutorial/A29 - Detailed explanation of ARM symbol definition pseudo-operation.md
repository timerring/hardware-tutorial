- [ARM符号定义伪操作详解](#arm符号定义伪操作详解)
  - [ARM汇编语言的伪操作、宏指令与伪指令](#arm汇编语言的伪操作宏指令与伪指令)
  - [两种编译模式的集成开发环境IDE介绍](#两种编译模式的集成开发环境ide介绍)
    - [ADS/SDT IDE开发环境](#adssdt-ide开发环境)
    - [集成了GNU开发工具的IDE开发环境](#集成了gnu开发工具的ide开发环境)
  - [ADS编译环境下的ARM伪操作和宏指令](#ads编译环境下的arm伪操作和宏指令)
  - [符号定义伪操作](#符号定义伪操作)
    - [GBLA，GBLL及GBLS](#gblagbll及gbls)
      - [语法格式](#语法格式)
      - [使用示例](#使用示例)
    - [LCLA，LCLL及LCLS](#lclalcll及lcls)
      - [语法格式](#语法格式-1)
      - [使用示例](#使用示例-1)
    - [SETA，SETL及SETS](#setasetl及sets)
      - [语法格式](#语法格式-2)
    - [寄存器列表定义伪指令RLIST](#寄存器列表定义伪指令rlist)


# ARM符号定义伪操作详解

## ARM汇编语言的伪操作、宏指令与伪指令

ARM汇编语言源程序中语句一般由指令、伪操作、宏指令和伪指令组成
伪操作是ARM汇编语言程序里的一些特殊指令助记符，它的作用主要是为完成汇编程序做各种准备工作，在源程序进行汇编时由汇编程序处理，而不是在计算机运行期间由机器执行。

宏指令是一段独立的程序代码，可以插在源程序中，它通过伪操作来定义。宏在被使用之前必须提前定义好，宏之间可以互相调用，也可以自己递归调用。通过直接书写宏名来使用宏，并根据宏指令的格式设置相应的输入参数。宏定义本身不会产生代码，只是在调用它时把宏体插入到源程序中。

伪指令也是ARM汇编语言程序里的特殊指令助记符，也不在处理器运行期间由机器执行，它们在汇编时将被合适的机器指令代替成ARM或Thumb指令,从而实现真正指令操作。

## 两种编译模式的集成开发环境IDE介绍

### ADS/SDT IDE开发环境

它由ARM公司开发，使用了CodeWarrior公司的编译器；

### 集成了GNU开发工具的IDE开发环境

它由GNU的汇编器as、交叉编译器gcc、和链接器ld等组成。

## ADS编译环境下的ARM伪操作和宏指令

ADS编译环境下的伪操作有如下几种：

+ 符号定义（Symbol Definition）伪操作
+ 数据定义（Data Definition）伪操作
+ 汇编控制（Assembly Control）伪操作
+ 框架描述（Frame Description）伪操作
+ 信息报告（Reporting）伪操作
+ 其他（Miscellaneous）伪操作 

## 符号定义伪操作

1.  全局变量定义伪指令GBLA、GBLL、GBLS
2.  局部变量定义伪指令LCLA、LCLL、LCLS
3.  变量赋值伪指令SETA、SETL、SETS
4.  寄存器列表定义伪指令RLIST

### GBLA，GBLL及GBLS

GBLA，GBLL及GBLS伪操作用于声明一个ARM程序中的全局变量并在默认情况下将其初始化。

GBLA伪操作声明一个全局的算术变量，并将其初始化成0

GBLL伪操作声明一个全局的逻辑变量，并将其初始化成{FALSE}

GBLS伪操作声明一个全局的字符串变量，并将其初始化成空串“”

#### 语法格式

```assembly
<GBLX>  Variable
```

​     其中：
`<GBLX>`是GBLA，GBLL或GBLS  3种伪操作之一；Variable是全局变量的名称。在其作用范围内必须惟一，即同一个变量名只能在作用范围内出现一次。

#### 使用示例

```assembly
GBLA  A1  ;定义一个全局的数值变量，变量名为A1
 A1    SETA  0x0F ;将该变量赋值为0x0F
            
GBLL  A2   ;定义一个全局的逻辑变量，变量名为A2
 A2    SETL  {TRUE} ;将该变量赋值为真
        
GBLS  A3 ;定义一个全局的字符串变量，变量名为A3
 A3    SETS “Testing”  ;将该变量赋值为“Testing”
```

### LCLA，LCLL及LCLS

LCLA，LCLL及LCLS伪操作用于声明一个ARM程序中的局部变量，并在默认情况下将其初始化。

LCLA伪操作声明一个局部的算术变量，并将其初始化成0。

LCLL伪操作声明一个局部的逻辑变量，并将其初始化成{FALSE}

LCLS伪操作声明一个局部的串变量，并将其初始化成空串“”

#### 语法格式

```assembly
<LCLX>  Variable
```

其中：

`<LCLX>`是LCLA，LCLL或LCLS 3种伪操作之一；Variable是局部变量的名称。在其作用范围内必须唯一，即同一个变量名只能在作用范围内出现一次。

#### 使用示例

```assembly
  LCLA   Test4 ;声明一个局部的数值变量，变量名为Test4
  Test4  SETA  0xaa  ;将该变量赋值为0xaa

  LCLL   Test5     ;声明一个局部的逻辑变量，变量名为Test5
  Test5  SETL {TRUE} ;将该变量赋值为真

  LCLS   Test6  ;定义一个局部的字符串变量，变量名为Test6
  Test6  SETS  “Testing” ;将该变量赋值为“Testing”
```

### SETA，SETL及SETS

SETA，SETL及SETS伪操作用于给一个ARM程序中的全局或局部变量赋值。

SETA伪操作给一个全局或局部算术变量赋值

SETL伪操作给一个全局或局部逻辑变量赋值

SETS伪操作给一个全局或局部字符串变量赋值

#### 语法格式

```assembly
<SETX>  Variable  expr
```

其中：

`<SETX>`是SETA，SETL或SETS 3种伪操作之一；Variable是使用GBLA，GBLL，GBLS，LCLA，LCLL或LCLS定义的变量的名称，在其作用范围内必须唯一；expr为表达式，即赋予变量的值。

### 寄存器列表定义伪指令RLIST

格式：名称	RLIST  {通用寄存器列表}

功能：用于对一个通用寄存器列表定义名称，

```assembly
 reglist RLIST {R0-R3, R8, R12}
		…
	STMFD	SP!, reglist			
; 将列表reglist存储到堆栈中
		…
	LDMIA	R4, reglist			
; 将列表reglist加载到R4中
```



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)