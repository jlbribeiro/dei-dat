%% Ex 4.
% Initial Vars
wname = 'haar';
MAX_LEVEL = 2;

[img map] = imread('files/lenna.jpg', 'jpg');

[C S] = wavedec2(img, MAX_LEVEL, wname);

%Coefficients
ca_max = appcoef2(C, S, MAX_LEVEL, wname);

% index 1: coefficient details horizontal
% index 2: coefficient details vertical
% index 3: coefficient details diagonal
cd = cell(MAX_LEVEL, 3);
for detail_level = MAX_LEVEL : -1 : 1,
	% Using 'all' parameter to retrieve all the horizontal, vertical and
	% diagonal detail coefficients at level MAX_LEVEL
	[h v d] = detcoef2('all', C, S, detail_level);
	cd(detail_level, :) = {h v d};
end;

n_colors = double(max(max(img)));

% Maps the color values to map indexes
ca_max_map = wcodemat(ca_max, n_colors);

cd_map = cell(MAX_LEVEL, 3);
for dim = 1 : 3,
	for detail_level = MAX_LEVEL : -1 : 1,
		cd_map(detail_level, dim) = {wcodemat(cell2mat(cd(detail_level, dim)), n_colors)};
	end;
end;

% 'Dirty' generalization
matrix = ca_max_map;
for detail_level = MAX_LEVEL : -1 : 1
	matrix = [matrix cell2mat(cd_map(detail_level, 1)); cell2mat(cd_map(detail_level, 2)) cell2mat(cd_map(detail_level, 3))];
end;

titl_ = sprintf('Ex 4.1. Decomposition of image in %d levels', MAX_LEVEL);
figure('Name', titl_);
imshow(matrix, map);
title(titl_);

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% Ex. 4.2
ca_max_rec = wrcoef2('a', C, S, wname, MAX_LEVEL);

img_rec = ca_max_rec;

titl_ = sprintf('Ex. 4.2. Representation of the partially reconstructed image, %d level approximation coefficients (using wavelet %s)', MAX_LEVEL, wname);
figure('Name', titl_);
imshow(img_rec, map);
title(titl_);

str_partial = ' partially';
dims = {'h', 'v', 'd'};
for detail_level = MAX_LEVEL : -1 : 1,
	for dim = 1:3
		img_rec = img_rec + wrcoef2(char(dims(dim)), C, S, wname, detail_level);
	end;

	titl_ = sprintf('Ex. 4.2. Representation of the%s reconstructed image, with level %d detail coefficients (using wavelet %s)', str_partial, detail_level, wname);
	figure('Name', titl_);
	imshow(img_rec, map);
	title(titl_);
end;