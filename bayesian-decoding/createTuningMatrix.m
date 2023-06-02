function [tuning_matrix] = createTuningMatrix(spike_matrix, pos)

B = 30;
gridloc = ceil(pos) + 5;
[N, T] = size(spike_matrix);
tuning_matrix = zeros(N, B*B);
default = 0.0001;

% for each neuron
for n = 1:N
    
    S = zeros(B, B); % spike count at each pixel
    Np = zeros(B, B); % number of visits to each pixel
    
    % for each timestep
    for t = 1:T
        
        % get pixel visited at this timestep
        x = gridloc(t, 1);
        y = gridloc(t, 2);
        
        % increment spike count for this pixel by the number of spikes
        % experienced by this neuron at this time step
        S(y,x) = S(y,x) + spike_matrix(n, t);
        
        % increment that pixel's visit count by 1
        Np(y,x) = Np(y,x) + 1;
        
    end
    
    % compute firing rate for each pixel
    firing_rate = zeros(B, B);
    for i = 1:B
        for j = 1:B
            if Np(i,j) == 0
                firing_rate(i, j) = default;
            else
                firing_rate(i, j) = S(i,j) / (Np(i,j) * 0.01);
            end
        end
    end
    
    % save this neuron's firing_rates to the tuning matrix
    tuning_matrix(n, :) = reshape(firing_rate, 1, B*B);
    
end