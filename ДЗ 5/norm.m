clc
clear
pkg load statistics

function eval_norm(n)
  n
  a = 0;
  sigma = 6;
  m = 100;
  c1 = 0.4;
  
  printf("Theoretical:\n");
  Xn = sqrt(power(sigma, 2) / n)
  med = sqrt(pi * power(sigma, 2) / (2 * n))
  halfsum = sqrt(c1 * power(sigma, 2) / log(n))

  printf("Practical:\n");
  X = normrnd(a, sigma, n, m);
  Xn = std(mean(X))
  med = std(median(X))
  halfsum = std((min(X) + max(X)) / 2)
endfunction

eval_norm(100)
eval_norm(10000)