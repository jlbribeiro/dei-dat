function ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, title_prefix)
	W0 = 2 * pi / T0;

	x_t_noise = x_t + noise;

	[C_m_pre_filter, Theta_m_pre_filter] = FourierSeries(t_', x_t_noise', T0, m_max); % Fourier Series Coeffs before filtering (original signal + noise)

	x_t_noise_approx = zeros(size(t_));
	for m=0:m_max
		x_t_noise_approx = x_t_noise_approx + C_m_pre_filter(m + 1) * cos(m * W0 * t_ + Theta_m_pre_filter(m + 1));
	end

	C_m_post_filter = zeros(size(C_m_pre_filter));
	Theta_m_post_filter = zeros(size(Theta_m_pre_filter));

	if accept
		coeff_indexes = (lim_m_inf + 1):(lim_m_sup + 1);
	else
		coeff_indexes = [(1:lim_m_inf) (lim_m_sup + 2):(m_max + 1)];
	end

	C_m_post_filter(coeff_indexes) = C_m_pre_filter(coeff_indexes);
	Theta_m_post_filter(coeff_indexes) = Theta_m_pre_filter(coeff_indexes);

	x_t_noise_approx_filtered = zeros(size(t_));
	for m = 0:m_max
		x_t_noise_approx_filtered = x_t_noise_approx_filtered + C_m_post_filter(m + 1) * cos(m * W0 * t_ + Theta_m_post_filter(m + 1));
	end

	titl_ = sprintf('%sOriginal signal (blue) overlapped by the noisy signal (green) and the Fourier Series Filtered Signal (dashed, red)', title_prefix);
	figure('Name', titl_);
	hold all;
	plot(t_, x_t_noise, 'g');
	plot(t_, x_t, 'b', t_, x_t_noise_approx_filtered, 'r--');
	hold off;
	title(titl_);
	legend('Noisy signal', 'Original signal', 'Filtered Noisy Signal');

	titl_ = sprintf('%sNoisy signal Fourier Series coefficients (blue) overlapped by the filtered noisy signal Fourier Series coefficients (red)', title_prefix);
	m = 0:m_max;
	figure('Name', titl_);
	plot(m, C_m_pre_filter, 'b*', m, C_m_post_filter, 'ro');
	title(titl_);
	legend('Noisy signal Fourier Series coefficients', 'Filtered noisy signal Fourier Series coefficients');
end
