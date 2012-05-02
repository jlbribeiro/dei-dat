function waveplay(signal, Fs)
	wavwrite(signal, Fs, '/tmp/temp_waveplay.wav');
	!aplay -q /tmp/temp_waveplay.wav
	!rm -rf /tmp/temp_waveplay.wav
end
