clc
clear
pkg load statistics

k=3
a=4
b=7
gam=0.98

n=10^4
T=norminv((1+gam)/2);
x=unifrnd(a,b,n,k);
Z=3*log(7+x.^3)./(x+2);
I=mean(Z)
I1=mean(I)
dI=T*std(Z)/sqrt(n)
dI1=mean(dI)
In=[I1-dI1,I1+dI1]

n=10^6
x=unifrnd(a,b,n,k);
Z=3*log(7+x.^3)./(x+2);
I=mean(Z)
I1=mean(I)
dI=T*std(Z)/sqrt(n)
dI1=mean(dI)
In=[I1-dI1,I1+dI1]

Ireal=quad('log(7+x.^3)./(x+2)',4,7)