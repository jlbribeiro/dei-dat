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

% [zeroes, poles, ~] = tf2zpk(b, a);

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

%% Ex. 1.2.2
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432 0 0];

zeroes_poles = [roots(b)' roots(a)'];
for i = 1:length(zeroes_poles)
	if abs(zeroes_poles(i)) > 1
		i = 0;
		break;
	end;
end;

if i
	fprintf('Ex. 1.2.2\nThe y[n] system is stable, since every zero and pole is inside the unit circle.\n\n');
else
	fprintf('Ex. 1.2.2\nThe y[n] system is unstable, since not every zero and pole is inside the unit circle.\n\n');
end;

%% Ex. 1.2.3
syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
h = iztrans(H);
fprintf('Ex. 1.2.3\nSystem''s impulse response, h[n]:\n'); pretty(h);
fprintf('\n\n');

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
title(sprintf(titl_, 'in'));
legend('h[n] using iztrans', 'h[n] using impz', 'h[n] using dimpulse');

%% Ex. 1.2.5
syms z;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);
U = 1 / (1 - z^-1);

Y = U * H;
y = iztrans(Y);

fprintf('System''s unit step response:'); pretty(y);

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
title(sprintf(titl_, 'in'));
legend('y[n] unit step response using U(z) and iztrans', 'y[n] unit step response using dstep');

%% Ex. 1.2.7
LLIM = 0;
RLIM = 70;

syms z; syms n;
H = (0.3137 * z^2 - 0.1537) / (z^5 - 2.3 * z^4 + 1.74 * z^3 - 0.432 * z^2);

fprintf('Ex. 1.2.7\n');
x_expr = input('Insert an expression for x[n] [e.g.: 4 * (heaviside(n - 3) - heaviside(n - 9))]: ');

x = sym(x_expr);

X = ztrans(x);

Y = X * H;
y = iztrans(Y);

n = LLIM:RLIM;

y_n = subs(y, 'n', n);
titl_ = sprintf('Ex. 1.2.7: y[n] response to the specific input (%s), n %%s [0, 70]', char(x_expr));
figure('Name', sprintf(titl_, '∈'));
stairs(n, y_n);
title(sprintf(titl_, 'in'));

fprintf(sprintf('The y[n] system''s response to %s:\n', char(x_expr))); pretty(y);