%% Initial vars setup
demo_mode = true;

%% Ex. 2.
%% Ex. 2.1.
[x, Fs, Nbits] = wavread('files/saxriff.wav');
waveplay(x, Fs);

% N = length(x);

% Smallest power of 2 greater than length(x)
N = 2 ^ ceil(log(length(x)) / log(2));

X = fftshift(fft(x, N));

Fstep = Fs / N;
f = linspace(-(N - mod(N, 2)) / 2, (N - mod(N, 2)) / 2 - mod(N + 1, 2), N) * Fstep;

titl_ = 'Ex. 2.1: Signal''s frequency magnitude (Discrete Fourier Transform)';
figure('Name', titl_);
stem(f, abs(X));
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 2.2.
F0_ind = (N - mod(N, 2)) / 2 + 1; % 0-frequency index
Fmax_ind = F0_ind;
Fmax_amp = abs(X(Fmax_ind));

% Calculating the greatest magnitude frequency
for i = F0_ind+1:length(X)
	if abs(X(i)) > Fmax_amp
		Fmax_ind = i;
		Fmax_amp = abs(X(i));
	end;
end;

% DFT values are related to the Complex Fourier Transform by a factor of
% 1/N.
% Furthermore, since the Complex Fourier Transform coefficients module
% is half of the corresponding Trigonometric Fourier Series coefficients
% module, we must multiply by 2 (except on the 0-frequency).
C_m_Fmax = (2 - (Fmax_ind == F0_ind)) * abs(X(Fmax_ind)) / N;

fprintf('\nThe maximum amplitude frequency is %.2fHz, with an amplitude of %.2f.\n\n', f(Fmax_ind), C_m_Fmax);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 2.3 - ex. 2.6.
DEBUG = struct('toPlay', true, 'toPlot', true);

ex23_26(Fs, N, X, Fstep, f, F0_ind, Fmax_amp, [8500, 9500], 8000, 6, 'low', DEBUG);
ex23_26(Fs, N, X, Fstep, f, F0_ind, Fmax_amp, [2000, 3000], [2000, 3000], 6, 'stop', DEBUG);