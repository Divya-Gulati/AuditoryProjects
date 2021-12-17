%% [rampedSound,rampingFunction] = rampSound(soundFile,timeVals,rampTime,ramp)
% Murty V P S Dinavahi 20/04/2015

function [rampedSound,rampingFunction] = rampSound(soundFile,timeVals,rampTime,ramp,PlotFlag) % rampTime is in seconds

% Input arguments:
% timeVals
% rampTime: is in same units as timeVals
% optional: 
% 1. ramp:
%    1. 'SquaredSine'
%    2. 'Hanning' (Default)
% 2. soundFile
% 
% Output arguments:
% rampedSound:
% rampingFunction
%

%% Set defaults
if ~exist('ramp','var'); ramp='Hanning'; end
if ~exist('PlotFlag','var'); PlotFlag=0; end
if size(soundFile,1)> size(soundFile,2)
    soundFile = soundFile';
end

%% Calculate ramping function
rampPonits=timeVals(1:(find(timeVals>=rampTime,1))-1);
rampPonits=rampPonits./max(rampPonits);

% create upward ramp
switch ramp
    case 'SquredSine'
        disp(['Applying squared sine ramp of ' num2str(rampTime) ' sec']);
        a=sin(0.5*pi*rampPonits);
        a=(a./max(a)).^2; % squaring the sinusoid smoothens the function at zero
    case 'Hanning'
        disp(['Applying hanning ramp of ' num2str(rampTime) ' sec']);
        a=hanning(length(rampPonits)*2)';
        a = a(1:floor(length(a)/2));
        a=(a./max(a));
end

% static ramp is constant at 1
b=ones(1,(length(timeVals)-(2*(length(a)))));

% downward ramp is time-flipped version of upward to maintain symmetry
c=fliplr(a);

% create ramping function
% The function ramps up from 0 to 1 in time rampTime sec, stays at value 1
% till length(timeVals)-rampTime sec, and ramps down symmetrically as upward ramp in rampTime secs.
rampingFunction=[a b c]; 


%% Plot Ramping Function if PlotFlag
if PlotFlag
    figure(2345); plot(timeVals,rampingFunction);
end
%% Apply Ramping Function: Multiply soundFile with the Ramping Function
if ~isempty(soundFile)
    
    % it is presumed that the sound file is an m*n matrix, n represnting
    % data and m representing channels. Otherwise, invert the matrix
    if size(soundFile,1)> size(soundFile,2)
        soundFile = soundFile';
    end
    
    % element-wise multiplication of each channel. This is useful for
    % lateralisation experiments.
    for i=1:size(soundFile,1)
        rampedSound(i,:)=soundFile(i,:).*rampingFunction;
    end
else
    rampedSound = [];
end

end