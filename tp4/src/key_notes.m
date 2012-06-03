function [ output ] = key_notes(freqs)
	key_freqs = [262 277 294 311 330 349 370 392 415 440 466 494];
	key_names = {'Do' 'Do#' 'Re' 'Re#' 'Mi' 'Fa' 'Fa#' 'Sol' 'Sol#' 'La' 'La#' 'Si'};

	output = cell(1, length(freqs));
	for i = 1:length(freqs)
		freq = freqs(i);

		if freq ~= 0
			if freq < key_freqs(1)
				freq = freq * 2 ^ ceil(log2(key_freqs(1)) - log2(freq));
			end;

			if freq > key_freqs(end)
				freq = freq / 2 ^ ceil(log2(freq) - log2(key_freqs(end)));
			end;

			for j = 1:length(key_freqs)
				if (freq < key_freqs(j))
					break;
				end;
			end;

			if(j ~= 1)
				if(abs(freq - key_freqs(j - 1)) <= abs(freq - key_freqs(j)))
					j = j - 1;
				end;
			end;

			output(i) = key_names(j);
		else
			output(i) = {'.'}; % silence
		end;
	end;
end

