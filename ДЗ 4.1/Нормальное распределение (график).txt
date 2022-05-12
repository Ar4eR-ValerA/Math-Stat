clc
clear
pkg load statistics

alpha = 0;
sigma = 6;
n = 10^6;
k = 100;
gamma = 0.96;

x0 = [-12 : 0.01 : 12];
Fx = normpdf(x0, alpha, sigma);

x = sort(normrnd(alpha, sigma, n, 1));

h = (x(n) - x(1)) / k;
xh = [x(1) : h : x(n) - h]; 
Fh = hist(x, k) / (n * h);
[a, b] = stairs(xh, Fh);

plot(x0, Fx, a, b)
title(strcat("N(0, 36), gamma=", num2str(gamma)));