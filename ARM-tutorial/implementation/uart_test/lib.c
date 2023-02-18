#include "uart_driver.h"

void s3c2440_putchar(char c)
{
	switch(c)
	{
		case '\n':
			uart_putchar('\r');
			break;
		case '\b':
			uart_putchar('\b');
			uart_putchar(' ');
			break;
		default:
			break;
	}
	uart_putchar(c);
}
char s3c2440_getchar(void)
{
	char c  = uart_getchar();
	return c=='\r'?'\n':c;
}

void s3c2440_puts(const char *str)
{
	while(*str)
		s3c2440_putchar(*str++);
}


void s3c2440_putint_1(int num)
{
	int n,m;
	if(num==0)
		return;
	n = num%10;
	m = num/10;
	s3c2440_putint_1(m);		
	s3c2440_putchar(n+'0');
}

void s3c2440_putint(int num)
{
	if(num==0)
		s3c2440_putchar('0');
	else
		s3c2440_putint_1(num);
}



int strlen(const char *str)
{
	const char *s = str;
	while(*str++)
		;
	return str - s - 1;
}

void inverse(char *str)
{
	int len,i,temp;
	len = strlen(str);
	for(i=0;i<len/2;i++)
	{
		temp = str[i];
		str[i] = str[len-i-1];
		str[len-i-1] = temp;
	}
}

/**********************************
void s3c2440_putint(int num)
{
	char str[11];
	int i = 0;
	do{
		str[i++] = num%10 + '0';
		num/=10;
	}while(num!=0);
	
	str[i] = 0;
	
	inverse(str);
	
	s3c2440_puts(str);
}
**********************************/
void s3c2440_putchar_hex(char c)
{
	char hex[] = "0123456789ABCDEF";
	s3c2440_putchar(hex[(c>>4 & 0xF)]);	
	s3c2440_putchar(hex[(c>>0 & 0xF)]);	
}

void s3c2440_putint_hex(int num)
{
	s3c2440_putchar_hex(num>>24 & 0xFF);
	s3c2440_putchar_hex(num>>16 & 0xFF);
	s3c2440_putchar_hex(num>>8 & 0xFF);
	s3c2440_putchar_hex(num>>0 & 0xFF);
}


int s3c2440_printf(const char *format,...)
{
	char c;
	int total = 0;
	int *addr = (int*)&format;
	while((c=*format)!=0)
	{
		if(c=='%')
		{
			format++;
			switch(*format)
			{
				case 's':
					total++;
					s3c2440_puts(*(char**)(++addr));
					break;
				case 'd':
					total++;
					s3c2440_putint(*(int*)(++addr));
					break;
				case 'c':
					total++;
					s3c2440_putchar(*(char*)(++addr));
					break;
				case 'x':
					total++;
					s3c2440_putint_hex(*(int*)(++addr));
					break;
				default:
					s3c2440_putchar('%');
					s3c2440_putchar(*format);
			}
		}
		else
		{
			s3c2440_putchar(c);
		}
		format++;
	}
	return total;
}