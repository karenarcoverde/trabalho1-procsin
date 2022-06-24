[~,Fs] = audioread('musica.wav');
tempo_inicial_segundos = 85;
tempo_inicial_amostras = tempo_inicial_segundos*Fs;
start = tempo_inicial_amostras;
samples = [start,start+5*Fs];
clear Fs
[musica,FS_musica] = audioread('musica.wav',samples);

[~,Fs] = audioread('voz.wav');
samples = [1,5*Fs];
clear Fs
[voz,FS_voz] = audioread('voz.wav',samples);

voz = voz(:,1);
musica = musica(:,1);

FS = 16000;

% --- Alterando a freq de amostragem para FS:
if FS_musica ~= FS
   musica = resample(musica, FS, FS_musica);
end
if FS_voz ~= FS
   voz = resample(voz, FS, FS_voz);
end

N = 512;
window = hamming(N);
Noverlap = N/2;

[SPEC_voz, w1, t1] = spectrogram(voz, window, Noverlap, N);
[SPEC_musica, w2, t2] = spectrogram(musica, window, Noverlap, N);

figure('units', 'centimeters', 'position', [2, 2, 23, 10])
spectrogram(voz, window, Noverlap, N, 'yaxis')
title('voz.wav')
colormap bone
figure('units', 'centimeters', 'position', [2, 2, 23, 10])
spectrogram(musica, window, Noverlap, N, 'yaxis')
title('musica.wav')
colormap bone