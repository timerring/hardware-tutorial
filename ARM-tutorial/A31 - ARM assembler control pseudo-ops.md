- [ARM 汇编控制伪操作](#arm-汇编控制伪操作)
  - [IF、ELSE、ENDIF](#ifelseendif)
    - [语法格式](#语法格式)
    - [使用示例](#使用示例)
  - [WHILE、WEND](#whilewend)
    - [语法格式](#语法格式-1)
    - [使用示例](#使用示例-1)
  - [MACRO、MEND](#macromend)
    - [语法格式](#语法格式-2)
    - [语法格式](#语法格式-3)
    - [宏的定义体](#宏的定义体)
  - [MEXIT](#mexit)
    - [语法格式](#语法格式-4)


# ARM 汇编控制伪操作

1.  IF、ELSE、ENDIF条件编译伪操作 
2.  WHILE、WEND条件编译伪操作 
3.  MACRO、MEND宏定义伪操作
4.  MEXIT宏退出伪操作

## IF、ELSE、ENDIF     

### 语法格式

```assembly
      IF 逻辑表达式     
      指令序列 1     
      ELSE     
      指令序列 2     
      ENDIF     
```

IF 、 ELSE 、 ENDIF 伪操作能根据条件的成立与否决定是否执行某个指令序列。当 IF 后面的逻辑表达式为真，则执行指令序列 1 ，否则执行指令序列 2 。其中， ELSE 及指令序列 2 可以没有，此时，当 IF 后面的逻辑表达式为真，则执行指令序列 1 ，否则继续执行后面的指令。

IF 、 ELSE 、 ENDIF 伪操作可以嵌套使用。     

### 使用示例

```assembly
      GBLL Test ;声明一个全局的逻辑变量，变量名为 Test……     
      IF Test = TRUE     
      指令序列 1     
      ELSE     
      指令序列 2     
      ENDIF  
```

## WHILE、WEND 

###  语法格式    

```assembly
WHILE 逻辑表达式     
  指令序列     
  WEND     
```

WHILE 、 WEND 伪操作能根据条件的成立与否决定是否循环执行某个指令序列。当 WHILE 后面的逻辑表达式为真，则执行指令序列，该指令序列执行完毕后，再判断逻辑表达式的值，若为真则继续执行，一直到逻辑表达式的值为假。     

WHILE 、 WEND 伪指令可以嵌套使用。

### 使用示例

```assembly
  GBLA Counter ;声明一个全局的数学变量，变量名为 Counter     
  Counter SETA 3 ;由变量Counter 控制循环次数     
  ……     
  WHILE Counter < 10     
  指令序列     
  WEND  
```

## MACRO、MEND     

### 语法格式     

```assembly
      $ 标号 宏名 $ 参数 1 ， $ 参数 2 ，……     
      指令序列     
      MEND     
```

MACRO 、 MEND 伪指令可以将一段代码定义为一个整体，称为宏指令，然后就可以在程序中通过宏指令多次调用该段代码。其中， \$ 标号在宏指令被展开时，标号会被替换为用户定义的符号， 宏指令可以使用一个或多个参数，当宏指令被展开时，这些参数被相应的值替换。

宏指令的使用方式和功能与子程序有些相似，子程序可以提供模块化的程序设计、节省存储空间并提高运行速度。但在使用子程序结构时需要保护现场，从而增加了系统的开销，因此，在代码较短且需要传递的参数较多时，可以使用宏指令代替子程序。

包含在 MACRO 和 MEND 之间的指令序列称为宏定义体，在宏定义体的第一行应声明宏的原型（包含宏名、所需的参数），然后就可以在汇编程序中通过宏名来调用该指令序列。在源程序被编译时，汇编器将宏调用展开，用宏定义中的指令序列代替程序中的宏调用，并将实际参数的值传递给宏定义中的形式参数。

MACRO 、 MEND 伪操作可以嵌套使用。 

MACRO伪操作标识宏定义的开始，MEND标识宏定义的结束。用MACRO和MEND定义的一段代码，称为宏定义体，这样在程序中就可以通过宏名多次调用该代码段来完成相应的功能。

### 语法格式

```assembly
	MACRO
	{$label}  macroname ｛$parameter｛，$parameter｝…｝
	…	;宏代码
	MEND
```

`macroname`为所定义的宏的名称；`$label`在宏指令被展开时，label可被替换成相应的符号，通常是一个标号。（在一个符号前使用\$表示程序被汇编时将使用相应的值来替代\$后的符号）；`$parameter`为宏指令的参数，当宏指令被展开时将被替换成相应的值，类似于函数中的形式参数。可以在宏定义时为参数指定相应的默认值。

### 宏的定义体

```assembly
  MACRO
$PM        DELAY $CanShu
$PM  
           LDR     R7,=$CanShu   ;
          ;LDR  R7,[R7] ;此时参数是一个立即数  如果是变量的话 是会用到这一句
$PM.LOOP 
          SUBS R7,R7,#0X01
          BNE   $PM.LOOP
             MEND

在程序段中的使用：（使用两次）
...
AA    DELAY 0X000005F0
...
BB    DELAY 0X00000FF0
...
```

此时调用多次，编译器就不会出现问题，例子中的AA和BB仅仅是一个标号，用户可以自行书写，因为在宏指令呗展开时，这个符号在汇编时将使用相应的值替代0x00000FF0是一个参数 在此处是一个立即数，用户可自行使用为变量等。

## MEXIT     

### 语法格式      

```assembly
MEXIT
```

MEXIT 用于从宏定义中跳转出去。 

如: 

```assembly
  MACRO
  $abc macroabc $param1, $param2
   ;code
   WHILE condition1
   ;code
   IF condition2
      ;code
      MEXIT ;<----直接退出宏
   ELSE
     ;code
   ENDIF
  WEND
```




参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)