function hd=ideal_lp(wc,N) %点0到N-1之间的理想脉冲响应
%wc=截止频率（弧度）%N=理想滤波器的长度
tao=(N-1)/2;
n=[0:(N-1)];
m=n-tao+eps; %加一个小数以避免0作除数
hd=sin(wc*m)./(pi*m);