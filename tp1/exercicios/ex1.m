%% Ex 1.1.
Ts1 = 0.01;
Ts2 = 0.1;
Ts3 = 0.5;

t1 = -pi:Ts1:pi;
t2 = -pi:Ts2:pi;
t3 = -pi:Ts3:pi;

x1_t1 = 6 * cos(3*t1) .* sin(4*t1);
x1_t2 = 6 * cos(3*t2) .* sin(4*t2);
x1_t3 = 6 * cos(3*t3) .* sin(4*t3);

t = linspace(-pi, pi, 500);
x1_t = 6 * cos(3*t) .* sin(4*t);

plot(t, x1_t, 'b', t1, x1_t1, '+r', t2, x1_t2, 'oy', t3, x1_t3, '*g');

xlabel('tempo em s');
ylabel('x1(t)');
title('Gráfico do ex. 1.1');
grid;

% text(0, 2, 'texto');
% subplot(3, 2, 4)