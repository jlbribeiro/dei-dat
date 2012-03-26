%% Ex. 2
%% Ex. 2.1
%% Ex. 2.1.1 - 2.1.3
fprintf('Ex. 2.1.1, 2.1.2, 2.1.3\n');
T0 = input('Fundamental period: ');
t_ = linspace(0, T0, 500);

syms t;

choice = menu('Choose a signal, x(t):', 'Square Wave', 'Sawtooth Wave', 'Custom expression for x(t)');

if (choice == 1)
	x_t = ex213_square(t_);
elseif (choice == 2)
	x_t = ex213_sawtooth(t_, T0);
else
    x_t = double(subs(input('Insert the custom expression, x(t): '), 't', t_));
end

%% Ex. 2.1.4 - 2.1.6
m_max = 100;
m_max_i = [0, 1, 3, 5, 10, 50];

ex214_216(t_, x_t, T0, m_max, m_max_i, 'Ex. 2.1.4: ');

%% Ex. 2.2.
%% Ex. 2.2.1
T0 = 2 * pi;
t_ = linspace(0, T0, 500);
x_t = ex213_square(t_);

m_max = 100;
m_max_i = [0, 1, 3, 5, 10, 50];

ex214_216(t_, x_t, T0, m_max, m_max_i, 'Ex. 2.2.1: ');

%% Ex. 2.2.2
T0 = 2 * pi;
t_ = linspace(0, T0, 500);
x_t = ex213_sawtooth(t_, T0);

m_max = 100;
m_max_i = [0, 1, 3, 5, 10, 50];

ex214_216(t_, x_t, T0, m_max, m_max_i, 'Ex. 2.2.2: ');

%% Ex. 2.2.3
% x_t	= 1 + 2 * sin(12 * pi * t_ + pi/4) .* cos(21 * pi * t_)
%		= cos(0) + cos(33 * pi * t_ + 7 * pi / 4) + cos(9 * pi * t_ + pi / 4)
%
% W0	= 3 * pi
% T0	= 2 * pi / W0 = 2 / 3;

T0 = 2 / 3;

t_ = linspace(0, T0, 500);
x_t = cos(0) + cos(33 * pi * t_ + 7 * pi / 4) + cos(9 * pi * t_ + pi / 4);

m_max = 100;
m_max_i = [0, 1, 3, 5, 10, 50];

ex214_216(t_, x_t, T0, m_max, m_max_i, 'Ex. 2.2.3: ');

%% Ex. 2.2.4
% x_t	= -2 + 4 * cos(4 * t_ + pi / 3) - 2 * sin(10 * t_)
%		= 2 * cos(pi) + 4 * cos(4 * t_ + pi / 3) + 2 * cos(10 * t_ + pi / 2)
%
% W0	= 2
% T0	= 2 * pi / W0 = pi;

T0 = pi;

t_ = linspace(0, T0, 500);
x_t = 2 * cos(pi) + 4 * cos(4 * t_ + pi / 3) + 2 * cos(10 * t_ + pi / 2);

m_max = 100;
m_max_i = [0, 1, 3, 5, 10, 50];

ex214_216(t_, x_t, T0, m_max, m_max_i, 'Ex. 2.2.4: ');

%% Ex. 2.4
% TODO % % TODO % % TODO %