%% Ex. 3.
% Initial Vars
demo_mode = true;

%% Ex. 3.1.
load files/sinal.mat
signal = sumsin_freqbrk;
t = 0 : length(signal) - 1;

titl_ = 'Ex. 3.1: Representation of Signal sumsin_freqbrk';
figure('Name', titl_);
plot(t, signal);
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
plot(t, rec_signal);
title(titl_);

if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

titl_ = 'Reconstruction of Signal sumsin\_freqbrk (blue) overlapped with Original Signal sumsin\_freqbrk (red)';
figure('Name', 'Ex. 3.3. Equality of Proof');
plot(t, rec_signal, 'b-', t, signal, 'r-.');
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

figure('Name', sprintf('Ex. 3.4. - 3.5. Decomposition coefficients of signal with 4 level''s of resolution (using wavelet family %s)', wname));
subplot(MAX_LEVEL + 2, 1, 1);
titl_ = 'Representation of Original Signal';
plot(t, signal);
title(titl_);

ca_max = appcoef(C, L, wname, MAX_LEVEL);
x_ca_max = linspace(0, length(signal) - 1, length(ca_max));

subplot(MAX_LEVEL + 2, 1, 2);
titl_ = sprintf('Representation of Approximation Coefficients Level %d (using wavelet: %s)', MAX_LEVEL, wname);
plot(x_ca_max, ca_max);
title(titl_);

for detail_level = MAX_LEVEL : -1 : 1,
	cd_i = detcoef(C, L, detail_level);
	x_cd_i = linspace(0, length(signal) - 1, length(cd_i));
    
    subplot(MAX_LEVEL + 2, 1, MAX_LEVEL - detail_level + 3);
	titl_ = sprintf('Representation of Detail Coefficients Level %d (using wavelet: %s)', detail_level, wname);
	plot(x_cd_i, cd_i);
	title(titl_);
end;

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 3.5/3.6
%Reconstruct single branch from 1-D wavelet coefficients
signal_rec_waverec = waverec(C, L, wname);

% Partial reconstruction matrix (for plotting)
% Index 1 to MAX_LEVEL: Detail coeffs. of level index
% Index MAX_LEVEL + 1 (end): Approximation coeffs. of MAX_LEVEL
signal_rec_wrcoef_matrix = zeros(MAX_LEVEL + 1, length(signal));

signal_rec_wrcoef_matrix(end, :) = wrcoef('a', C, L, wname, MAX_LEVEL);

for detail_level = MAX_LEVEL : -1 : 1,
	signal_rec_wrcoef_matrix(detail_level, :) = wrcoef('d', C, L, wname, detail_level);
end;

% Ex. 3.5: Approximation and Detail coefficients corresponding signals
% representation
figure('Name', sprintf('Ex. 3.4. - 3.5. Decomposition of signal with 4 level''s of resolution (using wavelet family %s)', wname));
subplot(MAX_LEVEL + 2, 1, 1);
titl_ = 'Representation of Original Signal';
plot(t, signal);
title(titl_);

subplot(MAX_LEVEL + 2, 1, 2);
titl_ = sprintf('Representation of Approximation Coefficients Level %d Signal (using wavelet: %s)', MAX_LEVEL, wname);
plot(t, signal_rec_wrcoef_matrix(end, :));
title(titl_);

for detail_level = MAX_LEVEL : -1 : 1,
    subplot(MAX_LEVEL + 2, 1, MAX_LEVEL - detail_level + 3);
	titl_ = sprintf('Representation of Detail Coeficients Level %d Signal (using wavelet: %s)', detail_level, wname);
	plot(t, signal_rec_wrcoef_matrix(detail_level, :));
	title(titl_);
end;

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

% Ex. 3.6: Multilevel 1-D wavelet reconstruction
figure('Name', sprintf('Ex. 3.6. Incremental signal reconstruction with 4 level''s of resolution (using wavelet family %s)', wname));
subplot(MAX_LEVEL + 2, 1, 1);
plot(t, signal);
title('Representation of Original Signal');

signal_rec = signal_rec_wrcoef_matrix(end, :); % Approximation coefficients signal of level MAX_LEVEL

subplot(MAX_LEVEL + 2, 1, 2);
plot(t, signal_rec);
title(sprintf('Representation of partially reconstructed signal (level %d approximation coefficients signal, using wavelet: %s)', MAX_LEVEL, wname));

str_partial = ' partially';
for detail_level = MAX_LEVEL : -1 : 1,
	signal_rec = signal_rec + signal_rec_wrcoef_matrix(detail_level, :); % Detail coefficients signal of level MAX_LEVEL

	subplot(MAX_LEVEL + 2, 1, MAX_LEVEL - detail_level + 3);
	plot(t, signal_rec);

	if detail_level == 1
		str_partial = '';
	end;

	title(sprintf('Representation of%s reconstructed signal (level %d detail coefficients signal, using wavelet: %s)', str_partial, detail_level, wname));
end;

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;