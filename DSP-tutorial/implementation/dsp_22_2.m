%blackman´°
M=21;alpha=(M-1)/2;n=0:M-1;
hd=(cos(pi*(n-alpha)))./(n-alpha);hd(alpha+1)=0;
w_black=(blackman(M))';
h=hd.*w_black;
[Hr,w,P,L]=Hr_Type3(h);
%plots
figure;
subplot(221);stem(n,hd);title('Ideal Impulse Response')
axis([-1 M -1.2 1.2]);xlabel('n');ylabel('hd(n)')
subplot(222);stem(n,w_black);title('Blackman Window')
axis([-1 M 0 1.2]);xlabel('n');ylabel('w(n)')
subplot(223);stem(n,h);title('Actual Impulse Response')
axis([-1 M -1.2 1.2]);xlabel('n');ylabel('h(n)')
subplot(224);plot(w/pi,Hr/pi);title('Amplitude Response');grid;
axis([0 1 0 1]);xlabel('frenquency in pi units');ylabel('slope in pi units');