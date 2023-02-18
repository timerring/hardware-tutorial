WTCON	  EQU 	0x53000000			;;看门狗定时器控制寄存器
LOCKTIME  EQU	0x4C000000			;;变频锁定时间(PLL锁定时间计数器)
MPLLCON   EQU	0x4C000004			;;MPLL配置寄存器
CLKCON 	  EQU	0x4C00000C			;;时钟发生器控制寄存器
CLKSLOW   EQU	0x4C000010			;;慢时钟
CLKDIVN   EQU	0x4C000014			;;时钟降频因子寄存器
CAMDIVN   EQU	0x4C000018			;;Camera降频寄存器
	
	import __entry;;声明C语言程序的入口
	
	AREA Example ,CODE,READONLY
	ENTRY
	CODE32
start
	;;1.禁用看门狗
	ldr r0,=WTCON
	mov r1,#0
	str r1,[r0]
	
	;;2.初始化时钟
	bl clock_init
	
	ldr sp,=0x1000
	bl __entry
loop
	b loop
	
clock_init
	ldr r0,=LOCKTIME
	ldr r1,=0xFFFFFFFF
	str r1,[r0]

	ldr r0,=CLKSLOW
	mov r1,#0
	str r1,[r0]
		
	ldr r0,=CAMDIVN
	ldr r1,[r0]
	bic r1,r1,#0x200
	str r1,[r0]
	
	ldr r0,=CLKDIVN
	mov r1,#5
	str r1,[r0]
	
	mrc p15,0,r0,c1,c0,0;;
	orr r0,r0,#0xC0000000
	mcr p15,0,r0,c1,c0,0
	
	ldr r0,=MPLLCON ;;FCLK=400MHz,HCLK=100MHz,PCLK=50MHz
	mov r1,#92
	mov r2,r1,LSL #12
	orr r2,r2,#0x11
	str r2,[r0]
	
	mov pc,lr
			
	END