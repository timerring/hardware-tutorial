/*******************************************************************
* File： armasmc.c
********************************************************************/
#include <stdio.h>
int Main()
{  

  extern void delayxms(int xms);  //在C程序调用汇编程序之前需要在C语言程序中使用extern关键词来声明该汇编程序
  
  int i=100;
  
  while(1)
  {
     delayxms(1000);
     i--;
     if(i==0)
       i=100;
  }
  
  return 0;
}