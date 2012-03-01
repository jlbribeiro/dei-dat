% Ex. 1.
G = 25;
A1 = 2 * mod(G, 2);       % => A1 = 2
A2 = 3 * mod(G + 1, 2);   % => A2 = 0
A3 = 5 * mod(G, 2);		% => A3 = 5
A4 = 4 * mod(G + 1, 2);	% => A4 = 0
Wa = mod(G, 5) + 2;		% => Wa = 2
Wb = mod(G, 7) + 7;		% => Wb = 11
Wc = mod(G, 9) + 1;		% => Wc = 8

% x(t) = A1 * sin(Wa * t) * cos(Wb * t) + A2 * cos(Wa * t) * sin(Wb * t) + A3 * cos(Wc * t)^2 + A4 * sin(Wc * t)^2
% =>
% x(t) = 2 * sin(2 * t) * cos(11 * t) + 5 * cos(8 * t)^2

%% Ex. 1.1.
N_POINTS = 1000;
t_t = linspace(-pi, pi, N_POINTS);

x_t1 = 2 * sin(2 * t_t) .* cos(11 * t_t) + 5 .* cos(8 * t_t) .^ 2;
x_t2 = 5/2 * cos(0) + cos(9 * t_t + pi/2) + cos(13 * t_t + 3*pi/2) + 5/2 * cos(16 * t_t);

plot(t_t, x_t1, 'b-', t_t, x_t2, 'r-.');
title('Ex. 1.1: Original expression signal overlapped by the cosine sum expression signal');

%% Ex. 1.2.
% x[n] = 5/2 * cos(0) + cos(9 * n * Ts + pi/2) + cos(13 * n * Ts + 3*pi/2) + 5/2 * cos(16 * n * Ts)

%% Ex. 1.3.
N_POINTS = 500;
Ts = 0.1;
t_t = linspace(-pi, pi, N_POINTS);
t_n = -pi:Ts:pi;

%%%
% Signal calculation using matrixes (for GPU-accelerated operations)
% Ci = [5/2 1 1 5/2];
% Wi = [0; 9; 13; 16];
% Ti = [0; pi/2; 3*pi/2; 0];
% x_t = Ci * cos(Wi * t_t + Ti * ones(size(t_t)));
%%%

x_t = 5/2 * cos(0) + cos(9 * t_t + pi/2) + cos(13 * t_t + 3*pi/2) + 5/2 * cos(16 * t_t);
x_n = 5/2 * cos(0) + cos(9 * t_n + pi/2) + cos(13 * t_n + 3*pi/2) + 5/2 * cos(16 * t_n);

plot(t_t, x_t, 'b-', t_n, x_n, 'r*');
title('Ex. 1.3: x(t) representation using 500 samples (blue); x[n] representation using Ts = 0.1s (red)');

%% Ex.1.4.
% --- TODO ---

%% Ex.1.5.
%%%
% Energy calculation using matrixes (for GPU-accelerated operations)
% energy_n = sum(abs(x_n).^2)
%%%

energy_n = 0;
for i=1:length(x_n),
    energy_n = energy_n + abs(x_n(i))^2;
end
fprintf('The x[n] signal''s energy on the [-π,π] interval is %f.\n', energy_n);