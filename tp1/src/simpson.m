function [integral_val, step] = simpson(f, a, b, n)
% Simpson Rule Integral Approximation
%	The f function area between a and b is approximated by dividing the
%	integration interval (b - a) into n equally large trapezoids and
%	summing the trapezoids areas.

step = (b - a) / n;
t = a:step:b;

f_val = f(t);

% Integral is approximated using the formula
% simpson_int(f, a, b, n) = ((b - a) / (3 * n)) * (f(1) + 4f(2) + 2f(3) +
% 4f(4) + ... + 2f(n - 2) + 4f(n - 1) + f(n)
integral_val = step * (f_val(1) + 4 * sum(f_val(2:2:end - 1)) + 2 * sum(f_val(3:2:end - 2)) + f_val(end)) / 3;

end