  AREA Init,CODE,READONLY
 ENTRY
 CODE32
main NOP
NUM EQU 8                
start
 MOV SP,#0X800
 LDR R0,=src            ;把src的地址赋给R0
 MOV R2,#NUM            ;把循环次数赋给R2
 MOV R4,#1
 MOV R5,#2
 MOV R6,#3
 MOV R7,#4
 MOV R8,#5
 MOV R9,#6
 MOV R10,#7
 MOV R11,#8              ;给寄存器赋初值    
loop
 ADD R4,R4,#1
 ADD R5,R5,#1
 ADD R6,R6,#1
 ADD R7,R7,#1
 ADD R8,R8,#1
 ADD R9,R9,#1
 ADD R10,R10,#1
 ADD R11,R11,#1          ;循环累加，每个寄存器值加一
 STMFD SP!,{R4-R11}      ;多寄存器寻址，把R4~R11的内容放入SP栈中
 SUBS R2,R2,#1           ;R2中的循环次数减一
 BNE loop                ;不为0则跳转到loop继续循环    
 LDMIA R0!,{R4-R11}      ;将以R0起始地址的值存入R4-R11，即把R4~R11清空赋值为0. IA模式表示：每次传送后地址+4(After Increase)
Stop
 B Stop
 LTORG                   ;声明数据缓冲池
src DCD 0,0,0,0,0,0,0,0    
 END