wp=0.6*pi;
ws=0.4586*pi;
Rp=1;
As=15;
[b,a]=cheb1hpf(wp,ws,Rp,As);
[C,B,A]=dir2cas(b,a);