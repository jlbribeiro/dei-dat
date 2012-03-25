function [] = ex214_216(t_, x_t, T0, m_max, m_max_i)
%% Ex. 2.1.1
W0 = 2 * pi / T0;

%% Ex. 2.1.4
fprintf('Ex. 2.1.4\n');

[C_m, Theta_m] = FourierSeries(t_', x_t', T0, m_max);

titl_ = 'Fourier Transform %s, for m = %d';
figure('Name', sprintf('Ex. 2.1.4: %s', sprintf(titl_, 'Coefficient (Cm) and Sinusoidal Phase, θm', m_max)));
subplot(2, 1, 1);
stem(0:m_max, C_m);
title(sprintf(titl_, 'Coefficient, C_m', m_max));

subplot(2, 1, 2);
stem(0:m_max, Theta_m);
title(sprintf(titl_, 'Sinusoidal Phase, \theta_m', m_max));
fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 2.1.5
fprintf('Ex. 2.1.5 (plotted)\n');

interval = '';
for m = 1:length(m_max_i)
	interval = sprintf('%s%d', interval, m_max_i(m));

	if m ~= length(m_max_i)
		interval = sprintf('%s, ', interval);
	end
end

titl_ = sprintf('Fourier Transform Signal Approximation for m %%s [%s]', interval);
figure('Name', sprintf(titl_, '∈'));
hold all;

plot(t_, x_t, 'b'); % original signal

i_ = 1;
ft = zeros(size(t_));
plot_colors = ['r', 'g', 'm', 'k'];
for m = 0:m_max
	ft = ft + C_m(m+1) * cos(m * W0 * t_ + Theta_m(m+1));

	if i_ <= length(m_max_i) && m == m_max_i(i_)
		plot(t_, ft, plot_colors(mod(i_, length(plot_colors)) + 1));
		i_ = i_ + 1;
	end
end

plot(t_, ft, plot_colors(mod(length(m_max_i), length(plot_colors)) + 1));
plot(t_, x_t, 'b--'); % original signal (to assure it is visible as well as a perfect approximation)
title(sprintf(titl_, '\in'));
hold off;

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 2.1.6
fprintf('Ex. 2.1.6 (plotted)\n');
c_m = zeros(1, m_max * 2 + 1);
c_m(m_max + 1) = C_m(1) * cos(Theta_m(1));

for m = 1:m_max
	c_m(m_max + 1 + m) = C_m(1 + m) * (cos(Theta_m(1 + m)) + 1j * sin(Theta_m(1 + m))) / 2;
	c_m(m) = C_m(1 + m) * (cos(Theta_m(1 + m)) - 1j * sin(Theta_m(1 + m))) / 2;
end

c_m_amp = abs(c_m);
c_m_phase = angle(c_m);

titl_ = 'Fourier Transform %s coefficients (%s), for m %s [%d, %d]';
figure('Name', sprintf('Ex: 2.1.6: %s', sprintf(titl_, 'cm', 'amplitude and phase', '∈', -m_max, m_max)));
subplot(2, 1, 1);
plot(-m_max:m_max, c_m_amp, '.');
title(sprintf(titl_, 'c_m', 'amplitude', '\in', -m_max, m_max));

subplot(2,1,2);
plot(-m_max:m_max, c_m_phase, '.');
title(sprintf(titl_, 'c_m', 'phase', '\in', -m_max, m_max));

end