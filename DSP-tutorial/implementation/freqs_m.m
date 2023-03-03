% freqs的修正
%freqs_m.m函数可计算出滤波器的幅值响应（绝对和相对）及其相位响应
function [db mag pha w]=freqs_m(b,a,wmax)
%Computation of s-domain frequenxy response:Modified version
% _______________________________________
% [db mag pha w]=freqs_m(b,a,wmax);
% db=Relative magnitude in db over[0 to wmax];
% mag=Absolute magnitude in db over[0 to wmax];
% pha=Phase response in radians over [0 to wmax];
% w=array of 500 frequency samples between [0 to wmax];
% b=numerator polynomial coefficients of Ha(s);
% a=denominator polynomial coefficients of Ha(s);
% wmax=Maximun frequency in rad/sec over which response is desired
% ________________________
w=[0:500]*wmax/500;
H=freqs(b,a,w);
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);
