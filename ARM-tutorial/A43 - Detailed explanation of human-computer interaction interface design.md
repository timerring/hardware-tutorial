- [人机交互接口设计详解](#人机交互接口设计详解)
	- [键盘和LED的接口原理](#键盘和led的接口原理)
		- [HD7279A与S3C2410A的连接原理图](#hd7279a与s3c2410a的连接原理图)
		- [键盘和LED控制的编程实例](#键盘和led控制的编程实例)
	- [LCD显示原理](#lcd显示原理)
		- [LCD控制器概述](#lcd控制器概述)
		- [嵌入式处理器与LCD的连接](#嵌入式处理器与lcd的连接)
		- [S3C2410A的LCD控制器](#s3c2410a的lcd控制器)
			- [（1）STN LCD](#1stn-lcd)
			- [（2）TFT LCD](#2tft-lcd)
		- [LCD控制器的框图](#lcd控制器的框图)
		- [LCD接口信号](#lcd接口信号)
		- [STN LCD控制器操作](#stn-lcd控制器操作)
			- [（1）VM的切换速率](#1vm的切换速率)
			- [（2）VFRAME 和VLINE脉冲](#2vframe-和vline脉冲)
			- [（3）VCLK 信号速率](#3vclk-信号速率)
			- [（4）帧速率](#4帧速率)
		- [视频操作](#视频操作)
			- [（1）查找表](#1查找表)
			- [（2）灰度模式操作](#2灰度模式操作)
			- [（3）256级彩色模式操作](#3256级彩色模式操作)
			- [（4）4096级彩色模式操作](#44096级彩色模式操作)
			- [（5）扫描模式支持](#5扫描模式支持)
				- [（A）4位单扫描](#a4位单扫描)
				- [（B）4位双扫描](#b4位双扫描)
				- [（C）8位单扫描](#c8位单扫描)
			- [（6）显示数据的存放](#6显示数据的存放)
		- [与LCD相关的寄存器](#与lcd相关的寄存器)
		- [LCD显示的编程实例](#lcd显示的编程实例)
	- [触摸屏工作原理](#触摸屏工作原理)
		- [四线电阻触摸屏原理](#四线电阻触摸屏原理)
		- [S3C2410A的触摸屏接口](#s3c2410a的触摸屏接口)
		- [CPU与触摸屏连接图](#cpu与触摸屏连接图)
		- [触摸屏编程实例](#触摸屏编程实例)


# 人机交互接口设计详解

## 键盘和LED的接口原理    

HA7279A是一片具有串行接口并可同时驱动8位共阴式数码管或64只独立LED的智能显示驱动芯片。该芯片同时可连接多达64键的键盘矩阵，一片即可完成LED显示及键盘接口的全部功能。 

HA7279A一共有28个引脚：

+ RESET：复位端。通常，该端接＋5V电源；
+ DIG0～DIG7：８个LED管的位驱动输出端；
+ SA～SG：LED数码管的Ａ段～Ｇ段的输出端；
+ DP：小数点的驱动输出端；
+ RC：外接振荡元件连接端。
+ HD7279A与微处理器仅需４条接口线:
+ CS：片选信号（低电平有效）；
+ DATA：串行数据端。
+ CLK：数据串行传送的同步时钟输入端，时钟的上升沿表示数据有效。
+ KEY:按键信号输出端。该端在无键按下时为高电平；而在有键按下时变为低电平，并一直保持到按键释放为止。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108090920172.png)

### HD7279A与S3C2410A的连接原理图   

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108090930630.png)

### 键盘和LED控制的编程实例 

举例：通过按键来控制LED的显示。 

1．键盘中断的初始化 

```c
void KeyINT_Init(void){
    rGPFCON=(rGPFCON&0xF3FF)|(2<<10);
    rGPECON=(rGPECON&0xF3FFFFFF)|(0x01<<26); //设置GPE13为输出位，模拟时钟输出
    rEXTINT0 &= 0xff8fffff; //外部中断5低电平有效
    if (rEINTPEND & 0x20)   //清除外部中断5的中断挂起位
        rEINTPEND |= 0x20;
    if ((rINTPND & BIT_EINT4_7)){
    	rSRCPND |= BIT_EINT4_7;
    	rINTPND |= BIT_EINT4_7;
    }
    rINTMSK  &= ~(BIT_EINT4_7);      //使用外部中断4～7
    rEINTMASK &= 0xffffdf;           //外部中断5使能
    pISR_EINT4_7 = (int)Key_ISR;
}
```

2．书写中断服务子程序 

```c
void __irq Key_ISR( void ){ 
	int j;
	rINTMSK  |= BIT_ALLMSK;   // 关中断
	if (rEINTPEND & 0x20){
  		key_number = read7279(cmd_read);//读键盘指令程序
  		rINTMSK  &= ~(BIT_EINT4_7);
  		switch(key_number){ 
  		  case 0x04 :     key_number = 0x08;   break;
  		  case 0x05 :     key_number = 0x09;   break;
  		  case 0x06 :     key_number = 0x0A;   break;
  		  case 0x07 :     key_number = 0x0B;   break;
  		  case 0x08 :     key_number = 0x04;   break; 
  		  case 0x09 :     key_number = 0x05;   break;
  		  case 0x0A :     key_number = 0x06;   break;
  		  case 0x0b :     key_number = 0x07;   break;
  		  default:        break;
  	     }
    	Uart_Printf("key is %x \n", key_number);
  	}
	rEINTPEND |= 0x20;
	rSRCPND |= BIT_EINT4_7;
    rINTPND |= BIT_EINT4_7;
}
```

3．主程序的主要功能是根据按键键值，向HD7279A发送不同的处理命令，程序结构如下。 

```c
void Main(){ 
 	char p;
 	Target_Init(); //目标初始化
  	while(1){  
  	    switch(key_number){
 	       case 0:  send_byte(cmd_test); //测试键
  			    break;
                case 1: for(p=0;p<8;p++){         //右移8位
              		send_byte(0xA0);
            		send_byte(0xC8+7);    
            		send_byte(p);
                                long_delay();
                                Delay(7000);
                        } break;
   	       //case 2到case14
 	       case 15://最右两个数码管上显示15
  		    write7279(decode1+5,key_number/16*8);
    	                write7279(decode1+4,key_number & 0x0f);
  		    break;
  	       default: break;
  	     }
 	     key_number = 0xff;
 	     Delay(50);
	}
} 
```

## LCD显示原理 

所谓LCD，是Liquid Crystal Display的缩写，即液晶显示器。LCD液晶显示器主要有两类：STN（Super Twisted Nematic,超扭曲向列型）和TFT（Thin Film Transistor，薄膜晶体管型）。对于S3C2410A的LCD控制器，同时支持STN和TFT显示器。

STN与TFT的主要区别在于：

+ 从工作原理上看，STN主要是增大液晶分子的扭曲角，而TFT为每个像素点设置一个开关电路，做到完全单独的控制每个像素点；
+ 从品质上看，STN的亮度较暗，画面的质量较差，颜色不够丰富，播放动画时有拖尾现象,耗电量小，价格便宜；而TFT亮度高，画面质量高，颜色丰富，播放动画时清晰，耗电量大，价格高。

### LCD控制器概述

市面上出售的LCD有两种类型：

一种是带有驱动控制电路的LCD显示模块，这种LCD可以方便地与各种低档单片机进行接口；

另一种是LCD显示屏，没有驱动控制电路， 

大部分ARM处理器中都集成了LCD控制器，所以对于采用ARM处理器的系统，一般使用不带驱动电路的LCD显示屏。 

### 嵌入式处理器与LCD的连接

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091210976.png)

### S3C2410A的LCD控制器 

S3C2410A中的LCD控制器可支持STN和TFT两种液晶显示屏。 LCD控制器支持单色、4级、16级灰度LCD显示，以及8位彩色（256色）、12位彩色（4096色）LCD显示。LCD控制器由REGBANK、LCDCDMA、VIDPRCS、TIMEGEN和LPC3600组成。  

#### （1）STN LCD

— 支持 3 种STN LCD 显示: 4-bit 双扫描, 4-bit 单扫描, 和8-bit 单扫描
— 支持二值, 4 级灰度, 16 级灰度，256色 和 4096 色的 STN LCD
— 典型屏幕尺寸为：640×480, 320×240, 160×160等。256色模式虚拟屏幕尺寸为：4096×1024, 2048×2048, 1024×4096等等

#### （2）TFT LCD

— 支持 1位、2位、4位和8位 调色板模式的TFT LCD 显示
— 支持16位、24位（16M）非调色板模式的TFT LCD显示
— 典型实际屏幕尺寸为 640×480, 320×240, 160×160等。64K 彩色模式下支持的最大虚拟屏幕尺寸为 2048×1024

### LCD控制器的框图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091312367.png)

+ REGBANK：寄存器组，由17个寄存器和一个256×16的调色板构成，用来设置LCD控制器。
+ LCDCDMA：专用DMA，用来自动将存储器中的视频数据传送到LCD驱动器中。无需CPU干涉。
+ VIDPRCS：视频数据产生，用来从LCDCDMA接收视频数据，并且转换成适当的格式（如：4/8比特单扫描或4比特双扫描），然后从端口VD[23:0] 发送到LCD驱动器。
+ TIMEGEN: 时序产生，用来产生视频控制信号。
+ LPC3600：定时控制生成逻辑单元。

### LCD接口信号

S3C2410A中的LCD控制器一共有33个输出端口，其中24个数据信号端口，9个控制信号端口。  

+ VFRAME/VSYNC/STV : LCD控制器发往驱动器的帧同步信号 ，它表示新的一帧的开始。LCD控制器在一个完整的帧显示后发出该信号，开始新的一帧的显示。
+ VLINE/HSYNC/CPV : LCD控制器发往驱动器的行同步脉冲信号 ，LCD驱动器在收到该信号后，将水平移位寄存器的内容显示到LCD屏上。LCD控制器在一整行数据全部传输到LCD驱动器后，发出一个VLINE信号。
+ VCLK/LCD_HCLK : LCD控制器发往驱动器的像素时钟信号 ，LCD控制器在VCLK的上升沿发送数据，LCD驱动器在VCLK的下降沿采样数据。
+ VD[23:0] : LCD 像素数据输出端口 ，也就是平时所说的RGB信号线，采用的是5：6：5的模式。
+ VM/VDEN/TP : LCD 驱动器所使用的的AC 偏置信号 。LCD驱动器使用该信号改变行电压和列电压的极性，进而打开或者关闭像素，使像素点显示或熄灭。VM信号可以与帧同步信号或者行同步信号进行同步。
+ LEND/STH : 行终止信号 (TFT)/SEC TFT信号 STH
+ LCD_PWREN : LCD 电源使能信号
+ LCDVF0 : SEC TFT OE信号
+ LCDVF1 : SEC TFT REV信号
+ LCDVF2 : SEC TFT REVB信号

### STN LCD控制器操作

定时发生器 (TIMEGEN)

TIMEGEN产生LCD驱动器所需要的各种控制信号，如：VFRAME, VLINE, VCLK, 和VM。 这些信号是与REGBANK 里面的寄存器LCDCON1/2/3/4/5 的配置密切相关的。可以通过改变这些寄存器的配置使得这些控制信号能够满足各种LCD驱动器的要求。比如：

####  （1）VM的切换速率

VM 的切换速率由LCDCON1寄存器的 MMODE位和LCDCON4寄存器的MVAL 字段来决定。如果MMODE = 0,则VM信号每帧切换一次。如果MMODE =1 ，则VM 每MVAL[7:0]个VLINE切换一次，即： 

VM Rate = VLINE Rate / ( 2 * MVAL)  ，如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091406015.png)

#### （2）VFRAME 和VLINE脉冲 

VFRAME 和VLINE脉冲的产生依赖于LCDCON2/3寄存器的HOZVAL字段和LINEVAL 字段。这两个字段的值由LCD的显示尺寸和显示模式决定：

HOZVAL = (水平显示尺寸 / 有效 VD 数据行数)- 1

（在彩色显示模式水平显示尺寸= 3 ×水平像素数；在4位单扫描和4位双扫描模式，有效 VD 数据行数为4，在8位单扫描模式，有效 VD 数据行数为8. ）

```c
LINEVAL = (垂直显示尺寸) -1  //单扫描模式下

LINEVAL = (垂直显示尺寸/2) -1  //双扫描模式下 
```

#### （3）VCLK 信号速率 

VCLK 信号的速率依赖于LCDCON1寄存器的CLKVAL 字段的设置。VCLK与 CLKVAL（最小为2）的对应关系为：
`VCLK(Hz)=HCLK/(CLKVAL x 2)`  

如下表所示： 

![image-20230108091421378](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091421378.png)

#### （4）帧速率

帧速率即是VFRAM 信号的频率. 帧速率与LCDCON1/2/3/4寄存器中的WLH[1:0](VLINE脉冲宽度),WDLY[1:0] (VLINE脉冲之后的VCLK延时长度)，HOZVAL，LINEBLANK和LINEVAL等字段，以及VCLK和HCLK有关。帧速率的计算公式为： 
`frame_rate(Hz) = 1/{[(1/VCLK)×(HOZVAL+1)+(1/HCLK)×(A+B+(LINEBLANK×8))]×(LINEVAL+1)}`

其中：

`A = 2(4+WLH)，B = 2(4+WDLY)`

### 视频操作

#### （1）查找表

S3C2410 LCD控制器支持单色、2位（4级灰度）、4位（16灰度级）、8位（256级彩色）和12位（4096级彩色） LCD显示。

为了便于用户选择不同的显示模式， S3C2410 LCD控制器采用了调色板。通过这个调色板，用户可以在4灰度级模式下从16级灰度中选择4级灰度，构成查找表。在256级彩色中，8位彩色由3位红（8色）、3位绿（8色）、2位蓝（4色）构成(8×8×4= 256)，这些红绿蓝色级也是分别在自己的16级中进行选择构成查找表。在16级灰度显示模式下，不需要查找表，16个灰度级都需要。在4096级彩色中不需要查表（红、绿、蓝都是16级， 16×16×16= 4096）。

#### （2）灰度模式操作

S3C2410 LCD控制器支持两种灰度模块：2位（4级灰度）、4位（16灰度级）。其中，4级灰度模式使用查找表，并且该查找表和彩色中的蓝色共用BLUELUT寄存器中的BLUEVAL[15:0]。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091509673.png)

0级灰度用BLUEVAL[3:0]来表示（如：这四位的值是3，则表示用16级灰度中的3级来表示4级灰度中的0级）、 1级灰度用BLUEVAL[7:4]来表示， 2级灰度用BLUEVAL[11:8]来表示， 3级灰度用BLUEVAL[15:12]来表示。

#### （3）256级彩色模式操作

S3C2410 LCD控制器支持每像素8位的256色彩色模式。每个象素的8位有3位表示红，3位表示绿，2位表示兰，分别利用自己的查找表。各个表分别用REDLUT寄存器中的REDVAL[31:0]、GREENLUT寄存器中的GREENVAL[31:0]和BLUELUT寄存器中的BLUEVAL[15:0]作为查找表的入口。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091536032.png)

#### （4）4096级彩色模式操作

S3C2410 LCD控制器支持每像素12位的4096色彩色模式。每个象素的12位有4位表示红，4位表示绿，4位表示兰，不再使用查找表。

#### （5）扫描模式支持

S3C2410 LCD控制器支持3种显示：4位单扫描、4位双扫描和8位单扫描。扫描方式通过PNRMODE（LCDCON1[6:5]）来设置：

| PNRMODE | 00        | 01        | 10        | 11       |
| ------- | --------- | --------- | --------- | -------- |
| 模式    | 4位双扫描 | 4位单扫描 | 8位单扫描 | TFT  LCD |

##### （A）4位单扫描     

从VD[3：0]1次移动4位数据，直到一帧数据移位完毕。如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091608184.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091615076.png)

##### （B）4位双扫描   

显示控制器分别使用两条扫描线进行数据显示，显示数据从VD[3:0]获得高扫描数据， VD[7:4]获得低扫描数据。如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091632022.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091637921.png)

##### （C）8位单扫描     

显示数据从VD[7:0]获得扫描数据，一次输入8位行数据。如下图所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091648575.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091701852.png)

#### （6）显示数据的存放

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091711842.png)

在4级灰度模式，2bit视频数据对应一个像素

在16级灰度模式，4bit视频数据对应一个像素

在256色彩色模式，8bit视频数据对应一个像素。8位彩色数据格式如下：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091720797.png)

在4096色彩色模式，12bit视频数据对应一个像素，以字为单位的彩色数据格式如下（注意：这时彩色视频数据必须3字对齐，即8像素对齐）：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091743143.png)

### 与LCD相关的寄存器 

+ LCD控制寄存器1（LCDCON1）
+ LCD控制寄存器2（LCDCON2） 
+ LCD控制寄存器3（LCDCON3） 
+ LCD控制寄存器4（LCDCON4）
+ LCD控制寄存器5（LCDCON5） 
+ 帧缓冲起始地址寄存器1（LCDSADDR1） 
+ 帧缓冲起始地址寄存器2（LCDSADDR2）
+ 帧缓冲起始地址寄存器3（LCDSADDR3）
+ RGB查找表寄存器（REDLUT、GREENLUT 、BLUELUT ）  
+ 抖动模式寄存器（DITHMODE） 

### LCD显示的编程实例 

举例：在LCD上填充一个蓝色的矩形，并画一个红色的圆。 

1．定义与LCD相关的寄存器 

```c
#define 	M5D(n) 		((n) & 0x1fffff)
#define MVAL		(13)
#define MVAL_USED 	(0)
#define MODE_CSTN_8BIT   (0x2001)
#define LCD_XSIZE_CSTN 	(320)
#define LCD_YSIZE_CSTN 	(240)
#define SCR_XSIZE_CSTN 	(LCD_XSIZE_CSTN*2)   //虚拟屏幕大小
#define SCR_YSIZE_CSTN 	(LCD_YSIZE_CSTN*2) 
#define HOZVAL_CSTN	 (LCD_XSIZE_CSTN*3/8-1)  //有效的VD数据行号是8
#define LINEVAL_CSTN		(LCD_YSIZE_CSTN-1)
#define WLH_CSTN	        (0)
#define WDLY_CSTN		(0)
#define LINEBLANK_CSTN		(16 &0xff)
#define CLKVAL_CSTN		(6) 	
//130hz @50Mhz,WLH=16hclk,WDLY=16hclk,LINEBLANK=16*8hclk,VD=8
#define LCDFRAMEBUFFER 0x33800000  //帧缓冲区起始地址
```

2．初始化LCD，即对相关寄存器进行赋初值。其中参数type用于传递显示器的类型，如STN8位彩色、STN12位彩色等。 

```c
void  LCD_Init(int type){
      rIISPSR=(2<<5)|(2<<0); //IIS_LRCK=44.1Khz @384fs,PCLK=50Mhz.
      rGPHCON = rGPHCON & ~(0xf<<18)|(0x5<<18);
      switch(type){
        case MODE_CSTN_8BIT:  //STN8位彩色模式
          frameBuffer8Bit=(U32 (*)[SCR_XSIZE_CSTN / 4])LCDFRAMEBUFFER;
          rLCDCON1=(CLKVAL_CSTN<<8)|(MVAL_USED<<7)|(2<<5)|(3<<1)|0;
                       // 8-bit单扫描，8bpp CSTN,ENVID=关闭
          rLCDCON2=(0<<24)|(LINEVAL_CSTN<<14)|(0<<6)|0;
          rLCDCON3=(WDLY_CSTN<<19)|(HOZVAL_CSTN<<8)|(LINEBLANK_CSTN<<0);
          rLCDCON4=(MVAL<<8)|(WLH_CSTN<<0);
          rLCDCON5= 0;
          rLCDSADDR1=(((U32)frameBuffer8Bit>>22)<<21)|M5D((U32)frameBuffer8Bit>>1);
          rLCDSADDR2=M5D(((U32)frameBuffer8Bit+((SCR_XSIZE_CSTN)*LCD_YSIZE_CSTN))>>1);
          rLCDSADDR3=(((SCR_XSIZE_CSTN-LCD_XSIZE_CSTN)/2)<<11)|(LCD_XSIZE_CSTN / 2);
          rDITHMODE=0;
	   rREDLUT  =0xfdb96420;
	   rGREENLUT=0xfdb96420;
	   rBLUELUT =0xfb40;
	   break;
        default:  break;
      }
}
```

3．书写常用的绘图函数。函数_PutCstn8Bit()实现了在LCD的（x，y）处打点的功能。  

```c
void _PutCstn8Bit(U32 x,U32 y,U32 c){
    if(x<SCR_XSIZE_CSTN&& y<SCR_YSIZE_CSTN)
        frameBuffer8Bit[(y)][(x)/4]=( frameBuffer8Bit[(y)][x/4]
	    & ~(0xff000000>>((x)%4)*8) ) | ( (c&0x000000ff)<<((4-1-((x)%4))*8) );
}
```

4．书写主函数，通过调用初始化函数及绘图API函数，实现在LCD上填充一个蓝色的矩形，并画一个红色的圆。 

```c
void Main(void){
       int Count = 3000;
 	Target_Init();   //硬件初始化
 	GUI_Init();      //图形用户接口初始化，包括对LCD的初始化
  	Set_Color(GUI_BLUE);
  	Fill_Rect(0,0,319,239);
  	Delay(Count);
  	Set_Color(GUI_RED);
  	Draw_Circle(100,100,50);
  	Delay(Count);
       while(1);
} 
```

## 触摸屏工作原理 

触摸屏按其工作原理的不同可分为电阻式触摸屏、表面声波触摸屏、红外式触摸屏和电容式触摸屏几种。

最常见的是电阻式触摸屏，其屏体部分是一块与显示器表面非常配合的多层复合薄膜。触摸屏工作时，上下导体层相当于电阻网络。当某一层电极加上电压时，会在该网络上形成电压梯度。如有外力使得上下两层在某一点接触，则在另一层未加电压的电极上可测得接触点处的电压，从而知道接触点处的坐标。

### 四线电阻触摸屏原理

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108091959248.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108092011956.png)

在触摸点X、Y坐标的测量过程中，测量电压与测量点的等效电路图所示，图中P为测量点 

### S3C2410A的触摸屏接口 

S3C2410A支持触摸屏接口，它由一个触摸屏面板、四个外部晶体管、一个外部电压源、信号AIN[7]和信号AIN[5]组成。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108092034850.png)

###  CPU与触摸屏连接图  

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230108092052483.png)

### 触摸屏编程实例  

举例：在触摸屏上按下的位置画一个点 。

1．对与触摸屏相关的寄存器进行初始化 

```c
void Touch_Init(void){
    rADCDLY   = (0x5000);             // ADC启动或间隔延时
	rADCTSC   = (0<<8)|(1<<7)|(1<<6)|(0<<5)|(1<<4)|(0<<3)|(0<<2)|(3);
                                      //设置成为等待中断模式：1101
	rADCCON	= (1<<14)|(49<<6)|(7<<3)|(0<<2)|(1<<1)|(0);
                                      //设置ADC控制寄存器
}
```

2．对触摸屏中断进行初始化 

```c
void TouchINT_Init(void){
    if ((rSRCPND & BIT_ADC))                //清除中断挂起位
    	rSRCPND |= BIT_ADC;
    if ((rINTPND & BIT_ADC))
    	rINTPND |= BIT_ADC;
    if ((rSUBSRCPND & BIT_SUB_TC))
    	rSUBSRCPND |= BIT_SUB_TC;
    if ((rSUBSRCPND & BIT_SUB_ADC))
    	rSUBSRCPND |= BIT_SUB_ADC;
    rINTMSK &= ~(BIT_ADC);      //相关中断屏蔽位置0,使能中断
    rINTSUBMSK &= ~(BIT_SUB_TC);
    pISR_ADC = (unsigned)Touch_ISR;             //设置中断向量
}
```

3．书写触摸屏中断服务程序，当有触笔按下时，转到中断服务程序执行。 

```c
void __irq  Touch_ISR(void){
	int AD_XY,yPhys,xPhys;
	//关中断
	rINTMSK |= (BIT_ADC);
	rINTSUBMSK |= (BIT_SUB_ADC | BIT_SUB_TC);	// 关闭子中断(ADC和TC) 
	//获取位置
	AD_XY  = GetTouch_XY_AD();     //得到阿A/D转换后的X/Y值
	yPhys = (AD_XY) & 0xffff;      //获取Y的AD值
      xPhys = (AD_XY >> 16) & 0xffff;//获取X的AD值
      TOUCH_X = AD2X(xPhys);
      TOUCH_Y = AD2Y(yPhys);
      Touch_Show(TOUCH_X,TOUCH_Y);//实现在触摸点位置画点
      //开中断,清空挂起位
      rSUBSRCPND |= BIT_SUB_TC;
      ClearPending(BIT_ADC);
      rINTMSK  &= ~(BIT_ADC);
      rINTSUBMSK &= ~(BIT_SUB_ADC);
      rINTSUBMSK &= ~(BIT_SUB_TC);
}
```

4．书写主程序，首先对硬件及图形用户界面进行初始化，接下来通过一个while循环语句等待触摸屏中断的发生，一旦有触摸屏中断发生，则转到触摸屏中断服务程序执行。 

```c
void Main(void){
    Target_Init(); //初始化硬件
    GUI_Init();    //初始化图形用户界面
    //背景填充为蓝色
    Set_Color(GUI_BLUE);
    Fill_Rect(0,0,319,239);
    //设置当有触笔按下时，在LCD上画点的颜色为黄色
    Set_Color(GUI_YELLOW);
    //等待触摸屏中断
    while (1){}
}
```

参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.

杨宗德.   嵌入式ARM系统原理与实例开发 [M]．北京：北京大学出版社，2007.

S3C2410 Datasheet



[返回首页](https://github.com/timerring/hardware-tutorial)