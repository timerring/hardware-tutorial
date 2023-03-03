for N=5:5:10 
n=0:N-1;k=n; 
x=[n>=0]; 
n1=0:6*N-1;k1=n1; 
x1=x(mod(n1,N)+1); 
y=x*exp(-j*2*pi/N).^(n'*k); 
y1=x1*exp(-j*2*pi/N).^(n1'*k1); 
w=linspace(-2*pi,2*pi,500); 
y2=x*exp(-j*n'*w); 
figure; 
subplot(4,2,1);stem(n,x,'.');ylabel('x'); 
subplot(4,2,2);stem(n1,x1,'.');ylabel('x~(n)'); 
subplot(4,2,3);stem(k,abs(y),'.');ylabel('mag X(k)'); 
subplot(4,2,4);stem(k,angle(y),'.');ylabel('ang X(k)'); 
subplot(4,2,5);stem(k1,abs(y1),'.');ylabel('mag X~(k)'); 
subplot(4,2,6);stem(k1,angle(y1),'.');ylabel('ang X~(k)'); 
subplot(4,1,4);plot(w/pi,abs(y2));xlabel('X pi');ylabel('X(w)'); 
end