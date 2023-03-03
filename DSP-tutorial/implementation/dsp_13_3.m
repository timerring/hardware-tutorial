f=64;
dt=1/f;
N=[16,32,64];
for k=1:3
 n=0:N(k)-1;
 nt=n*dt;
 x=cos(8*pi*nt)+cos(16*pi*nt)+cos(20*pi*nt);
 y=fft(x);
 subplot(3,3,3*k-2),stem(n,x,'.');
 title('x(n)');
 subplot(3,3,3*k-1),stem(n,abs(y),'.');
 title('abs(X(k))');
 subplot(3,3,3*k),stem(n,angle(y),'.');
 title('angle(X(k))');
end