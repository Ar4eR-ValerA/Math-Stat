clc
clear
pkg load statistics

xmin = -2.5;
xmax = 2.1;
n = 60;
c1 = 3.2;
c2 = -5.6;
sigma = 1.6;

coeff = [c1, c2];
m = 1;

printf("Function: y = %gx + %g\t\n\n", c2, c1);

X = linspace(xmin, xmax, n)';
A = [];
i = 1:(m + 1);
A(:, i) = X.^(i - 1);
y = A * coeff';
Z = normrnd(0, sigma, n, 1);
Y = y + Z;

coeff_function = polyfit(X, Y, m);
coeff_matrix = (A' * A)^-1 * A' * Y;

cov_x_y = X' * Y / n - mean(X) * mean(Y);
var_x = X' * X / n - (mean(X))^2;
cov_theta = [mean(Y) - cov_x_y / var_x * mean(X); cov_x_y / var_x];

printf("Params:  \t\t %f \t %f\n", coeff(2), coeff(1));
printf("Build in func:  \t %f \t %f\n",  coeff_function(1), coeff_function(2));
printf("Calc by hand:  \t %f \t %f\n", coeff_matrix(2), coeff_matrix(1));
printf("Covariation:  \t\t %f \t %f\n\n", cov_theta(2), cov_theta(1));

Y_matrix = A * coeff_matrix;
Y_function = polyval(coeff_function, X);

plot(X, Y, '.', X, Y_function, '+', X, Y_matrix, 'o', X, y, '-');
legend("Selection", "Approx with Octave functions", "Approx with matrix method", "Function");
axis("tight");

r = Y_matrix - Y;
printf("Ortogonality: %d\n", r' * Y_matrix);
sigma_n = sqrt(r' * r / (n - 3));
printf("Noise evaluation = %d\n", sigma_n);