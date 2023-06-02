function [decoded_locations] = bayesDecode(spike_matrix, tuning_matrix, behavior_time_indiv, tau)

% tau is in seconds, so multiply by 100 to get # of 10 ms timesteps, then
% divide by 2 to get radius around actual timestep
window = floor(100*tau/2);
decoded_locations = zeros(behavior_time_indiv(2)-behavior_time_indiv(1)+1, 2);

[N, P] = size(tuning_matrix);
B = sqrt(P);
tuning_matrices = zeros(N, B, B);
for i = 1:N
    tuning_matrices(i, :, :) = reshape(tuning_matrix(i, :), B, B);
end

for t = behavior_time_indiv(1):behavior_time_indiv(2)
    
    % n is vector containing sum of spikes across tau-specified window for
    % each neuron
    n = sum(spike_matrix(:,t-window:t+window), 2);
    
    % Calculate P(x|n) for all (x, y)
    px_given_n = zeros(B, B);
    for y = 1:B
        for x = 1:B
            
            term1 = 0;
            for i = 1:N
                term1 = term1 + TO_BE_FILLED_IN_BY_YOU(1);
            end
            term2 = 0;
            for i = 1:N
                term2 = term2 + TO_BE_FILLED_IN_BY_YOU(2);
            end
            % posterior distribution of p(x|n)
            px_given_n(y,x) = TO_BE_FILLED_IN_BY_YOU(3);
            
        end
    end
    
    TO_BE_FILLED_IN_BY_YOU(4);
    % find xindex, and yindex at the location where px_given_n is maximum
    
    decoded_locations(t-behavior_time_indiv(1)+1, :) = [xindex, yindex];
    
end