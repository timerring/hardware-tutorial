#define rGPHCON 	(volatile unsigned int *)0x56000070

#define rULCON0 	(volatile unsigned int *)0x50000000 //Uart Line Control Register
#define rUCON0 		(volatile unsigned int *)0x50000004	//Uart Control Register
#define rUFCON0 	(volatile unsigned int *)0x50000008	//FIFO Control Register
#define rUMCON0 	(volatile unsigned int *)0x5000000C	//AFC COntronl Register
#define rUTRSTAT0 	(volatile unsigned int *)0x50000010	//State Register
#define rUERSTAT0 	(volatile unsigned int *)0x50000014	//ERROR Detect Register
#define rUFSTAT0 	(volatile unsigned int *)0x50000018	//FIFO State Register
#define rUMSTAT0 	(volatile unsigned int *)0x5000001C	//AFC State Register
#define rUTXH0 		(volatile unsigned char *)0x50000020	//Transmiter Buffer Register
#define rURXH0 		(volatile unsigned char *)0x50000024	//Receiver Buffer Register
#define rUBRDIV0 	(volatile unsigned int *)0x50000028	//BaudRate Generate Register

#define rCLKCON 	(volatile unsigned int *)0x4C00000C 

void uart_init(void)
{
	*rGPHCON &= ~(0xF<<4);	//function selection
	*rGPHCON |= 0xA<<4;

	*rULCON0 = 3;	//8N1
	*rUCON0 = 5;	//polling mode,interrupt disable,PCLK
	*rUFCON0 = 0;	//fifo disable
	*rUMCON0 = 0;	//AFC disable
	*rUBRDIV0 = 26;	//PCLK,115200
	
	*rCLKCON |= 1<<10;	//clock enable
}

void uart_putchar(char c)
{
	while(!(*rUTRSTAT0>>1 & 0x1))
		;
	*rUTXH0 = c;
}

char uart_getchar(void)
{
	while(!(*rUTRSTAT0 & 0x1))
		;
	return *rURXH0;
}