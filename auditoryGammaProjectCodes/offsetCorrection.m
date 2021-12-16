
function goodStimTimes = offsetCorrection(subjectName,expDate,protocolName,folderSourceString,stimNumbers,startTimes)

%getting .vhdr fileName
fileName = [subjectName expDate protocolName '.vhdr'];
folderIn = fullfile(folderSourceString,'data','rawData',[subjectName expDate]);

% use EEGLAB plugin "bva-io" to read the file
eegInfo = pop_loadbv(folderIn,fileName,[],[]);

% getting the unsegmented data to shift markers
s = eegInfo.data(end,:); % data from electrode 5 - sound input
t = eegInfo.times;
figure,plot(t,s);

cutOff = input ("Enter amplitude cutOff Value  "); % can only be decided after visual inspection

% removing trials for blank condition (number 32)
cond = stimNumbers;
idx = find(cond==max(stimNumbers));
startTimes_noblank = startTimes*1000; %changing timeStamps to milliseconds
startTimes_noblank(idx)= [];

% finding the timeStamp when amplitude crosses a certain threshold

for iStart_noblank = 1: length(startTimes_noblank)
    start_noblank = startTimes_noblank(iStart_noblank);
    for iTimes_noblank = 1:length(t)
        if (t(iTimes_noblank)> start_noblank)&& s(iTimes_noblank)> cutOff %-2.5*1000 %-6000% 4*100000%-8000%-1.9*10000
            ind(iStart_noblank) = iTimes_noblank;
            break;
        end
    end
end

timeInd = t(ind);
timeDiff = timeInd - startTimes_noblank; % offset Values

mintimeDiff = min(timeDiff);
maxtimeDiff = max(timeDiff);
meantimeDiff = mean(timeDiff);
mediantimeDiff = median(timeDiff);
stdtimeDiff = std(timeDiff);
stdErr = stdtimeDiff./sqrt(length(timeDiff));

%adding median offset to blank Stimuli trials
trialnumber = length(stimNumbers);% input('enter the total number of trials');
empty = ones(1,trialnumber);
empty(idx) = 0;
offsetVals = zeros(size(startTimes_noblank,1),numel(empty));

gind = logical(empty);
offsetVals(:,gind) = timeDiff;
offsetVals(:,~gind) = 0;

idxd = find(offsetVals==0);
offsetVals(idxd) = mediantimeDiff;
offsetVals_medianblank = offsetVals;

StimTimes = (startTimes*1000+offsetVals_medianblank);

hold on; plot(startTimes(1)*1000,0*ones(length(startTimes(1))),'r*','MarkerSize',10);
hold on; plot(StimTimes(1),0*ones(length(StimTimes(1))),'g*','MarkerSize',10);
hold on; plot(startTimes(2:trialnumber)*1000,0*ones(length(startTimes(2:trialnumber))),'r*','MarkerSize',10);
hold on; plot(StimTimes(2:trialnumber),0*ones(length(StimTimes(2:trialnumber))),'g*','MarkerSize',10);
legend ('Sound Input','Original Stimulus marker', 'Shifted stimulus marker');
title("Amplitude Cut off Value"+cutOff)

% plotting distribution of offset
binLimits = [35 85];
figure, histogram(timeDiff,'BinLimit',binLimits,'BinWidth',2,'facecolor','y'); xlim([30 90])
xline(meantimeDiff,'Color','g','Linewidth',2);
xline(mediantimeDiff,'Color','b','LineStyle','--','Linewidth',2);
xline(meantimeDiff-stdtimeDiff,'Color','r','Linewidth',2,'LineStyle','--');
xline(meantimeDiff+stdtimeDiff,'Color','r','Linewidth',2,'LineStyle','--');
print = "Mean = %.3f\nMedian = %.3f\nStd Error = %.3f";
textToPrint = sprintf(print, meantimeDiff, mediantimeDiff,stdErr);
yl = ylim;
text(70,yl(2)/1.2,textToPrint,'Color','r','Fontweight','Bold','FontSize',12,'EdgeColor','b')
xlabel('offset between digitalTimeStamp Start and sound onset in ms');

goodStimTimes = StimTimes./1000;

end