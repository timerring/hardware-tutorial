;***************************************************************
; NAME: delay.s  
;***************************************************************

  EXPORT delayxms

  area delay,code,readonly    
  code32
  
;下面是延时若干ms的子程序      
delayxms
     sub r0,r0,#1 ;r0=r0-1
     ldr r11,=1000
loop2
     sub r4,r4,#1
     cmp r4,#0x0
     bne loop2
     cmp r0,#0x0    ;将r0与0比较
     bne delayxms   ;比较的结果不为0，则继续调用delayxms

     mov pc,lr;返回
     
     end