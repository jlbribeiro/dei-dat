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
% --- TODO ---

%% Ex. 1.2.
% --- TODO --- Verificar
% x[n] = 2 * sin(2 * n * Ts) * cos(11 * n * Ts) + 5 * cos(8 * n * Ts)^2

%% Ex. 1.3.
Ts = 0.1;
t = linspace(-pi, pi, 500);
td = -pi:Ts:pi;

x_t = 2 * sin(2 * t) .* cos(11 * t) + 5 * cos(8 * t) .^ 2;
x_n = 2 * sin(2 * td) .* cos(11 * td) + 5 * cos(8 * td) .^ 2;

plot(t, x_t, 'b-', td, x_n, 'r*');
title('Ex. 1.3: representação de x(t) com 500 elementos (azul) e de x[n] com Ts = 0.1s (vermelho)');

%% Ex.1.4.
% --- TODO ---

%% Ex.1.5.
sumd = sum(abs(xd) .^ 2);
fprintf('The x[n] signal''s energy on the [-π,π] interval is %f.\n', sumd);