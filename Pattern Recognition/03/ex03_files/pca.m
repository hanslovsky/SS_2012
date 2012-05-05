function [lambdas, variance, pc] = pca(data)

m = size(data, 1)
n = size(data, 2)

data_centered = data - repmat(mean(data), m);
all(all(cov(data_centered) == cov(data)))

% [U,S,V] = svd(data);
% 1
% [pc, lambdas] = eig(U*S*S'*U');
% 2
% lambdas       = diag(lambdas);
% 3
% variance      = diag(S);
% 4

