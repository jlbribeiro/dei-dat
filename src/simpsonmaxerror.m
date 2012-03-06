function [integral_val, step] = simpsonmaxerror(f, a, b, max_error)
% Simpson Rule Integral Approximation
%	Using the Simpson's rule error estimate, it is possible to obtain the
%	number of necessary points to approximate the f function integral
%	between a and b using quadratic interpolants with a maximal error of
%	max_error.

% Function's fourth order derivative, used in the error estimate formula
f_dx4 = diff(f, 4);
fh_dx4 = matlabFunction(f_dx4); % MATLAB function handler conversion

t = linspace(a,b, 50000);

% Find the maximum value for the fourth order derivative of f;
% this guarantees the max_error constraint for the number of intervals.
M = max(fh_dx4(t));

% The number of intervals is calculated using the error estimate formula:
% error = ((b - a) ^ 5) / (180 N ^ 4) * f''(ξ), for some ξ between a and
% b. Since the forth order derivative sign may vary, abs is used to
% guarantee a real forth order root.
n = ceil(nthroot(abs(M * (((b - a) ^ 5) / (180 * max_error))), 4));
n = n + mod(n, 2); % Simpson's Rule assumes N is an even number

fh = matlabFunction(f);

[integral_val, step] = simpson(fh, a, b, n);

end
