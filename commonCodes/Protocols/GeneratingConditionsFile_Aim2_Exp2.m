%%%%%%%%%% generating conditions file for experiment 2 %%%%%%%%%%%%

%%%% opening conditions file %%%%
folderSourceString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\programs';
folderName = fullfile(folderSourceString,'AuditoryProjects','commonCodes','Protocols');
fid =fopen(fullfile(folderName,'ASSR_exp2.txt'),'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t','Condition','Frequency','Block','Timing File','TaskObject#1');

% for generating sound file name

modIndex = [0,0.125,0.25,0.5];
modIndex2 = [0,0.125,0.25,0.5];
modFreq = 20:4:60;
modFreq2 = 40;

count = 1;
for mi1 = 1:length(modIndex)
    for mi2 = 1:length(modIndex2)
        for mf1 = 1:length(modFreq)
            for mf2 = 1:length(modFreq2)
                str = sprintf('snd(Azi_0.0_Elev_0.0_Type_3_RF_40.0_RP_%2.1f_MD_%2.1f _RV_%1.1f _Dur_800.wav)',modIndex2(mi2)*100,modIndex(mi2)*100,modFreq(mf1));
                fprintf(fid,'\n%d\t%d\t%d\t%s\t%s',count,1,1,'timingfile_assr_exp2', str);
                count = count+1;
            end
        end
    end
end
 


%%blank stimuli
fprintf(fid,'\n%d\t%d\t%d\t%s\t%s\t%s\t',count,1,1,'timingfile_assr_exp2','snd(Azi_0.0_Elev_0.0_Type_0_RF_0.0_RP_0_MD_0.0_RV_0.0_Dur_800.wav)');
fclose(fid);
