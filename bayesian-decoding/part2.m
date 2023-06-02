
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
saveas(gcf,'part2.png');

%%
rand_drops = [1.0; 0.75; 0.25; 0.10];
numDrops = size(rand_drops,1);

tau = 0.11;
numRuns = 10;

figure('Position', [10 10 400 200])

for bt_index = 1:2
    
    errs = zeros(numDrops, numRuns);

    for idx = 1:numDrops

        for jdx = 1:numRuns

            rand_idx = randi(size(spike_matrix,1),1,round(size(spike_matrix,1)*rand_drops(idx)));

            spike_matrix_drop = spike_matrix(rand_idx,:);
            tuning_matrix_drop = createTuningMatrix(spike_matrix_drop, pos);

            decoded_locations = bayesDecode(spike_matrix_drop, tuning_matrix_drop, behavior_time(bt_index,:), tau, pos);
            
            % subtract 5 from decoded_locations to reset them to original pos range
            decoded_locations = decoded_locations - 5;
            
            range = behavior_time(bt_index,1):behavior_time(bt_index,2);
            diff = pos(range,:) - decoded_locations;
            sqrerr = sum(diff.^2, 2);
            error = mean(sqrt(sqrerr));
            errs(idx, jdx) = error;
        
        end

        fprintf('For behavior_time set #%d, data used = %.2f, the mean mean error is %.2f\n', bt_index, rand_drops(idx), mean(errs(idx,:)))
        
    end

    subplot(1,2,bt_index);

    std_err = std(errs.');
    y_plot = mean(errs.');
    errorbar(y_plot,std_err);

    xticklabels({'100%','75%','25%','10%'})

    mean_error = mean(mean(errs,2));
    
    xlabel(sprintf('Behavior time set %d; \nMean mean error = %.2f; \ntau = %.2f', bt_index, mean_error, tau))
    
    fprintf('\n')

end

saveas(gcf,'part2q3.png');
