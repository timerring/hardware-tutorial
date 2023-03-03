for N=8:8:16 
n=0:N-1;k=n; 
x=[n<=3]; 
y=x*exp(-j*2*pi/N).^(n'*k); 
figure; 
subplot(3,1,1);stem(n,x,'filled');ylabel('x£¨n£©'); 
subplot(3,1,2);stem(k,abs(y),'filled');ylabel('mag X(k)'); 
subplot(3,1,3);stem(k,angle(y),'filled');ylabel('ang X(k)'); 
end