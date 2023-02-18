  AREA comp,CODE,READONLY ;定义代码片段comp 只读
 	ENTRY           ;进入程序
 CODE32          ;以下为ARM程序
START         
  LDR R0, = DAT      ;加载数据段中DAT的数据的地址到R0
  LDR R1, [R0]       ;加载R0的数据到R1
  LDR R2, [R0]       ;加载R0的数据到R1
  MOV R3,#1        ;循环变量R3初始化1
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