%% Ex. 3.
% Initial Vars
demo_mode = true;

%% Ex. 3.1.
load files/sinal.mat
signal = sumsin_freqbrk;

titl_ = 'Ex. 3.1: Representation of Signal sumsin_freqbrk';
figure('Name', titl_);
plot(signal);
titl_ = 'Ex. 3.1: Representation of Signal sumsin\_freqbrk';
title(titl_);

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 3.2. - 3.3.
[ca, cd] = dwt(signal, 'haar');

figure('Name', 'Exercise 3.2.-3.3. Decomposition of signal using wavelet haar and respective reconstruction');
subplot(3, 1, 1);
titl_ = 'Approximation coefficients vector of Signal sumsin\_freqbrk';
plot(ca);
title(titl_);

subplot(3, 1, 2);
titl_ = 'Coefficients Detail Vector of Signal sumsin\_freqbrk';
plot(cd);
title(titl_);

%Reconstruction of signal using idwt
rec_signal = idwt(ca, cd, 'haar');

subplot(3, 1, 3);
titl_ = 'Reconstruction of Signal sumsin\_freqbrk with the Approximation and Coefficients Vector';
plot(rec_signal);
title(titl_);

if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

titl_ = 'Reconstruction of Signal sumsin\_freqbrk (blue) overlapped with Original Signal sumsin\_freqbrk (red)';
figure('Name', 'Ex. 3.3. Equality of Proof');
x = 1:length(signal);
plot(x, rec_signal, 'b-', x, signal, 'r-.');
title(titl_);

%% Ex. 3.4 - 3.5
MAX_LEVEL = 4;

choice = menu('Please choose the desired wavelet to analysis', 'db3', 'sym2');

if choice == 1
	wname = 'db3';
else
	wname = 'sym2';
end

[C, L] = wavedec(signal, MAX_LEVEL, wname);

figure('Name', sprintf('Ex. 3.4. - 3.5. Decomposition of signal with 4 level''s of resolution (using wavelet family %s)', wname));
subplot(6, 1, 1);
titl_ = 'Representation of Original Signal';
plot(signal);
title(titl_);

ca_max = appcoef(C, L, wname, MAX_LEVEL);
x_ca_max = linspace(0, length(signal) - 1, length(ca_max));

subplot(6, 1, 2);
titl_ = sprintf('Representation of Approximation Coefficients Level %d (using wavelet: %s)', MAX_LEVEL, wname);
plot(x_ca_max, ca_max);
title(titl_);

for detail_level = MAX_LEVEL : -1 : 1,
	cd_i = detcoef(C, L, detail_level);
	x_cd_i = linspace(0, length(signal) - 1, length(cd_i));
    
    subplot(6, 1, MAX_LEVEL - detail_level + 3);
	titl_ = sprintf('Representation of Detail Coeficients Level %d (using wavelet: %s)', detail_level, wname);
	plot(x_cd_i, cd_i);
	title(titl_);
end;

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 3.6
%Reconstruct single branch from 1-D wavelet coefficients
x_signal_rec_waverec = waverec(C, L, wname);

% Partial reconstruction matrix (for plotting)
% Index 1: Approximation coeffs. of MAX_LEVEL
% Index 2 to MAX_LEVEL + 1: Detail coeffs. of level MAX_LEVEL - index + 2
x_signal_rec_wrcoef_matrix = zeros(MAX_LEVEL + 1, length(signal));

x_signal_rec_wrcoef_matrix(1, :) = wrcoef('a', C, L, wname, MAX_LEVEL);

for detail_level = MAX_LEVEL : -1 : 1,
	index = MAX_LEVEL - detail_level + 2;
	x_signal_rec_wrcoef_matrix(index, :) = wrcoef('d', C, L, wname, detail_level);
end;

% Multilevel 1-D wavelet reconstruction
x_signal_rec_wrcoef = sum(x_signal_rec_wrcoef_matrix, 1);

figure('Name', 'Ex. 3.6. Original Signal and Reconstruction of Signal using function waverec and wrcoef');
subplot(3, 1, 1);
titl_ = 'Original Signal';
plot(x, signal);
title(titl_);

subplot(3, 1, 2);
titl_ = sprintf('Representation of Reconstructed Signal With the C and L Using wavelet: %s, with waverec', wname);
plot(x, x_signal_rec_waverec);
title(titl_);

subplot(3, 1, 3);
titl_ = sprintf('Representation of Reconstructed Signal with the aproximation coefficient level %d and the detail coefficients of level %d and upper. Using wavelet: %s, with wrcoef', MAX_LEVEL, MAX_LEVEL, wname);
plot(x, x_signal_rec_wrcoef);
title(titl_);

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

titl_ = sprintf('Representation of Original Signal (black dot''s) overlapped with Reconstructed Signal wrcoef(blue dashed) and Reconstruted Signal waverec(red). (using wavelet: %s)', wname);
figure('Name', 'Ex 3.6. Equality of Proof');
plot(x, x_signal_rec_wrcoef, 'b-', x, x_signal_rec_waverec, 'r-.', x, signal, 'ks', 'MarkerSize', 3, 'MarkerFaceColor', 'k');
title(titl_);