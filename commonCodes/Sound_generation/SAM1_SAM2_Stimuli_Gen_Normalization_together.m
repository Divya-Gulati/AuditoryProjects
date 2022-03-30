clear;
close all;
clc;

folderSaveString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\programs';
folderName = fullfile(folderSaveString,'AuditoryProjects','commonCodes','Sounds','Sounds');

modIndex = [0.0625,0.125,0.25,0.5,1]; %modulation Index
modFreq = 22:6:58; % modulation frequency
timeRange = 0.8;%seconds
fs =44100; % sampling frequency
t=0:1/fs:timeRange-1/fs; % Total time for simulation


rampTime = 0.01; %in seconds
ramp = 'Hanning';
count= 1;
%%
y_notnorm = zeros(length(modFreq),length(modIndex),length(t));
for mf = 1:length(modFreq)
    for mi = 1:length(modIndex)
        
        %XXXXXXXXXXXXXXXX carrier signal generation XXXXXXXXXXXXXXX
        
        Ac=1;% Amplitude of carrier signal
        fc=1000;% Frequency of carrier signal
        Tc=1/fc;% Time period of carrier signal
        yc=Ac*sin(2*pi*fc*t);% Equation of carrier signal
        
        mindex = modIndex(mi);
        
        Am=Ac*mindex;%[ where, modulation Index (m)=Am/Ac ] % Amplitude of modulating signal
        fa=modFreq(mf); % Frequency of modulating signal
        Ta=1/fa;% Time period of modulating signal
        ym=Am*sin(2*pi*fa*t); % Equation of modulating signal
        
        %XXXXXXXXXXXXXXXXXX AM Modulation XXXXXXXXXXXXXXXXX
        
        y_notnorm(mf,mi,:) =(Ac*(1+mindex*sin(2*pi*fa*t))).*sin(2*pi*fc*t);% Equation of Amplitude modulated signal
         Simp_y_notnorm (:,count)= y_notnorm(mf,mi,:);%      
         count = count+1;
    end
end

%%%%% stimulus set for experiment two- aim2 %%%%%%%

%input
modIndex2 = [0,0.25,0.5];
modIndex22 = [0,0.25,0.5];
modFreq2 = 22:6:58;
modFreq22 = 40;


rampTime2 = 0.01; %in seconds
ramp2 = 'Hanning';

%%
fs2 =44100; % sampling frequency
timeRange2 = 0.8;%seconds
t2=0:1/fs2:timeRange2-1/fs2; % Total time for simulation
Amplitude_of_carrier_freq2 = 1;
carrier_freq2 = 1000;
count2 = 1;

for mi1 = 1:length(modIndex2)
    for mi2 = 1:length(modIndex22)
        for mf1 = 1:length(modFreq2)
            for mf2 = 1:length(modFreq22)
                
                mindex1 =modIndex2(mi1);
                mindex2 = modIndex22(mi2);
                fa1 = modFreq2(mf1);
                fa2 = modFreq22(mf2);
                s1 = (Amplitude_of_carrier_freq2*(1+mindex1*sin(2*pi*fa1*t2))).*sin(2*pi*carrier_freq2*t2);
                s2 = (Amplitude_of_carrier_freq2*(1+mindex2*sin(2*pi*fa2*t2))).*sin(2*pi*carrier_freq2*t2);
                s3 = Amplitude_of_carrier_freq2*sin(2*pi*carrier_freq2*t2).*(((mindex1*sin(2*pi*fa1*t2))+(mindex2*sin(2*pi*fa2*t2)))+1);
                
                y_notnorm2(mi1,mi2,mf1,:) = s3; %s1+s2;
               Simp_y_notnorm (:,count) = y_notnorm2(mi1,mi2,mf1,:);
               count = count+1;
            end
        end
    end
end

% normalizing by max of all sounds

norm_deno = max(abs(Simp_y_notnorm),[],'all');

y2 = y_notnorm2./norm_deno;
y = y_notnorm./norm_deno;



for mf = 1:length(modFreq)
    for mi = 1:length(modIndex)
        
        mindex = modIndex(mi);
        fa=modFreq(mf);
        
        oneSoundFile = squeeze(y(mf,mi,:));
        
        rampedSound = rampSound(oneSoundFile,t,rampTime,ramp);
        sound_final(:,1)= rampedSound;
        sound_final(:,2)= rampedSound;
        str= sprintf('Azi_0.0_Elev_0.0_Type_2_RF_1000.0_RP_0.0_MD_%2.1f _RV_%1.1f _Dur_800.wav',mindex*100,fa);
        audiowrite(fullfile(folderName,str),sound_final,fs);
    end
end

%XXXXXXXXXXXXXXXXXXX  Ramping  XXXXXXXXXXXXXXXXXXXXXXX
 for mi1 = 1:length(modIndex2)
     for mi2 = 1:length(modIndex22)
         for mf1 = 1:length(modFreq2)
             for mf2 = 1:length(modFreq22)
                 
                 mindex1 =modIndex2(mi1);
                 mindex2 = modIndex22(mi2);
                 fa1 = modFreq2(mf1);
                 fa2 = modFreq22(mf2);
                 
                 oneSoundFile = squeeze(y2(mi1,mi2,mf1,:));
                 
                 rampedSound = rampSound(oneSoundFile,t2,rampTime2,ramp2);
                 
                 sound_final(:,1)= rampedSound;
                 sound_final(:,2) = rampedSound;
                 
                 str = sprintf('Azi_0.0_Elev_0.0_Type_3_RF_40.0_RP_%2.1f_MD_%2.1f _RV_%1.1f _Dur_800.wav', mindex2*100,mindex1*100,fa1);
                 audiowrite(fullfile(folderName,str),sound_final,fs2);
             end
         end
     end
 end
 
 %%%%%%% generating blank stimulus %%%%%%%%
data =zeros( length(t),2);
name = 'Azi_0.0_Elev_0.0_Type_0_RF_0.0_RP_0_MD_0.0_RV_0.0_Dur_800.wav';
audiowrite (fullfile(folderName,name),data,fs);