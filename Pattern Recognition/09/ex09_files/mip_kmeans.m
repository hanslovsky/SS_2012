function [centers, post] = mip_kmeans(data, K, minErrDecr)
%function [centers, post] = mip_kmeans(data, K, minErrDecr)
%
%%% USAGE:
%
% partitions the points in the N-by-P data matrix into K clusters with
% early stopping criterion controlled by minErrDecr
% 
%%% INPUT:
%
% data          - required. observations to be clustered
% K             - required. the number of clusters
% minErrDecr    - optional. minimum decrease of error measured by squared Euclidean distance
%                 
%%% OUTPUT:
%
% centers       - coordinates of new cluster centers 
% posterior     - assignment of observations to new cluster centers 
%
%%% EXAMPLE:
%
%%% DESCRIPTION:
%
% partitions the points in the N-by-P data matrix into K clusters with
% early stopping criterion controlled by minErrDecr
%
%%% DATE AND AUTHORS:
%
% Fred Hamprecht
% Xinghua Lou
%
%%% DEPENDENCIES:
%
%%% REFERENCE:
%
%%% MEX INFORMATION:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
    minErrDecr = 0;
end

[nData, nDim] = size(data);

% initialization
I = randperm(nData);
centers = data(I(1:K), :);

% enter the iteration
[centers, prior, err] = mip_kmeans_it(centers, data);

lastErr = 1+minErrDecr+err;
while (abs(lastErr - err) > minErrDecr)
    lastErr = err;
    [centers, post, err] = mip_kmeans_it(centers, data, prior);
    prior = post;
end
