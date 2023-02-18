#ifndef UART_DRIVER_H
#define UART_DRIVER_H

void uart_init(void);
void uart_putchar(char);
char uart_getchar(void);

#endif