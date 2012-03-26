%% Ex. 4.
%% Ex. 4.1.
% x(t) = A * e^(-a * t) * sin (4 * pi * t) dt, a > 0, 0 <= t < 6
% where A = 2 and a = 0.7
syms t;
syms w;

x = 2 * exp(-0.7 * t) * sin(4 * pi * t);
X = int(x * exp(-1j * w * t), t, 0, 6);

w_ = -30 * pi : pi / 6 : 30 * pi;
X_w = double(subs(X, 'w', w_));

titl_ = 'Signal''s Fourier Transform (%s), %s %s [-30 %s rad/s, 30 %s rad/s], with a step of %s/6 rad/s';
figure('Name', sprintf(sprintf('Ex. 4.1: %s', titl_), 'module', 'ω', '∈', 'π', 'π', 'π'));
plot (w_, abs(X_w));
title(sprintf(sprintf('Ex. 4.1: %s', titl_), 'module', '\omega', '\in', '\pi', '\pi', '\pi'));

figure('Name', sprintf(sprintf('Ex. 4.1: %s', titl_), 'phase', 'ω', '∈', 'π', 'π', 'π'));
plot (w_, angle(X_w));
title(sprintf(sprintf('Ex. 4.1: %s', titl_), 'phase', '\omega', '\in', '\pi', '\pi', '\pi'));

%% Ex. 4.2
syms t;
syms w;

x = 2 * exp(-0.7 * t) * sin(4 * pi * t);

t_ = linspace(0, 6, 1000);
x_t = double(subs(x, 't', t_));

X = int(x * exp(-1j * w * t), t, 0, 6);

x_2 = ifourier(X, t);
x_2_t = real(double(subs(x_2, t, t_)));

titl_ = 'Ex. 4.2: Original signal, x(t), (blue) overlapped by the Inverse Fourier Transform applied to x(t) * e ^ (-j w t) (red)';
figure('Name', titl_);
plot(t_, x_t, 'b', t_, x_2_t, 'r--');
title(titl_);

%% Ex. 4.3
%%% TODO