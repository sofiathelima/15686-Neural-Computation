function [ recon ] = rbm_reconstruct( rbm, original_V)
%RBM_RECONSTRUCT reconstructs an image
%
% INPUTS:
%   original ...........: a (# examples  by # visible units) matrix. 
%                           
% OUTPUTS:
%   recon ..............: a (# examples  by # visible units) matrix.
%                           Computed by sampling the hidden layer given the 
%                           visisble units in 'original' and then sampling
%                           the visible layer given the sampled hidden
%                           layer


H_sample = sample(rbm_ph_given_v(rbm, original_V));


recon = sample(rbm_pv_given_h(rbm, H_sample));


end

