t1=-4:0.01:4;%定义时间的变化
y=rectpuls(t1-1,2)
y1=rectpuls(-t1-1,2)
y3=conv(y,y1);
y3=y3*0.01;
t0=2.*t1(1);
t3=length(y)+length(y1)-2; 
t=t0:0.01:(t3*0.01+t0);
subplot(2,2,1)
plot(t1,y)
title('g_4(t)');
xlabel('t');
ylabel('g_4(t)');
grid on
axis([-4,4,-1.5,1.5])
subplot(2,2,2)
plot(t1,y1)
title('g_4(t)的相关器的冲激响应');
xlabel('t');
ylabel('h（t）');
grid on
axis([-4,4,-1.5,1.5])
subplot(2,2,3)
plot(t,y3)
title('输出波形');
xlabel('t');
ylabel('y(t)');
grid on
axis([-8,8,-3,5])
