%%%%% stimulus set for experiment one aim2 %%%%%%%

clear;
close all;
clc;

folderSaveString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\programs';
folderName = fullfile(folderSaveString,'AuditoryProjects','commonCodes','Sounds');

modIndex = [0.031250,0.0625,0.125,0.25,0.5,1]; %modulation Index
modFreq = 20:4:60; % modulation frequency
timeRange = 0.8;%seconds
fs =44100; % sampling frequency
t=0:1/fs:timeRange-1/fs; % Total time for simulation

%%
for mf = 1:length(modFreq)
    for m = 1:length(modIndex)
        
        %XXXXXXXXXXXXXXXX carrier signal generation XXXXXXXXXXXXXXX
        
        Ac=1;% Amplitude of carrier signal 
        fc=1000;% Frequency of carrier signal
        Tc=1/fc;% Time period of carrier signal
        yc=Ac*sin(2*pi*fc*t);% Equation of carrier signal
        
        mindex = modIndex(m);

        Am=Ac*mindex;%[ where, modulation Index (m)=Am/Ac ] % Amplitude of modulating signal
        fa=modFreq(mf); % Frequency of modulating signal
        Ta=1/fa;% Time period of modulating signal
        ym=Am*sin(2*pi*fa*t); % Equation of modulating signal
        
        %XXXXXXXXXXXXXXXXXX AM Modulation XXXXXXXXXXXXXXXXX
        
        y_notnorm=Ac*(1+mindex*sin(2*pi*fa*t)).*sin(2*pi*fc*t);% Equation of Amplitude modulated signal
        y = y_notnorm./max(abs(y_notnorm));  
        
        %XXXXXXXXXXXXXXXXXXX  Ramping  XXXXXXXXXXXXXXXXXXXXXXX
        rampTime = 0.01; %in seconds
        ramp = 'Hanning'; 
        rampedSound = rampSound(y,t,rampTime,ramp);
        
        sound_final(:,1)= rampedSound;
        sound_final(:,2)= rampedSound;

        str= sprintf('Azi_0.0_Elev_0.0_Type_2_RF_1000.0_RP_0.0_MD_%2.1f _RV_%1.1f _Dur_800.wav',mindex*100,fa);
        audiowrite(fullfile(folderName,str),sound_final,fs);
        
    end
end


%%%%%%% generating blank stimulus %%%%%%%%
data =zeros( length(t),2);
name = 'Azi_0.0_Elev_0.0_Type_0_RF_0.0_RP_0_MD_0.0_RV_0.0_Dur_800.wav';
audiowrite (fullfile(folderName,name),data,fs)