function ex23_26(Fs, N, X, Fstep, f, F0_ind, Fmax_amp, Fnoise_range, F_filter, filter_order, filter_type, DEBUG)
	if ~exist('DEBUG', 'var')
		DEBUG = {};
		DEBUG.toPlay = true;
		DEBUG.toPlot = true;
	end;

	Fmin_rand = Fnoise_range(1);
	Fmax_rand = Fnoise_range(2);

	%% Ex. 2.3.
	noise_ind_pos = (F0_ind + ceil(Fmin_rand / Fstep)) : 1 : (F0_ind + floor(Fmax_rand / Fstep));
	noise_ind_neg = (F0_ind - floor(Fmax_rand / Fstep)) : 1 : (F0_ind - ceil(Fmin_rand / Fstep));

	amp_noise = rand(size(noise_ind_pos)) * 0.1 * Fmax_amp;
	phase_noise = rand(size(noise_ind_pos)) * 2 * pi - pi;

	X_noise_pos = amp_noise .* (cos(phase_noise) + 1j * sin(phase_noise));
	X_noise_neg = conj(X_noise_pos(end : -1 : 1));

	X_noise = X;
	X_noise(noise_ind_pos) = X_noise(noise_ind_pos) + X_noise_pos';
	X_noise(noise_ind_neg) = X_noise(noise_ind_neg) + X_noise_neg';

	if DEBUG.toPlot
		titl_ = sprintf('Ex. 2.3: Original signal (blue) overlapped with the noisy signal (uniform noise on the [%dHz, %dHz] range, red)', Fmin_rand, Fmax_rand);
		figure('Name', titl_);
		hold on;
			stem(f, abs(X_noise), 'r');
			stem(f, abs(X), 'b');
		hold off;
		title(titl_);
	end;

	%% Ex. 2.4.
	x_noise = real(ifft(ifftshift(X_noise), N));

	if DEBUG.toPlay
		waveplay(x_noise, Fs);
	end;

	%% Ex. 2.5./2.6
	Wn = 2 * F_filter / Fs;

	[b, a] = butter(filter_order / length(Wn), Wn, filter_type);
	x_filtered = filter(b, a, x_noise);
	X_filtered = fftshift(fft(x_filtered));

	fprintf('Transfer Function (G(z)) coefficients:\n');
	disp(b);
	fprintf('%s%s\n', char(' ' * ones(1, 4)), char('-' * ones(1, 66)));
	disp(a);

	fprintf('Zeros:\n');
	zeroes = roots(b);
	disp(zeroes);

	fprintf('Poles:\n');
	poles = roots(a);
	disp(poles);

	if DEBUG.toPlot
		if strcmp(filter_type, 'stop')
			filter_type_str = 'bandstop';
			filter_range = sprintf('[%dHz, %dHz]', F_filter(1), F_filter(2));
		else
			filter_type_str = sprintf('%spass', filter_type);
			if strcmp(filter_type, 'low')
				Fmin_filter = 0;
				Fmax_filter = F_filter;
			else
				Fmin_filter = F_filter;
				Fmax_filter = Fs / 2;
			end;
			filter_range = sprintf('[%dHz, %dHz]', Fmin_filter, Fmax_filter);
		end;

		titl_ = sprintf('Ex. 2.5: Z-plane representation of a %d order %s Buttworth filter, on the %s range', filter_order, filter_type_str, filter_range);
		figure('Name', titl_);
		zplane(b, a);
		title(titl_);

		titl_ = 'Ex. 2.5: Filtered signal (frequency representation, red) overlapped with the Noisy signal (frequency representation, blue)';
		figure('Name', titl_);
		hold on;
			stem(f, abs(X_filtered), 'r');
			stem(f, abs(X), 'b');
		hold off;
		title(titl_);
	end;

	if DEBUG.toPlay
		waveplay(x_filtered, Fs);
	end;
end