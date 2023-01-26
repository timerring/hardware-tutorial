- [杂项汇编器伪指令](#杂项汇编器伪指令)
  - [AREA](#area)
  - [ALIGN](#align)
  - [CODE16和CODE32](#code16和code32)
  - [ENTRY](#entry)
  - [END](#end)
  - [EQU](#equ)
  - [EXPORT和GLOBAL](#export和global)
  - [IMPORT](#import)
  - [EXTERN](#extern)
  - [GET和INCLUDE](#get和include)
  - [INCBIN](#incbin)
  - [RN](#rn)
  - [ROUT](#rout)


# 杂项汇编器伪指令

## AREA

格 式：AREA 段名 属性1，属性2，……	

功 能：AREA伪操作用于定义一个代码段、数据段或特定属性的段。
其中，段名若以数值开头，则该段名需用“|”括起来，如|1_test|，用C的编译器产生的代码一般也用“|”括起来。属性字段表示该代码段（或数据段）的相关属性，多个属性用逗号分隔。

使用示例：

```assembly
           AREA Init，CODE，READONLY    ;定义段Init，代码段，只读
                         ENTRY         ;程序入口
                                 …     ;指令序列
                         B START1
           AREA STOCK,DATA,READWRITE    
                                       ;定义段STOCK，数据段，读/写
                        SAVE   SPACE 20 ;分配数据空间
           AREA Init，CODE，READONLY     
                                    ;定义段Init，代码段，只读     
           START1  ADD R1,R2,R3
                              …    ;指令序列
                        B START1 
```

## ALIGN

## CODE16和CODE32

格 式：CODE16（或CODE32）

功 能：

1. CODE16伪操作通知编译器，其后的指令序列为16位的Thumb指令。 
2. CODE32伪操作通知编译器，其后的指令序列为32位的ARM指令。

使用示例：

```assembly
   AREA Init，CODE，READONLY
      …
      CODE32  ;通知编译器其后的指令为32位的ARM指令
      LDR R0，=NEXT＋1   ;将跳转地址放入寄存器R0
      BX R0   ;程序跳转到新的位置执行，
              ;并将处理器切换到Thumb工作状态
      …
      CODE16    ;通知编译器其后的指令为16位的Thumb指令
NEXT  LDR R3，=0x3FF	
      …
      END     ;程序结束
```

## ENTRY

格 式：ENTRY

功 能：ENTRY伪操作用于指定汇编程序的入口点。一个程序可由一个或多个源文件组成，一个源文件由一个或多个程序段组成。一个程序至少有一个入口，在只有一个入口时，编译程 序会把这个入口的地址定义为系统复位后的程序的起始点。

使用示例：

```assembly
 AREA Init，CODE，READONLY
   ENTRY ;指定应用程序的入口点
   …
```

## END

格 式：END

功 能：END伪操作用于通知编译器已经到了源程序的结尾。

使用示例：

```assembly
AREA Init，CODE，READONLY
     ……
     END ;指定应用程序的结尾
```

## EQU

格 式：名称 EQU表达式{，类型}

功 能：EQU伪操作用于为程序中的常量、标号等定义一个等效的字符名称，类似于C语言中的＃define。

使用示例：

```assembly
Test EQU 50     ;定义标号Test的值为50
Addr EQU 0x55   ; 定义Addr的值为0x55
```

## EXPORT和GLOBAL

格 式：EXPORT 标号 [，WEAK]

功 能：EXPORT伪操作用于在程序中声明一个全局的标号，该标号可在其它的文件中引用。

使用示例：

```assembly
                 AREA Init，CODE，READONLY
                 EXPORT Stest ;声明一个可全局引用的标号Stest
                  ……
                 END
```

## IMPORT

格 式：IMPORT 标号 [，WEAK]

功 能：IMPORT伪操作用于通知编译器要使用的标号在其它的源文件中定义，但要在当前源文件中引用，而且无论当前源文件是否引用该标号，该标号均会被加入到当前源文件的符号表中。标号在程序中区分大小写。

使用示例：

```assembly
    AREA Init，CODE，READONLY
     IMPORT Main
       …
       END
```

## EXTERN

## GET和INCLUDE

格 式：GET 文件名

功 能：GET伪操作用于将一个源文件包含到当前的源文件中，并将被包含的源文件在当前位置进行汇编处理。可以使用INCLUDE代替GET。

使用示例：

```assembly
        AREA Init，CODE，READONLY
        GET a1.s ;通知编译器当前源文件包含源文件a1.s
        GET C:\a2.s ;通知编译器当前源文件包含源文件C:\a2.s
         …
          END
```

## INCBIN

格 式：INCBIN 文件名

功 能：INCBIN伪操作用于将一个目标文件或数据文件包含到当前的源文 件中，被包含的文件不作任何变动地存放在当前文件中，编译器从其后开始继续处理。

使用示例：

```assembly
     AREA Init，CODE，READONLY
    GET  a1.s 
    INCBIN  C:\a2.txt 
     …
     END
```

 分析：使用GET包含文件时，由于必须对包含文件进行编译，所以被包含的文件只能是源文件。而使用INCBIN包含文件时，可以是其它类型的文件。	

## RN

格 式：名称 RN 表达式

功 能：RN伪操作用于给一个寄存器定义一个别名。采用这种方式可以方便程序员记忆该寄存器的功能。其中，名称为给寄存器定义的别名，表达式为寄存器的编码。

使用示例：

```assembly
Temp RN R0 ;将R0定义一个别名Temp  
```

ARM汇编语言程序框架

段：

+ ARM汇编程序由段组成（程序段、数据段）；
+ 段是由汇编器伪指令AREA定义的相对独立程序块；
+ 段的属性：READONLY（只读）或READWRITE（读写）分别用于定义一个代码段或数据段；

```assembly
;文件名：TEST1.S 
;功能：实现字符串拷贝功能 
;说明：使用ARMulate软件仿真调试 
	AREA	Example1,CODE,READONLY  ;声明代码段Example1 
num    EQU  20       		    ;设置拷贝字的个数 
	ENTRY				    ;标识程序入口 
	CODE32				    ;声明32位ARM指令
START	LDR	R0, =src     ; R0指向源数据块
	LDR	R1, =dst     ; R1指向目的数据块
	MOV	R2, #num     ; R2需要拷贝的数据个数 
wordcopy
	LDR	R3, [R0], #4 ; 从源数据块中取一个字，放入R3中，
				; R0=R0+4
	STR	R3, [R1], #4	; 将R3中的数据存入R1指向的存储
				; 单元中，R1=R1+4
	SUBS	R2, R2, #1	; R2计数器减1
	BNE	wordcopy	; 如果R2不为0，则转向wordcopy处

stop
	MOV	R0, #0x18	; 程序运行结束返回编译器调试环境
	LDR	R1, =0x20026	
	SWI	0x123456
	AREA  BlockData, DATA, READWRITE
			;  数据段的名字BlockData

Src	DCD	1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4
Dst	DCD	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

AREA |.extra|, NOINIT, READWRITE
			; 未初始数据段的名字.extra

data	SPACE	1024

END			; 文件结束 
```

## ROUT



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)