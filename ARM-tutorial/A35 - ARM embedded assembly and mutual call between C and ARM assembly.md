- [ARM embedded assembly and mutual call between C and ARM assembly](#arm-embedded-assembly-and-mutual-call-between-c-and-arm-assembly)
  - [内嵌汇编](#内嵌汇编)
    - [内嵌汇编指令的语法格式](#内嵌汇编指令的语法格式)
    - [内嵌汇编注意事项](#内嵌汇编注意事项)
    - [内嵌汇编举例](#内嵌汇编举例)
  - [C和ARM汇编程序间相互调用](#c和arm汇编程序间相互调用)
    - [汇编程序对C全局变量的访问](#汇编程序对c全局变量的访问)
    - [在C语言程序中调用汇编程序](#在c语言程序中调用汇编程序)
    - [在汇编程序中调用C语言程序](#在汇编程序中调用c语言程序)


# ARM embedded assembly and mutual call between C and ARM assembly

## 内嵌汇编

在C程序中嵌入汇编程序可以实现一些高级语言没有的功能，并可以提高执行效率。armcc和armcpp内嵌汇编器支持完整的ARM指令集；tcc和tcpp用于Thumb指集。但是内嵌汇编器并不支持诸如直接修改PC实现跳转的底层功能。

内嵌的汇编指令包括大部分的ARM指令和Thumb指令，但是不能直接引用C的变量定义，数据交换必须通过ATPCS进行。嵌入式汇编在形式上表现为独立定义的函数体。

### 内嵌汇编指令的语法格式

```assembly
__asm（“指令[；指令]”）；
```

ARM C汇编器使用关键字“__asm"。如果有多条汇编指令需要嵌入，可以用“｛｝”将它们归为一条语句。如：

```assembly
__asm
｛
指令［；指令］
…
[指令]
｝
```

各指令用“；”分隔。如果一条指令占据多行，除最后一行外都要使用连字符“＼”。在汇编指令段中可以使用C语言的注释语句。需要特别注意的是__asm是两个下划线。

### 内嵌汇编注意事项

必须小心使用物理寄存器，如R0~R3，LR和PC

不要使用寄存器寻址变量

使用内嵌汇编时，编译器自己会保存和恢复它可能用到的寄存器，用户无须保存和恢复寄存器。事实上，除了CPSR和SPSR寄存器，对物理寄存器没写就读都会引起汇编器报错。

LDM和STM指令的寄存器列表只允许物理寄存器

汇编语言用“，”作为操作数分隔符

### 内嵌汇编举例 

```c
#include <stdio.h>
void my_strcpy(const char *src, char *dest)
{
  char ch;
  _asm
  {
    loop:
    ldrb ch, [src], #1
    strb ch, [dest], #1
    cmp ch, #0
    bne loop
  }
}
int main()
{
  char *a = "forget it and move on!";
  char b[64];
  my_strcpy(a, b);
  printf("original: %s", a);
  printf("copyed: %s", b);
  return 0;
}
```

## C和ARM汇编程序间相互调用

在C和ARM汇编程序之间相互调用必须遵守ATPCS（ARM-Thumb Procedure Call Standard）规则。

### 汇编程序对C全局变量的访问

汇编程序可以通过地址间接访问在C语言程序中声明的全局变量。通过使用IMPORT关键词引入全局变量，并利用LDR和STR指令根据全局变量的地址可以访问它们。

对于不同类型的变量，需要采用不同选项的LDR和STR指令，如下所示： 

| unsigned  char  | LDRB/STRB   |
| --------------- | ----------- |
| unsigned  short | LDRH/STRH   |
| unsigned  int   | LDR/STR     |
| char            | LDRSB/STRSB |
| short           | LDRSH/STRSH |

举例：

```c
/* cfile.c

定义全局变量，并作为主调程序
*/
#include <stdio.h>
int gVar_1 = 12;
extern asmDouble(void);
int main()
{
printf("original value of gVar_1 is: %d", gVar_1);
asmDouble();
printf(" modified value of gVar_1 is: %d", gVar_1);
return 0;
}
```

对应的汇编语言文件:

```assembly
;called by main(in C),to double an integer, a global var defined in C is used.
AREA asmfile, CODE, READONLY
EXPORT asmDouble
IMPORT gVar_1
asmDouble
ldr r0, =gVar_1
ldr r1, [r0]
mov r2, #2
mul r3, r1, r2
str r3, [r0]
mov pc, lr
END
```

### 在C语言程序中调用汇编程序

为了保证程序调用时参数的正确传递，汇编程序的设计要遵守ATPCS。在汇编程序中需要使用EXPORT伪操作来声明，使得本程序可以被其它程序调用。同时，在C程序调用该汇编程序之前需要在C语言程序中使用extern关键词来声明该汇编程序。 

举例：

```c
/* cfile.c

*in C,call an asm function, asm_strcpy
*/
#include <stdio.h>
extern void asm_strcpy(const char *src, char *dest);
int main()
{
const char *s = "seasons in the sun";
char d[32];
asm_strcpy(s, d);
printf("source: %s", s);
printf(" destination: %s",d);
return 0;
}
```

```assembly
;asm function implementation
AREA asmfile, CODE, READONLY
EXPORT asm_strcpy
asm_strcpy
loop
ldrb r4, [r0], #1 address increment after read
cmp r4, #0
beq over
strb r4, [r1], #1
b loop
over
mov pc, lr
END
```

### 在汇编程序中调用C语言程序

为了保证程序调用时参数的正确传递，汇编程序的设计要遵守ATPCS。在C程序中不需要使用任何关键字来声明将被汇编语言调用的C程序，但是在汇编程序调用该C程序之前需要在汇编语言程序中使用IMPORT伪操作来声明该C程序。在汇编程序中通过BL指令来调用子程序。 

举例：

```assembly
;the details of parameters transfer comes from ATPCS
;if there are more than 4 args, stack will be used
EXPORT asmfile
AREA asmfile, CODE, READONLY
IMPORT cFun
ENTRY
mov r0, #11
mov r1, #22
mov r2, #33
BL cFun
END
```

```c
/*C file, called by asmfile */
int cFun(int a, int b, int c)
{
return a + b + c;
```



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)