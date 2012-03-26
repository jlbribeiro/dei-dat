function [noise] = ex3_rand_noise(t_, amp)
	noise = amp * (rand(size(t_)) - 0.5);
end
