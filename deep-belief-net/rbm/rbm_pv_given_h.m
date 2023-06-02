function [ p_v ] = rbm_pv_given_h(rbm, h)
%RBM_PV_GIVEN_H computes the probability of the visible
%               layer given a sample of the visible layer
%
% INPUTS:
%   rbm ....... : an RBM structure created by initialize_rbm()
%   H ......... : an (# examples by # hidden units) matrix in which
%                   H(d,j) corresponds to the activation (0 or 1) of
%                   the jth hidden unit in the dth example
%
% OUTPUTS:
%   p_v ....... : an (# examples by # visible units) matrix in which
%                   p_v(d,i) correspond to the probability that the
%                   ith visible unit is active in the dth example.
%       
% disp(size(rbm.w)) % 784 x 500; n x m
% disp(size(h)) % 100 x 500; n x m
p_v = sigmoid(h*rbm.w' + repmat(rbm.vb, size(h,1), 1));
% disp(size(p_v)) % 100 x 784

end

