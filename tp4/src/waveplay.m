function waveplay(signal, Fs)
	if ~ispc
		wavwrite(signal, Fs, '/tmp/temp_waveplay.wav');
		!aplay -q /tmp/temp_waveplay.wav
		!rm -rf /tmp/temp_waveplay.wav
	else
		wavplay(signal, Fs);
	end;
end
