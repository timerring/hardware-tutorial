M=20;alpha=(M-1)/2;l=0:M-1;wl=(2*pi/M)*l;
Hrs=[1,1,1,zeros(1,15),1,1];
Hdr=[1,1,0,0];wdl=[0,0.25,0.25,1];
k1=0:floor((M-1)/2);k2=floor((M-1)/2)+1:M-1;
angH=[-alpha*(2*pi)/M*k1,alpha*(2*pi)/M*(M-k2)];
H=Hrs.*exp(j*angH);h=real(ifft(H,M));
[db,mag,pha,grd,w]=freqz_m(h,1); 
[Hr,ww,a,L]=Hr_Type2(h);
subplot(221);plot(wl(1:11)/pi,Hrs(1:11),'o',wdl,Hdr);
axis([0,1,-0.1,1.1]);title('Frequency Samples:M=20')
xlabel('frequency in pi units');ylabel('Hr(k)')
subplot(222);stem(l,h);axis([-1,M,-0.1,0.3])
title('impulse response');xlabel('n');ylabel('h(n)');
subplot(223);plot(ww/pi,Hr,wl(1:11)/pi,Hrs(1:11),'o');
axis([0,1,-0.2,1.2]);title('amplitude response')
xlabel('frequency in pi units');ylabel('Hr(w)')
subplot(224);plot(w/pi,db);axis([0,1,-60,10]);grid
title('magnitude response');xlabel('frequency in pi units');ylabel('Decibels');