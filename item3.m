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

% Potencia dos sinais
pot_voz = sum(voz.^2)/length(voz);
pot_musica = sum(musica.^2)/length(musica);

% SNR = 10*log(pot_sinal/pot_ruido):
SNR = 0; 
pot_ruido_voz = pot_voz/10^(SNR/10);
pot_ruido_musica = pot_musica/10^(SNR/10);

% pot_ruido = desvio_padrao^(1/2):
desvio_voz = pot_ruido_voz^(1/2);
desvio_musica = pot_ruido_musica^(1/2);

% Colocando ruído branco nos sinais
contaminado_voz = voz + desvio_voz.*randn(length(voz),1);
contaminado_musica = musica + desvio_musica.*randn(length(musica),1);

t_contaminado_voz = (1:length(contaminado_voz))/FS;
t_contaminado_musica = (1:length(contaminado_musica))/FS;

% Gráfico dos sinais no tempo
figure('units', 'centimeters', 'position', [3, 3, 20, 13])
nexttile
plot(t_contaminado_voz, contaminado_voz/max(abs(contaminado_voz)))
title('contaminado voz.wav')
xlim([0 inf])
nexttile
plot(t_contaminado_musica, contaminado_musica/max(abs(contaminado_musica)))
title('contaminado musica.wav')
xlim([0 inf])
xlabel('tempo [s] \rightarrow')

% Espectogramas
N = 512;
window = hamming(N);
Noverlap = N/2;
figure('units', 'centimeters', 'position', [2, 2, 23, 10])
spectrogram(contaminado_voz, window, Noverlap, N, 'yaxis')
title('voz.wav')
colormap bone
figure('units', 'centimeters', 'position', [2, 2, 23, 10])
spectrogram(contaminado_musica, window, Noverlap, N, 'yaxis')
title('musica.wav')
colormap bone

%soundsc(contaminado_voz, FS)
%soundsc(contaminado_musica, FS)