clc
clear
pkg load statistics

function eval_unif(n)
  n
  a = 0;
  delta = 0.6;
  m = 100;
  
  printf("Theoretical:\n");
  Xn = sqrt(power(delta, 2) / (12 * n))
  med = sqrt(power(delta, 2) / (4 * n))
  halfsum = sqrt(power(delta, 2) / (2 * power(n, 2)))

  printf("Practical:\n");
  X = unifrnd(a - delta / 2, a + delta / 2, n, m);
  Xn = std(mean(X))
  med = std(median(X))
  halfsum = std((min(X) + max(X)) / 2)
endfunction

eval_unif(100)
eval_unif(10000)