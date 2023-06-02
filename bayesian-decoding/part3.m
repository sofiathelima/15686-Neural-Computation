
% Part 3

clear all

load('hippocampus_data.mat')
% tuning_matrix = createTuningMatrix(spike_matrix, pos);
[numNeurs, T] = size(spike_matrix);
% numNeurs = size(spike_matrix, 1);
% numTime
% numLocs = size(tuning_matrix,2);

gridloc = ceil(pos) + 5;

B = 30;

taus = [0.5; 1.0];
numTaus = size(taus,1);

figure('Position', [10 10 200 100])

for tau_idx = 1:numTaus

    tau = taus(tau_idx);

    [neur_idx, spikes, v] = find(spike_matrix == max(spike_matrix,[],[1 2]));
    spike_train = spike_matrix(neur_idx(1),:);

    window = floor(100*tau/2);
    numWindows = T-window*2;

    S = zeros(B, B, numWindows); % spike count at each pixel
%     Np = zeros(B, B); % number of visits to each pixel

    % for each timestep
    t_idx = 1;
    for t = 1+window:T-window

        spike_count = sum(spike_train(t-window:t+window));
        
        % get pixel visited at this timestep
        x = gridloc(t, 1);
        y = gridloc(t, 2);
        
        % record spike count for this pixel by the number of spikes
        % experienced by this neuron at this time step
%         S(y,x,:) = [S(y,x,:) spike_count];
        S(y,x, t_idx) = spike_count;
        t_idx = t_idx+1;
        
%         % increment that pixel's visit count by 1
%         Np(y,x) = Np(y,x) + 1;
        
    end
%     [loc_x, loc_y] = find(S == max(S,[],[1 2 3]));
    [mxv,idx] = max(S(:));
    [r,c,p] = ind2sub(size(S),idx);
    fprintf('max S %i\n',mxv);

%     loc = randi(B,2,1);
%     posterior_distribution = squeeze(S(loc(1), loc(1), :));
    posterior_distribution = squeeze(S(r, c, :));
    fprintf('size of nonzero posterior %i\n',size(find(posterior_distribution),1));

    subplot(1,numTaus,tau_idx);
    histogram(posterior_distribution,10);
    title(sprintf('Neuron #%i; tau = %.2f\n\n', neur_idx(1), tau), 'FontSize',5)
    xlabel('spike count')
    ylabel('frequency')
%     hold on;

end

saveas(gcf,'part3.png');