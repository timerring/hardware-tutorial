;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Copyright (c) 2004-2007 threewater@up-tech.com, All	rights reserved.
;;; 
;;; Startup Code for
;;;	   S3C2440 : Startup.s
;;;; by	threewater	2005.2.22
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	GET 2440addr.s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Some ARM920	CPSR bit discriptions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Pre-defined constants
USERMODE    EQU	0x10
FIQMODE	    EQU	0x11
IRQMODE	    EQU	0x12
SVCMODE	    EQU	0x13
ABORTMODE   EQU	0x17
UNDEFMODE   EQU	0x1b
MODEMASK    EQU	0x1f
NOINT	    EQU	0xc0

I_Bit			*	0x80
F_Bit			*	0x40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MMU	Register discription
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;p15	CP	15
;c0	CN	0
;c1	CN	1
;c2	CN	2
;c3	CN	3

CtrlMMU			*	1
CtrlAlign		*	2
CtrlCache		*	4
CtrlWBuff		*	8
CtrlBigEnd		*	128
CtrlSystem		*	256
CtrlROM			*	512

;initialization	L0 is MMU FULL_ACCESS, DOMAIN, SECTION
TLB_L0_INIT		*	0x0C02
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			AREA	Init,CODE,READONLY
			IMPORT __use_no_semihosting_swi

			IMPORT	Enter_UNDEF
			IMPORT	Enter_SWI
			IMPORT	Enter_PABORT
			IMPORT	Enter_DABORT
			IMPORT	Enter_FIQ

			ENTRY

			b	ColdReset
			b	Enter_UNDEF	;UndefinedInstruction
			b	Enter_SWI	;syscall_handler or SWI
			b	Enter_PABORT	;PrefetchAbort
			b	Enter_DABORT	;DataAbort
			b	.		;ReservedHandler
			b	IRQ_Handler	;IRQHandler
			b	Enter_FIQ	;FIQHandler

;deal with IRQ interrupt
	EXPORT	IRQ_Handler
IRQ_Handler
	IMPORT	ISR_IrqHandler
	STMFD	sp!, {r0-r12, lr}
	BL	ISR_IrqHandler
	LDMFD	sp!, {r0-r12, lr}
	SUBS	pc, lr,	#4

;=======
; ENTRY	 
;=======
	EXPORT ColdReset
ColdReset
	ldr	r0,=WTCON	;watch dog disable 
	ldr	r1,=0x0		
	str	r1,[r0]

	ldr	r0,=INTMSK
	ldr	r1,=0xffffffff	;all interrupt disable
	str	r1,[r0]

	ldr	r0,=INTSUBMSK
	ldr	r1,=0x7ff		;all sub interrupt disable, 2002/04/10
	str	r1,[r0]

;****************************************************
;*	Initialize stacks			    * 
;****************************************************
			bl	InitStacks	; Stack	Setup for each MODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; copy excption table to sram at 0x0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		IMPORT	|Load$$EXCEPTION_EXEC$$Base|
		IMPORT	|Image$$EXCEPTION_EXEC$$Base|
		IMPORT	|Image$$EXCEPTION_EXEC$$Length|
			
		ldr	r0,	=|Load$$EXCEPTION_EXEC$$Base|	;source	data
		ldr	r1,	=|Image$$EXCEPTION_EXEC$$Base|	;place exception talbe at 0x0
		ldr	r2,	=|Image$$EXCEPTION_EXEC$$Length|

exception_cploop
		sub	r2,	r2,	#4
		ldmia	r0!,	{r3}
		stmia	r1!,	{r3}
		cmp	r2, #0
		bge exception_cploop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; start main function in C language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			IMPORT __main

			BL	__main	    ;Don't use main() because ......
			B	.

;****************************************************
;*	The function for initializing stack	    *
;****************************************************
	IMPORT UserStack
	IMPORT SVCStack
	IMPORT UndefStack
	IMPORT IRQStack
	IMPORT AbortStack
	IMPORT FIQStack

InitStacks
	;Don't use DRAM,such as	stmfd,ldmfd......
	;SVCstack is initialized before
	;Under toolkit ver 2.50, 'msr cpsr,r1' can be used instead of 'msr cpsr_cxsf,r1'

	mrs	r0,cpsr
	bic	r0,r0,#MODEMASK
	orr	r1,r0,#UNDEFMODE|NOINT
	msr	cpsr_cxsf,r1		;UndefMode
	ldr	sp,=UndefStack
				
	orr	r1,r0,#ABORTMODE|NOINT
	msr	cpsr_cxsf,r1		;AbortMode
	ldr	sp,=AbortStack
			
	orr	r1,r0,#IRQMODE|NOINT
	msr	cpsr_cxsf,r1		;IRQMode
	ldr	sp,=IRQStack
				
	orr	r1,r0,#FIQMODE|NOINT
	msr	cpsr_cxsf,r1		;FIQMode
	ldr	sp,=FIQStack
			
	;bic	r0,r0,#MODEMASK|NOINT
	orr	r1,r0,#SVCMODE|NOINT
	msr	cpsr_cxsf,r1		;SVCMode
	ldr	sp,=SVCStack
			
	;USER mode is not initialized.
	mov	pc,lr ;The LR register may be not valid for	the mode changes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; End of Startup.c
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			END
