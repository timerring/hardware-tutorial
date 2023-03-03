function [A,w,type,tao]=amp(h);
N=length(h);
tao=(N-1)/2;
L=floor((N-1)/2);
n=1:L+1;
w=[0:500]*2*pi/500;
if all(abs(h(n)-h(N-n+1))<1e-10)
 A=2*h(n)*cos(((N+1)/2-n)'*w)-mod(N,2)*h(L+1);
 type=2-mod(N,2);
elseif all(abs(h(n)+h(N-n+1))<1e-10)&(h(L+1)*mod(N,2)==0)
 A=2*h(n)*sin(((N+1)/2-n)'*w);
 type=4-mod(N,2);
else disp('错误：这是非线性相位系统！');
 [A,m,w]=dtft(h);
 A=A.*exp(i*m);
 type='?';
 tao='?';
 
end