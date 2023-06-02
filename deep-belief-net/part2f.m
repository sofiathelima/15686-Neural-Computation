
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

n=200;
sparsities=[0.01,0.1];
lambdas=[0.1,1.];

for l=lambdas
    for p=sparsities

        rbm = initialize_rbm(784, 500, 100,p,l);
        
        rbm_n = train_rbm(rbm, data_1000, n);
        
        fname = sprintf('weights_p%s_l%s.png',string(p),string(l));
        rbm_visualize_weights(rbm_n.w,28,28,fname);
        
        reconstructed = rbm_reconstruct(rbm_n, data_100);
        
        figure()
        i=1;
        for recon=reconstructed'
            subplot(10,10,i);
            imagesc(reshape(recon,28,28));
            axis off
            i=i+1;
        end
        saveas(gcf,sprintf('recons_p%s_l%s.png',string(p),string(l)))
    
    end
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