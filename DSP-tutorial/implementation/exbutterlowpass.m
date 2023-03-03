wp=0.2*pi;ws=0.3*pi;Rp=1;As=15;
T=1;
OmegaP=wp*T;
OmegaS=ws*T;
ep=sqrt(10^(Rp/10)-1);
Ripple=sqrt(1/(1+ep*ep));
Attn=1/(10^(As/20));
[cs,ds]=afd_butt(OmegaP,OmegaS,Rp,As);
[b,a]=imp_invr(cs,ds,T);
[C,B,A]=dir2par(b,a)

% plots
figure(1);
[db,mag,pha,grd,w]=freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);title('Magnitude Response')
xlabel('frequency in pi units');ylabel('|H|');
axis([0,1,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn,Ripple,1]);grid
subplot(2,2,2);plot(w/pi,db);title('Magnitude in dB')
xlabel('frequency in pi units');ylabel('decibels');
axis([0,1,-40,5])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[-50,-15,-1,0]);grid
%set(gca,'YTickLabelMode','manual','YTickLabels',['50';'15';'1';'0'])
subplot(2,2,3);plot(w/pi,pha/pi);title('Phase Response')
xlabel('frequency in pi units');ylabel('pi units');
axis([0,1,-1,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);grid
subplot(2,2,4);plot(w/pi,grd);title('Group Delay')
xlabel('frequency in pi units');ylabel('Sample');
axis([0,1,0,10])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[0:2:10]);grid
