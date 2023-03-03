% 非归一化Chebyshev II型模拟低通滤波器原型设计;
% u_chb2ap.m
function [b a]=u_chb2ap(N,As,Omegac)
% Unnormalized Chebyshev-2 Anolog Lowpass Filter Prototype
%%%%%%%%%%%%%%%%%%%%%%%%%%
%[b a]=u_chb2ap(N,Rp,Omegac);
% b=numerator polynomial coefficients of Ha(s);
% a=denominator polynomial coefficients of Ha(s);
%N=Order of the Elliptic Filter;
%As=stopband Ripple in dB,As>0;
% Omegc=Cutoff frequency in radians/sec
%%%%%%%%%%%%%%%%%%%%%%%%
[z p k]=cheb2ap(N,As);
a=real(poly(p));
aNn=a(N+1);
p=p*Omegac;
a=real(poly(p));
aNu=a(N+1);
b=real(poly(p));
M=length(b);
bNn=b(M);
z=z*Omegac;
b=real(poly(z));
bNu=b(M);
k=k*(aNu*bNn)/(aNn*bNu);
b0=k;
b=k*b;