clc; clear;

% Set name of figure for problem 1
f = figure('Name', 'Advanced Peak Finder', 'NumberTitle', 'off');
figure(f);

hfile = 'PinkPanther30.wav';

% Read input file
[y, Fs] = audioread(hfile);

numOfPeaks = zeros(1, 5);

% Find peaks without moving average filter
peaks = findpeaks(y);

numOfPeaks(1) = length(peaks);

cutoff_freqs = 0:1000:4000;

for i = 2:5
    % Apply low pass filter
    output = lowpass(y, cutoff_freqs(i), Fs);
    
    % Find peaks
    peaks = findpeaks(output);    
    
    % Save number of peaks
    numOfPeaks(i) = length(peaks);
end

% Plot number of peaks versus changing cut-off frequencies
plot(cutoff_freqs, numOfPeaks);
title('Number of Peaks vs Changing Cut-Off Frequencies');
