%% Initial vars setup
demo_mode = true;

%% Ex. 2.
escala.filename = 'escala.wav';
escala.window_time_size = 150 * 1e-3;
escala.window_time_overlap = escala.window_time_size / 32;

piano.filename = 'piano.wav';
piano.window_time_size = 180 * 1e-3;
piano.window_time_overlap = piano.window_time_size / 32;

flauta.filename = 'flauta.wav';
flauta.window_time_size = 50 * 1e-3;
flauta.window_time_overlap = flauta.window_time_size / 32;

signal_choices = [escala piano flauta];

choice = menu('Choose a signal:', 'escala.wav', 'piano.wav', 'flauta.wav');
if choice == 0
	return;
end;

chosen_signal = signal_choices(choice);

%% Ex. 2.1.
[x, Fs, ~] = wavread(sprintf('files/%s', chosen_signal.filename));
waveplay(x, Fs);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

t = linspace(0, length(x) / Fs, length(x));

if size(x, 2) == 2
	x = (x(:,1) + x(:,2)) / 2;
end;

titl_ = sprintf('Ex. 2.1: Signal''s representation of file %s', chosen_signal.filename);
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

titl_ = 'Ex. 2.1: Signal''s frequency magnitude (Fast Fourier Transform)';
figure('Name', titl_);
stem(f, abs(X));
title(titl_);
if exist('demo_mode', 'var') && demo_mode

    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 2.2.
window_size = round(chosen_signal.window_time_size * Fs); % number of window elements
window_overlap = round(chosen_signal.window_time_overlap * Fs); % number of overlap elements
window_step = window_size - window_overlap; % number of non-overlapped elements

Fstep_window = Fs / window_size; % window frequency step (because of the number of elements used in the fft)

% frequencies used in the window
f_window = linspace(-(window_size - mod(window_size, 2)) / 2, (window_size - mod(window_size, 2)) / 2 - mod(window_size + 1, 2), window_size) * Fstep_window;

F0ind_window = (window_size - mod(window_size, 2)) / 2 + 1; % 0 frequency index (on X_window and f_window)

fprintf('Frequency resolution: %.2fHz\n', Fstep_window);

f_fund_ind_per_window = zeros(1, ceil(length(x) / window_step));
for i = 1 : window_step : length(x)
	window_ind = (i - 1) / window_step + 1; % window index

	ind_max = min(i + window_size - 1, length(x)); % window upper index
	x_window = x(i : ind_max); % window corresponding signal
	x_window = x_window .* hamming(length(x_window)); % applying an hamming window of the same size

	X_window = fftshift(fft(x_window, window_size)); % always using window_size elements

	f_fund_ind_per_window(window_ind) = F0ind_window;
	for j = F0ind_window + 1 : length(X_window)
		if abs(X_window(j)) > abs(X_window(f_fund_ind_per_window(window_ind)))
			f_fund_ind_per_window(window_ind) = j;
		end;
	end;
end;

titl_ = sprintf('Ex. 2.2 - 2.4: Fundamental frequencies temporal succession (%.2fms sliding window, %.2fms overlap)', chosen_signal.window_time_size * 1e3, chosen_signal.window_time_overlap * 1e3);
figure('Name', titl_);
temporal_succession_x_axis = 0 : window_step : length(x) - 1;
stairs(temporal_succession_x_axis, f_window(f_fund_ind_per_window));
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

% f_window(f_fund_ind_per_window)
keys = key_notes(f_window(f_fund_ind_per_window));

fprintf('Key notes:\n');
for i = 1:length(keys)
	fprintf('%s ', char(keys(i)));
end;
fprintf('\n');