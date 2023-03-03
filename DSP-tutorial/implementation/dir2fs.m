function[N,Hk,wk]=dir2fs(b)
N=length(b);
Hk=fft(b);
k=0:N-1;
wk=exp(2*pi*1i/N).^k;
end

