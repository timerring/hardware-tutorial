f1=697; 
f2=770; 
f3=852; 
f4=941; 
F1=1209; 
F2=1336; 
F3=1477; 
F4=1633; 
N=205; 
tmin=40/1000; 
fs=8000; 
dt=1/fs; 
N1=floor(tmin/dt); 
if N<=N1 
 t=[0:N-1]*dt; 
else 
 error('The time is not enough!'); 
end 
k1=sin(2*pi*f1*t)+sin(2*pi*F1*t); 
k2=sin(2*pi*f1*t)+sin(2*pi*F2*t); 
k3=sin(2*pi*f1*t)+sin(2*pi*F3*t); 
ka=sin(2*pi*f1*t)+sin(2*pi*F4*t); 
k4=sin(2*pi*f2*t)+sin(2*pi*F1*t); 
k5=sin(2*pi*f2*t)+sin(2*pi*F2*t); 
k6=sin(2*pi*f2*t)+sin(2*pi*F3*t); 
kb=sin(2*pi*f2*t)+sin(2*pi*F4*t); 
k7=sin(2*pi*f3*t)+sin(2*pi*F1*t); 
k8=sin(2*pi*f3*t)+sin(2*pi*F2*t); 
k9=sin(2*pi*f3*t)+sin(2*pi*F3*t); 
kc=sin(2*pi*f3*t)+sin(2*pi*F4*t); 
km=sin(2*pi*f4*t)+sin(2*pi*F1*t); 
k0=sin(2*pi*f4*t)+sin(2*pi*F2*t); 
kj=sin(2*pi*f4*t)+sin(2*pi*F3*t); 
kd=sin(2*pi*f4*t)+sin(2*pi*F4*t); 
key=['1','2','3','a';'4','5','6','b';'7','8','9','c';'*','0','#','d']; 
k=[18,20,22,24,31,34,38,42]; 
num=input('please enter the key:','s'); 
num=num-48; 
nn=length(num); 
disp('The number of the key is: '); 
disp(nn); 
number=zeros(nn,length(t)); 
for i=1:nn 
switch num(i) 
 case 1 
 number(i,1:N)=k1; 
 case 2 
 number(i,1:N)=k2; 
 case 3 
 number(i,1:N)=k3; 
 case 4 
 number(i,1:N)=k4; 
 case 5 
 number(i,1:N)=k5; 
 case 6 
 number(i,1:N)=k6; 
 case 7 
 number(i,1:N)=k7; 
 case 8 
 number(i,1:N)=k8; 
 case 9 
 number(i,1:N)=k9; 
 case 0 
 number(i,1:N)=k0; 
 case 49 
 number(i,1:N)=ka; 
 case 50 
 number(i,1:N)=kb; 
 case 51 
 number(i,1:N)=kc; 
 case 52 
 number(i,1:N)=kd; 
 case -6 
 number(i,1:N)=km; 
 case -13 
 number(i,1:N)=kj; 
 otherwise 
 error('The key is not right!'); 
end 
end 
disp('The key is: '); 
for i=1:nn 
xgk=goertzel(number(i,1:N),k+1); 
figure; 
x=[697,770,852,941,1209,1336,1477,1633]; 
stem(x,abs(xgk),'.'); 
xlabel('Hz'); 
title('ÆµÆ×·ÖÎö'); 
zb=find(abs(xgk)>50); 
disp(key(zb(1),zb(2)-4)); 
end