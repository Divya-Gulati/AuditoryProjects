% Modified from displaySingleChannelGRF. To improve the readability of this
% program, the segments related to spike analysis has been removed.

function displaySingleChannelAuditory(subjectName,expDate,protocolName,folderSourceString,gridType,gridLayout,stimType)

if ~exist('gridType','var');            gridType='ECoG';                end
if ~exist('gridLayout','var');          gridLayout=14;                  end
if ~exist('stimType','var');            stimType=1;                     end

folderName = fullfile(folderSourceString,'data',subjectName,gridType,expDate,protocolName);

% Get folders
folderExtract = fullfile(folderName,'extractedData');
folderSegment = fullfile(folderName,'segmentedData');
folderLFP = fullfile(folderSegment,'LFP');

% load Data Information
[analogChannelsStored,timeVals] = loadLFPInfo(folderLFP);

% Get Stimulus Combinations
[uniqueConditions,stimData] = loadStimulusCombinations(folderExtract,stimType);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display options
fontSizeMedium = 12; fontSizeLarge = 16;
backgroundColor = 'w';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Choices %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hChoicesPanel = uipanel('Title','Choices','fontSize', fontSizeLarge,'Unit','Normalized','Position',[0.25 0.775 0.25 0.175]);

% Analog channel
[analogChannelStringList,analogChannelStringArray] = getAnalogStringFromValues(analogChannelsStored);
uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.0 0.8 0.5 0.2],'Style','text','String','Analog Channel','FontSize',fontSizeMedium);
hAnalogChannel = uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.5 0.8 0.5 0.2],'Style','popup','String',analogChannelStringList,'FontSize',fontSizeMedium,'BackgroundColor',backgroundColor);

% Reference scheme
referenceChannelStringList = ['None|AvgRef|' analogChannelStringList];
referenceChannelStringArray = [{'None'} {'AvgRef'} analogChannelStringArray];
uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.0 0.6 0.5 0.2],'Style','text','String','Reference','FontSize',fontSizeMedium);
hReferenceChannel = uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.5 0.6 0.5 0.2],'Style','popup','String',referenceChannelStringList,'FontSize',fontSizeMedium,'BackgroundColor',backgroundColor);

% Analysis Type
analysisTypeStringList = 'ERP|FFT|deltaFFT|TF|deltaTF';
analysisTypeStringArray = [{'ERP'} {'FFT'} {'deltaFFT'} {'TF'} {'deltaTF'}];
uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.0 0.4 0.5 0.2],'Style','text','String','Analysis Type','FontSize',fontSizeMedium);
hAnalysisType = uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.5 0.4 0.5 0.2],'Style','popup','String',analysisTypeStringList,'FontSize',fontSizeMedium,'BackgroundColor', backgroundColor);

% Save options
saveTypeStringList = 'Nothing|Current combination|All combinations';
saveTypeStringArray = [{'Nothing'} {'Current combination'} {'All combinations'}];
uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.0 0.2 0.5 0.2],'Style','text','String','Data to save','FontSize',fontSizeMedium);
hsaveType = uicontrol('Parent',hChoicesPanel,'Unit','Normalized','Position',[0.5 0.2 0.5 0.2],'Style','popup','String',saveTypeStringList,'FontSize',fontSizeMedium,'BackgroundColor', backgroundColor);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Timing panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hTimingPanel = uipanel('Title','Timing','fontSize', fontSizeLarge,'Unit','Normalized','Position',[0.5 0.775 0.25 0.175]);

% Stim Period
stimPeriod = [0.25 0.75];
uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.00 0.8 0.50 0.2],'Style','text','String','Stim period (s)','FontSize',fontSizeMedium);
hStimPeriodMin = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.50 0.8 0.25 0.2],'Style','edit','String',num2str(stimPeriod(1)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);
hStimPeriodMax = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.75 0.8 0.25 0.2],'Style','edit','String',num2str(stimPeriod(2)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);

% FFT Range
fftRange = [0 100];
uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.00 0.6 0.50 0.2],'Style','text','String','FFT Range (Hz)','FontSize',fontSizeMedium);
hFFTMin = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.50 0.6 0.25 0.2],'Style','edit','String',num2str(fftRange(1)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);
hFFTMax = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.75 0.6 0.25 0.2],'Style','edit','String',num2str(fftRange(2)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);

% Stim Range
timeRange = [-0.2 1];
uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.00 0.4 0.50 0.2],'Style','text','String','Time Range (s)','FontSize',fontSizeMedium);
hXMin = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.50 0.4 0.25 0.2],'Style','edit','String',num2str(timeRange(1)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);
hXMax = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.75 0.4 0.25 0.2],'Style','edit','String',num2str(timeRange(2)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);

% Y Range
uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.00 0.2 0.50 0.2],'Style','text','String','Y Range','FontSize',fontSizeMedium);
hYMin = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.50 0.2 0.25 0.2],'Style','edit','String','0','FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);
hYMax = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.75 0.2 0.25 0.2],'Style','edit','String','1','FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);

% CLims
zRange = [-10 10];
uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.00 0 0.50 0.2],'Style','text','String','Z Range','FontSize',fontSizeMedium);
hZMin = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.50 0 0.25 0.2],'Style','edit','String',num2str(zRange(1)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);
hZMax = uicontrol('Parent',hTimingPanel,'Unit','Normalized','Position',[0.75 0 0.25 0.2],'Style','edit','String',num2str(zRange(2)),'FontSize',fontSizeMedium, 'BackgroundColor', backgroundColor);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hPlotOptionsPanel = uipanel('Title','Plotting Options','fontSize', fontSizeLarge,'Unit','Normalized','Position',[0.75 0.775 0.25 0.175]);

% Button for Plotting
[colorString, colorNames] = getColorString;
uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0.0 0.8 0.5 0.2],'Style','text','String','Color','FontSize',fontSizeMedium);
hChooseColor = uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0.5 0.8 0.5 0.2],'Style','popup','String',colorString,'FontSize',fontSizeMedium','BackgroundColor',backgroundColor);

uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0 0.4 0.5 0.2],'Style','pushbutton','String','rescale X','FontSize',fontSizeMedium,'Callback',{@rescaleX_Callback});
uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0 0.2 0.5 0.2],'Style','pushbutton','String','rescale Y','FontSize',fontSizeMedium,'Callback',{@rescaleY_Callback});
uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0 0.0 0.5 0.2],'Style','pushbutton','String','rescale Z','FontSize',fontSizeMedium,'Callback',{@rescaleZ_Callback});

hHoldOn = uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0.5 0.4 0.5 0.2],'Style','togglebutton','String','hold on','FontSize',fontSizeMedium,'Callback',{@holdOn_Callback});
uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0.5 0.2 0.5 0.2],'Style','pushbutton','String','cla','FontSize',fontSizeMedium,'Callback',{@cla_Callback});
uicontrol('Parent',hPlotOptionsPanel,'Unit','Normalized','Position',[0.5 0.0 0.5 0.2],'Style','pushbutton','String','plot','FontSize',fontSizeMedium,'Callback',{@plotData_Callback});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Saving Panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hSaveOptionsPanel = uipanel('Title','Save Variables','fontSize', fontSizeMedium,'Unit','Normalized','Position',[0.817 0.723 0.18 0.053]);
uicontrol('Parent',hSaveOptionsPanel,'Unit','Normalized','Position',[0.5 0.1 0.4 1],'Style','pushbutton','String','save ','FontSize',fontSizeMedium,'Callback',{@saveData_Callback});

uicontrol('Unit','Normalized','Position',[0 0.95 1 0.05],'Style','text','String',[subjectName expDate protocolName],'FontSize',fontSizeLarge);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get electrode array information
electrodeGridPos = [0.05 0.775 0.19 0.175];
hElectrodes = showElectrodeLocations(electrodeGridPos,analogChannelsStored(get(hAnalogChannel,'val')),colorNames(get(hChooseColor,'val')),[],1,0,gridType,subjectName,gridLayout);

% Main plot handles
mainGridPos = [0.05 0.05 0.75 0.675];
sideGridPos = [0.85 0.05 0.125 0.65];

if stimType==1 % AuditoryGamma
    
    numRows = length(unique(stimData.RFVals))+1;
    numCols = length(unique(stimData.RVVals))+1;
    mainPlotHandles = getPlotHandles(numRows,numCols,mainGridPos,0.01);
    
    numExtraEntries = length(uniqueConditions) - (numRows-1)*(numCols-1);
    sidePlotHandles = getPlotHandles(numExtraEntries,1,sideGridPos,0.05);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plotData_Callback(~,~)
        
        % Get Choices
        analogChannelPos = get(hAnalogChannel,'val');
        analogChannelString = analogChannelStringArray{analogChannelPos};
        referenceChannelString = referenceChannelStringArray{get(hReferenceChannel,'val')};
        analysisType = analysisTypeStringArray{get(hAnalysisType,'val')};
        
        stRange = [str2double(get(hStimPeriodMin,'String')) str2double(get(hStimPeriodMax,'String'))];
        
        plotColor = colorNames(get(hChooseColor,'val'));
        holdOnState = get(hHoldOn,'val');
        
        plotflag = 1;
        
        % Plot Data
        plotDataAllConditions(mainPlotHandles,stimType,'main',analogChannelString,referenceChannelString,folderName,analysisType,timeVals,stRange,plotColor,plotflag);
        plotDataAllConditions(sidePlotHandles,stimType,'side',analogChannelString,referenceChannelString,folderName,analysisType,timeVals,stRange,plotColor,plotflag);
        
        % Rescale
        axisLims = getAxisLims;
        rescaleData(mainPlotHandles,axisLims);
        rescaleData(sidePlotHandles,axisLims);
        
        % Show electrode location
        if analogChannelPos<=length(analogChannelsStored)
            channelNumber = analogChannelsStored(analogChannelPos);
        else
            channelNumber = 0;
        end
        showElectrodeLocations(electrodeGridPos,channelNumber,plotColor,hElectrodes,holdOnState,0,gridType,subjectName,gridLayout);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function rescaleX_Callback(~,~)
        axisLims = getAxisLims;
        rescaleData(mainPlotHandles,axisLims);
        rescaleData(sidePlotHandles,axisLims);
    end
    function rescaleY_Callback(~,~)
        axisLimsTMP = getAxisLims;
        yLims = [str2double(get(hYMin,'String')) str2double(get(hYMax,'String'))];
        axisLims = [axisLimsTMP(1:2) yLims];
        rescaleData(mainPlotHandles,axisLims);
        rescaleData(sidePlotHandles,axisLims);
    end
    function rescaleZ_Callback(~,~)
        axisLimsNew = getAxisLims;
        zLims = [str2double(get(hZMin,'String')) str2double(get(hZMax,'String'))];
        axisLims = [axisLimsNew(1:6) zLims];
        rescaleData(mainPlotHandles,axisLims);
        rescaleData(sidePlotHandles,axisLims);
    end
    function axisLims = getAxisLims
        analysisType = analysisTypeStringArray{get(hAnalysisType,'val')};
        
        if strcmp(analysisType,'ERP') || strcmp(analysisType,'TF') || strcmp(analysisType,'deltaTF')
            xMin = str2double(get(hXMin,'String'));
            xMax = str2double(get(hXMax,'String'));
            
        elseif strcmp(analysisType,'FFT') || strcmp(analysisType,'deltaFFT')
            xMin = str2double(get(hFFTMin,'String'));
            xMax = str2double(get(hFFTMax,'String'));
        end
        yLimsMain = getYLims(mainPlotHandles);
        yLimsSide = getYLims(sidePlotHandles);
        yMin = min(yLimsMain(1),yLimsSide(1));
        yMax = max(yLimsMain(2),yLimsSide(2));
        
        
        if strcmp(analysisType,'TF') || strcmp(analysisType,'deltaTF')
            zMin = str2double(get(hZMin,'String'));
            zMax = str2double(get(hZMax,'String'));
            axisLims = [xMin xMax yMin yMax -1 1 zMin zMax];
        else
            axisLims = [xMin xMax yMin yMax];
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function holdOn_Callback(source,~)
        holdOnState = get(source,'Value');
        
        holdOnGivenPlotHandle(mainPlotHandles,holdOnState);
        holdOnGivenPlotHandle(sidePlotHandles,holdOnState);
        
        if holdOnState
            hold(hElectrodes,'on');
        else
            hold(hElectrodes,'off');
        end
        
        function holdOnGivenPlotHandle(plotHandles,holdOnState)
            
            [nR,nC] = size(plotHandles);
            
            for i=1:nR
                for j=1:nC
                    if holdOnState
                        hold(plotHandles(i,j),'on');
                    else
                        hold(plotHandles(i,j),'off');
                    end
                end
            end
        end
    end
    function cla_Callback(~,~)
        
        claGivenPlotHandle(mainPlotHandles);
        claGivenPlotHandle(sidePlotHandles);
        
        function claGivenPlotHandle(plotHandles)
            [nR,nC] = size(plotHandles);
            for i=1:nR
                for j=1:nC
                    cla(plotHandles(i,j));
                end
            end
        end
    end
    function saveData_Callback(~,~)
        
        savingType = saveTypeStringArray{get(hsaveType,'val')};
        if strcmp (savingType,'All combinations')
            disp ('Saving all');
            stRange = [0.25 0.75];
            plotColor = colorNames(get(hChooseColor,'val'));
            plotflag = 0;
            for itype = 1:length(analysisTypeStringArray)
                for iref = 1:length(referenceChannelStringArray)
                    for ielec = 1: length(analogChannelStringArray)
                        analogChannelString = analogChannelStringArray{ielec};
                        referenceChannelString = referenceChannelStringArray{iref};
                        analysisType = analysisTypeStringArray{itype};
                        % save Data
                        main = plotDataAllConditions(mainPlotHandles,stimType,'main',analogChannelString,referenceChannelString,folderName,analysisType,timeVals,stRange,plotColor,plotflag);
                        side = plotDataAllConditions(sidePlotHandles,stimType,'side',analogChannelString,referenceChannelString,folderName,analysisType,timeVals,stRange,plotColor,plotflag);
                        data.elec.main(ielec,:,:)= main.dataVals;
                        data.elec.side(ielec,:,:)= side.dataVals;
                    end
                    data.titleMatrix.main = main.titleMatrix;
                    data.titleMatrix.side = side.titleMatrix;
                    if ~strcmp(analysisType,'ERP')
                        data.movingwin = main.movingwin;
                        data.params = main.params;
                        data.freqVals = main.freqVals;
                    end
                    if strcmp(analysisType,'TF') || strcmp(analysisType,'deltaTF')
                        data.timeVals = main.timeVals;
                        data.baselinepower = main.baselinepower;
                    end
                    Data.(referenceChannelString) = data;
                end
                DataAllComb.(analysisType) = Data;
            end
            save('data.mat','DataAllComb');
            
        elseif strcmp (savingType,'Current combination')
            disp('Saving current combination');
            
            % Get Choices
            analogChannelPos = get(hAnalogChannel,'val');
            data.analogChannelString = analogChannelStringArray{analogChannelPos};
            data.referenceChannelString = referenceChannelStringArray{get(hReferenceChannel,'val')};
            data.analysisType = analysisTypeStringArray{get(hAnalysisType,'val')};
            
            data.stRange = [str2double(get(hStimPeriodMin,'String')) str2double(get(hStimPeriodMax,'String'))];
            
            plotColor = colorNames(get(hChooseColor,'val'));
            plotflag = 0;
            
            % save Data
            data.main = plotDataAllConditions(mainPlotHandles,stimType,'main',data.analogChannelString,data.referenceChannelString,folderName,data.analysisType,timeVals,data.stRange,plotColor,plotflag);
            data.side = plotDataAllConditions(sidePlotHandles,stimType,'side',data.analogChannelString,data.referenceChannelString,folderName,data.analysisType,timeVals,data.stRange,plotColor,plotflag);
            
            save('data.mat','data');
        else
            disp('Not Saving')
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main function that plots the data
function data = plotDataAllConditions(plotHandles,stimType,plotType,analogChannelString,referenceChannelString,folderName,analysisType,timeVals,stRange,plotColor,plotflag)

folderExtract = fullfile(folderName,'extractedData');
folderSegment = fullfile(folderName,'segmentedData');

[~,stimData,parameterCombinations,uniqueAudFileNames] = loadStimulusCombinations(folderExtract,stimType);

if stimType==1
    dim1Vals = stimData.RFVals;
    dim2Vals = stimData.RVVals;
    dim1Str = 'RF';
    dim2Str = 'RV';
end

if strcmp(plotType,'main')
    
    uniqueDim1Vals = unique(dim1Vals);
    uniqueDim2Vals = unique(dim2Vals);
    numDim1 = length(uniqueDim1Vals);
    numDim2 = length(uniqueDim2Vals);
    
    parameterCombinationMatrix = cell(numDim1+1,numDim2+1);
    titleMatrix = cell(numDim1+1,numDim2+1);
    for i=1:numDim1
        for j=1:numDim2
            parameterCombinationMatrix{i,j} = parameterCombinations{(dim1Vals==uniqueDim1Vals(i)) & (dim2Vals==uniqueDim2Vals(j)) & (stimData.typeVals==stimType)};
            titleMatrix{i,j} = [dim1Str num2str(uniqueDim1Vals(i)) '-' dim2Str num2str(uniqueDim2Vals(j))];
        end
    end
    for i=1:numDim1
        allCombinations=[];
        for j=1:numDim2
            allCombinations=cat(2,allCombinations,parameterCombinationMatrix{i,j});
        end
        parameterCombinationMatrix{i,numDim2+1} = allCombinations;
        titleMatrix{i,numDim2+1} = [dim1Str num2str(uniqueDim1Vals(i)) '-' dim2Str 'All'];
    end
    for j=1:numDim2+1
        allCombinations=[];
        for i=1:numDim1
            allCombinations=cat(2,allCombinations,parameterCombinationMatrix{i,j});
        end
        parameterCombinationMatrix{numDim1+1,j} = allCombinations;
        if j>numDim2
            titleMatrix{numDim1+1,j} = [dim1Str 'All-' dim2Str 'All'];
        else
            titleMatrix{numDim1+1,j} = [dim1Str 'All-' dim2Str num2str(uniqueDim2Vals(j))];
        end
    end
elseif strcmp(plotType,'side')
    goodIndices = find(stimData.typeVals~=stimType);
    parameterCombinationMatrix = parameterCombinations(goodIndices)';
    titleMatrix = uniqueAudFileNames(goodIndices)';
end
data.titleMatrix = titleMatrix;

% Get the index of the blank stimulus
blankStimIndex=[];
for i=1:length(uniqueAudFileNames)
    fileDetails = strsplit(uniqueAudFileNames{i},'_');
    if sum(strcmpi('Noise',fileDetails)) % Should be changed to blank
        blankStimIndex=i;
        disp([num2str(i) ' index is for a blank stimulus']);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Get Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = load(fullfile(folderSegment,'LFP',analogChannelString));
analogData = x.analogData;

%%%%%%%%%%%%%%%%%%%%%%%%%% Change Reference %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmpi(referenceChannelString,'None')
    % Do nothing
elseif strcmp(referenceChannelString,'AvgRef')
    disp('Changing to average reference');
    x = load(fullfile(folderSegment,'LFP','AvgRef.mat'));
    analogData = analogData - x.analogData;
else
    disp('Changing to bipolar reference');
    x = load(fullfile(folderSegment,'LFP',referenceChannelString));
    analogData = analogData - x.analogData;
end

% Get bad trials
badTrialFile = fullfile(folderSegment,'badTrials.mat');
if ~exist(badTrialFile,'file')
    disp('Bad trial file does not exist...');
    badTrials=[];
else
    badTrials = loadBadTrials(badTrialFile);
    disp([num2str(length(badTrials)) ' bad trials']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isequal(size(plotHandles),size(parameterCombinationMatrix))
    [numRows,numCols] = size(plotHandles);
else
    error('Dimentions do not match');
end

for i=1:numRows
    for j=1:numCols
        
        goodPos = setdiff(parameterCombinationMatrix{i,j},badTrials);
        goodPosBL = setdiff(parameterCombinations{blankStimIndex},badTrials);
        
        if isempty(goodPos)
            disp('No entries for this combination..');
        else
            if plotflag == 1
                disp(['pos=(' num2str(i) ',' num2str(j) ') ,n=' num2str(length(goodPos))]);
            end
            
            if strcmp(analysisType,'ERP')        % compute ERP
                clear erp                
                erp = mean(analogData(goodPos,:),1);
                erp=erp-mean(erp);
                
                if plotflag == 1
                    plot(plotHandles(i,j),timeVals,erp,'color',plotColor);
                else
                    data.dataVals{i,j} = erp;
                end
                
            else
                
                Fs = round(1/(timeVals(2)-timeVals(1)));
                rangePos = round(diff(stRange)*Fs);
                stPos = find(timeVals>=stRange(1),1)+ (1:rangePos);
                xs = 0:1/diff(stRange):Fs-1/diff(stRange);
                
                
                %%% params %%%
                movingwin = [0.25 0.025];
                params.tapers   = [1 1];
                params.pad      = -1;
                params.Fs       = Fs;
                params.trialave = 1; %averaging across trials
                data.movingwin = movingwin;
                
                if strcmp(analysisType,'FFT')||strcmp(analysisType,'deltaFFT')
                    params.fpass    = [0 length(xs)];
                    data.params = params;
                    [fftST,fST]= mtspectrumc(analogData(goodPos,stPos)',params);
                    [fftBL,fBL]= mtspectrumc(analogData(goodPosBL,stPos)',params);
                    data.freqVals = fST;
                    
                    if strcmp(analysisType,'FFT')
                        plot(plotHandles(i,j),fST,log10(fftST),'color',plotColor);
                        hold(plotHandles(i,j),'on');
                        plot(plotHandles(i,j),fST,log10(fftBL),'color','k');
                    else
                        plot(plotHandles(i,j),fST,log10(fftST)-log10(fftBL),'color',plotColor);
                        hold(plotHandles(i,j),'on');
                        plot(plotHandles(i,j),fST,zeros(1,length(fBL)),'color','k');
                    end
                    if plotflag == 1
                        if strcmp(analysisType,'FFT')
                            plot(plotHandles(i,j),fST,log10(fftST),'color',plotColor);
                            hold(plotHandles(i,j),'on');
                            plot(plotHandles(i,j),fST,log10(fftBL),'color','k');
                        else
                            plot(plotHandles(i,j),fST,log10(fftST)-log10(fftBL),'color',plotColor);
                            hold(plotHandles(i,j),'on');
                            plot(plotHandles(i,j),fST,zeros(1,length(fBL)),'color','k');
                        end
                    else
                        if strcmp(analysisType,'FFT')
                            data.dataVals{i,j} = fftST;
                        else
                            data.dataVals{i,j}= log10(fftST)-log10(fftBL);
                        end
                    end
                    
                end
                
                if strcmp(analysisType,'TF') || strcmp(analysisType,'deltaTF')
                    params.fpass    = [0 100];
                    data.params = params;
                    [TfSt,TimeSt,FreqSt] = mtspecgramc(analogData(goodPos,:)',movingwin,params);
                    [TfBl,TimeBl,~] = mtspecgramc(analogData(goodPosBL,:)',movingwin,params);
                    TimeVals = TimeSt+timeVals(1)-1/Fs;
                    powerSt = log10(TfSt);
                    powerBl = log10(repmat(mean(TfBl,1),length(TimeBl),1));
                    PowerChange = powerSt-powerBl;
                    
                    data.timeVals = TimeVals;
                    data.freqVals = FreqSt;
                    data.baselinepower = 10*powerBl;
                    
                    if plotflag == 1
                        if strcmp(analysisType,'TF')
                            subplot(plotHandles(i,j))
                            pcolor(TimeVals, FreqSt,10*(powerSt)');
                            colormap('jet');
                            shading interp;
                        else
                            subplot(plotHandles(i,j))
                            pcolor(TimeVals, FreqSt,10*(PowerChange)');
                            colormap('jet');
                            shading interp;
                        end
                    else
                        if strcmp(analysisType,'TF')
                            data.dataVals{i,j} = 10*(powerSt);
                        else
                            data.dataVals{i,j}= 10*(PowerChange);
                        end
                    end
                end
                
            end
            if plotflag == 1
                text(0.05,0.9,titleMatrix{i,j},'Unit','Normalized','Parent',plotHandles(i,j));
            end
        end
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%% Scaling Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yLims = getYLims(plotHandles)

[nR,nC] = size(plotHandles);
% Initialize
yMin = inf;
yMax = -inf;

for row=1:nR
    for column=1:nC
        % get positions
        axis(plotHandles(row,column),'tight');
        tmpAxisVals = axis(plotHandles(row,column));
        if tmpAxisVals(3) < yMin
            yMin = tmpAxisVals(3);
        end
        if tmpAxisVals(4) > yMax
            yMax = tmpAxisVals(4);
        end
    end
end

yLims=[yMin yMax];
end
function rescaleData(plotHandles,axisLims)

[nR,nC] = size(plotHandles);
labelSize=12;
for i=1:nR
    for j=1:nC
        axis(plotHandles(i,j),axisLims);
        if (i==nR && rem(j,2)==1)
            if j~=1
                set(plotHandles(i,j),'YTickLabel',[],'fontSize',labelSize);
            end
        elseif (rem(i,2)==0 && j==1)
            set(plotHandles(i,j),'XTickLabel',[],'fontSize',labelSize);
        else
            set(plotHandles(i,j),'XTickLabel',[],'YTickLabel',[],'fontSize',labelSize);
        end
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%% Strings Generation  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [outString,outArray] = getAnalogStringFromValues(analogChannelsStored)
outString='';
count=1;
numChannels = length(analogChannelsStored);
outArray = cell(1,numChannels);
for i=1:numChannels
    outArray{count} = ['elec' num2str(analogChannelsStored(i))];
    outString = cat(2,outString,[outArray{count} '|']);
    count=count+1;
end
outString = outString(1:end-1);
end
function [colorString, colorNames] = getColorString

colorNames = 'brkgcmy';
colorString = 'blue|red|black|green|cyan|magenta|yellow';

end
%%%%%%%%%%%%%%%%%%%%%%%%% Loading Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [analogChannelsStored,timeVals,goodStimPos] = loadLFPInfo(folderLFP)
x = load(fullfile(folderLFP,'lfpInfo.mat'));
analogChannelsStored=sort(x.analogChannelsStored);
timeVals = x.timeVals;
goodStimPos = x.goodStimPos;
end
function [uniqueConditions,stimData,parameterCombinations,uniqueAudFileNames] = loadStimulusCombinations(folderExtract,stimType)

MLData = load(fullfile(folderExtract,'ML.mat'));
[uniqueConditions,uniqueAudFileNames,stimData] = getAudStimInfoFromML(MLData,stimType);

p = load(fullfile(folderExtract,'parameterCombinations.mat'));
if isequal(uniqueConditions,p.oValsUnique)
    numUniqueConditions = length(uniqueConditions);
    parameterCombinations = cell(1,numUniqueConditions);
    
    for i=1:numUniqueConditions
        parameterCombinations{i} = p.parameterCombinations{1,1,1,1,i};
    end
end
end
function badTrials = loadBadTrials(badTrialFile)
b=load(badTrialFile);
badTrials=b.badTrials;
end