% sigmoid.m - sigmoid function
%
% function s = sigmoid(u)

function s = sigmoid(u)

s=1./(1+exp(-u));
