%% Initial vars setup
demo_mode = true;

%% Ex. 1.
%% Ex. 1.1.
[x, Fs, ~] = wavread('files/saxriff.wav');
waveplay(x, Fs);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

t = linspace(0, length(x) / Fs, length(x));

titl_ = 'Ex. 1.1: Signal''s representation';
figure('Name', titl_);
plot(t, x);
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

% N = length(x);

% Smallest power of 2 greater than length(x)
N = 2 ^ ceil(log(length(x)) / log(2));

X = fftshift(fft(x, N));

Fstep = Fs / N;
f = linspace(-(N - mod(N, 2)) / 2, (N - mod(N, 2)) / 2 - mod(N + 1, 2), N) * Fstep;

titl_ = 'Ex. 1.1: Signal''s frequency magnitude (Fast Fourier Transform)';
figure('Name', titl_);
stem(f, abs(X));
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 1.2. - 1.4.
mode = menu('Median mode:', 'Single median (user input)', 'Multiple (1, 5, 7 and 9)');

if mode == 1
	median_n = menu('Filter type:', 'No filter', '5-elements median', '7-elements median', '9-elements median');
	if median_n ~= 1
		median_n = median_n * 2 + 1; % menu option to value in [5, 7, 9]
	end;

	ex12_14(x, Fs, median_n);
elseif mode == 2
	ex12_14(x, Fs, 1);
	ex12_14(x, Fs, 5);
	ex12_14(x, Fs, 7);
	ex12_14(x, Fs, 9);
end;