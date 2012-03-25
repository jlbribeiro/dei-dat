function ex214_216(t_, x_t, T0, m_max, m_max_i, title_prefix)
%% Ex. 2.1.1
W0 = 2 * pi / T0;

%% Ex. 2.1.4
fprintf('%s (analog to 2.1.4)\n', title_prefix);

[C_m, Theta_m] = FourierSeries(t_', x_t', T0, m_max);

titl_ = 'Trigonometric Fourier Series %s, for %s = %d';
figure('Name', sprintf('%s%s', title_prefix, sprintf(titl_, 'Coefficient (Cm) and Sinusoidal Phase, θm', 'm_max', m_max)));
subplot(2, 1, 1);
stem(0:m_max, C_m);
title(sprintf(titl_, 'Coefficient, C_m', 'm\_max', m_max));

subplot(2, 1, 2);
stem(0:m_max, Theta_m);
title(sprintf(titl_, 'Sinusoidal Phase, \theta_m', 'm\_max', m_max));
fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 2.1.5
fprintf('%s (analog to 2.1.5, plotted)\n', title_prefix);

interval = '';
for m = 1:length(m_max_i)
	interval = sprintf('%s%d, ', interval, m_max_i(m));
end
interval = sprintf('%s%d', interval, m_max);

titl_ = sprintf('%s%s', title_prefix, sprintf('Fourier Series Signal Approximation for m %%s [%s]', interval));
figure('Name', sprintf(titl_, '∈'));
hold all;

plot(t_, x_t, 'b'); % original signal

i_ = 1;
ft = zeros(size(t_));
plot_colors = ['r', 'g', 'm', 'c'];
for m = 0:m_max
	ft = ft + C_m(m+1) * cos(m * W0 * t_ + Theta_m(m+1));

	if i_ <= length(m_max_i) && m == m_max_i(i_)
		plot(t_, ft, plot_colors(mod(i_, length(plot_colors)) + 1));
		i_ = i_ + 1;
	end
end

plot(t_, ft, 'r'); % m_max always plotted red
plot(t_, x_t, 'b--'); % original signal always plotted blue (second plotting to assure it is visible as well as a perfect approximation)
title(sprintf(titl_, '\in'));
hold off;

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 2.1.6
fprintf('%s (analog to 2.1.6, plotted)\n', title_prefix);
c_m = zeros(1, m_max * 2 + 1);
c_m(m_max + 1) = C_m(1) * cos(Theta_m(1));

for m = 1:m_max
	c_m(m_max + 1 + m) = C_m(1 + m) * (cos(Theta_m(1 + m)) + 1j * sin(Theta_m(1 + m))) / 2;
	c_m(m) = C_m(1 + m) * (cos(Theta_m(1 + m)) - 1j * sin(Theta_m(1 + m))) / 2;
end

c_m_amp = abs(c_m);
c_m_phase = angle(c_m);

titl_ = 'Complex Fourier Series %s coefficients (%s), for m %s [%d, %d]';
figure('Name', sprintf('%s%s', title_prefix, sprintf(titl_, 'cm', 'amplitude and phase', '∈', -m_max, m_max)));
subplot(2, 1, 1);
plot(-m_max:m_max, c_m_amp, '.');
title(sprintf(titl_, 'c_m', 'amplitude', '\in', -m_max, m_max));

subplot(2,1,2);
plot(-m_max:m_max, c_m_phase, '.');
title(sprintf(titl_, 'c_m', 'phase', '\in', -m_max, m_max));

end