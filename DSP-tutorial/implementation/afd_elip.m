%椭圆模拟低通滤波器原型设计
%afd_elip.m
function [b a]=afd_elip(Wp,Ws,Rp,As);
%Anolog lowpass filter design:Elliptic
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%[b a]=afd_elip(Wp,Ws,Rp,As);
%b=Numberator coefficients of Ha(s)
% a=denominator polynomial coefficients of Ha(s);
% Wp=passband edge frequency in rad/sec;Wp>0;
%  Ws=stopband edge frequency in rad/sec;Ws>Wp>0;
%  Rp=passband ripple in +dB;(Rp>0);
%  As=stopband attenuation in + dB;(As>0);
%%%%%%%%%%%%%%%%%%%%%%%%%
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
 k=Wp/Ws;
 k1=ep/sqrt(A*A-1);
 capk=ellipke([k.^2 1-k.^2]);
 capk1=ellipke([k1.^2 1-k1.^2]);
 N=ceil(capk(1)*capk1(2)/(capk(2)*capk1(1)));
 fprintf('\n***Elliptic Filter Order=%2.0f\n',N)
 [b a]=u_elipap(N,Rp,As,OmegaC)


