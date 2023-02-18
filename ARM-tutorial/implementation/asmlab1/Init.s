 AREA Init,CODE,READONLY  ; 伪指令AREA定义名为Init,属性为只读或的代码片段
  ENTRY  ; 伪指令ENTRY声明程序入口
  CODE32  ;声明以下代码为 32 位 ARM 指令
x EQU 45
y EQU 64 ;定义两个变量 x,y
stack_top EQU 0x1000 ; 定义堆栈地址 0x1000
start MOV SP, #stack_top  ;设置栈顶地址
      MOV R0, #x  ;把x的值赋给R0
      STR R0, [SP]  ;R0中的值（x的值）入栈
      MOV R0, #y  ;把y的值赋给R0
      LDR R1, [SP]  ; 数据出栈，放入R1，即R1中放x的值
      ADD R0, R0, R1  ;R0=R0+R1
      STR R0, [SP,#4] ;先执行SP+4(ARM为32位指令集)，再将R0内容复制到SP指向的寄存器
      B .
  END  ;程序结束