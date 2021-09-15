function [SubjectName,expDate,protocolNames,good_elecs] = EcogAuditoryGammaData

%protocol had 30 ripples, 1 sam, 1 blank
clear index; index=1; SubjectName{index} = '001PK'; expDate{index} = '190321'; protocolNames{index} = 'GRF_001';good_elecs{index}= {1,2,3,4};
clear index; index=2; SubjectName{index} = '002SU'; expDate{index} = '160421'; protocolNames{index} = 'GRF_001'; good_elecs{index}= {2,4};
clear index; index=3; SubjectName{index} = '003DE'; expDate{index} = '110821'; protocolNames{index} = 'GRF_001'; good_elecs{index}= {1,2,3};
clear index; index=4; SubjectName{index} = '004SS'; expDate{index} = '190821'; protocolNames{index} = 'GRF_001'; good_elecs{index}= {1,2,3};

end