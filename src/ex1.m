% Ex. 1.
% G = 25;
% A1 = 2 * mod(G, 2);       % => A1 = 2
% A2 = 3 * mod(G + 1, 2);   % => A2 = 0
% A3 = 5 * mod(G, 2);		% => A3 = 5
% A4 = 4 * mod(G + 1, 2);	% => A4 = 0
% Wa = mod(G, 5) + 2;		% => Wa = 2
% Wb = mod(G, 7) + 7;		% => Wb = 11
% Wc = mod(G, 9) + 1;		% => Wc = 8

% x(t) = A1 * sin(Wa * t) * cos(Wb * t) + A2 * cos(Wa * t) * sin(Wb * t) + A3 * cos(Wc * t)^2 + A4 * sin(Wc * t)^2
% =>
% x(t) = 2 * sin(2 * t) * cos(11 * t) + 5 * cos(8 * t)^2

%% Ex. 1.1.
N_POINTS = 1000;
t_t = linspace(-pi, pi, N_POINTS);

x_t1 = 2 * sin(2 * t_t) .* cos(11 * t_t) + 5 .* cos(8 * t_t) .^ 2;
x_t2 = 5/2 * cos(0) + cos(9 * t_t + pi/2) + cos(13 * t_t + 3*pi/2) + 5/2 * cos(16 * t_t);

titl = 'Ex. 1.1: Original signal expression overlapped by the cosine sum signal expression, with t in [-pi,pi]';
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

titl = sprintf('Ex. 1.3: x(t) representation using %d samples (blue), with t in [-pi,pi]; x[n] representation using Ts = %.1fs (red) on the same interval', N_POINTS, Ts);
figure('Name', titl);
plot(t_t, x_t, 'b-', t_n * Ts, x_n, 'r*');
title(titl);

%% Ex.1.4.
MAX_ERROR = 0.001;

syms t;
x_1 = 5/2 * cos(0) + cos(9 * t + pi/2) + cos(13 * t + 3*pi/2) + 5/2 * cos(16 * t);

% Assuming t is a real variable, abs() is redundant; therefore, its removal
% will provide the same result while being of faster computation, since it
% difficults the integral calculation.
% The lines commented below are also related with warnings thrown by the
% abs function and its 2nd order derivative (dirac function).

% x_1_energy = abs(x_1) ^ 2;
x_1_energy = x_1 ^ 2;

% warning('off','symbolic:sym:int:warnmsg1'); % suppress the "Warning: Explicit integral could not be found." message
tic;
energy_t = int(x_1_energy, t, -pi, pi);
time_t = toc;
% warning('on','symbolic:sym:int:warnmsg1');
fprintf('x_1(t) exact energy value for t ∈ [-π,π]:\n\tvalue: %s ≈ %.4f\n\texecution_time: %fs\n\n', char(energy_t), double(energy_t), time_t);

% warning('off','symbolic:mupadmex:MuPADTextWarning'); % suppress the "Warning: Function 'dirac' is not verified to be a valid MATLAB function." message
tic;
[energy_trap, step_trap] = trapezoidmaxerror(x_1_energy, -pi, pi, MAX_ERROR);
time_trap = toc;
% warning('on', 'symbolic:mupadmex:MuPADTextWarning');
fprintf('x_1(t) approximated energy value for t ∈ [-π,π] using the Trapezoid Rule (maximal error of %.3f):\n\tvalue: %.4f\n\tnecessary step: %f\n\texecution time: %fs\n\n', MAX_ERROR, energy_trap, step_trap, time_trap);

% warning('off','symbolic:mupadmex:MuPADTextWarning'); % suppress the "Warning: Function 'dirac' is not verified to be a valid MATLAB function." message
tic;
[energy_simpson, step_simpson] = simpsonmaxerror(x_1_energy, -pi, pi, MAX_ERROR);
time_simpson = toc;
% warning('on', 'symbolic:mupadmex:MuPADTextWarning');
fprintf('x_1(t) approximated energy value for t ∈ [-π,π] using Simpson Rule (maximal error of %.3f):\n\tvalue: %.4f\n\tnecessary step: %f\n\texecution time: %fs\n', MAX_ERROR, energy_simpson, step_simpson, time_simpson);

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