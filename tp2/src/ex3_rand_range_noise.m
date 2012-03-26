function [noise] = ex3_rand_range_noise(t_, W0, m_noise_min, m_noise_max, C_m_amp, Theta_m_amp)
	C_m_noise = C_m_amp * (rand(1, m_noise_max - m_noise_min + 1) - 0.5);
	Theta_m_noise = Theta_m_amp * (rand(1, m_noise_max - m_noise_min + 1) - 0.5);

	noise = zeros(size(t_));

	for m = m_noise_min : m_noise_max
		noise = noise + C_m_noise(m - m_noise_min + 1) .* cos(m * W0 * t_ + Theta_m_noise(m - m_noise_min + 1));
	end
end
