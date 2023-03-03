%冲击不变法模拟数字滤波器变换
% imp_invr.m
function [b a]=imp_invr(c,d,T) 
%Impulse Invariance Transformation from analog to digital filter;
%%%%%%%%%%%%%%%
%[b a]=imp_invr(c,d,T) 
%b=Numberator polynomial in z^(-1) of the digital filter;
%a=Denominator polynomial in z^(-1) of the digital filter;
%c=Numberator polynomial in s of the analog filter;
%d=Denominator polynomial in s of the analog filter;
%T=Sampling(transformation)parameters
%%%%%%%%%%%%%%%
[R,p,k]=residue(c,d);
p=exp(p*T);
[b a]=residue(R,p,k);
b=real(b');
a=real(a');
