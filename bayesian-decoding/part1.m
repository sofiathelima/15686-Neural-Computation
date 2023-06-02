
% Part 1

clear all

load('hippocampus_data.mat')

tuning_matrix = createTuningMatrix(spike_matrix, pos);

B = 30;
[N, T] = size(spike_matrix);

% plot for neuron #15...
i_neurons = randi(N,1,3);

neurIDs = [15, 8, i_neurons];
numIDs = size(neurIDs,2);

figure('Position', [10 10 1200 300])

idx=1;
indices = reshape(1:(numIDs*2), numIDs, 2).';
disp(indices);
for id=neurIDs

firing_rate = reshape(tuning_matrix(id,:),B,B);
% figure('Position', [10 10 900 600])
fprintf('\n%i',indices(idx));
subplot(2,numIDs,indices(idx));
idx = idx+1;
imagesc(firing_rate), axis xy
title(sprintf('2D Tuning Curve for Neuron #%s', string(id)))
% figure
fprintf('\n%i',indices(idx));
subplot(2,numIDs,indices(idx));
idx = idx+1;
plot(pos(:,1), pos(:,2), 'Color', [.5 .5 .5])
title(sprintf('Spike Locations for Neuron #%s', string(id)))
hold on
for i = 1:B
    for j = 1:B
        if firing_rate(i,j) >= 5
            for t = 1:T
                if ceil(pos(t,:))+5 == [j i]
                    plot(pos(t,1), pos(t,2), 'Marker','x','MarkerFaceColor','red','MarkerEdgeColor','red', 'MarkerSize', 4)
                end
            end
        end
    end
end
end
saveas(gcf,'part1.png');