%% Ex 4.
%Initial Vars
wname = 'haar';
MAX_LEVEL = 2;

[image map] = imread('files/lenna.jpg', 'jpg');

[C S] = wavedec2(image, MAX_LEVEL, wname);

%Coefficients
ca2 = appcoef2(C, S, MAX_LEVEL, wname);

%using 'all' parameter to retrieve all the horizontal, vertical and
%diagonal details at level N (in this case MAX_LEVEL)
[cdh2 cdv2 cdd2] = detcoef2('all', C, S, MAX_LEVEL);
[cdh1 cdv1 cdd1] = detcoef2('all', C, S, MAX_LEVEL-1);
cd2 = {cdh2 cdv2 cdd2};
cd1 = {cdh1 cdv1 cdd1};

ncolors = double(max(max(image)));

%Transform matrix to stay with map index
ca2m = wcodemat(ca2, ncolors);

% index 1: coefficient details horizontal
% index 2: coefficient details vertical
% index 3: coefficient details diagonal
cd2m = {[] [] []};
cd1m = {[] [] []};

for i = 1 : 3
	cd2m(i) = { wcodemat(cell2mat(cd2(i)), ncolors) };
	cd1m(i) = { wcodemat(cell2mat(cd1(i)), ncolors) };
end;

titl_ = 'Ex 4.1. Decomposition of image in two levels';
figure('Name', titl_);
x = [[ca2m cell2mat(cd2m(1)); cell2mat(cd2m(2)) cell2mat(cd2m(3))] cell2mat(cd1m(1)); cell2mat(cd1m(2)) cell2mat(cd1m(3))];
imshow(x, map);
title(titl_);

if exist('demo_mode', 'var') && demo_mode
    fprintf('Press [ENTER] to continue.\n'); pause();
end;

%% 4.2.
ca2 = wrcoef2('a', C, S, wname, MAX_LEVEL);
cd1 = {[] [] []};
cd2 = {[] [] []};
images = {[] zeros(length(image), length(image)) zeros(length(image), length(image)) []};

% Original Image
images(1) = { waverec2(C, S, wname) };

values = {'h' 'v' 'd'};
string = {'Original Image' 'Image with coefficients of level 2'
'Image with coefficients of level 1' 'Image with coefficients of level 1 to Level-Max with approximation coefficient of level 2'}';

for i = 1 : 3
	%Coefficients of level 2
	cd2(i) = { wrcoef2(char(values(i)), C, S, wname, MAX_LEVEL) };

	%Coefficients of level 1
	cd1(i) = { wrcoef2(char(values(i)), C, S, wname, MAX_LEVEL-1) };

	%Image with detail coefficients of level 2
	images(2) = { cell2mat(images(2)) + cell2mat(cd2(i)) };

	%Image with detail coefficients of level 1
	images(3) = { cell2mat(images(3)) + cell2mat(cd1(i)) };
end;

% Image with the detail coefficients of all 1 to Max-Levels
% with the approximation coefficient of Max-Level
images(4) = { cell2mat(images(2)) + cell2mat(images(3)) + ca2 };

for i = 1 : 4
	titl_ = string(i);
	figure('Name', char(titl_));
    imshow(cell2mat(images(i)), map);
	title(titl_);
    
    if exist('demo_mode', 'var') && demo_mode
        fprintf('Press [ENTER] to continue.\n'); pause();
    end;
end;
