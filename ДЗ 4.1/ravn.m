clc
clear
pkg load statistics

alpha = 0;
betta = 6;
n = 10^6;
k = 100;
u = 1.4
gamma = 0.96;

x0 = [alpha : 0.01 : betta];
Fx = unifpdf(x0, alpha, betta);

x = sort(unifrnd(alpha, betta, n, 1));

h = (x(n) - x(1)) / k;
xh = [x(1) : h : x(n) - h]; 
Fh = hist(x, k) / (n * h);
[a, b] = stairs(xh, Fh);

y = [alpha : 0.01 : betta];
Fy = 0;

plot(x0, Fx, a, b, y, Fy)
title(strcat("U(0, 6), gamma=", num2str(gamma)));