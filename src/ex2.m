% Ex. 2.
% G = 25;
% B11	=  0.4 * mod(G, 2);			%B11	=> 0.4
% B12	=  0.4 * mod(G + 1, 2);		%B12	=> 0
% B13	=  0.3 * (mod(G, 3) + 1);	%B13	=> 0.6
% B14	= -0.1 * (mod(G, 4) + 1);	%B14	=> -0.2
% B2	=  0.6 * (mod(G, 2) + 1);	%B2		=> 1.2
% B3	=  0.5 * (mod(G, 2) + 1);	%B3		=> 1.0

% y1[n] = B11 * x[n-1] + B12 * x[n-2] + B13 * x[n-3] + B14 * x[n-4]
% y2[n] = B2 * x[2 * n - 4]
% y3[n] = B3 * x[n-2] * x[n-3]
% y4[n] = (n-2) * x[n-3]
% =>
% y1[n] = 0.4 * x[n - 1] + 0.6 * x[n - 3] - 0.2 * x[n - 4]
% y2[n] = 1.2 * x[2 * n - 4]
% y3[n] = 1.0 * x[n - 2] * x[n - 3]
% y4[n] = (n-2) * x[n - 3]

%% Ex. 2.1.
n = -50:1:50;

u = @(x) x >= 0;

x = @(n) 1.5 * cos(0.025 * pi * n) .* (u(n + 40) - u(n - 40));
y1 = @(n) 0.4 * x(n - 1) + 0.6 * x(n - 3) - 0.2 * x(n - 4);
y2 = @(n) 1.2 * x(2 * n - 4);
y3 = @(n) x(n - 2) .* x(n - 3);
y4 = @(n) (n - 2) .* x(n - 3);

figure('Name', 'Ex. 2.1: x[n], y1[n], y2[n], y3[n] and y4[n], for n in [-50, 50]');
subplot(5,1,1), plot(n, x(n)), title('x[n] signal, for n in [-50, 50]');
subplot(5,1,2), plot(n, y1(n)), title('y1[n] signal, for n in [-50, 50]');
subplot(5,1,3), plot(n, y2(n)), title('y2[n] signal, for n in [-50, 50]');
subplot(5,1,4), plot(n, y3(n)), title('y3[n] signal, for n in [-50, 50]');
subplot(5,1,5), plot(n, y4(n)), title('y4[n] signal, for n in [-50, 50]');

%% Ex. 2.2.
% u[n], x[n] and y1[n] are redefined, since a clear workspace is always
% assumed.
LLIM = -50;
RLIM = 50;

BACK_MEMORY = 4;
OFF = abs(LLIM) + BACK_MEMORY + 1; % calculating the array offset, to assure correct subscription (MATLAB is 1-based, therefore + 1)

n = LLIM:1:RLIM;
n_memory = (LLIM - BACK_MEMORY):1:RLIM; % same as n, considering the y1[n] system's memory (4)

u = @(x) x >= 0;

x = @(n) 1.5 * cos(0.025 * pi * n) .* (u(n + 40) - u(n - 40));
x_noise = @(n) x(n) + 0.4 * rand(size(n)) - 0.2; % adding the noise (defining as a function, so it can be plotted on any interval)
x_noise_values = x_noise(n_memory); % calculating the x function (for n ∈ [-54, 50]) values with a uniform ]-0.2, 0.2[ noise (used for the input plot)

y1 = @(n) 0.4 * x(n - 1) + 0.6 * x(n - 3) - 0.2 * x(n - 4);
% Using the x function values + uniform noise with the offset array index.
% Although defined as a function, n is only valid on the [-54, 50] interval.
% For the infinite interval version: y1_x_noise = @(n) 0.4 * x_noise(n - 1) + 0.6 * x_noise(n - 3) - 0.2 * x_noise(n - 4);
y1_x_noise = @(n) 0.4 * x_noise_values(n - 1 + OFF) + 0.6 * x_noise_values(n - 3 + OFF) - 0.2 * x_noise_values(n - 4 + OFF);

figure('Name', 'Ex. 2.2: x[n] (blue) and x[n] with uniform noise between ]-0.2, 0.2[ (red), for n in [-54, 50] (above); y1[n] system''s response for x[n] (blue) and x[n] with noise, for n in [-50, 50] (below)');
subplot(2, 1, 1), plot(n_memory, x(n_memory), 'b', n_memory, x_noise_values, 'r'), title('x[n] (blue) and x[n] with uniform noise between ]-0.2, 0.2[ (red), for n in [-54, 50]');
subplot(2, 1, 2), plot(n, y1(n), 'b', n, y1_x_noise(n), 'r'), title('y1[n] system''s response for x[n] (blue) and the above x[n] with noise (red), for n in [-50, 50]');