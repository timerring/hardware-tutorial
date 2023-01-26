- [ARM定时器](#arm定时器)
    - [S3C2410A的PWM定时器](#s3c2410a的pwm定时器)
      - [定时器概述](#定时器概述)
      - [定时器工作原理](#定时器工作原理)
      - [定时器操作](#定时器操作)
        - [预分频器和除法器](#预分频器和除法器)
        - [开启一个定时器的步骤](#开启一个定时器的步骤)
        - [脉宽调制 PWM](#脉宽调制-pwm)
        - [PWM基本原理](#pwm基本原理)
        - [实例](#实例)
        - [正弦波采样](#正弦波采样)
    - [利用PWM技术实现简单DA转换](#利用pwm技术实现简单da转换)
    - [PWM简单的实现原理](#pwm简单的实现原理)
    - [S3C2410的PWM的实现原理](#s3c2410的pwm的实现原理)
        - [死区控制](#死区控制)
    - [PWM定时器控制寄存器](#pwm定时器控制寄存器)
    - [PWM应用举例](#pwm应用举例)


# ARM定时器

### S3C2410A的PWM定时器   

#### 定时器概述

S3C2410有5个16位定时器，其中定时器0、1、2、3、有PWM功能，定时器4只是一个内部定时器而无输出引脚。定时器0和定时器1具有死区发生器（dead-zone generator）。

 PWM定时器有：

+ 5个16位定时器
+ 2个8位预分频器，2个4位除法器。
+ 波形可编程（PWM）
+ 自动重装或短脉冲模式（One-shot Pulse Mode）
+ 死区发生器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100608330.png)

#### 定时器工作原理

每个定时器都有自己的16位减法计数器，该计数器由定时器时钟（来自于时钟除法器或外部时钟）驱动，当定时器计数器值减到0时，定时器发出中断请求，相应的定时器计数缓冲寄存器TCNTBn将自动载入计数器，继续下一次操作。

对于具有PWM功能的定时器，其控制逻辑中还有一个比较寄存器，当比较寄存器的值与定时器比较缓冲寄存器TCMPBn的值相等时，定时器控制逻辑改变输出逻辑。这样就能控制PWM输出的高电平或低电平的时间。

TCNTBn和TCMPBn的双缓冲特性，使得定时器在频率和占空比改变时，也能产生稳定的输出。

如果自动重装功能被启用，则当定时计数器TCNTn 计到0时，定时计数器缓冲寄存器TCNTBn 的值将被自动重装到TCNTn 。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100633342.png)

#### 定时器操作

##### 预分频器和除法器

1个8位预分频器和1个4位除法器在PCLK为50MHz时所能产生的信号频率如下表所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100652608.png)

##### 开启一个定时器的步骤

向TCNTBn和TCMPBn中写入初始值。

设置相关定时器的手动更新位。

设置相关定时器的开始位启动定时器（同时，清除手动更新位）。

##### 脉宽调制 PWM

脉冲宽度调制（PWM）是英文“Pulse Width Modulation”的缩写，简称脉宽调制。它是利用微处理器的数字输出来对模拟电路进行控制的一种非常有效的技术，广泛应用于测量，通信，功率控制与变换等许多领域。

方波信号有两个参量，一个是周期（Ts ），另一个是脉冲占空比（Dn）。占空比就是高电平的持续时间与周期之比。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100718510.png)

##### PWM基本原理

采样控制理论基础

冲量相等而形状不同的窄脉冲加在具有惯性的环节上时，其效果基本相同；

冲量指窄脉冲的面积；

效果基本相同，是指环节的输出响应波形基本相同；

将输出波形进行付氏分解，低频段非常接近，仅在高频段略有差异。

典型惯性环节就是电感、电容负载。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100732628.png)

##### 实例

电路如下图a)所示

电路输入：u(t)，窄脉冲，如上图a、b、c、d 所示

电路输出：i(t)，如下图 b)所示：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100741558.png)

##### 正弦波采样

正弦半波N 等分，可看成N 个彼此相连的脉冲序列，宽度相等，但幅值不等；

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100757078.png)

利用前面的采样控制理论我们可以在冲量相同的基础上，将这些宽度相同，幅度不同的脉冲，用幅度相同，宽度不同的脉冲来替换，效果保持相同。这些幅度相同，宽度不同的信号，就是PWM信号，该信号通过惯性负载时，和原来的正弦波信号效果相同。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100806165.png)

利用PWM技术控制惯性设备（比如：电机转速、IGBT的开关等）的输入，就相当于间接地利用模拟量控制了这些设备的行为。由于功率电子设备工作在开关状态时比工作在线性状态时工作效率更高，抗干扰能力更强，因此在电力电子应用中，常常采用这种技术对大功率电器设备进行控制。如UPS电源，开关电源，电机无级调速，恒温加热器，灯光亮度调节等应用中都会用到该技术。

### 利用PWM技术实现简单DA转换

不仅PWM信号经过惯性负载时，其输出效果等同于原来的模拟控制信号，或者其输出按原来的模拟信号变化规律变化。而且，如果PWM信号经过低通滤波器之后，我们还可以直接把其调制模拟信号取出，利用这个原理可以实现简单DA转换。

该电路没有基准电压，而且随着负载电流和环境温度的变化，精度很难保证。只能用在对D／A转换输出精度要求不高、负载很小的场合。

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100831207.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100837158.png)

图中A点的PWM波经过两级阻容滤波在B点得到直流电压信号，实现了D／A转换功能。由于放大器的输入阻抗很大，二级阻容滤波的效果很好，B点的电压纹波极小，满足高精度要求。输出放大器工作在电压跟随器方式，输出范围在(0—5)V之间。

### PWM简单的实现原理

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100850854.png)

固定幅度、斜率和周期的锯齿波加在比较器的反向端，调整信号Uc加在比较器的正向端，当Uc>锯齿波信号的电平时比较器输出高电平信号，反之输出低电平信号。这样Uc的大小决定了脉冲占空比。当Uc为一模拟信号，随着时间变化时，脉冲占空比也会随着时间变化，变化的规律和Uc一样，也就是实现了Uc对方波的PWM调制。

### S3C2410的PWM的实现原理

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100908143.png)

脉冲占空比取决于TCMPBn中的值，脉冲周期决定于TCNTBn 中的值，按照调制信号的大小改变TCMPBn 里的值，就会实现PWM调制。

##### 死区控制

全桥PWM逆变器原理图

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100925933.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107100947268.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101009923.png)

### PWM定时器控制寄存器

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101021906.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101028203.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101035006.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101041095.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101047273.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101053518.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101100967.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101107155.png)

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101114109.png)

### PWM应用举例   

举例：使用PWM输出功能，实现数模转换。

具体要求为：使用S3C2410A的TOUT0口输出PWM信号，使用RC滤波电路实现D/A转换。通过检测按键KEY1来改变PWM的占空比，改变D/A输出的电压值，输出电压分别为0.0V、0.5V、1.0V、1.5V、2.0V、2.5V和3.0V。 

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101132351.png)

程序清单

```c
   #include  "config.h"
    // 定义独立按键KEY1的输入口
      #define     KEY_CON   (1<<4)      /* GPF4口  */

/**********************************************************************************
** Function name: WaitKey
** Descriptions: 等待一个有效按键。本函数有去抖功能。      
** Input: 无
** Output: 无
********************************************************************************/
void  WaitKey(void)
{  
    uint32  i;
    while(1)
    {  
        while((rGPFDAT&KEY_CON) == KEY_CON) ;	// 等待KEY键按下
        for(i=0; i<1000; i++);				// 延时去抖
         if( (rGPFDAT&KEY_CON) != KEY_CON) break;
    }
     while((rGPFDAT&KEY_CON) != KEY_CON); 		// 等待按键放开
}
```

```c
/*****************************************************************************
** Function name: PWM_Init
** Descriptions: 初始化PWM定时器       
** Input: cycle     PWM周期控制值(uint16类型)
**           duty      PWM占空比(uint16类型)
** Output: 无
***************************************************************************/
void  PWM_Init(uint16 cycle, uint16 duty)
{	   
    // 参数过滤
    if(duty>cycle) duty = cycle;             
    // 设置定时器0,即PWM周期和占空比
    // Fclk=200MHz，时钟分频配置为1:2:4，即Pclk=50MHz。
              rTCFG0 = 97;	// 预分频器0设置为98，取得510204Hz
	rTCFG1 = 0;	// TIMER0再取1/2分频，取得255102Hz
	rTCMPB0 = duty;	    // 设置PWM占空比
	rTCNTB0 = cycle;	// 定时值(PWM周期)
	if(rTCON&0x04) rTCON = (1<<1);	
                // 更新定时器数据 (取反输出inverter位)
	     else  rTCON = (1<<2)|(1<<1);			
	rTCON = (1<<0)|(1<<3);	       // 启动定时器		  
}	

```

```c
/*****************************************************************************
** Function name: main
** Descriptions: 使用PWM输出实现DAC功能，输出电压分别为0.0V、0.5V、1.0V、1.5V、2.0V、2.5V和3.0V。            
** Input: 无
** Output: 系统返回值0
*****************************************************************************/
int  main(void)
{	
    uint16  pwm_dac;  
     // 独立按键KEY1控制口设置
      rGPFCON = (rGPFCON & (~(0x03<<8))); 
     // rGPFCON[9:8] = 00b，设置GPF4为GPIO输入模式     
     // TOUT0口设置
    rGPBCON = (rGPBCON & (~(0x03<<0))) | (0x02<<0);     
    // rGPBCON[1:0] = 10b，设置TOUT0功能    
    rGPBUP = rGPBUP | 0x0001; // 禁止TOUT0口的上拉电阻 
   
    // 初始化PWM输出。设PWM周期控制值为255 (即DAC分辨率为8位)
    pwm_dac = 0;     // 初始化占空比为0,即输出0V电压
    PWM_Init(255, pwm_dac);          
 	// 等待按键KEY1，改变占空比	
   while(1)
    {		                    
            WaitKey();	    
               // 由于PWM周期控制值为255，所以0.5V对应的PWM占空比的
               // 值为：0.5/3.3 * 256 = 39
            pwm_dac = pwm_dac + 39;     // 改变D/A输出的电压值
	if(pwm_dac>255) 
	{   
                   pwm_dac = 0; 		    
	}
	rTCMPB0 = pwm_dac;		
    }		
    return(0);
}
```

运行结果：

![](https://raw.githubusercontent.com/timerring/picgo/master/picbed/image-20230107101220427.png)

参考文献：

孟祥莲．嵌入式系统原理及应用教程（第2版）[M]．北京：清华大学出版社，2017.

杨宗德.   嵌入式ARM系统原理与实例开发 [M]．北京：北京大学出版社，2007.

S3C2410 Datasheet



[返回首页](https://github.com/timerring/hardware-tutorial)