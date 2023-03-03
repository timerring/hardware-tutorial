for N=16:16:32 
n=0:15; 
x1=cos(5*n*pi/16); 
n=0:N-1;k=n; 
x=zeros(1,N); 
x(find(n<=15))=x1; 
y=x*exp(-j*2*pi/N).^(n'*k); 
w=linspace(-2*pi,2*pi,500); 
y1=x*exp(-j*n'*w); 
figure; 
subplot(3,1,1);stem(n,x,'.');ylabel('x(n)'); 
subplot(3,1,2);plot(w/pi,abs(y1));xlabel('X pi');ylabel('X(w)'); 
subplot(3,1,3);stem(k,abs(y),'.');ylabel('mag X(k)'); 
end