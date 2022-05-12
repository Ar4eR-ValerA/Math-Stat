clc
clear
pkg load statistics

function eval_laplace(n)
  n
  a = 0;
  u = 6;
  m = 100;
  c2 = 0.9;
  
  printf("Theoretical:\n");
  Xn = sqrt(2 * power(u, 2) / n)
  med = sqrt(power(u, 2) / n)
  halfsum = sqrt(c2 * power(u, 2))

  printf("Practical:\n");
  X = a + exprnd(u, n, m) - exprnd(u, n, m);
  Xn = std(mean(X))
  med = std(median(X))
  halfsum = std((min(X) + max(X)) / 2)
endfunction

eval_laplace(100)
eval_laplace(10000)