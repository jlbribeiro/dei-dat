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

titl = 'Ex. 1.1: Original expression signal overlapped by the cosine sum expression signal';
figure('Name', titl);
plot(t_t, x_t1, 'b-', t_t, x_t2, 'r-.');
title(titl);

%% Ex. 1.2.
% x[n] = 5/2 * cos(0) + cos(9 * n * Ts + pi/2) + cos(13 * n * Ts + 3*pi/2) + 5/2 * cos(16 * n * Ts)

%% Ex. 1.3.
N_POINTS = 500;
Ts = 0.1;
t_t = linspace(-pi, pi, N_POINTS);
t_n = -floor(((pi-(-pi))/Ts)/2):1:floor(((pi-(-pi))/Ts)/2);

%%%
% Signal calculation using matrixes (for GPU-accelerated operations)
% Ci = [5/2 1 1 5/2];
% Wi = [0; 9; 13; 16];
% Ti = [0; pi/2; 3*pi/2; 0];
% x_t = Ci * cos(Wi * t_t + Ti * ones(size(t_t)));
%%%

x_t = 5/2 * cos(0) + cos(9 * t_t + pi/2) + cos(13 * t_t + 3*pi/2) + 5/2 * cos(16 * t_t);
x_n = 5/2 * cos(0) + cos(9 * t_n * Ts + pi/2) + cos(13 * t_n * Ts + 3*pi/2) + 5/2 * cos(16 * t_n * Ts);

titl = sprintf('Ex. 1.3: x(t) representation using %d samples (blue); x[n] representation using Ts = %.1fs (red)', N_POINTS, Ts);
figure('Name', titl);
plot(t_t, x_t, 'b-', t_n * Ts, x_n, 'r*');
title(titl);

%% Ex.1.4.
MAX_ERROR = 0.001;

syms t;
x_1 = 5/2 * cos(0) + cos(9 * t + pi/2) + cos(13 * t + 3*pi/2) + 5/2 * cos(16 * t);

tic;
energy_t = int(x_1^2, t, -pi, pi); % assuming t is a real variable, abs() is redundant; therefore, it is removed, since it difficults the integral calculation
time_t = toc;
fprintf('x_1(t) exact energy value for t = [-π,π]:\n\tvalue: %s ≈ %f\n\texecution_time: %fs\n\n', char(energy_t), double(energy_t), time_t);

tic;
[energy_trap, step_trap] = trapezoidenergy(x_1, -pi, pi, MAX_ERROR);
time_trap = toc;
fprintf('x_1(t) approximated energy value for t = [-π,π] using the Trapezoid Rule (maximal error of %.3f):\n\tvalue: %f\n\tnecessary step: %f\n\texecution time: %fs\n', MAX_ERROR, energy_trap, step_trap, time_trap);

% TODO % TODO % TODO % TODO % TODO %
tic;
[energy_simpson, step_simpson] = simpsonenergy(x_1, -pi, pi, MAX_ERROR);
time_simpson = toc;
fprintf('x_1(t) approximated energy value for t = [-π,π] using Simpson Rule (maximal error of %.3f):\n\tvalue: %f\n\tnecessary step: %f\n\texecution time: %fs\n', MAX_ERROR, energy_simpson, step_simpson, time_simpson);
% TODO % TODO % TODO % TODO % TODO %

%% Ex.1.5.
%%%
% Energy calculation using matrixes (for GPU-accelerated operations)
% energy_n = sum(abs(x_n).^2)
%%%

energy_n = 0;
for i=1:length(x_n),
    energy_n = energy_n + abs(x_n(i))^2;
end
fprintf('x_1[n] signal''s energy for the [-π,π] interval is %f.\n', energy_n);