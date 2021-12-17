%%%%% stimulus set for experiment two- aim2 %%%%%%%

clear;
close all;
clc;

folderSaveString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\programs';
folderName = fullfile(folderSaveString,'AuditoryProjects','commonCodes','Sounds');

%input
modIndex = [0,0.125,0.25,0.5];
modIndex2 = [0,0.125,0.25,0.5];
modFreq = 20:4:60;
modFreq2 = 40;

%%
fs =44100; % sampling frequency
timeRange = 0.8;%seconds
t=0:1/fs:timeRange-1/fs; % Total time for simulation
Amplitude_of_carrier_freq = 1;
carrier_freq = 1000;

for mi1 = 1:length(modIndex)
    for mi2 = 1:length(modIndex2)
        for mf1 = 1:length(modFreq)
            for mf2 = 1:length(modFreq2)
                
                mindex1 =modIndex(mi1);
                mindex2 = modIndex2(mi2);
                fa1 = modFreq(mf1);
                fa2 = modFreq2(mf2);
                s1 = Amplitude_of_carrier_freq*(1+mindex1*sin(2*pi*fa1*t)).*sin(2*pi*carrier_freq*t);
                s2 = Amplitude_of_carrier_freq*(1+mindex2*sin(2*pi*fa2*t)).*sin(2*pi*carrier_freq*t);
                
                y = s1+s2;
                y = y./max(abs(y));
                
                %XXXXXXXXXXXXXXXXXXX  Ramping  XXXXXXXXXXXXXXXXXXXXXXX
                rampTime = 0.01; %in seconds
                ramp = 'Hanning';
                rampedSound = rampSound(y,t,rampTime,ramp);
                
                sound_final(:,1)= rampedSound;
                sound_final(:,2) = rampedSound;
                
                str = sprintf('Azi_0.0_Elev_0.0_Type_3_RF_40.0_RP_%2.1f_MD_%2.1f _RV_%1.1f _Dur_800.wav', mindex2*100,mindex1*100,fa1);
                audiowrite(fullfile(folderName,str),sound_final,fs);
            end
        end
    end
end
        
