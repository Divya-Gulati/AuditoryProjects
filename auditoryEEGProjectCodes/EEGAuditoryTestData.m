function [subjectNames,expDates,protocolNames] = EEGAuditoryTestData

clear index; index=1; subjectNames{index} = '001AT'; expDates{index} = '2512211'; protocolNames{index} ={'GRF_004'};
clear index; index=2; subjectNames{index} = '002NT'; expDates{index} = '311221'; protocolNames{index} ={'GRF_004','GRF_005'};
clear index; index=3; subjectNames{index} = '003ST'; expDates{index} = '020122'; protocolNames{index} ={'GRF_003','GRF_005'};

end