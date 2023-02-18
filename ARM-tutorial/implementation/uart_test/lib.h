#ifndef LIB_H
#define LIB_H

#include "uart_driver.h"

void s3c2440_putchar(char c);
char s3c2440_getchar(void);
void s3c2440_puts(const char *str);
void s3c2440_putint(int num);
void s3c2440_putchar_hex(char c);
void s3c2440_putint_hex(int num);
int s3c2440_printf(const char *format,...);

#endif