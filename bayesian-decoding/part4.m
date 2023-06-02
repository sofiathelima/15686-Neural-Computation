
% part 4

clear all

load('hippocampus_data.mat')
tuning_matrix = createTuningMatrix(spike_matrix, pos);
%occ_matrix = createOccupancyMatrix(pos);

%% Decode paths -- testing taus
tau = [0.02 0.04 0.06 0.07 0.32 0.57 1.07]; 
numTaus = size(tau,2);

figure('Position', [10 10 400 1200]); 
plt_idx = 1;
for tau_idx = 1:numTaus
    % for both replay_time sets
    for rt_index = 1:3
        
        decoded_locations = bayesDecode(spike_matrix, tuning_matrix, replay_time(rt_index,:), tau(tau_idx), pos);
        %decoded_locations = bayesDecodeOcc(spike_matrix, tuning_matrix, replay_time(rt_index,:), tau,occ_matrix);
    
        % subtract 5 from decoded_locations to reset them to original pos range
        decoded_locations = decoded_locations - 5;
        
        subplot(numTaus,3,plt_idx);
        plotTrajectory(pos,replay_time(rt_index,:),decoded_locations);
        title(sprintf('Replay time set %d,\ntau = %.2f', rt_index, tau(tau_idx)));
        plt_idx = plt_idx+1;
    end

end

saveas(gcf,'part4_taus.png');

%% Decode paths
tau = [0.07 0.06 0.04]; 

figure('Position', [10 10 600 300]); 
% for both replay_time sets
for rt_index = 1:3
    
    decoded_locations = bayesDecode(spike_matrix, tuning_matrix, replay_time(rt_index,:), tau(rt_index), pos);
    %decoded_locations = bayesDecodeOcc(spike_matrix, tuning_matrix, replay_time(rt_index,:), tau,occ_matrix);

    % subtract 5 from decoded_locations to reset them to original pos range
    decoded_locations = decoded_locations - 5;
    
    subplot(1,3,rt_index);
    plotTrajectory(pos,replay_time(rt_index,:),decoded_locations);
    title(sprintf('Replay time set %d,\ntau = %.2f', rt_index, tau(rt_index)));
end

saveas(gcf,'part4.png');
