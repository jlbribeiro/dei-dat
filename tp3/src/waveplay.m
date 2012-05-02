function wavplay(signal, Fs)
	wavwrite(signal, Fs, 'temp_wavplay.wav');
    !aplay -q temp_wavplay.wav
    !rm -rf temp_wavplay.wav
end
