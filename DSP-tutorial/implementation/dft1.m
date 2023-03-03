%dft1.m 
function[Am,pha]=dft1(x)
N=length(x);
w=exp(-j*2*pi/N);
for k=1:N
 sum=0;
 for n=1:N
 sum=sum+x(n)*w^((k-1)*(n-1));
 end
 Am(k)=abs(sum);
 pha(k)=angle(sum);
end
