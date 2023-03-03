function[m,a,w]=dtft(x)
N=length(x);
n=0:N-1;
w=linspace(-2*pi,2*pi,500);
y=x*exp(-j*n'*w);
m=abs(y);
a=angle(y);