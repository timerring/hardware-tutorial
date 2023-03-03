Wp=0.2*pi;Ws=0.3*pi;Rp=1;As=16;
Ripple=10^(-Rp/20);Attn=10^(-As/20);
[b,a]=afd_chb1(Wp,Ws,Rp,As);
[C,B,A]=sdir2cas(b,a)
[db,mag,pha,w]=freqs_m(b,a,0.5*pi);
[ha,x,t]=impulse(b,a);

% plots
figure(1)
subplot(2,2,1);plot(w/pi,mag);title('Magnitude Response')
xlabel('Analog frequency in pi units');ylabel('|H|');
axis([0,0.5,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickMode','manual','YTick',[0,Attn,Ripple,1]);grid
subplot(2,2,2);plot(w/pi,db);title('Magnitude in dB')
xlabel('Analog frequency in pi units');ylabel('decibels');
axis([0,0.5,-30,5])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickMode','manual','YTick',[-30,-As,-Rp,0]);grid
%set(gca,'YTickLabelMode','manual','YTickLabels',['30';'16';'1';'0'])
subplot(2,2,3);plot(w/pi,pha/pi);title('Phase Response')
xlabel('Analog frequency in pi units');ylabel('radians');
axis([0,0.5,-1,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickMode','manual','YTick',[-1,-0.5,0,0.5,1]);grid
subplot(2,2,4);plot(t,ha,[0,max(t)],[0,0]);title('Impulse Response')
xlabel('time in seconds');ylabel('ha(t)');
axis([0,max(t),min(ha),max(ha)])