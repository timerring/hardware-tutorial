% 非归一化的Chebyshev I 型模拟低通滤波器原型设计;
% u_chblap.m
function [b a]=u_chblap(N,Rp,Omegac)
% Unnormalized Chebyshev-1 Anolog Lowpass Filter Prototype
%%%%%%%%%%%%%%%%%%%%%%%%%%
%[b a]=u_chblap(N,Rp,Omegac);
% b=numerator polynomial coefficients of Ha(s);
% a=denominator polynomial coefficients of Ha(s);
%N=Order of the Elliptic Filter;
%Rp=Passband Ripple in dB,Rp>0;
% Omegc=Cutoff frequency in radians/sec
%%%%%%%%%%%%%%%%%%%%%%%%
[z p k]=cheb1ap(N,Rp);
a=real(poly(p));
aNn=a(N+1);
p=p*Omegac;
a=real(poly(p));
aNu=a(N+1);
k=k*aNu/aNn;
b0=k;
B=real(poly(z));
b=k*B;