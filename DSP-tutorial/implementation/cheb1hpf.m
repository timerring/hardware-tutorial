% 利用Chebyshev I 型滤波器原型设计高通滤波器
% cheb1hpf.m
function [b a]=cheb1hpf(wp.ws,Rp,As)
% IIR Highpass filter design using Chebyshev I prototype;
% [b a]=cheb1hpf(wp.ws,Rp,As);
%b=Numberator polynomial of the highpass filter;
%a=Denominator polynomial of the highpass filter;
% Wp=passband frequency in radians;
%  Ws=stopband edge frequency in radians;
%  Rp=passband ripple in dB
%  As=stopband attenuation in dB;
%Determine thr digital lowpass cutoff frequencies;
wplp=0.2*pi;
alpha=-(cos((wplp+wp)/2))/(cos((wplp-wp)/2));
wslp=angle(-(exp(-j*ws)+alpha)/(1+alpha*exp(-j*ws)));
%compute analog lowpass prototype specifications
T=1;Fs=1/T;
OmegaP=(2/T)*tan(wplp/2);
OmegaS=(2/T)*tan(wslp/2);
%design analog Chebyshev prototype lowpass filter
[cs ds]=afd_chb1(OmegaP,OmegaS,Rp,As);
%perform bilinear transformation to obtain digital lowpass
[blp alp]=bilinear(cs,ds,Fs);
%transform digital lowpass into highpass filter
Nz=-[alpha,1];Dz=[1,alpha];
[b a]=zmapping(blp,alp,Nz,Dz);


