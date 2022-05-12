clc
clear
pkg load statistics

k=5
a=-4
s=sqrt(3/2)
gam=0.98
T=norminv((1+gam)/2);

n=10^4
X=normrnd(a,s,n,k);
Z=s*sqrt(2*pi)*(abs(X).^(5/2));
I=mean(Z);
I1=mean(I)
dI=T*std(Z)/sqrt(n)
dI1=mean(dI)
In=[I1-dI1,I1+dI1]

n=10^6
X=normrnd(a,s,n,k);
Z=s*sqrt(2*pi)*(abs(X).^(5/2));
I=mean(Z)
I1=mean(I)
dI=T*std(Z)/sqrt(n)
dI1=mean(dI)
In=[I1-dI1,I1+dI1]
Ireal=quad('(abs(x).^(5/2))*exp(-(x+4)^2/3)',-inf, inf)