%%%%%%%%%% generating conditions file for for experiment 1  %%%%%%%%%%%%

%%%% opening conditions file %%%%
folderSourceString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\programs';
folderName = fullfile(folderSourceString,'AuditoryProjects','commonCodes','Protocols');
fid =fopen(fullfile(folderName,'ASSR_exp1.txt'),'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t','Condition','Frequency','Block','Timing File','TaskObject#1');

% for generating sound file name

modIndex = [0.031250,0.0625,0.125,0.25,0.5,1];
modFreq = 20:4:60;


count = 1;
for mf = modFreq
    for mi = modIndex
        str = sprintf('snd(Azi_0.0_Elev_0.0_Type_2_RF_1000.0_RP_0.0_MD_%2.1f _RV_%1.1f _Dur_800.wav)',mi*100,mf);
        fprintf(fid,'\n%d\t%d\t%d\t%s\t%s',count,1,1,'timingfile_assr_exp1', str);
        count = count+1;
    end
end
 


%%blank stimuli
fprintf(fid,'\n%d\t%d\t%d\t%s\t%s\t%s\t',count,1,1,'timingfile_assr_exp1','snd(Azi_0.0_Elev_0.0_Type_0_RF_0.0_RP_0_MD_0.0_RV_0.0_Dur_800.wav)');
fclose(fid);


