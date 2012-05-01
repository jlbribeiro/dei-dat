%% Ex. 1
% G = 25;
% x(t)	= -1 + 3 * sin(30 * pi * t) + 4 * mod(G, 2) * sin(12 * pi * t - pi / 4) * cos(21 * pi * t) + 4 * mod(G + 1, 2) * cos(20 * pi * t + pi / 4) * sin(45 * pi * t)
%
% x(t)	= -1 + 3 * sin(30 * pi * t) + 4 * sin(12 * pi * t - pi / 4) * cos(21 * pi * t)
%		= cos(pi) + 2 * cos(9 * pi .* t + 3 * pi / 4) + 3 * cos(30 * pi .* t + 3 * pi / 2) + 2 * cos(33 * pi .* t + 5 * pi / 4)

%% Ex. 1.1
% According to the Nyquist-Shannon Theorem, the sampling frequency should
% be greater than twice the maximum frequency, i.e., Fs > 2 * F_max.
% Since mod(2 * F_max, F_0) = 0, adding a multiple of the
% critical frequency (F_0) still assures a F_0 multiple.

W0 = 3 * pi;		% mdc(0, 9 * pi, 30 * pi, 33 * pi)
Wmax = 33 * pi;	% max(0, 9 * pi, 30 * pi, 33 * pi)

% Fs = 2 * F_max + n * F_0, with F_0 > 0 (and, in this case, n = 2)
Ws = (2 * Wmax + 2 * W0);
% n = 2 assures (in this case) that Ws is a 2 * pi multiple,
% useful for the rad-to-Hz conversion

% radians to hertz conversions
F0 = W0 / (2 * pi);
Fs = Ws / (2 * pi);

% periods
T0 = 1 / F0;
Ts = 1 / Fs;

% x_t = cos(pi) + 2 * cos(9 * pi .* t_t + 3 * pi / 4) + 3 * cos(30 * pi .* t_t + 3 * pi / 2) + 2 * cos(33 * pi .* t_t + 5 * pi / 4);
% =>
% x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);

%% Ex. 1.2.
N_POINTS = 5000;

t_t = linspace(-2 * pi, 2 * pi, N_POINTS);
t_n = -floor(2 * pi / Ts) : 1 : floor(2 * pi / Ts);

x_t = cos(pi) + 2 * cos(9 * pi .* t_t + 3 * pi / 4) + 3 * cos(30 * pi .* t_t + 3 * pi / 2) + 2 * cos(33 * pi .* t_t + 5 * pi / 4);
x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);

plot(t_t, x_t, 'b', t_n * Ts, x_n, 'r*');

%% Ex. 1.3.
N = T0 / Ts;
t_n = 0:N - 1;

x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);
X_n = fftshift(fft(x_n));

% TODO TODO TODO
% TODO stem abs(X_n)
% TODO stem angle(X_n)

%% Ex. 1.4.
c_m = X_n / N;

% TODO TODO TODO
% TODO stem abs(c_m)
% TODO stem angle(c_m)