clc
clear
pkg load statistics

xmin = -2.5;
xmax = 2.1;
n = 60;
a1 = 2.8;
a2 = -4.4;
a3 = -6.8;
sigma = 1.6;

coeff = [a1, a2, a3];
m = 2;

printf("Function: y = %gx^2 + %gx + %g\t\n\n", a3, a2, a1);

X = linspace(xmin, xmax, n)';
A = [];
i = 1:(m + 1);
A(:, i) = X.^(i - 1);
y = A * coeff';
Z = normrnd(0, sigma, n, 1);
Y = y + Z;

coeff_function = polyfit(X, Y, m);
coeff_matrix = (A' * A)^-1 * A' * Y;

printf("Parameters:  \t\t %f \t %f \t %f\n", coeff(3), coeff(2), coeff(1));
printf("Build in func:  \t %f \t %f \t %f\n",  coeff_function(1), coeff_function(2), coeff_function(3));
printf("Calc by hand:  \t\t %f \t %f \t %f\n\n", coeff_matrix(3), coeff_matrix(2), coeff_matrix(1));

Y_matrix = A * coeff_matrix;
Y_function = polyval(coeff_function, X);

plot(X, Y, '.', X, Y_function, '+', X, Y_matrix, 'o', X, y, '-');
legend("Selection", "Approx with Octave functions", "Approx with matrix method", "Function");
axis("tight");

r = Y_matrix - Y;
printf("Ortogonality: %d\n", r' * Y_matrix);
sigma_n = sqrt(r' * r / (n - 3));
printf("Noise evaluation = %d\n", sigma_n);