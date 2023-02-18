#include "lib.h"


int __entry(void)
{	
	//char i;
	//char c;
	uart_init();
	
    //s3c2440_printf("name: %s\tage: %d\tgender: %c\n","Lihua",48,'m');
	
	//s3c2440_printf("hex test: 0x%x\n",0x12345);
	
	//#if 0
	//s3c2440_puts("Hello world!\n");
	s3c2440_puts("Test begin,please input your char:\n");
	//s3c2440_puts("Test Begin:\n");
	
	//s3c2440_puts("abcdefg\n");
	//s3c2440_putint(12345);
	//s3c2440_putchar('\n');
	//s3c2440_putint(543210);
	//s3c2440_putchar('\n');
	//s3c2440_putint(0);
	//s3c2440_putchar('\n');
	//s3c2440_putchar_hex('A');
	//s3c2440_putchar_hex(100);
	//s3c2440_putint_hex(0x12345);
	//#endif
	
	//#if 0
	while(1)
		s3c2440_putchar(s3c2440_getchar());
	//#endif
	
	//#if 0
	//for(i='a';i<='z';i++)
	//	uart_putchar(i);
	//#endif
	
	return 0;
}