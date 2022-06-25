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

% frequencia de amostragem FS
FS = 8000; 

% Alterando a freq de amostragem para FS usando o resample
if FS_musica ~= FS
   musica = resample(musica, FS, FS_musica);
end
if FS_voz ~= FS
   voz = resample(voz, FS, FS_voz);
end


%soundsc(musica, FS)
%soundsc(voz, FS)

t_musica = (1:length(musica))/FS;
t_voz = (1:length(voz))/FS;

figure('units', 'centimeters', 'position', [3, 3, 20, 13])
nexttile
plot(t_musica, musica/max(abs(musica)))
title('musica.wav')
xlim([0 inf])

nexttile
plot(t_voz, voz/max(abs(voz)))
title('voz.wav')
xlim([0 inf])

xlabel('tempo [s] \rightarrow')
