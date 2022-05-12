pkg load statistics;
clc
clear

m = 10^2;
n = 10^4;
t0 = 0.85;
u = 1.5;
sigma = 1;
mu = 0;
gamma = 0.95;

function result = calc_norm(gamma)
   m = 10^2;
   n = 10^4;
   t0 = 0.85;
   sigma = 1;
   mu = 0;

   X = normrnd(mu, sigma, n, m);
   FX_n = mean(X < t0);
   FX = normcdf(t0, mu, sigma);
   d2 = norminv((1 + gamma) / 2) * sqrt(FX) * sqrt(1 - FX) / sqrt(n);
   d_minus2 = FX_n - d2;
   d_plus2 = FX_n + d2;

   count_left = 0;
   count_right = 0;
   for i = 1:m
       if(d_minus2(i)(1) > FX)
           count_left++;
       endif
       if(d_plus2(i)(1) < FX)
           count_right++;
       endif
    end
    result = count_left + count_right;
endfunction

function result = calc_exp(gamma)
   m = 10^2;
   n = 10^4;
   t0 = 0.85;
   u = 1.5;
   sigma = 1;

   Y = exprnd(u, n, m);
   FY_n = mean(Y < t0);
   FY = expcdf(t0, u);
   d1 = norminv((1 + gamma) / 2) * sqrt(FY) * sqrt(1 - FY) / sqrt(n);
   d_plus1 = FY_n + d1;
   d_minus1 = FY_n - d1;

   count_left = 0;
   count_right = 0;
   for i = 1:m
       if(d_minus1(i)(1) > FY)
           count_left++;
       endif
       if(d_plus1(i)(1) < FY)
           count_right++;
       endif
    end
    result = count_left+count_right;
endfunction

printf("Normal:\n");
X = normrnd(mu, sigma, n, m);
FX_n = mean(X < t0);
FX = normcdf(t0, mu, sigma);
d2 = norminv((1 + gamma) / 2) * sqrt(FX) * sqrt(1 - FX) / sqrt(n);
d_plus2 = FX_n + d2;
d_minus2 = FX_n - d2;

figure(1)
plot(1:m, d_minus2, 1:m, d_plus2, 1:m, linspace(FX, FX, m));
printf("Plot 1 for N(%g, %g), gamma = %g\n", mu, sigma, gamma)

for i = 0:9
    ans =[];
    gamma = 0.9+i*10^(-2);
    for j = 1:100
        ans(j) = calc_norm(gamma);
    endfor
    average = mean(ans);
    printf("gamma=%g, average = %g\n", gamma, average);
endfor

printf("Exponential\n");
Y = exprnd(u, n, m);
FY_n = mean(Y < t0);
FY = expcdf(t0, u);
d1 = norminv((1 + gamma) / 2) * sqrt(FY) * sqrt(1 - FY) / sqrt(n);
d_plus1 = FY_n + d1;
d_minus1 = FY_n - d1;

figure(2);
plot(1:m, d_minus1, 1:m,d_plus1, 1:m, linspace(FY, FY ,m));
printf("Plot 2 for Exp(%g), gamma = %g\n", u, gamma)

for i=0:9
    ans =[];
    gamma = 0.9+i*10^(-2);
    for j = 1:100
    ans(j) = calc_exp(gamma);
    endfor
    average = mean(ans);
    printf("gamma=%g, average = %g\n", gamma, average);
endfor