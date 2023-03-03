n=0:11; 
x=[1,2,3,4,5,6,6,5,4,3,2,1]; 
k=n; 
N=length(n); 
y=x*exp(-j*2*pi/N).^(n'*k);%DFT 
w=linspace(-2*pi,2*pi,500); 
y1=x*exp(-j*n'*w);%DTFT 
figure; 
subplot(4,1,1);stem(n,x,'.');ylabel('x£¨n£©'); 
subplot(4,2,3);stem(k,abs(y),'.');ylabel('mag X(k)'); 
subplot(4,2,4);stem(k,angle(y),'.');ylabel('ang X(k)'); 
subplot(4,1,3);plot(w/pi,abs(y1));xlabel('X pi');ylabel('X(jw)'); 
subplot(4,1,4);plot(w/pi,angle(y1));xlabel('X pi');ylabel('arg(jw)'); 
figure;%mag 
stem(2*k/N,abs(y),'filled'); 
hold on; 
plot(w/pi,abs(y1));xlabel('X pi');title('mag'); 
figure;%arg 
stem(2*k/N,angle(y),'filled'); 
hold on; 
plot(w/pi,angle(y1));xlabel('X pi');title('arg');