clc;
clear;
pkg load statistics;

function result = criterion_with_ans(a_1, a_2, d_1, d_2, n, gamma)
  X = sort(normrnd(a_1, a_2, 1, n));
  e_1 = sum(X) / n;
  e_2 = sqrt(sum((X - a_1).^2) / n);
  m = ceil(n^(1/3));
  h = (X(n) - X(1)) / m;
  hi = hist(X, m);
  e_1 += d_1;
  e_2 += d_2;
  chi = 0;
  i = 1;
  m1 = 0;

  while (i <= m)
    old_i = i - 1;
    nj = hi(i);
    while (nj < 6 && i < m)
    i = i + 1;
    nj = nj + hi(i);
    endwhile
    p_i = normcdf(X(1) + h * i, e_1, e_2) - normcdf(X(1) + h * old_i, e_1, e_2);
    chi = chi + (nj - n * p_i)^2 / (n * p_i);
    i = i + 1;
    m1 = m1 + 1;
  endwhile

  porog=chi2inv(gamma, m1 - 3);
  printf("chi = %f, porog = %f\n", chi, porog)
  result = chi >= porog;
endfunction

function result = criterion(a_1, a_2, d_1, d_2, n, gamma)
  X = sort(normrnd(a_1, a_2, 1, n));
  e_1 = sum(X) / n;
  e_2 = sqrt(sum((X - a_1).^2) / n);
  m = ceil(n^(1/3));
  h = (X(n) - X(1)) / m;
  hi = hist(X, m);
  e_1 += d_1;
  e_2 += d_2;
  chi = 0;
  i = 1;
  m1 = 0;

  while (i <= m)
    old_i = i - 1;
    nj = hi(i);
    while (nj < 6 && i < m)
    i = i + 1;
    nj = nj + hi(i);
    endwhile
    p_i = normcdf(X(1) + h * i, e_1, e_2) - normcdf(X(1) + h * old_i, e_1, e_2);
    chi = chi + (nj - n * p_i)^2 / (n * p_i);
    i = i + 1;
    m1 = m1 + 1;
  endwhile

  porog=chi2inv(gamma, m1 - 3);
  result = chi >= porog;
endfunction

function criterion_first_errors(a_1, a_2, d_1, d_2, n, gamma, cnt)
  e = 0;
  for i = 1:cnt
  e += criterion(a_1, a_2, d_1, d_2, n, gamma);
  endfor
  printf("n = %g, cnt = %g\n", n, cnt)
  printf("Probability of first type error (gamma = %g): ", gamma);
  printf("%f\n", e/cnt);
endfunction

function criterion_second_errors(a_1, a_2, d_1, d_2, n, gamma, cnt)
  e = 0;
  for i = 1:cnt
  e += criterion(a_1, a_2, d_1, d_2, n, gamma);
  endfor
  printf("n = %g, cnt = %g\n", n, cnt)
  e = cnt - e;
  printf("Probability of second type error with delta1 = %g, delta2 = %g (gamma = %g): ", d_1, d_2, gamma);
  printf("%f\n", e/cnt);
endfunction

cnt = 100;

printf("Distribution - normal\n");
mu = 1;
sigma = 3;

printf("For gamma=%g is %g\n", 0.90, 1-criterion_with_ans(mu, sigma, 0, 0, 10^6, 0.90))
printf("For gamma=%g is %g\n", 0.95, 1-criterion_with_ans(mu, sigma, 0, 0, 10^6, 0.95))
printf("For gamma=%g is %g\n", 0.99, 1-criterion_with_ans(mu, sigma, 0, 0, 10^6, 0.99))

printf("First type\n")
criterion_first_errors(mu, sigma, 0, 0, 10^6, 0.90, cnt);
criterion_first_errors(mu, sigma, 0, 0, 10^6, 0.95, cnt);
criterion_first_errors(mu, sigma, 0, 0, 10^6, 0.99, cnt);
printf("Second type\n")
criterion_second_errors(mu, sigma, 0, 0.01, 10^6, 0.95, cnt);
criterion_second_errors(mu, sigma, 0, 0.02, 10^6, 0.95, cnt);
criterion_second_errors(mu, sigma, 0, 0.03, 10^6, 0.95, cnt);