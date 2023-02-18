usr_stack_legth equ 64 ;定义各个部分的长度
svc_stack_legth equ 32
fiq_stack_legth equ 16
irq_stack_legth equ 64
abt_stack_legth equ 16
und_stack_legth equ 16               

  area reset,code,readonly ;定义CODE段并命名
  entry ;设置程序入口伪指令
  code32 ;定义后面的指令为32位的ARM指令

;设置各个寄存器中的内容
start    mov r0,#0
    mov r1,#1
    mov r2,#2
    mov r3,#3
    mov r4,#4
    mov r5,#5
    mov r6,#6
    mov r7,#7
    mov r8,#8
    mov r9,#9
    mov r10,#10
    mov r11,#11
    mov r12,#12
             
    bl initstack  ;跳转至initstack，并且初始化各模式下的堆栈指针，打开IRQ中断(将cpsr寄存器的i位清0)
                              
    mrs r0,cpsr        ;r0<--cpsr
    bic r0,r0,#0x80    ;cpsr的I位置0，开IRQ中断
    msr cpsr_cxsf,r0   ;cpsr<--r0
                                    
    ;切换到用户模式
    msr cpsr_c,#0xd0     ;11010000：I，F位置1，禁止IRQ和FIQ中断，T=0，ARM执行，M[4：0]为10000，切换到用户模式
    mrs r0,cpsr          ;r0<--cpsr
    stmfd sp!,{r1-r12}   ;R1-R12入栈     
                         ;观察用户模式能否切换到其他模式
    ;切换到管理模式
    msr cpsr_c,#0xdf    ;11011111：I，F位置1，禁止IRQ和FIQ中断，T=0，ARM执行，M[4：0]为11111，切换到系统模式
    mrs r0,cpsr			;r0<--cpsr
    stmfd sp!,{r1-r12}  ;将寄存器列表中的寄存器存入堆栈

halt  b halt ;从halt跳转到halt

initstack  mov r0,lr   ; r0<--lr,因为各种模式下r0是相同的而各个模式不同       
                                   
    ;设置管理模式堆栈
    msr cpsr_c,#0xd3   ; 11010011 切换到管理模式
    ldr sp,stacksvc    ;设置管理模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置中断模式堆栈
    msr cpsr_c,#0xd2   ;11010010  切换到中断模式
    ldr sp,stackirq    ;设置中断模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置快速中断模式堆栈
    msr cpsr_c,#0xd1   ;11010001  切换到快速中断模式
    ldr sp,stackfiq    ;设置快速中断模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置中止模式堆栈   
    msr cpsr_c,#0xd7   ;11010111  切换到中止模式
    ldr sp,stackabt    ;设置中止模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置未定义模式堆栈   
    msr cpsr_c,#0xdb   ;11011011  切换到未定义模式
    ldr sp,stackund    ;设置未定义模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    ;设置系统模式堆栈    
    msr cpsr_c,#0xdf   ;11011111  切换到系统模式
    ldr sp,stackusr    ;设置系统模式堆栈地址
    stmfd sp!,{r1-r12} ;R1-R12入栈，满递减模式

    mov pc,r0 ;返回
    
    ;为各模式堆栈开辟一段连续的字存储空间
stackusr    dcd  usrstackspace+(usr_stack_legth-1)*4
stacksvc    dcd  svcstackspace+(svc_stack_legth-1)*4
stackirq    dcd  irqstackspace+(irq_stack_legth-1)*4
stackfiq    dcd  fiqstackspace+(fiq_stack_legth-1)*4
stackabt    dcd  abtstackspace+(abt_stack_legth-1)*4
stackund    dcd  undstackspace+(und_stack_legth-1)*4
	;定义data段并命名
      area reset,data,noinit,align=2
      ;为各模式堆栈分配存储区域
usrstackspace space usr_stack_legth*4
svcstackspace space svc_stack_legth*4
irqstackspace space irq_stack_legth*4
fiqstackspace space fiq_stack_legth*4
abtstackspace space abt_stack_legth*4
undstackspace space und_stack_legth*4
    end