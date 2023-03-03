%频率采样法
M=33;alpha=(M-1)/2;Dw=2*pi/M;l=0:M-1;wl=Dw*l;
k1=0:floor((M-1)/2);k2=floor((M-1)/2)+1:M-1;
Hrs=[j*Dw*k1,-j*Dw*(M-k2)];
angH=[-alpha*Dw*k1,alpha*Dw*(M-k2)];
H=Hrs.*exp(j*angH);h=real(ifft(H,M));[Hr,ww,a,P]=Hr_Type3(h);
%plots
figure;
subplot(211);stem(0:M-1,h);title('Actual Impulse Response')
axis([-1 M -0.5 1.5]);xlabel('n');ylabel('h(n)')
subplot(212);plot(ww/pi,Hr/pi);title('Amplitude Response');grid;
axis([0 1 -0.5 1.5]);xlabel('frenquency in pi units');ylabel('slope in pi units');