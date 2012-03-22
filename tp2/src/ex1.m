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
a = [1 -2.3 1.74 -0.432];

zeroes = roots(b);
poles = roots(a);

% [zeroes, poles, ~] = tf2zpk(b, a);

fprintf('Ex. 1.2.1\n\n');
fprintf('     0.3137 z^-3 - 0.1537 z^-5\n');
fprintf('-------------------------------------\n');
fprintf('1 - 2.3 z^-1 + 1.74 z^-2 - 0.432 z^-3\n\n');

fprintf('Zeros:\n');
disp(zeroes);
fprintf('Poles:\n');
disp(poles);

titl_ = 'Ex. 1.2.1: y[n] z-plane representation (zeros and poles)';
figure('Name', titl_);
zplane(b, a); % includes 2 "extra" poles
% zplane(zeroes, poles);
title(titl_);

%% Ex. 1.2.2
b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432];

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
H = (0.3137 * z^-3 - 0.1537 * z^-5) / (1 - 2.3 * z^-1 + 1.74 * z^-2 - 0.432 * z^-3);
h = iztrans(H);
fprintf('Ex. 1.2.3\nSystem''s impulse response, h[n]:\n');
pretty(h);
fprintf('\n\n');

%% Ex. 1.2.4
LLIM = 0;
RLIM = 70;

b = [0 0 0 0.3137 0 -0.1537];
a = [1 -2.3 1.74 -0.432];

syms z;
H = (0.3137 * z^-3 - 0.1537 * z^-5) / (1 - 2.3 * z^-1 + 1.74 * z^-2 - 0.432 * z^-3);
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