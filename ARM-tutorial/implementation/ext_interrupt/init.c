/*
 * init.c: 进行一些初始化
 */ 
#include "s3c2440.h"
/*
 * LED1-4对应GPB5、GPB6、GPB7、GPB8
 */
#define GPB5_out        (1<<(5*2))      // LED1
#define GPB6_out        (1<<(6*2))      // LED2
#define GPB7_out        (1<<(7*2))      // LED3
#define GPB8_out        (1<<(8*2))      // LED4
/*
 * K1-K4对应GPG0、GPG3、GPG5、GPG6
 */
#define GPG0_eint      (2<<0)           // K1,EINT8
#define GPG3_eint       (2<<(3*2))      // K2,EINT11
#define GPG5_eint       (2<<(5*2))      // K3,EINT13
#define GPG6_eint       (2<<(6*2))      // K4,EINT14

/*
 * 关闭WATCHDOG，否则CPU会不断重启
 */
void disable_watch_dog(void)
{
    WTCON = 0;  // 关闭WATCHDOG很简单，往这个寄存器写0即可
}
void init_led(void)
{
    GPBCON = GPB5_out | GPB6_out | GPB7_out | GPB8_out ;  //设置为输出功能
}
/*
 * 初始化GPIO引脚为外部中断
 * GPIO引脚用作外部中断时，默认为低电平触发、IRQ方式(不用设置INTMOD)
 */ 
void init_irq( )
{
    GPGCON  = GPG0_eint | GPG3_eint |GPG5_eint | GPG6_eint;
 
   //使能EINT8 EINT11 EINT13 EINT14
    EINTMASK&=(~(1<<8)) & (~(1<<11)) & (~(1<<13)) & (~(1<<14));
   
   //EINT8 EINT11 EINT13 EINT14中断优先级一样,无需设置
     INTMSK   &=(~(1<<5));           //使能IRQ5
}
 