
% Part 2

clear all

load('hippocampus_data.mat')
tuning_matrix = createTuningMatrix(spike_matrix, pos);

tau = [0.11, 0.21, 0.31, 0.41, 0.51, 0.81, 1.81, 2.81, 5.81, 10.81];

figure
idx=1;

% for both behavior_time sets
for bt_index = 1:2
    
    % and for multiple values of tau
    for tau_index = 1:10
        
        decoded_locations = bayesDecode(spike_matrix, tuning_matrix, behavior_time(bt_index,:), tau(tau_index), pos);
        
        % subtract 5 from decoded_locations to reset them to original pos range
        decoded_locations = decoded_locations - 5;
        
        range = behavior_time(bt_index,1):behavior_time(bt_index,2);
        diff = pos(range,:) - decoded_locations;
        sqrerr = sum(diff.^2, 2);
        error = mean(sqrt(sqrerr));
        
        fprintf('For behavior_time set #%d and tau = %.2f, the mean error is %.2f\n', bt_index, tau(tau_index), error)
        
        if tau_index == 1 || tau_index == 4 || tau_index == 7
            subplot(2,3,idx);
            idx=idx+1;
            plot(pos(:,1), pos(:,2), 'Color', [.5 .5 .5])
            hold on
            plot(pos(range,1), pos(range,2), 'b', 'LineWidth', 3)
            plot(decoded_locations(:,1), decoded_locations(:,2), 'rx', 'MarkerSize', 7, 'LineWidth', 3)
            xlabel(sprintf('Behavior time set %d; \nMean error = %.2f; \ntau = %.2f', bt_index, error, tau(tau_index)))
%             saveas(gcf,sprintf('part2_Behavior_time_set_%d_tau_%.2f.png', bt_index, tau(tau_index)));
        end
        
    end
    
    fprintf('\n')
    
end
saveas(gcf,'part2q2.png');

% plot with tau on x and compare