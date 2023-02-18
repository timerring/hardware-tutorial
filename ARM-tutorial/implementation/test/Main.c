#define DATA (*(volatile unsigned*)0x03ff5008)

void Delay(unsigned int);
int Main()
{
	unsigned long x;
	DATA=0X01;
for(;;)
{
	x=DATA;
	x=(x<<1);
	DATA=x;
	Delay(10);
	if(!(x&0X0F))
	DATA=0X01;
}
	return(0);
}
void Delay(unsigned int x)
{
	unsigned int i;
	for(i=0;i<=x;i++);
}