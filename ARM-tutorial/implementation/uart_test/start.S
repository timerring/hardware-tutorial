WTCON	  EQU 	0x53000000			;;???Ź???ʱ?????ƼĴ???
LOCKTIME  EQU	0x4C000000			;;??Ƶ????ʱ??(PLL????ʱ????????)
MPLLCON   EQU	0x4C000004			;;MPLL???üĴ???
CLKCON 	  EQU	0x4C00000C			;;ʱ?ӷ????????ƼĴ???
CLKSLOW   EQU	0x4C000010			;;??ʱ??
CLKDIVN   EQU	0x4C000014			;;ʱ?ӽ?Ƶ???ӼĴ???
CAMDIVN   EQU	0x4C000018			;;Camera??Ƶ?Ĵ???
	
	import __entry;;????C???Գ?????????
	
	AREA Example ,CODE,READONLY
	ENTRY
	CODE32
start
	;;1.???ÿ??Ź?
	ldr r0,=WTCON
	mov r1,#0
	str r1,[r0]
	
	;;2.??ʼ??ʱ??
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