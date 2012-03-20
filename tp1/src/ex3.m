%% Ex. 3.
%% Ex. 3.1
f_i = 200; % minimum frequency
f_step = 100; % frequency step
f_f = 18000; % maximum frequency

% Sampling frequency: in this case, the double of the max human-audible
% frequency
Fs = 44100;
Ts = 1 / Fs;

t = 0 : Ts : 0.5; % 0.5 seconds of sound

for f = f_i : f_step : f_f
	x = sin(2 * pi * f * t);
	wavplay(x, Fs, 'async');
end;

%% Ex. 3.2.
f_i = 200;
f_step = 100;
f_f = 18000;

Fs = 44100;
Ts = 1 / Fs;

t = 0 : Ts : 0.5;

for f = f_i : f_step : f_f
    x = sin(2 * pi * f * t);
    wavplay(x, Fs, 'async');
    signal = wavrecord(0.5 * Fs + 1, Fs);
    % plot(t, signal);
end

%% Ex. 3.3.
f_i = 200;
f_step = 100;
f_f = 18000;

Fs = 44100;
Ts = 1 / Fs;

t = 0 : Ts : 0.5;

amps = zeros(1, (f_f - f_i) / f_step);

N = 5;
j = 1;

maxs = zeros(1,N);
mins = zeros(1,N);
for f = f_i : f_step : f_f
    x = sin(2 * pi * f * t);
    wavplay(x, Fs, 'async');

    signal = wavrecord(0.5 * Fs + 1, Fs);
    signal_size = length(signal);

    interval_length = floor(signal_size / N);

    for i = 1:N,
        interval = signal((i - 1) * interval_length + 1 : i * interval_length);
        maxs(i) = max(abs(interval));
        mins(i) = min(abs(interval));
    end;

    amps(j) = sum((maxs - mins) ./ 2) / N;
    j = j + 1;
end

figure('Name', 'Signal''s amplitude by frequency');
f = f_i : f_step : f_f;
plot(f, amps);
title('Ex. 3.3: Signal''s amplitude by frequency')