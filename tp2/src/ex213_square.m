function [x_t] = ex213_square(t_)
%% Ex. 2.1.3
    x_t = zeros(size(t_));
    x_t(1:round(length(t_) / 2)) = 1;	
end
