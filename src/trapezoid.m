function [integral_val, step] = trapezoid(f, a, b, n)
% Trapezoid Rule Integral Approximation
%	The f function area between a and b is approximated by dividing the
%	integration interval (b - a) into n equally large trapezoids and
%	summing the trapezoids areas.

step = (b - a) / n;
t = a:step:b;

f_val = f(t);

% Integral is approximated using the formula
% trap_int(f, a, b, n) = ((b - a) / (2 * n)) * (f(1) + 2f(2) + 2f(3) +
% + 2f(4) + ... + f(n+1))
integral_val = step * (f_val(1) + 2 * sum(f_val(2:end - 1)) + f_val(end)) / 2;

end
