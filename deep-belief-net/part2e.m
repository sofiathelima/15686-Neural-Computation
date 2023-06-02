
% Part a: 
% Computing the probability of visible units given the hidden units

% Part b: 
% Synthesizing an image by sampling

% Part c: 
% The RBM learning rule

% Part d: 
% Visualizing the weights of a hidden unit

clear all

load('data.mat')

% rbm = initialize_rbm(n_visible, n_hidden, batch_size);
rbm = initialize_rbm(784, 500, 100);

epoch_tries=[1,10,50,200];

for n=epoch_tries
rbm_n = train_rbm(rbm, data_1000, n);

% rbm_visualize_weights(w, dim1, dim2);
fname = sprintf('weights_p%s.png',string(n));
rbm_visualize_weights(rbm_n.w,28,28,fname);

% recon = rbm_reconstruct(rbm, original_V);
reconstructed = rbm_reconstruct(rbm_n, data_100);

figure()
i=1;
for recon=reconstructed'
    subplot(10,10,i);
    imagesc(reshape(recon,28,28));
    axis off
    i=i+1;
end
saveas(gcf,sprintf('recons_n%s.png',string(n)))

end

%%
figure()
i=1;
for dig=data_100'
    subplot(10,10,i);
    imagesc(reshape(dig,28,28));
    axis off
    i=i+1;
end
saveas(gcf,'original.png')