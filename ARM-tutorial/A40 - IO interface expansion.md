- [I/O接口扩展](#io接口扩展)
  - [端口控制寄存器](#端口控制寄存器)
  - [I/O口编程实例](#io口编程实例)
    - [实例1](#实例1)
    - [实例2](#实例2)


## I/O接口扩展

S3C2410A共有117个多功能复用输入输出口（I/O口），分为8组PORT A～PORT H。PORT A除了作为功能口外，它只作为输出口使用；其余的PORT B～PORT H都可以作为输入输出口使用。8组I/O口按照其位数的不同，可分为：

+ 1个23位的输出口（PORT A）
+ 2个11位的I/O口（PORT B 和PORT H）
+ 4个16位的I/O口（PORT C、PORT D、PORT E、PORT G）
+ 1个8位的I/O口（PORT F）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105075857842.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105075908173.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105075918351.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105075927255.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105075935329.png)

### 端口控制寄存器

与配置I/O口相关的寄存器包括：

（1）端口控制寄存器（GPACON~GPHCON）
S3C2410大部分引脚是复用的，在使用这些引脚之前，需要定义其中的一个功能，这个端口控制寄存器就是实现该功能的。

（2）端口数据寄存器（GPADAT~GPHDAT）
如果端口被配置为输出端口，可以将要输出的数据写入该端口数据寄存器，如果端口被配置为输入端口，可以从端口数据寄存器读取所输入的数据。

（3）端口上拉寄存器（GPBUP~GPHUP）
端口上拉寄存器控制着每个端口组的上拉寄存器的使能或禁止。0允许，1禁止。

（4）MISCELLANEOUS杂项控制寄存器
控制着USB、时钟、数据总线的端口属性。

外部中断控制寄存器（EXTINTN） 

用来配置24个外部中断请求信号的触发方式（电平、边沿）

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080012689.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080049969.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080108171.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080119090.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080130229.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080137113.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080145654.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080152436.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080159375.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080208156.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080223800.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080231107.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080238513.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080245395.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080251730.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080258308.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080305663.png)

### I/O口编程实例 

#### 实例1

输出实例：使用GPIO控制LED1～LED4，使其指示0～F的16进制数值（LED4为最高位，LED1为最低位）。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080323299.png)

程序清单

```c
   #include  "config.h"
   /**************************************************************************************
   ** Function name: LED_DispNum
   ** Descriptions: 控制LED1～LED4显示指定16进制数值。LED4为最高位，  
   **                       LED1为最低为，点亮表示该位为1。      
   ** ** Output: 无
   ********************************************************************************/
     void  LED_DispNum(uint32 dat)   // Input: dat   显示数值(低4位有效)
     {
         dat = dat & 0x0000000F;     // 参数过滤
         // 控制LED4、LED3显示(d3、d2位)
         if(dat & 0x08) rGPHDAT = rGPHDAT | (0x01<<6); 
            else  rGPHDAT = rGPHDAT & (~(0x01<<6)); 
         if(dat & 0x04) rGPHDAT = rGPHDAT | (0x01<<4); 
           else  rGPHDAT = rGPHDAT & (~(0x01<<4));        
        // 控制LED2、LED1显示(d1、d0位)
         rGPEDAT = (rGPEDAT & (~(0x03<<11))) | ((dat&0x03) << 11); 
      }

    /******************************************************************************************
     ** Function name: DelayNS
     ** Descriptions: 长软件延时。延时时间与系统时钟有关。
     ** Input: dly	延时参数，值越大，延时越久
     ** Output: 无
     *************************************************************************************/
    void  DelayNS(uint32  dly)
     {  
   	    uint32  i;
         for(; dly>0; dly--) 
         for(i=0; i<50000; i++);
     }

int  main(void)
{		
    int  i;
    
    // 初始化I/O
    rGPECON = (rGPECON & (~(0x0F<<22))) | (0x05<<22);  
      // rGPECON[25:22] = 0101b，设置GPE11、GPE12为GPIO输出模式
    rGPHCON = (rGPHCON & (~(0x33<<8))) | (0x11<<8);    
      // rGPHCON[13:8] = 01xx01b，设置GPH4、GPH6为GPIO输出模式
        
    // LED显示控制
    while(1)
    {                        
        // 控制LED指示0～F的16进制数值
        for(i=0; i<16; i++)
        {
            LED_DispNum(i);     // 显示数值i
            DelayNS(5);
        }
    }  
  return(0);
}


```

#### 实例2

输入实例： S3C2410A的GPF4口（输入口）连接一个独立按键KEY1。当KEY1键按下时，GPH10口（输出口）上的蜂鸣器便发出声响，松开按键时，蜂鸣器便停止发声。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230105080418338.png)

程序清单

```c
   #include  "config.h"
   // 定义独立按键KEY1的输入口
       #define     KEY_CON	(1<<4) /* GPF4口  */

   // 定义蜂鸣器控制口
       #define   	BEEP   	(1<<10)     	/* GPH10口 */	
       #define   	BEEP_MASK	(~BEEP)

  int  main(void)
   {	
        // 初始化I/O
         rGPFCON = (rGPFCON & (~(0x03<<8)));   
        // rGPFCON[9:8] = 00b，设置GPF4为GPIO输入模式   
        rGPHCON = (rGPHCON & (~(0x01<<21))) | (0x01<<20);  
        //  rGPHCON[21:20] = 01b，设置GPH10为GPIO输出模式 	
        rGPHDAT = rGPHDAT & BEEP_MASK; 
        // 初始状态按键未按下，设置GPH10=0，禁止蜂鸣器发声											    
       while(1)
         {
             if(rGPFDAT & KEY_CON)  // 判断GPF4是否为高电平
             {
                   rGPHDAT = rGPHDAT & BEEP_MASK; 
                    // GPF4为高电平，按键未按下，则设置GPH10=0
             }
           else
            {
                   rGPHDAT = rGPHDAT | BEEP;       
                    // GPF4为低电平，按键已按下，则设置GPH10=1
            }
          
           DelayNS(1);
        }
  	return(0);
}

```


参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.



[返回首页](https://github.com/timerring/hardware-tutorial)