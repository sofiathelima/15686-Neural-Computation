
% Part 5

clear all

load('hippocampus_data.mat')

[N, T] = size(spike_matrix);

rand_noises = [0.10;0.25;0.5;0.65];
numNoises = size(rand_noises,1);

taus = [0.11; 0.51; 0.81; 1.81];
numTaus = size(taus,1);
numRuns = 10;

figure('Position', [10 10 900 600])
plt_idx = 1;

for bt_index = 1:2

    for tau_idx = 1:numTaus

        tau = taus(tau_idx);

        errs = zeros(numNoises, numRuns);
    
        for idx = 1:numNoises
    
            for jdx = 1:numRuns
    
                rand_idx = randi(N*T,1,round(N*rand_noises(idx)));
    
                [r,c] = ind2sub(size(spike_matrix),rand_idx);
    
                spike_matrix_noise = spike_matrix;
                spike_matrix_noise(r,c) = spike_matrix_noise(r,c) + 1;
                tuning_matrix_noise = createTuningMatrix(spike_matrix_noise, pos);
    
                decoded_locations = bayesDecode(spike_matrix_noise, tuning_matrix_noise, behavior_time(bt_index,:), tau, pos);
                
                % subtract 5 from decoded_locations to reset them to original pos range
                decoded_locations = decoded_locations - 5;
                
                range = behavior_time(bt_index,1):behavior_time(bt_index,2);
                diff = pos(range,:) - decoded_locations;
                sqrerr = sum(diff.^2, 2);
                error = mean(sqrt(sqrerr));
                errs(idx, jdx) = error;
            
            end
    
            fprintf('For behavior_time set #%d, tau = %.2f, data noised = %.2f, the mean mean error is %.2f\n', bt_index, tau, rand_noises(idx), mean(errs(idx,:)))
   

        end
    
    subplot(2,numTaus,plt_idx);

    std_err = std(errs.');
    y_plot = mean(errs.');
    errorbar(y_plot,std_err);

    xticklabels({'10%','25%','50%','65%'})

    mean_error = mean(mean(errs,2));
    
    xlabel(sprintf('Behavior time set %d; \nMean mean error = %.2f; \ntau = %.2f', bt_index, mean_error, tau))
    
    plt_idx = plt_idx+1;
    

    end

fprintf('\n')

end

saveas(gcf,'part5.png');