function [ p_h] = rbm_ph_given_v(rbm, V  )
%RBM_PH_GIVEN_V computes the probability of the hidden
%               layer given the visible layer.
%
% INPUTS:
%   rbm ....... : an RBM structure created by initialize_rbm()
%   V ......... : an (# examples by # visible units) matrix in which
%                   V(d,i) corresponds to the activation (0 or 1) of
%                   the ith visible unit in the dth example
%
% OUTPUTS:
%   p_h ....... : an (# examples by # hidden units) matrix in which
%                   p_h(d,j) correspond to the probability that the
%                   jth unit is active in the dth example.
%       
p_h = sigmoid(V*rbm.w + repmat(rbm.hb, size(V,1), 1));
% disp(size(p_h)) % 100 x 500

end

