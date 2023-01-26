- [AD接口设计](#ad接口设计)
		- [S3C2410A的A/D转换器](#s3c2410a的ad转换器)
		- [四线电阻式触摸屏接口基础知识](#四线电阻式触摸屏接口基础知识)
			- [四线电阻式触摸屏组成及工作原理](#四线电阻式触摸屏组成及工作原理)
			- [四线电阻式触摸屏接口主要操作](#四线电阻式触摸屏接口主要操作)
		- [与A/D转换相关的寄存器](#与ad转换相关的寄存器)
		- [A/D接口编程实例](#ad接口编程实例)
			- [程序清单](#程序清单)


# AD接口设计

### S3C2410A的A/D转换器   

S3C2410A的A/D转换器包含一个8通道的模拟输入转换器，可以将模拟输入信号(带有采样保持器）转换成10位数字编码。在AD转换时钟为2.5MHz时，其最大转换率为500KSPS，输入电压范围是0～3.3V。 A/D转换器的AIN5、AIN7还可以与控制脚nYPON（正的Y轴开关控制）、YMON （负的Y轴开关控制） 、nXPON （正的X轴开关控制）和XMON （负的X轴开关控制）配合，实现触摸屏输入功能；

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081547262.png)

### 四线电阻式触摸屏接口基础知识

#### 四线电阻式触摸屏组成及工作原理

下图为四线电阻式触摸屏截面图及在X电极对上施加确定的电压后，X方向导电层不同位置电压示意图。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081559427.png)

下图给出了上导电层X+、X-电极、下导电层Y+、Y-电极的位置。下图（a）和下图（b）分别表示，确定触点位置时，要先在X+、X-电极对施加电压，Y+、Y-电极对不施加电压；然后在Y+、Y-电极对施加电压，X+、X-电极对不施加电压。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081611210.png)

#### 四线电阻式触摸屏接口主要操作

接口主要操作包括：有触摸动作时首先控制X+、X-电极对施加电压，Y+电极与A/D转换器连接、Y-电极对地高阻，读A/D转换值得到触点的X坐标；然后控制Y+、Y-电极对施加电压，X+电极与A/D转换器连接，X-电极对地高阻，读A/D转换值值得到触点的Y坐标；另外还有检测触摸动作，产生中断请求等操作。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081620979.png)

### 与A/D转换相关的寄存器 

+ ADC控制寄存器（ADCCON） 
+ ADC触摸屏控制寄存器（ADCTSC） 
+ ADC启动延时寄存器(ADCDLY) 
+ ADC转换数据寄存器(ADCDATn) 

为了正确使用A/D转换器，需要设置A/D转换器的时钟，还有A/D转换器的工作模式设置和输入通道选择，这都是通过ADCCON寄存器来设置的。然后置位ADCCON寄存器的ENABLE_START位来控制启动A/D转换，读ADCCON寄存器的ECFLG位来判断A/D转换是否已经结束。当一次A/D转换结束后，通过读ADCDAT0寄存器来取得A/D转换结果，寄存器的低10位数据有效；

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081643459.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081650658.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081656843.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081704233.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081710279.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081716243.png)

### A/D接口编程实例   

举例：使用串口延长线把 S3C2410的串口与PC机的COM1连接，设置串口波持率为115200， 8位数据位，无奇偶校验位，1位停止位。 调整W1、W2改变测量的电压，观察PC机上的“超级终端”主窗口显示电压值是否正确。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081730462.png)

#### 程序清单

```c
#include  "config.h"
// 定义用于保存ADC结果的变量
uint32  adc0, adc1;

// 定义显示缓冲区
char  disp_buf[50];
	
// 定义ADC转换时钟 (2MHz)
 #define  ADC_FREQ	(2*1000000)	
```

```c
/*************************************************************************************
** Function name: ReadAdc
** Descriptions: ADC转换函数          
** Input: ch 转换通道(0--7)
** Output: 返回转换结果
*************************************************************************************/
uint32  ReadAdc(uint32 ch)
{   
    int i;
	ch = ch & 0x07;		// 参数过滤
         rADCCON = (1<<14)|((PCLK/ADC_FREQ - 1)<<6)|(ch<<3)|(0<<2)|(0<<1)|(0<<0);
	// PRSCEN=1，使能分频器
	// PRSCVL=(PCLK/ADC_FREQ - 1)，即ADC转换时钟为ADC_FREQ
	// SEL_MUX=ch，设置ADC通道	
	// STDBM=0，标准转换模式
	// READ_START=0，禁止读(操作后)启动ADC
	// ENABLE_START=0，不启动ADC
         rADCTSC = rADCTSC & (~0x03);	// 普通ADC模式(非触摸屏)
	for(i=0; i<100; i++);
	rADCCON = rADCCON | (1<<0);		// 启动ADC    
    while(rADCCON & 0x01);			// 等待ADC启动        
    while(!(rADCCON & 0x8000));		// 等待ADC完成
    return (rADCDAT0 & 0x3ff);		// 返回转换结果
}					

```

```c
int  main(void)
{	 
	int   vin0, vin1;
	UART_Select(0);         // 选择UART0
    UART_Init();            // 初始化UART0	
	while(1)
	{	
	    // 进行A/D转换	
		adc0 = ReadAdc(0);
		adc1 = ReadAdc(1);		
		// 通过串口输出显示
		vin0 = (adc0*3300) / 1024;	// 读算实际电压值 (mV)
		vin1 = (adc1*3300) / 1024;
		sprintf(disp_buf, "AIN0 is %d mV,  AIN1 is %d mV \n", vin0, vin1);
		UART_SendStr(disp_buf);		
		// 延时
		DelayNS(20);
	}   		
   	return(0);
}

```

运行结果：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230106081806737.png)

参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.

杨宗德.   嵌入式ARM系统原理与实例开发 [M]．北京：北京大学出版社，2007.

S3C2410 Datasheet


[返回首页](https://github.com/timerring/hardware-tutorial)