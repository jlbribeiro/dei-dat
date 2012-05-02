%% Ex. 2.
%% Ex. 2.1.
[x, Fs, Nbits] = wavread('files/saxriff.wav');
waveplay(x, Fs);

% N = length(x);
N = 2 ^ ceil(log(length(x)) / log(2));

Fstep = Fs / N;

X = fftshift(fft(x, N));

f = linspace(-(N-mod(N, 2)) / 2, (N-mod(N, 2)) / 2 - (1 - mod(N, 2)), N) * Fstep;

figure();
stem(f, abs(X));

%% Ex. 2.2.
F0_ind = (N - mod(N, 2)) / 2 + 1;
Fmax_ind = F0_ind;
Fmax_amp = abs(X(Fmax_ind));

for i = F0_ind+1:length(X)
	if abs(X(i)) > Fmax_amp
		Fmax_ind = i;
		Fmax_amp = abs(X(i));
	end;
end;

C_m_Fmax = 2 * abs(X(Fmax_ind)) / N;

fprintf('The maximum amplitude frequency is %.2fHz, with an amplitude of %.2f.\n', f(Fmax_ind), C_m_Fmax);

%% Ex. 2.3.
%%% TODO