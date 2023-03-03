t = -4:0.01:4;
duty = 50;
y=prf(t,duty,4);
%ÇóÆ¥ÅäÂË²¨Æ÷
ht=conj(fliplr(y));
Hf=fft(ht,801);
Sf=fft(y,801);
s=ifft(Hf.*Sf);
t2 = -8:0.01:8;
plot(t,s/400)


