% Chebyshev I 型模拟低通滤波器原型设计;
% afd_chb1.m;
function [b a]=afd_chb1(Wp,Ws,Rp,As);
% Anolog Lowpass Filter Design:chebyshev-1
% ^^^^^^^^^^^^^^^^^^^
% [b a]=afd_chb1(Wp,Ws,Rp,As);
%  b=numerator polynomial coefficients of Ha(s);
%  a=denominator polynomial coefficients of Ha(s);
%  Wp=passband edge frequency in rad/sec;Wp>0;
%  Ws=stopband edge frequency in rad/sec;Ws>Wp>0;
%  Rp=passband ripple in +dB;(Rp>0);
%  As=stopband attenuation in + dB;(As>0);
%  ^^^^^^^^^^^^^^^^^^^^
 if Wp<=0
     error('passband edge must be larger than 0')
 end
 if Ws<=Wp
     error('stopband dege must be larger than passband edge')
 end
 if(Rp<=0)|(As<0)
     error('PB ripple and/or SB attenuation must be larger than 0')
 end
 ep=sqrt(10^(Rp/10)-1);
 A=10^(As/20);
 OmegaC=Wp;
 OmegaR=Ws/Wp;
 g=sqrt(A*A-1)/ep;
 N=ceil(log10(g+sqrt(g*g-1))/log10(OmegaR+sqrt(OmegaR*OmegaR-1)));
 fprintf('\n***Chebyshev-1 filter order=%2.0f\n',N)
 [b a]=u_chblap(N,Rp,OmegaC);