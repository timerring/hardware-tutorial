wp=0.2*pi;ws=0.3*pi;Rp=1;As=15;
T=1;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
[N,wn]=cheb1ord(OmegaP,OmegaS,Rp,As,'s')
wn=wn/pi;
[b,a]=cheby1(N,Rp,wn);
[C,B,A]=dir2cas(b,a)