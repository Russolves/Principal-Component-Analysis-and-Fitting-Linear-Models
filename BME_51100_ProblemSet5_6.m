load('EEG_SSPdata.mat');

nchans = size(dat, 1);
nsamps = size(dat, 2);
%Collect blink samples
tmin = -0.2;
tmax = +0.2;
imin = floor(tmin*fs);
imax = ceil(tmax*fs);
B = [];  %To concatenate the samples across the blinks
for k = 1:numel(blink_samples)
    start_ind = max([1, blink_samples(k) + imin]);
    end_ind = min([blink_samples(k) + imax, nsamps]);
    B = [B, dat(:, start_ind:end_ind)]; %B is of size 32x95178
end

%Performing PCA on the matrix B
C = cov(B');
[q, lambda] = eigs(C, 1);

%Constructing projection matrix
P = eye(nchans) - q*q';


%% Applying the Projection and plotting the channels A1 to A5 out
dat_cleaned = P*dat;

% Plot original and cleaned EEG data for channels A1-A5
plotEEG(dat, [1, 2, 3, 4, 5], "Original");
plotEEG(dat_cleaned, [1, 2, 3, 4, 5], "Cleaned");
%% Save the variable B and q matrix into a new file
save('gradedSSPoutput.mat', 'B', 'q', 'P');

%% Function for plotEEG
function plotEEG(data, channels, title_name)
% data: nchans x nsamps matrix of EEG data
% channels: vector of channel indices to plot
    
    % Set up time axis
    fs = 1000; %sampling rate
    nsamps = size(data, 2);
    t = linspace(0, nsamps/fs, nsamps);
    
    % Plot original and cleaned data for selected channels
    figure;
    title(title_name + " Data");
    for i = 1:length(channels)
        subplot(length(channels), 1, i);
        hold on;
        plot(t, data(channels(i), :), 'b');
        hold off;
        title(sprintf('Channel %d', channels(i)));
        ylabel('Voltage (uV)');
        xlabel('Time (s)');
    end
    % Set the y-axis limits to the same range for both plots
    ylims = get(gca, 'YLim');
    set(gca, 'YLim', [min(ylims), max(ylims)]);
end

