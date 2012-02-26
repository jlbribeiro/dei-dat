% Ex. 1.
% G# = 25
% A1 = 2 * (G# % 2)			=> A1 = 2
% A2 = 3 * ((G# + 1) % 2)	=> A2 = 0
% A3 = 5 * (G# % 2)			=> A3 = 5
% A4 = 4 * ((G# + 1) % 2)	=> A4 = 0
% Wa = (G# % 5) + 2			=> Wa = 2
% Wb = (G# % 7) + 7			=> Wb = 11
% Wc = (G# % 9) + 1			=> Wc = 8

% x(t) = A1 * sin(Wa * t) * cos(Wb * t) + A2 * cos(Wa * t) * sin(Wb * t) + A3 * cos(Wc * t)^2 + A4 * sin(Wc * t)^2
% =>
% x(t) = 2 * sin(2 * t) * cos(11 * t) + 5 * cos(8 * t)^2

%%% Ex. 1.1.
% ...

%%% Ex. 1.2.
% x[n] = 2 * sin(2 * n * Ts) * cos(11 * n * Ts) + 5 * cos(8 * n * Ts)^2
