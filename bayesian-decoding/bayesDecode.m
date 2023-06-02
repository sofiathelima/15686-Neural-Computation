function [decoded_locations] = bayesDecode(spike_matrix, tuning_matrix, behavior_time_indiv, tau, pos)

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


% px = prob of rat at position; already have all position data
% matrix that has prob of each location

% 30 x 30

px = zeros(30,30);
for xy=pos
    px(round(xy(2))+5,round(xy(1))+5) = px(round(xy(2)+5),round(xy(1))+5) + 1;
end
total_sum = sum(sum(px));
px = px./total_sum;


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
                term1 = term1 + log((tuning_matrices(i, y, x))^(n(i))); % TO_BE_FILLED_IN_BY_YOU(1);
            end
            term2 = 0;
            for i = 1:N
                term2 = term2 + tuning_matrices(i, y, x); % TO_BE_FILLED_IN_BY_YOU(2);
            end
            % posterior distribution of p(x|n)
            px_given_n(y,x) = exp(term1)*exp(-tau*term2); % TO_BE_FILLED_IN_BY_YOU(3);
            
%             % question 2
%             px_given_n(y,x) = exp(term1)*exp(-tau*term2)*px(y,x);
            
        end
    end
    
    %TO_BE_FILLED_IN_BY_YOU(4);
    [xindex, yindex] = find(px_given_n==max(max(px_given_n)));
    % find xindex, and yindex at the location where px_given_n is maximum
    
    decoded_locations(t-behavior_time_indiv(1)+1, :) = [xindex(1), yindex(1)];
    
end