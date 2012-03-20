function [integral_val, step] = trapezoidmaxerror(f, a, b, max_error)
% Trapezoid Rule Integral Approximation
%	The number of subintervals (trapezoids) is obtained using max_error,
%	in order to calculate an integral approximation of f between a and b
%	with a maximal error of max_error. f is a symbolic representation
%	function, in order to be possible to "analytically" obtain its second
%	order derivative.

% Function's second order derivative, used in the error estimate formula
f_dx2 = diff(f, 2);
fh_dx2 = matlabFunction(f_dx2); % MATLAB function handler conversion

t = linspace(a,b, 50000);

% Find the maximum value for the second order derivative of f;
% this guarantees the max_error constraint for the number of intervals.
m = max(fh_dx2(t));

% The number of intervals is calculated using the error estimate formula:
% error = - ((b - a) ^ 3) / (12 * N ^ 2) * f''(ξ), for some ξ between a and
% b. Since the second order derivative sign may vary, abs is used to
% guarantee a real square root.
n = ceil(sqrt(abs((((b - a) ^ 3) / (12 * max_error)) * m)));

fh = matlabFunction(f);

[integral_val, step] = trapezoid(fh, a, b, n);

end
