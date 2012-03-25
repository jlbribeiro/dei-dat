% Ex. 1.
% G = 25;
% A1 = -2.1 - 0.2 * mod(G, 2);		% => A1 = -2.3
% A2 = 1.43 + 0.31 * mod(G, 2);		% => A2 = 1.74
% A3 = -0.315 - 0.117 * mod(G, 2);	% => A3 = -0.432
% B2 = 0.9167 * mod(G + 1, 2);		% => B2 = 0
% B3 = 0.3137 * mod(G, 2);			% => B3 = 0.3137
% B4 = -0.5867 * mod(G + 1, 2);		% => B4 = 0
% B5 = -0.1537 * mod(G, 2);			% => B5 = -0.1537

% y[n] = B2 * x[n - 2] + B3 * x[n - 3] + B4 * x[n - 4] + B5 * x[n - 5] - A1 * y[n - 1] - A2 * y[n - 2] - A3 * y[n - 3]
% =>
% y[n] = 0.3137 * x[n - 3] - 0.1537 * x[n - 5] + 2.3 * y[n - 1] - 1.74 * y[n - 2] + 0.432 * y[n - 3]

%% Ex. 1.2.
%% Ex. 1.2.1
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

zeroes = roots(b);
poles = roots(a);

fprintf('Ex. 1.2.1\n\n');
fprintf('         0.3137 z^2 - 0.1537\n');
fprintf('-------------------------------------\n');
fprintf('z^5 - 2.3 z^4 + 1.74 z^3 - 0.432 z^2\n\n');

fprintf('Zeros:\n');
disp(zeroes);
fprintf('Poles:\n');
disp(poles);

titl_ = 'Ex. 1.2.1: y[n] z-plane representation (zeros and poles)';
figure('Name', titl_);
zplane(zeroes, poles);
title(titl_);

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.2
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

zeroes_poles = [roots(b)' roots(a)'];
for i_ = 1:length(zeroes_poles)
	if abs(zeroes_poles(i_)) > 1
		i_ = 0;
		break;
	end;
end;

if i_
	fprintf('Ex. 1.2.2\nThe y[n] system is stable, since every zero and pole is inside the unit circle.\n\n');
else
	fprintf('Ex. 1.2.2\nThe y[n] system is unstable, since not every zero and pole is inside the unit circle.\n\n');
end;

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.3
syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
h = iztrans(H);
fprintf('Ex. 1.2.3\nSystem''s impulse response, h[n]:\n'); pretty(h);

fprintf('\n\nPress ENTER to continue.\n\n'); pause();

%% Ex. 1.2.4
LLIM = 0;
RLIM = 70;

b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
h = iztrans(H);

n = LLIM:RLIM;

h1_n = subs(h, 'n', n);
h2_n = impz(b, a, length(n))';
h3_n = dimpulse(b, a)';

titl_ = 'Ex. 1.2.4: h[n], n %s [0, 70], using iztrans (blue), impz (red) and dimpulse (green)';
figure('Name', sprintf(titl_, '∈'));
hold all;
stairs(h1_n);
plot(h2_n(1:RLIM), 'ro');
plot(h3_n, 'g+');
hold off;
title(sprintf(titl_, '\in'));
legend('h[n] using iztrans', 'h[n] using impz', 'h[n] using dimpulse');
fprintf('Ex. 1.2.4 (plotted)\n');

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.5
syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
U = 1 / (1 - z^-1);

Y = U * H;
y = iztrans(Y);

fprintf('Ex. 1.2.5\n');
fprintf('System''s unit step response:'); pretty(y);

fprintf('\n\nPress ENTER to continue.\n\n'); pause();

%% Ex. 1.2.6
LLIM = 0;
RLIM = 70;

b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
U = 1 / (1 - z^-1);

Y = U * H;
y = iztrans(Y);

n = LLIM:RLIM;

y1_n = subs(y, 'n', n);
y2_n = dstep(b, a, length(n) - 1);

titl_ = 'Ex. 1.2.6: y[n] unit step response, n %s [0, 70], using U(z) and iztrans (blue) and dstep (red)';
figure('Name', sprintf(titl_, '∈'));
hold all;
stairs(y1_n(1:RLIM));
plot(y2_n, 'ro');
hold off;
title(sprintf(titl_, '\in'));
legend('y[n] unit step response using U(z) and iztrans', 'y[n] unit step response using dstep');

fprintf('Ex. 1.2.6 (plotted)\n');
fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.7
syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);

fprintf('Ex. 1.2.7\n');
x_expr = input('Insert an expression for x[n] [ENTER for: 4 * (heaviside(n - 3) - heaviside(n - 9))]: ', 's');
if isempty(x_expr)
	x_expr = '4 * (heaviside(n - 3) - heaviside(n - 9))';
end;

x = sym(x_expr);

X = ztrans(x);

Y = X * H;
y = iztrans(Y);

fprintf(sprintf('The y[n] system''s response to %s:\n', char(x_expr))); pretty(y);

fprintf('\n\nPress ENTER to continue.\n\n'); pause();

%% Ex. 1.2.8
LLIM = 0;
RLIM = 70;

b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

syms z;
syms n;

H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);

fprintf('Ex. 1.2.8\n');
x_expr = input('Insert an expression for x[n] [ENTER for: 4 * (heaviside(n - 3) - heaviside(n - 9))]: ', 's');
if isempty(x_expr)
	x_expr = '4 * (heaviside(n - 3) - heaviside(n - 9))';
end;

x = sym(x_expr);

X = ztrans(x);

Y = X * H;
y = iztrans(Y);

n = LLIM:RLIM;

x_n = double(subs(x, 'n', n(1:RLIM)+1));

y1_n = subs(y, 'n', n);
y2_n = filter(b, a, x_n);
y3_n = dlsim(b, a, x_n);

titl_ = sprintf('Ex. 1.2.8: y[n] response to the specific input (%s) using iztrans over convolution, filter and dlsim, n %%s [0, 70]', char(x_expr));
figure('Name', sprintf(titl_, '∈'));
hold all;
stairs(n, y1_n);
plot(y2_n, 'ro');
plot(y3_n, 'g+');
hold off;
title(sprintf(titl_, '\in'));
legend('y[n] response to the specific input using iztrans over convolution', 'y[n] response to the specific input using filter', 'y[n] response to the specific input using dlsim');

fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.9
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

w = linspace(0, pi, 1000);
H_w = freqz(b, a, w);

titl_ = 'y[n] frequency response in %s, %s %s [0, %s] rad';
figure('Name', sprintf('Ex. 1.2.9: %s', sprintf(titl_, 'amplitude (dB) and phase (deg)', 'Ω', '∈', 'π')));
subplot(2, 1, 1);
plot(db(abs(H_w)), 'b');
title(sprintf(titl_, 'amplitude (dB)', '\Omega', '\in', '\pi'));

subplot(2, 1, 2);
plot(unwrap(rad2deg(angle(H_w))), 'b');
title(sprintf(titl_, 'phase (deg)', '\Omega', '\in', '\pi'));

fprintf('Ex. 1.2.9 (plotted)\n');
fprintf('Press ENTER to continue.\n\n'); pause();

%% Ex. 1.2.10
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

gain = ddcgain(b, a);
fprintf('Ex. 1.2.10\nThe system''s gain is %.3f.\n', gain);