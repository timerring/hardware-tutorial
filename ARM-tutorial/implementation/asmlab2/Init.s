  AREA Init,CODE,READONLY
 ENTRY
 CODE32
start
  MOV SP, #0x400      ;设置堆栈地址(这个好像没用到)
  LDR R0, =Src        ;将原字符串地址给R0
  LDR R1, =Dst        ;将目的字符串地址给R1
  MOV R3,#0           ;R3赋值为0
strcopy
  LDRB R2,[R0],#1     ;存储器地址为R0的字节内容读入寄存器R2，并把新地址R0+1的值存入R0
  CMP R2,#0           ;比较R2和0，检测字符串是否结束
  BEQ endcopy         ;等于0则跳转至endcopy
  STRB R2,[R1],#1     ;将R2中的字节数据写入以R1为地址的存储器中，并把新地址R1+1的值存入R1
  ADD R3,R3,#1        ;R3自加一，记录字符个数
  B strcopy           ;循环
endcopy
  LDR R0, =ByteNum    ;把字符数的地址给R0
  STR R3,[R0]         ;把R3的值放到R0中
  B .
  AREA Datapool,DATA,READWRITE  
Src  DCB  "string",0  ;初始字符串存储空间
Dst DCB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0      ;目的字符串存储空间
ByteNum DCD 0
 END
