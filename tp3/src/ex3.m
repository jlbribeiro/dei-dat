%% Ex. 3.
%% Ex. 3.1.
[img, map] = imread('files/lena.bmp', 'bmp');
[height, width] = size(img);

%% Ex. 3.2.
figure();
imshow(img, map);

%% Ex. 3.3.
X = fftshift(fft2(img));

x_axis = -(width - mod(width, 2)) / 2 : 1 : (width - mod(width, 2)) / 2 - (1 - mod(width, 2));
y_axis = (-(height - mod(height, 2)) / 2 : 1 : (height - mod(height, 2)) / 2 - (1 - mod(height, 2)));

figure();
mesh(x_axis, y_axis, db(abs(X)));
xlabel('Width');
ylabel('Height');
axis([x_axis(1) x_axis(end) y_axis(1) y_axis(end)]);
view([-37,5, 30]);
rotate3d;

DC_x_ind = (width - mod(width, 2)) / 2 + 1;
DC_y_ind = (height - mod(height, 2)) / 2 + 1;

DC_amp = X(DC_y_ind, DC_x_ind) / (width * height);

fprintf('The average color amplitude is %f.\n', DC_amp);

%% Ex. 3.4.
mask_scale_factor = 50;
highpass_scale_factor = 10;

mask = zeros(size(X));

choice = menu('Filter choice', 'Lowpass filter', 'Highpass filter') - 1;

%% Ex. 3.5.
Flimit = input('Please choose the cutting frequency: ');
Flimit_sq = Flimit * Flimit;

for i = 1:height
	y_offset_sq = DC_y_ind - i;
	y_offset_sq = y_offset_sq * y_offset_sq;
	for j = 1:width
		x_offset = DC_x_ind - j;
		mask(i,j) = (x_offset * x_offset + y_offset_sq) <= Flimit_sq;
	end
end

if choice
	mask = 1 - mask;
end

figure();
mesh(x_axis, y_axis, mask * mask_scale_factor);

%% Ex. 3.6.
X_filtered = X .* mask;

figure();
mesh(x_axis, y_axis, db(abs(X_filtered)));
xlabel('Width');
ylabel('Height');
axis([x_axis(1) x_axis(end) y_axis(1) y_axis(end)]);
view([-37,5, 30]);
rotate3d;

%% Ex. 3.7.
x_filtered = ifft2(ifftshift(X_filtered));

if choice
	x_filtered = x_filtered * highpass_scale_factor;
end;

%% Ex. 3.8.
figure();
imshow(x_filtered, map);