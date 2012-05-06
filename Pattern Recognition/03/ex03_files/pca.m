function [lambdas, variance, pc] = pca(data)

[p, n] = size(data);



 
data_centered = data - repmat(mean(data, 2), 1, n);


[U,S,V]  = svd(data_centered, 'econ');

pc       = U;
variance = diag(S).*diag(S)./(n-1);
lambdas  = S*V';




