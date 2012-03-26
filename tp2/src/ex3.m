%% Ex. 3.1.1 - 3.1.2
syms t;

T0 = input('Fundamental period: ');
t_ = linspace(0, T0, 500);

W0 = 2 * pi / T0;

m_max = double(input('Fourier Series maximum m: '));

choice = menu('Choose a signal, x(t):', 'Square Wave', 'Sawtooth Wave', 'Custom expression for x(t)');

if (choice == 1)
	x_t = ex213_square(t_);
elseif (choice == 2)
	x_t = ex213_sawtooth(t_, T0);
else
    x_t = double(subs(input('Insert the custom expression, x(t): '), 't', t_));
end

choice = menu('Type of noise', 'Random', 'Random defined in a certain range', 'Defined by an expression', 'Without Noise');

switch choice
    case 1
		noise = ex3_rand_noise(t_, 0.2);

	case 2
		m_noise_min = ceil(input('Choose the minimum frequency: ') / W0);
        m_noise_max = ceil(input('Choose the maximum frequency: ') / W0);

		noise = ex3_rand_range_noise(t_, W0, m_noise_min, m_noise_max, 0.2, 2 * pi);

	case 3
        noise = double(subs(input('Please input the expression: '), 't', t_));

    case 4
        noise = zeros(size(t_));

end

x_t_noise = x_t + noise;

titl_ = 'Ex. 3.1.2: Original signal (blue) overlapped by the noisy signal (red)';
figure('Name', titl_);
plot(t_, x_t, 'b', t_, x_t_noise, 'r');
title(titl_);

%% Ex. 3.1.3
choice = menu('Type of filter', 'Low pass', 'High Pass', 'Band-pass', 'Band-reject');
if choice == 1
	lim_m_inf = 0;
	lim_m_sup = ceil(input('Please insert the maximum frequency: ') / W0 );

elseif choice == 2
	lim_m_inf = ceil(input('Please insert the minimum frequency: ') / W0 );
	lim_m_sup = m_max;

else
	lim_m_inf = ceil( input('Please insert the minimum frequency: ') / W0);
	lim_m_sup = ceil( input('Please insert the maximum frequency: ') / W0);
end;
accept = choice < 4;

%% Ex. 3.1.4
ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, 'Ex. 3.1.4: ');

%% Ex. 3.2
%% Ex. 3.2.1
T0 = 2 * pi;
% W0 = 2 * pi / T0;

m_max = 100;
lim_m_inf = 0;
lim_m_sup = 20;
accept = true;

t_ = linspace(0, T0, 500);

x_t = ex213_square(t_);
noise = ex3_rand_noise(t_, 0.2);

ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, 'Ex. 3.2.1: ');

%% Ex. 3.2.2
T0 = 2 * pi;
W0 = 2 * pi / T0;

m_max = 100;
lim_m_inf = 0;
lim_m_sup = 4;
accept = true;

t_ = linspace(0, T0, 500);

x_t = ex213_sawtooth(t_, T0);
noise = ex3_rand_range_noise(t_, W0, ceil(4 / W0), ceil(6 / W0), 0.2, 2 * pi);

%figure();
%plot(t_, x_t, 'b', t_, x_t + noise, 'r');

ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, 'Ex. 3.2.2: ');

%% Ex. 3.2.3
% x_t	= 1 + 2 * sin(12 * pi * t_ + pi/4) .* cos(21 * pi * t_)
%		= cos(0) + cos(33 * pi * t_ + 7 * pi / 4) + cos(9 * pi * t_ + pi / 4)

T0 = 2 / 3;
W0 = 2 * pi / T0;

m_max = 100;
lim_m_inf = floor(20 * pi / W0);
lim_m_sup = ceil(30 * pi / W0);
accept = false;

t_ = linspace(0, T0, 500);

x_t = cos(0) + cos(33 * pi * t_ + 7 * pi / 4) + cos(9 * pi * t_ + pi / 4);
noise = ex3_rand_range_noise(t_, W0, ceil(20 * pi / W0), ceil(30 * pi / W0), 0.2, 2 * pi);

%[Cm Tetam] = FourierSeries(t_', x_t', T0, m_max);
%figure();
%plot(0:m_max, Cm, 'o');

ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, 'Ex. 3.2.3: ');

%% Ex. 3.2.4
% x_t	= -2 + 4 * cos(4 * t_ + pi / 3) - 2 * sin(10 * t_)
%		= 2 * cos(pi) + 4 * cos(4 * t_ + pi / 3) + 2 * cos(10 * t_ + pi / 2)
%
% W0	= 2
% T0	= 2 * pi / W0 = pi;

T0 = pi;
W0 = 2 * pi / T0;

m_max = 100;
lim_m_inf = 1;
lim_m_sup = 5;
accept = true;

t_ = linspace(0, T0, 500);

x_t = 2 * cos(pi) + 4 * cos(4 * t_ + pi / 3) + 2 * cos(10 * t_ + pi / 2);
noise = 0.2 * cos(9 * t_) .^ 2;

ex314(T0, t_, x_t, noise, m_max, lim_m_inf, lim_m_sup, accept, 'Ex. 3.2.4: ');