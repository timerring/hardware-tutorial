%非归一化椭圆模拟低通滤波器原型设计
%u_elipap.m
function [b a]=u_elipap(N,Rp,As,Omegac)
%unnormorlized elliptic analog lowpass filter prototype ;
%[b a]=u_elipap(N,Rp,As,Omegac);
% ^^^^^^^^^^^^^^^^^^
%  b=numerator polynomial coefficients of Ha(s);
%  a=denominator polynomial coefficients of Ha(s);
% N=order of elliptic filter;
%  Rp=passband ripple in +dB;(Rp>0);
%  As=stopband attenuation in + dB;(As>0);
% Omegac=cutoff frequency in radians/sec  
%^^^^^^^^^^^^^^^^^^^^
[z p k]=ellipap(N,Rp,As);
a=real(poly(p));
aNn=a(N+1);
p=p*Omegac;
a=real(poly(p));
aNu=a(N+1);
b=real(poly(z));
M=length(b);
bNn=b(M);
z=z*Omegac;
b=real(poly(z));
bNu=b(M);
k=k*(aNu*bNn)/(aNn*bNu);
b0=k;
b=k*b;