function [ rbm ] = initialize_rbm(n_visible, n_hidden, batch_size, sparsity,...
                                        sparsity_lambda)

rbm.momentum = .5;
rbm.batch_size = batch_size;

% Learning rates
rbm.eps_w = .1; % for weights
rbm.eps_vb = .1; % for visual biases
rbm.eps_hb = .1; % for hidden biases

% Initialize weights and biases
rbm.w = 0.1*randn(n_visible, n_hidden);
rbm.hb = zeros(1, n_hidden);
rbm.vb = zeros(1, n_visible);


rbm.sparsity = -1;
rbm.sparsity_lambda = 0;
if nargin > 3
    rbm.sparsity = sparsity;
    rbm.sparsity_lambda = sparsity_lambda;
end

end

