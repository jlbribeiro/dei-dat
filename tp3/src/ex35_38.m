function ex35_38(map, width, height, x_axis, y_axis, X, DC_x_ind, DC_y_ind, choice, Flimit)
	%% Initial vars setup
	mask_scale_factor = 50;
	highpass_scale_factor = 10; % allows better contrast on Highpass Filters

	mask = zeros(size(X));

	filter_str_a = {'Lowpass' 'Highpass'};

	filter_str = char(filter_str_a(choice));

	%% Ex. 3.5.
	% Computing the mask matrix
	% (x - F0_x)^2 + (y - F0_y)^2 <= Fc^2

	Flimit_sq = Flimit * Flimit; % squaring the limit avoids the use of sqrt

	for i = 1:height
		y_offset_sq = DC_y_ind - i;

		% squaring d_y outside of the loop
		y_offset_sq = y_offset_sq * y_offset_sq;
		for j = 1:width
			x_offset = DC_x_ind - j;
			mask(i,j) = (x_offset * x_offset + y_offset_sq) <= Flimit_sq;
		end
	end

	% A Highpass Filter's mask is the xor'd version of the corresponding
	% Lowpass Filter's mask
	if choice == 2
		mask = 1 - mask;
	end

	titl_ = sprintf('Ex. 3.5: %s Filter with f_c = %d (%d scale factor)', filter_str, Flimit, mask_scale_factor);
	figure('Name', titl_);
	mesh(x_axis, y_axis, mask * mask_scale_factor);
	xlabel('Width');
	ylabel('Height');
	axis([x_axis(1) x_axis(end) y_axis(1) y_axis(end)]);
	view([-37.5, 30]);
	rotate3d;
	title(titl_);
	fprintf('Press [ENTER] to continue.\n'); pause();

	%% Ex. 3.6.
	X_filtered = X .* mask;

	titl_ = sprintf('Ex. 3.6: Frequency magnitude after applying %s Filter (with f_c = %d)', filter_str, Flimit);
	figure('Name', titl_);
	mesh(x_axis, y_axis, db(abs(X_filtered)));
	title(titl_);
	xlabel('Width');
	ylabel('Height');
	axis([x_axis(1) x_axis(end) y_axis(1) y_axis(end)]);
	view([-37.5, 30]);
	rotate3d;
	fprintf('Press [ENTER] to continue.\n'); pause();

	%% Ex. 3.7.
	x_filtered = ifft2(ifftshift(X_filtered));

	if choice == 2
		x_filtered = x_filtered * highpass_scale_factor;
	end;

	%% Ex. 3.8.
	titl_ = sprintf('Ex. 3.8: Resulting image, after applying the %s Filter (with F_c = %d)', filter_str, Flimit);
	figure('Name', titl_);
	imshow(x_filtered, map);
	title(titl_);
	fprintf('Press [ENTER] to end this filter''s analysis.\n'); pause();
end