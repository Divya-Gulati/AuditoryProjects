% runExtractAudEEGData

clear;close all; clc;

[subjectName,expDate,protocolNames] = EEGAuditoryData;
%[subjectName,expDate,protocolNames] = EEGAuditoryTestData;
gridType = 'EEG';

% Change this to the folder where rawData is kept%
folderSourceString = 'D:\OneDrive - Indian Institute of Science\divya\NimhansRippleProject\Divya_AuditoryProjects\data\humanEEG';

%segment these indices
SegmentIndex =1;

impedanceTag = 'ImpedanceAtStart';
displayFlag = 1;
capType = 'actiCap64_2019';


for id = 1:length(SegmentIndex) 
    for iid = 1:length(protocolNames{SegmentIndex(id)})
          protocolName = cell2mat(protocolNames{SegmentIndex(id)}(:,iid)); 
          extractAudEEGdata(subjectName{SegmentIndex(id)},expDate{SegmentIndex(id)},protocolName,folderSourceString)
    end
        getImpedanceDataEEG(subjectName{SegmentIndex(id)},expDate{SegmentIndex(id)},folderSourceString,gridType,impedanceTag,displayFlag,capType);
end


