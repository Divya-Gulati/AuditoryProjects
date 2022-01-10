clear;clc;close all;

%[subjectName,expDate,protocolNames] = EEGAuditoryData;
[subjectName,expDate,protocolNames] = EEGAuditoryTestData;

%find bad trials for these indices
SegmentIndex = 1:3;
folderSourceString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\data\humanEEG';
gridType ='EEG';
capType = 'actiCap64_2019';
electrodeGroup = 'Temporal';
checkPeriod = [-0.2 0.750];  
checkBaselinePeriod = [0.25 0.750];
useEyeData = 0;
nonEEGElectrodes = 65;

for id = 1:length(SegmentIndex)
    for iid = 1:length(protocolNames{SegmentIndex(id)})
        protocolName = cell2mat(protocolNames{SegmentIndex(id)}(:,iid));
        [badTrials{id,iid},allBadTrials{id,iid},badTrialsUnique{id,iid},badElecs{id,iid},totalTrials{id,iid},slopeValsVsFreq{id,iid}] = findBadTrialsWithEEG(subjectName{SegmentIndex(id)},expDate{SegmentIndex(id)},protocolName,folderSourceString,gridType,[],nonEEGElectrodes,impedanceTag,capType,electrodeGroup,checkPeriod,checkBaselinePeriod,useEyeData);
    end
end