%非归一化的Butterworth模拟低通滤波器原型设计
% u_buttap.m file
function [b a]=u_buttap(N,Omegac)
% Unnormorlized Butterworth Analog Lowpass Filter Prototype
% _____________________________________________
% [b,a]=u_buttap(N,Omegac);
% b=numerator polynomial coefficients of Ha(s)
% a=denominator polynomial coefficients of Ha(s)
% N=Order of the Butterworth Fiter
% Omegc=Cutoff frequency in radians/sec
[z p k]=buttap(N);
p=p*Omegac;
k=k*Omegac^N;
B=real(poly(z));
b0=k;
b=k*B;
a=real(poly(p));


