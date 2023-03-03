clc;clear all;close all;
b=[1 2 2 1];a=[1 13/24 5/8 1/3];
n=0:63;
figure;
h=impz(b,a,n);
u=dstep(b,a,n);
subplot(2,1,1),stem(h,'.');
title('直接型单位冲激响应')
subplot(2,1,2),stem(u,'.');
title('直接型单位阶跃响应')
[K,C] = dir2ladr(b,a);
figure; 
h0=[n==0];
u0=[n>=0];
h1=ladrfilt(K,C,h0);
u1=ladrfilt(K,C,u0);
subplot(2,1,1),stem(n,h1,'.');
title('格式梯形结构单位冲激响应')
subplot(2,1,2),stem(n,u1,'.');
title('格式梯形结构单位阶跃响应')