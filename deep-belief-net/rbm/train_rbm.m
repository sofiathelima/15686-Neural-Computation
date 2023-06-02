function [ rbm ] = train_rbm( rbm, data, n_epochs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n_datapoints = size(data,1);

% Compute the number of batches on each epoch
n_batches = floor(n_datapoints/rbm.batch_size);

% Initialize previous updates to zero.
prev_delta_w = zeros(size(rbm.w));
prev_delta_hb = zeros(size(rbm.hb));
prev_delta_vb = zeros(size(rbm.vb));


for epoch=1:n_epochs
    
    % Randomly assign batches
    batch_inds = reshape(randperm(n_batches*rbm.batch_size), n_batches, rbm.batch_size);
    
    for batch=1:n_batches
        data_batch = data(batch_inds(batch,:), :);

        % transpose data batch

        % Compute p_data(h) given the data
        p_h_clamped = rbm_ph_given_v(rbm, data_batch);

        sample_h_clamped = sample(p_h_clamped);
        
        % Compute p_model1(v) given a sample of h
        p_v_model = rbm_pv_given_h(rbm, sample_h_clamped);
  
        % Compute p_model1(h) given p(v)
        p_h_model = rbm_ph_given_v(rbm, p_v_model);
        
        % Matrix multiplication
        clamped_expectation =  (data_batch' * p_h_clamped)./rbm.batch_size; %  Task 1:  You are to fill out this line here to compute clamped expectation   < V  h>     data expectation   -- averaged correlation
        model_expectation =  (p_v_model'*p_h_model)/rbm.batch_size;%  Task 2:  You are to fill out this line here to compute model expectation.    < V1  h1>   hallucination expectation

        
        mean_p_h_clamped = sum(p_h_clamped,1)/rbm.batch_size;
        
        delta_w =  (clamped_expectation - model_expectation);
        delta_hb = (mean_p_h_clamped - sum(p_h_model)/rbm.batch_size);
        delta_vb = (sum(data_batch)-sum(p_v_model))/rbm.batch_size;
        
        
        % Sparsity updates
        if(rbm.sparsity > 0)
            dw_p_h = p_h_clamped .* (1-p_h_clamped);
            
            delta_w = delta_w + rbm.sparsity_lambda ...
                        * bsxfun( @times, (rbm.sparsity - mean_p_h_clamped)', ...
                         (dw_p_h' * data_batch))';
            delta_hb = delta_hb + rbm.sparsity_lambda ...
                        * (rbm.sparsity - mean_p_h_clamped) .* sum(dw_p_h);
        end
        
        delta_w = rbm.eps_w * delta_w;
        delta_hb = rbm.eps_hb * delta_hb;
        delta_vb = rbm.eps_vb * delta_vb;
        % Update parameters with momentum from previous updates
        rbm.w = rbm.w + rbm.momentum*prev_delta_w + delta_w;
        rbm.hb = rbm.hb + rbm.momentum*prev_delta_hb + delta_hb;
        rbm.vb = rbm.vb + rbm.momentum*prev_delta_vb + delta_vb;
        
        prev_delta_w = delta_w;
        prev_delta_hb = delta_hb;
        prev_delta_vb = delta_vb;
        
    end
end


end

