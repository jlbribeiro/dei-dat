%% Initial vars setup
demo_mode = true;

%% Ex. 3.
%% Ex. 3.1.
[img, map] = imread('files/lena.bmp', 'bmp');
[height, width] = size(img);

%% Ex. 3.2.
titl_ = 'Ex. 3.2: Original image (lena.bmp)';
figure('Name', titl_);
imshow(img, map);
title(titl_);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 3.3.
% Applying the 2-D DFT
X = fftshift(fft2(img));

% Calculating the axis
x_axis = -(width - mod(width, 2)) / 2 : 1 : (width - mod(width, 2)) / 2 - (mod(width + 1, 2));
y_axis = (-(height - mod(height, 2)) / 2 : 1 : (height - mod(height, 2)) / 2 - (mod(height + 1, 2)));

titl_ = 'Ex. 3.3: Frequency magnitude plot (Fourier Transform)';
figure('Name', titl_);
mesh(x_axis, y_axis, db(abs(X)));
title(titl_);
xlabel('Width');
ylabel('Height');
axis([x_axis(1) x_axis(end) y_axis(1) y_axis(end)]);
view([-37.5, 30]);
rotate3d;

% Calculating the DC component (0-frequency) on the X matrix after the
% fftshift
DC_x_ind = (width - mod(width, 2)) / 2 + 1;
DC_y_ind = (height - mod(height, 2)) / 2 + 1;

% The DC component (0-frequency) obtained in the DFT is multiplied by N (in
% this case, since we're dealing with a 2-D DFT, width * height). Therefore
% we must multiply by 1 / N.
% Since the absolute value of the 0-frequency (its magnitude) in the
% Complex Fourier Transform is equal to the Trigonometric Fourier
% Transform, no further calculations should be made.
DC_amp = X(DC_y_ind, DC_x_ind) / (width * height);

fprintf('\nThe average color amplitude is %f.\n\n', DC_amp);
if exist('demo_mode', 'var') && demo_mode
	fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 3.5 - ex. 3.8.
default_filters = menu('Mode', 'User input', 'Default filters') - 1;

if default_filters
	% Ex. 3.5 - ex. 3.8. (analysis)
	ex35_38(map, width, height, x_axis, y_axis, X, DC_x_ind, DC_y_ind, 1, 20);
	ex35_38(map, width, height, x_axis, y_axis, X, DC_x_ind, DC_y_ind, 2, 30);
else
	% Ex. 3.4.
	choice = menu('Filter choice', 'Lowpass filter', 'Highpass filter');

	% Ex. 3.5.
	Flimit = input('Please choose the cutting frequency: ');

	% Ex. 3.5 - ex. 3.8.
	ex35_38(map, width, height, x_axis, y_axis, X, DC_x_ind, DC_y_ind, choice, Flimit);
end;