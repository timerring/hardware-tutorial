- [数据处理指令详解](#数据处理指令详解)
    - [数据处理指令的特点](#数据处理指令的特点)
    - [数据处理指令的汇编格式](#数据处理指令的汇编格式)
    - [数据处理指令－指令表](#数据处理指令指令表)
    - [（1）ADD、ADC、SUB、SBC、RSB和RSC](#1addadcsubsbcrsb和rsc)
    - [（2）AND、ORR、EOR和BIC](#2andorreor和bic)
    - [（3）MOV和MVN](#3mov和mvn)
    - [（4）CMP和CMN](#4cmp和cmn)
    - [（5）TST和TEQ](#5tst和teq)
    - [（6）乘法指令](#6乘法指令)
      - [乘法指令的二进制编码](#乘法指令的二进制编码)
      - [汇编格式](#汇编格式)
      - [注意事项](#注意事项)


# 数据处理指令详解

ARM的数据处理指令主要完成寄存器中数据的算术和逻辑运算操作：

+ 数据处理指令分类
+ 数据处理指令二进制编码
+ 数据处理指令表

数据处理指令根据指令实现处理功能可分为以下六类： 

+ 数据传送指令；
+ 算术运算指令；
+ 逻辑运算指令；
+ 比较指令；
+ 测试指令；
+ 乘法指令。

### 数据处理指令的特点

所有操作数都是32位宽，或来自寄存器或来自指令中的立即数（符号或0扩展）

如果数据操作有结果，则结果为32位宽，放在一个寄存器中（有一个例外是长乘指令的结果是64位的）；

ARM数据处理指令中使用“3地址模式”，即1个目的操作寄存器、1个源操作数寄存器和1个灵活的第2操作数，这个第2操作数可以使寄存器、移位后的寄存器或者立即数。如果第2操作数为寄存器Rm，它也可以进行移位（包括：逻辑移位、算术移位、循环移位），移位位数可以来自一5位立即数或也可以使一寄存器的内容。当然，这3个操作数也可以只用1个或者2个，甚至1个都不用（如测试指令TST，TEQ等）。

### 数据处理指令的汇编格式

根据第2操作数的类型，其汇编格式分为以下2种：

```assembly
<op>  {<cond>}  {S}  Rd,Rn, #<32位立即数>
<op>  {<cond>}  {S}  Rd,Rn, Rm,{<shift>}
```

注意：R15（PC）作为一个特殊的寄存器PC，同时也可以作为一般寄存器使用。但是当R15作源操作数时，不能指定移位位数。另外，在3级流水线中真实PC是当前指令地址加8。当R15作为目的操作数时，该指令的功能相当于执行某种形式的转移指令。也常用来实现子程序返回。另外，当R15作目的寄存器且使用了后缀S，则在恢复PC的同时，自动将当前模式的SPSR拷贝到CPSR，完成对CPSR的恢复，这是实现异常返回的标准方式。由于用户和系统模式下，没有自己的SPSR，因此，在这两种模式下这种操作无效，但汇编时并不警告。

数据处理指令的二进制编码如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221220130932896.png)

### 数据处理指令－指令表

数据处理指令的详细列表如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221220131012587.png)

### （1）ADD、ADC、SUB、SBC、RSB和RSC

+ 用法：
  ADD和SUB是简单的加减运算
  ADC和SBC是带进位的加减运算
  RSB是反减，即用第2个操作数减第1个操作数，由于第2个操作数可选范围宽，所以这条指令常用。
  RSC是带进位的反减。若C为0，则结果减1。

+ 注意事项：
  若设置S位，则这些指令根据结果更新标志N、Z、C和V。
  ADC、SBC和RSC可用于多字算术运算。如下面两条语句完成64位加法：

  ```assembly
        ADDS  R4，R0，R2
        ADDC  R5，R1，R3 
  ```

### （2）AND、ORR、EOR和BIC

+ 用法：
  AND完成按位“与”操作，常用于提取寄存器中的某些位。如：AND R9，R2，#0XFF00
  ORR完成按位“或”操作，常用于将寄存器中的某些位设置为1。如：ORREQ R2，R0，R5
  EOR完成按位“异或”操作，常用于将寄存器中的某些位的值取反。如：EOR R0，R0，R3，ROR R6
  BIC用于将源操作数的各位与第2操作数中相应位的反码进行“与”操作，常用于将寄存器中的某些位设置为0。如：BICNES R8，R10，R0，RRX
+ 注意事项：
  若设置S位，则这些指令根据结果更新标志N、Z，在计算第2操作数时更新标志C，不影响V标志。

### （3）MOV和MVN

+ 用法：
  MOV是将第2操作数的值拷贝到结果寄存器中。如：    

  ```assembly
  MOV R9，R2
  MOVS R0,R0,ROR R6 
  ```

  MVN “取反传送” ，它是把第2操作数的每一位取反，将得到的值送入结果寄存器。如： `MVNNE  R0,#0XFF00`

+ 注意事项：
  若设置S位，则这些指令根据结果更新标志N、Z，在计算第2操作数时更新标志C，不影响V标志。

### （4）CMP和CMN

+ 用法：
  CMP表示比较，用目的操作数减去源操作数，根据结果更新条件码标志。除了将结果丢弃外，CMP指令和SUBS指令完成的操作一样。如：            

  ```assembly
              CMPGT  R13,R7,LSL #2 
  ```

  CMN 表示取反比较 ，将目的操作数和源操作数相加，根据结果更新条件码标志。除了结果丢弃外，CMN指令与ADDS指令完成的操作一样。如：            

  ```assembly
              CMN  R0,#6400
  ```

+ 注意事项：
  这些指令根据结果更新标志N、Z、C和V，但结果不放到任何寄存器中。

### （5）TST和TEQ

+ 用法：
  TST表示位测试，对第2个操作数进行位“与”操作，根据结果更新条件码标志。除了将结果丢弃外，TST指令和ANDS指令完成的操作一样。TST通常用于测试寄存器中某些位是1还是0。如：

  ```assembly
  TST  R0, #0x3F8 
  ```

  TEQ 表示测试相等 ，对第2个操作数进行按位“异或”操作，根据结果更新条件码标志。除了结果丢弃外，TEQ指令与EORS指令完成的操作一样。TEQ通常用于比较2个操作数是否相等，这种比较一般不影响CPSR的V和C。它也可用于比较2个操作数符号是否相同。如：

  ```assembly
  TEQEQ  R10，R9 
  ```

+ 注意事项：
  这些指令根据结果更新标志N、Z、C和V，但结果不放到任何寄存器中。

### （6）乘法指令

乘法指令完成2个寄存器中数据的乘法。按结果位宽一般分为2类：一类是2个32位二进制数相乘的结果是64位；另一类是2个32位二进制数相乘，仅保留最低有效32位。并且这2类指令都有乘加变形，即将乘积连续相加成为总和，而且有符号和无符号操作数都能使用。这两类指令共有6条，如下图所示：

乘法指令

| 操作码[23：21] | 助记符    | 意义                   | 效果                        |
| -------------- | --------- | ---------------------- | --------------------------- |
| **000**        | **MUL**   | **乘（2位结果）**      | **Rd←(Rm\*Rs)[31:0]**       |
| **001**        | **MLA**   | **乘累加（32位结果）** | **Rd←(Rm\*Rs+Rn)[31:0]**    |
| **100**        | **UMULL** | **无符号数长乘**       | **RdHi:RdLo ←Rm\*Rs**       |
| **101**        | **UMLAL** | **无符号长乘累加**     | **RdHi:RdLo +=Rm\*Rs**      |
| **110**        | **SMULL** | **有符号数长乘**       | **RdHi:RdLo ←Rm\*Rs**       |
| **111**        | **SMLAL** | **有符号长乘累加**     | **RdHi:RdLo**  **+=Rm\*Rs** |

注：  对于有符号和无符号操作数，结果的最低有效32位是一样的，所以对于只保留32位结果的乘法指令，无须区分有符号和无符号数2种格式。

####   乘法指令的二进制编码

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20221220131542635.png)

说明：

对于32位乘积结果指令，Rd为结果寄存器，Rm、Rs、Rn为操作数寄存器。

对于64位乘积结果指令，RdLo、RdHi为结果寄存器，“RdHi:RdLo”是由RdHi（最高有效32位）和RdLo（最低有效32位）连接形成64位乘积结果，Rm、Rs为操作数寄存器。

R15不能用作Rd、Rm、Rs或Rn，且Rd不能与Rm相同。

当在指令中设置了S后根据结果影响标志位N和Z。对于32位结果的指令，N为Rd的第31位值；对于产生64位结果的指令，N设置为RdHi的第31位值；如果Rd或RdHi和RdLo为0，则Z标志置位。

ARM V4及以前版本标志C、V不可靠，ARM V5后，不影响C和V。

####   汇编格式

产生32位乘积的指令：

```assembly
    MUL {<cond>}{S}  Rd,Rm,Rs 
    MLA {<cond>}{S}  Rd,Rm,Rs,Rn 
```

产生64位乘积的指令：

```assembly
    UMULL {<cond>}{S}  RdHi,RdLo,Rm,Rs 
    UMLAL {<cond>}{S}  RdHi,RdLo,Rm,Rs
    SMULL {<cond>}{S}  RdHi,RdLo,Rm,Rs
    SMLAL {<cond>}{S}  RdHi,RdLo,Rm,Rs
```

例子：

```assembly
      MOV  R11,#20  ;初始化循环计数器 
      MOV  R10,#0  ;初始化总和
LOOP: LDR  R0,[R8],#4 ;读取第1分量
      LDR  R1,[R9],#4   ;读取第2分量
      MLA  R10,R0,R1,R10 ;乘积累加
      SUBS  R11，R11，#1 ;循环减计数
      BNE  LOOP
```

####   注意事项

乘以一个常数，可以先把常数放到寄存器中，然后再用上述指令实现。但是，有时利用移位和乘加指令组合构成一个程序段更有效，如：将R0乘以35可以如下实现

```assembly
      ADD R0,R0,R0,LSL #2  ;R0’ ←R0*5 
      RSB R0,R0,R0,LSL #3  ;R0’’←R0’*7 
```

注意事项：

不支持第2操作数为立即数；

结果寄存器不能同时作为第一源寄存器，即Rd、RdHi和RdLo不能与Rm为同一寄存器，RdHi和RdLo不能为同一寄存器。

应避免R15定义为任一操作数或结果操作数。

早期的ARM处理器仅支持32位乘法指令（MUL和MLA)。ARM7版本（ARM7DM、ARM7TM等）和后续的在名字中有M的处理器才支持64位乘法器。



参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)