%% Initial vars setup
demo_mode = true;

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

W0 = 3 * pi;	% mdc(0, 9 * pi, 30 * pi, 33 * pi)
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

N = T0 / Ts;

% x_t = cos(pi) + 2 * cos(9 * pi .* t_t + 3 * pi / 4) + 3 * cos(30 * pi .* t_t + 3 * pi / 2) + 2 * cos(33 * pi .* t_t + 5 * pi / 4);
% =>
% x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);

%% Ex. 1.2.
LLIM = -pi/2;
RLIM = pi/2;

N_POINTS = 5000;

t_t = linspace(LLIM, RLIM, N_POINTS);
t_n = (sign(LLIM) * floor(abs(LLIM) / Ts)) : 1 : (sign(RLIM) * floor(abs(RLIM) / Ts));

x_t = cos(pi) + 2 * cos(9 * pi .* t_t + 3 * pi / 4) + 3 * cos(30 * pi .* t_t + 3 * pi / 2) + 2 * cos(33 * pi .* t_t + 5 * pi / 4);
x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);

titl_ = 'Ex. 1.2: Original signal (x(t), blue) overlapped with the discrete signal (x[n], red)';
figure('Name', titl_);
plot(t_t, x_t, 'b', t_n * Ts, x_n, 'r*');
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 1.3.
t_n = 0:(N-1);

x_n = cos(pi) + 2 * cos(9 * pi * Ts * t_n + 3 * pi / 4) + 3 * cos(30 * pi * Ts * t_n + 3 * pi / 2) + 2 * cos(33 * pi * Ts * t_n + 5 * pi / 4);
X_n = fftshift(fft(x_n));

% if mod(N, 2) == 0
%	omega = (-(N / 2) : 1 : N / 2 - 1) * Ws / N
% else
%	omega = (-((N-1) / 2) : 1 : ((N-1) / 2)) * Ws / N
omega = ((-(N-mod(N, 2)) / 2) : 1 : ((N - mod(N, 2)) / 2 - mod(N + 1, 2))) * Ws / N;

titl_ = '%sDFT representation (%s)';
figure('Name', sprintf(titl_, 'Ex. 1.3: ', 'module and phase'));

subplot(2,1,1);
stem(omega, abs(X_n));
title(sprintf(titl_, '', 'module'));

subplot(2,1,2);
stem(omega, angle(X_n));
title(sprintf(titl_, '', 'phase'));
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 1.4.
% Since
% c_m	->	FT	->	DFT
%		xT0		x1/Ts
% then we must divide by T0/Ts, N (since N = T0/Ts)
% in order to obtain the Complex Fourier Transform coefficients
c_m = X_n / N;

titl_ = '%sComplex Fourier Series coefficients (%s)';
figure('Name', sprintf(titl_, 'Ex. 1.4: ', 'module and phase'));

subplot(2,1,1);
stem(omega, abs(c_m));
title(sprintf(titl_, '', 'module'));

subplot(2,1,2);
stem(omega, angle(c_m));
title(sprintf(titl_, '', 'phase'));
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 1.5.
% if mod(N, 2) == 0
%	W0_index = N / 2 + 1
% else
%	W0_index = (N - 1) / 2 + 1
W0_index = (N - mod(N, 2)) / 2 + 1;
omega = 0:(W0_index - 1);

% We use the negative part of the Complex Fourier coefficients, since they
% possess 1 more value (when N is an even number).
C_m = abs(c_m(W0_index:-1:1)) * 2;
C_m(1) = C_m(1) / 2;

% Since we're using the negative part of the angles, we must use their
% conjugate.
% We make them mod(2 * pi) in order to normalize them on the interval
% w in [0, 2 * pi].
% The .* (abs(C_m) > exp(-12)) part is to assure that only the relevant
% angular frequencies (C_m ~= 0) are plotted.
Theta_m = mod(angle(conj(c_m(W0_index:-1:1))) .* (abs(C_m) > exp(-12)), 2 * pi);

titl_ = '%sTrigonometric Fourier Series %s';
figure('Name', sprintf(titl_, 'Ex. 1.5: ', 'parameters (Cm (coefficients) and theta (phase))'));

subplot(2,1,1);
stem(omega, C_m);
title(sprintf(titl_, '', 'C_m (coefficients)'));

subplot(2,1,2);
stem(omega, Theta_m);
title(sprintf(titl_, '',  '\theta_m (phase)'));
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 1.6.
x_t_rec = zeros(1, N_POINTS);

% Fourier Series signal reconstruction
for i = 1:length(C_m)
	x_t_rec = x_t_rec + C_m(i) * cos((i-1) * W0 * t_t + Theta_m(i));
end;

titl_ = 'Ex. 1.6: Original signal (x(t), blue) overlapped with the reconstructed signal through the Trigonometric Fourier Series (x[n], red)';
figure('Name', titl_);
plot(t_t, x_t, 'b', t_t, x_t_rec, 'r.');
title(titl_);