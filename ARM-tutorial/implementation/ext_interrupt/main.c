
 #include "s2440addr.h"

 #define GPC5_ON  ~(1<<5)
 #define GPC5_OFF (1<<5) 
 #define GPC6_ON  ~(1<<6)
 #define GPC6_OFF (1<<6) 
 #define GPC7_ON  ~(1<<7)
 #define GPC7_OFF (1<<7)
 
 
 /*
 * KEY对应GPF5
 */
 
 #define GPF5_eint    (0x2<<(5*2))
 #define GPF5_mask    (3<<(5*2))

/***********************端口初始化******************************/ 
void port_init()
  {
    rGPCCON= rGPCCON & ~(0x3f<<10)|(0x15<<10); // GPC5～7端口设置为输出
    rGPCUP= rGPCUP|(7<<5); //禁止GPC 的5～7端口引脚上拉   
    rGPCDAT= rGPCDAT|(GPC5_OFF|GPC6_OFF|GPC7_OFF);// GPC5-7端口灭掉  

    rGPCDAT=rGPCDAT&GPC5_ON;  
  }  

/*
 * 关闭WATCHDOG，否则CPU会不断重启
 */
void disable_watch_dog()
{
    rWTCON = 0;  // 关闭WATCHDOG很简单，往这个寄存器写0即可
}


/***********************中断初始化******************************/
void eint_init()
{

 // key0对应的引脚设为中断引脚 EINT5
    rGPFCON &= ~GPF5_mask;
    rGPFCON |= GPF5_eint;  
    
 // 对于EINT5，需要在EINTMASK寄存器中使能它
    rEINTMASK &= ~(1<<5);
    rINTMSK &=~(1<<4); //Enable EINT4_7 interrupt 

}



void EINT_Handle()  //中断处理函数
{
   
    //清中断
     rEINTPEND |= (1<<5);   // EINT4_7合用IRQ4
    rSRCPND |= 1<<4;
    rINTPND |= 1<<4;
      
    //点亮LED6
        rGPCDAT=rGPCDAT|GPC5_OFF|GPC7_OFF;
        rGPCDAT=rGPCDAT&GPC6_ON;
}

//********************main.c ************
 
int Main()
{
   while(1)
   {
      rGPCDAT=rGPCDAT|GPC6_OFF|GPC7_OFF;
      rGPCDAT=rGPCDAT&GPC5_ON;
    
   };
   return(0);
}

