%% Ex 3.1.
n = -60:60;

x_n = signal3(n);
y_n = 0.1 * signal3(n-1) + 0.7 * signal3(n-2) + 0.2 * signal3(n-3);

plot(n, x_n, '-o', n, y_n, '-+');
% stem(n, x_n, n, y_n)

%% Ex 3.2.
clc;
n_noise = -63:60; % signal has a 3 step memory
noise_size = length(n_noise);

noise = rand(noise_size,1) * 0.4 - 0.2;

signal3(n-1) + noise(3 : noise_size - 1);

y_n = 0.1 * (signal3(n-1) + noise(3 : noise_size - 1)) + 0.7 * (signal3(n-2) + noise(2 : noise_size - 2)) + 0.2 * (signal3(n-3) + noise(1 : noise_size - 3));

x_n_noise = signal3(n) + noise(4 : noise_size);

plot(n, x_n_noise, '-o', n, y_n, '-+');