clc
clear
pkg load statistics

left = 0;
right = 4;
n = 100;
gamma = 0.95;
u = 1.36;

x0 = [0 : 0.01 : 4];
Fx = unifcdf(x0, left, right);

x = sort(unifrnd(left, right, n, 1));
y = [1/n : 1/n : 1];
[a, b] = stairs(x, y);
plot(x0, Fx, a, b);

Fmin = max(0, b - u / sqrt(n));
Fmax = min(1, b + u / sqrt(n));
plot(x0, Fx, a, b, a, Fmin, a, Fmax);
title(strcat("U(0, 4),  gamma=", num2str(gamma)));


function critery(n)
  n
  alpha = 0;
  sigma = 4;
  gamma = 0.95;
  u = 1.36;

  i = [1 : 1 : n];
  x = sort(unifrnd(alpha, sigma, 1, n));
  F = unifcdf(x, alpha, sigma);
  printf("Critery for n=%g\n", n)
  k = sqrt(n) * max(max(abs(F(i) - (i - 1) / n), max(abs(F(i) - i / n))))
  w = 1/(12 * n) + sum((F(i) - (2 * i - 1) / (2 * n)).^ 2)
endfunction

critery(10^4)
critery(10^6)


function firstTypeErrors(n, launches)
  n
  alpha = 0;
  sigma = 4;
  gamma = 0.95;
  u = 1.36;
  quantile_k = 1.358;
  quantile_w = 0.46;
  count_k = 0;
  count_w = 0;

  for (j = 1 : launches)
    i = [1 : 1 : n];
    x = sort(unifrnd(alpha, sigma, 1, n));
    F = unifcdf(x, alpha, sigma);
    k = sqrt(n) * max(max(abs(F(i) - (i - 1) / n), max(abs(F(i) - i / n))));
    w = 1/(12 * n) + sum((F(i) - (2 * i - 1) / (2 * n)).^ 2);
    if (k >= quantile_k)
      ++count_k;
    endif
    if (w >= quantile_w)
      ++count_w;
    endif
  endfor
  probability_k = count_k / launches
  probability_w = count_w / launches
endfunction

firstTypeErrors(10^4, 100)
firstTypeErrors(10^6, 100)


function secondTypeErrors(n, launches)
  n
  alpha = 0;
  sigma = 4;
  gamma = 0.95;
  u = 1.36;
  quantile_k = 1.358;
  quantile_w = 0.46;
  count_k = 0;
  count_w = 0;

  for (j = 1 : launches)
    i = [1 : 1 : n];
    x = sort(unifrnd(alpha, sigma, 1, n));
    F = unifcdf(x, alpha + 0.1, sigma);
    k = sqrt(n) * max(max(abs(F(i) - (i - 1) / n), max(abs(F(i) - i / n))));
    w = 1/(12 * n) + sum((F(i) - (2 * i - 1) / (2 * n)).^ 2);
    if (k < quantile_k)
      ++count_k;
    endif
    if (w < quantile_w)
      ++count_w;
    endif
  endfor
  probability_k = count_k / launches
  probability_w = count_w / launches
endfunction

secondTypeErrors(10^4, 100)
secondTypeErrors(10^6, 100)