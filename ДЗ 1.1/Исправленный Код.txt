clc
clear
pkg load statistics

k=13
c=2.9
a=5.6
y=0.97

n=10^4
x=unifrnd(0,1,n,k);
f=exp(-a*x);
z=sum(f');
p=sum(z<c)/n
T=norminv((1+y)/2);
d=T*sqrt(p*(1-p)/n)
I=[p-d,p+d]

n=10^6
x=unifrnd(0,1,n,k);
f=exp(-a*x);
z=sum(f');
p=sum(z<c)/n
d=T*sqrt(p*(1-p)/n)
I=[p-d,p+d]