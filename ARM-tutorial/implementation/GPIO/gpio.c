 #define rGPCCON (*(volatile unsigned *)(0x56000020))
 #define rGPCDAT (*(volatile unsigned *)(0x56000024)) 
 #define rGPCUP (*(volatile unsigned *)(0x56000028)) 
 
 #define rGPFCON (*(volatile unsigned *)(0x56000050))
 #define rGPFDAT (*(volatile unsigned *)(0x56000054)) 
 #define rGPFUP (*(volatile unsigned *)(0x56000058)) 

 #define GPC5_ON  ~(1<<5)
 #define GPC5_OFF (1<<5) 
 #define GPC6_ON  ~(1<<6)
 #define GPC6_OFF (1<<6) 
 #define GPC7_ON  ~(1<<7)
 #define GPC7_OFF (1<<7)
 

void delay(int time) //延时函数,用于扫描按键时去软件抖动
{  
    int i,j; 
    for(i=0;i<time;i++)    
        for(j=0;j<255;j++);       
} 

void port_init()
{
  rGPCCON= rGPCCON & ~(0x3f<<10)|(0x15<<10); // GPC5～7端口设置为输出
  rGPCUP= rGPCUP|(7<<5); //禁止GPC 的5～7端口引脚上拉
  
  rGPFCON= rGPFCON & ~(0x3<<10); //将GPF的5端口设置为输入
  rGPFUP= rGPCUP & ~(1<<5); // GPF 的5端口引脚上拉
  
 // delay(10);
  
  rGPCDAT= rGPCDAT|(GPC5_OFF|GPC6_OFF|GPC7_OFF);// GPC5-7端口灭掉  

}

char Key_Scan() //按键扫描程序 
{
  char key=rGPFDAT&(1<<5);
  
 if(!key)  //如果GPF5被按下，读取到低电平   
  {
      delay(100); //延时去抖动，这里只是一个大概的延时值 
      if(!key) //再次判断
         return 1; //返回"1"
      else
         return 0;
  }
  else
   return 0;
}
   
int main()
{
   int count=0;
   char direction=0;
  // char olddir=0;
   port_init();
   while(1)
   {
      if(Key_Scan())
        direction=1;
      else
        direction=0;
                   
      switch(count)
      {
        case 0:
          rGPCDAT=rGPCDAT&GPC5_ON;
          rGPCDAT=rGPCDAT|GPC6_OFF|GPC7_OFF;
          delay(400);
          break; 
        case 1:
          rGPCDAT=rGPCDAT&GPC6_ON;
          rGPCDAT=rGPCDAT|GPC5_OFF|GPC7_OFF;
          delay(400);
          break;
        case 2:
          rGPCDAT=rGPCDAT&GPC7_ON;
          rGPCDAT=rGPCDAT|GPC5_OFF|GPC6_OFF;
          delay(400);
          break;
        default:
          break;
      }   
       
      if(!direction)
       {
         if(count==2)
           count=-1;
         count++;
       }
      else
       {
        if(count==0)
           count=3;
        count--;
       };           
        
    }
}

