function ex12_14(x, Fs, median_n)
	MIN_THRESHOLD = 100; % 100Hz minimum
	AMP_FACTOR = 10; % amplitude factor, used to amplify the volume

	median_n = median_n - 1;

	window_time_size = 46.44 * 1e-3; % in s
	window_time_overlap = 5.8 * 1e-3; % in s

	window_size = round(window_time_size * Fs); % number of window elements
	window_overlap = round(window_time_overlap * Fs); % number of overlap elements
	window_step = window_size - window_overlap; % number of non-overlapped elements

	Fstep_window = Fs / window_size; % window frequency step (because of the number of elements used in the fft)

	% frequencies used in the window
	f_window = linspace(-(window_size - mod(window_size, 2)) / 2, (window_size - mod(window_size, 2)) / 2 - mod(window_size + 1, 2), window_size) * Fstep_window;

	F0ind_window = (window_size - mod(window_size, 2)) / 2 + 1; % 0 frequency index (on X_window and f_window)

	Ts = 1 / Fs;
	t = 0 : Ts : (length(x) - median_n - 1) * Ts;
	x_filtered = zeros(length(x) - median_n, 1);
	
	for i = 1 : length(x) - median_n
		x_filtered(i) = median(x(i : i + median_n));
	end

	f_fund_ind_per_window = zeros(1, ceil(length(x_filtered) / window_step));
	for i = 1 : window_step : length(x_filtered)
		window_ind = (i - 1) / window_step + 1; % window index

		ind_max = min(i + window_size - 1, length(x_filtered)); % window upper index
		x_window = x_filtered(i : ind_max); % window corresponding signal
		x_window = x_window .* hamming(length(x_window)); % applying an hamming window of the same size

		X_window = fftshift(fft(x_window, window_size)); % always using window_size elements

		f_fund_ind_per_window(window_ind) = F0ind_window;
		for j = F0ind_window + 1 : length(X_window)
			if abs(X_window(j)) > abs(X_window(f_fund_ind_per_window(window_ind)))
				f_fund_ind_per_window(window_ind) = j;
			end;
		end;

		% Only consider frequencies greater than MIN_THRESHOLD.
		if f_window(f_fund_ind_per_window(window_ind)) < MIN_THRESHOLD
			f_fund_ind_per_window(window_ind) = F0ind_window;
		end;

		% Synthesizing the signal.
		a = AMP_FACTOR * abs(X_window(f_fund_ind_per_window(window_ind))) / window_size; %  / N, converting DFT coeffs. into Fourier Complex Series coeffs.
		f = f_window(f_fund_ind_per_window(window_ind));

		% Corresponding interval upper index (only worth writing on
		% window_step, others would be overwritten).
		ind_max = min(i + window_step - 1, length(x_filtered));

		x_rec(i : ind_max) = a * sin(2 * pi * f * t(i : ind_max));
	end;

	titl_ = 'Ex. 1.2: Hamming window used';
	figure('Name', titl_);
	plot(f_window, hamming(window_size));
	title(titl_);
	fprintf('Press [ENTER] to continue.\n'); pause();

	titl_ = sprintf('Ex. 1.2/1.3: Fundamental frequencies temporal succession (%d median, %.2fms sliding window, %.2fms overlap)', median_n + 1, window_time_size * 1e3, window_time_overlap * 1e3);
	figure('Name', titl_);
	temporal_succession_x_axis = 0 : window_step : length(x_filtered) - 1;
	stairs(temporal_succession_x_axis, f_window(f_fund_ind_per_window));
	title(titl_);
	fprintf('Press [ENTER] to continue.\n'); pause();

	wavwrite(x_rec, Fs, '/tmp/temp_wave.wav');
	[x_rec, Fs, ~] = wavread('/tmp/temp_wave.wav');
	waveplay(x_rec, Fs);
	fprintf('Press [ENTER] to continue.\n'); pause();

	titl_ = sprintf('Ex. 1.4: Synthesized signal (magnitude), using fundamental frequencies (%d median, %.2fms sliding window, %.2fms overlap)', median_n + 1, window_time_size * 1e3, window_time_overlap * 1e3);
	figure('Name', titl_);
	plot(t, x_rec);
	title(titl_);
	fprintf('Press [ENTER] to continue.\n'); pause();
end

