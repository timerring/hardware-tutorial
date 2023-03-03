clc;clear all;close all;
b=[1,13/24,5/8,1/3];a=[1];
n=0:63;
figure;
h=impz(a,b,n);
u=dstep(a,b);
subplot(2,1,1),stem(h,'.');
title('直接型单位冲激响应')
subplot(2,1,2),stem(u,'.');
title('直接型单位阶跃响应')
 
figure; 
h0=double([n==0]);
u0=double([n>=0]);
y=dir2latc(b);
h1=latcfilt(y,h0);
u1=latcfilt(y,u0);
subplot(2,1,1),stem(h1,'.');
title('全极点格型单位冲击响应')
subplot(2,1,2),stem(u1,'.');
title('全极点格型单位阶跃响应')