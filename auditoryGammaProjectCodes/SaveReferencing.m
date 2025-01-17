%%%%%% creating and saving vals for average referencing %%%%%
clear;clc;
[subjectName,expDate,protocolNames,good_elecs] = EcogAuditoryGammaData;
folderSourceString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\data\humanECoG';
gridType = 'ECoG';

%%
for id = 6%1:length(subjectName)
    for iid = 1:length(protocolNames{id})
        % Get folders
        protocolName = cell2mat(protocolNames{id}(:,iid)) ;
        folderName = string(fullfile(folderSourceString,'data',subjectName{id},gridType,expDate{id},protocolName));
        folderExtract = fullfile(folderName,'extractedData');
        folderSegment = fullfile(folderName,'segmentedData');
        folderLFP = fullfile(folderSegment,'LFP');
        
        
        x = load(fullfile(folderLFP,'lfpInfo.mat'));
        AllElectrode=sort(x.analogChannelsStored);
        ElecSet = intersect(AllElectrode,cell2mat(good_elecs{id}));
        
        
        all_elec_Data = [];
        for i = 1:length(ElecSet)%elecs
            ElectrodeData = load(fullfile(folderLFP, ['elec' num2str(ElecSet(i)) '.mat']));
            all_elec_Data = [all_elec_Data;ElectrodeData.analogData];
        end
        
        analogData= mean(all_elec_Data);
        analogData= repmat(analogData,size(ElectrodeData.analogData,1),1);
        save(fullfile(folderLFP,'\AvgRef.mat'),'analogData');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



