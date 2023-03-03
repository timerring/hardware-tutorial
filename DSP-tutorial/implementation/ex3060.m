wplp=0.2*pi;wslp=0.3*pi;Rp=1;As=15;
T=1;Fs=1/T;
OmegaP=(2/T)*tan(wplp/2);
OmegaS=(2/T)*tan(wslp/2);
ep=sqrt(10^(Rp/10)-1);
Ripple=sqrt(1/(1+ep*ep));
Attn=1/(10^(As/20));
[cs,ds]=afd_chb1(OmegaP,OmegaS,Rp,As);
[blp,alp]=bilinear(cs,ds,T);
wphp=0.6*pi;
alpha=-(cos((wplp+wphp)/2))/(cos((wplp-wphp)/2))
Nz=-[alpha,1];Dz=[1,alpha];
[bhp,ahp]=zmapping(blp,alp,Nz,Dz);
[C,B,A]=dir2cas(bhp,ahp)

%
%plot
figure(1);
[dbl,magl,phal,grdl,w]=freqz_m(blp,alp);
subplot(2,2,1);plot(w/pi,magl);title('Lowpass Filter Magnitude Response')
xlabel('frequency in pi units');ylabel('|H|');
axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,1]);
set(gca,'YTickMode','manual','YTick',[0,Ripple,1]);grid
subplot(2,2,2);plot(w/pi,dbl);title('Lowpass Filter Magnitude in dB')
xlabel('frequency in pi units');ylabel('decibels');
axis([0,1,-30,0])
set(gca,'XTickMode','manual','XTick',[0,0.2,1]);
set(gca,'YTickMode','manual','YTick',[-30,-Rp,0]);grid
%set(gca,'YTickLabelMode','manual','YTickLabels',['30';'1';'0']);
[dbh,magh,phah,grdh,w]=freqz_m(bhp,ahp);
subplot(2,2,3);plot(w/pi,magh);title('Highpass Filter Magnitude Response')
xlabel('frequency in pi units');ylabel('|H|');
axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.6,1]);
set(gca,'YTickMode','manual','YTick',[0,Ripple,1]);grid
subplot(2,2,4);plot(w/pi,dbh);title('Highpass Filter Magnitude in dB')
xlabel('frequency in pi units');ylabel('decibels');
axis([0,1,-30,0])
set(gca,'XTickMode','manual','XTick',[0,0.6,1]);
set(gca,'YTickMode','manual','YTick',[-30,-Rp,0]);grid