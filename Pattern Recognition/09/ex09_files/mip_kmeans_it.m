function [centers, post, err] = mip_kmeans_it(centers, data, varargin)
%function [centers, post, err] = mip_kmeans_it(centers, data, varargin)
%
%%% USAGE:
%
% performs a single k-means iteration: it finds the closest datum for 
% each center; it updates the center positions; and it returns the 
% assignment of each observation to a cluster center 
% 
%%% INPUT:
%
% oldcenters    - required. coordinates of cluster centers 
% data          - required. observations to be clustered
% prior         - required. current assignment of observations to old cluster centers, if
%                 available; can be omitted 
%                 
%%% OUTPUT:
%
% centers       - coordinates of new cluster centers 
% posterior     - assignment of observations to new cluster centers 
% err           - squared error
%
%%% EXAMPLE:
%
%%% DESCRIPTION:
%
% performs a single k-means iteration: it finds the closest datum for 
% each center; it updates the center positions; and it returns the 
% assignment of each observation to a cluster center 
%
%%% DATE AND AUTHORS:
%
% Fred Hamprecht
%
%%% DEPENDENCIES:
%
%%% REFERENCE:
%
%%% MEX INFORMATION:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% assign observations to cluster centers 
if nargin == 2
    d = mip_calc_squ_distance_matrix_of_point_sets(data, centers);
    [tmp, prior] = min(d, [], 2);
else
    prior = varargin{1};
end

% update locations of cluster centers 
for i = 1:size(centers, 1)
    I = prior==i;
    centers(i, :) = mean(data(prior==i, :));
end

% assign observations to new cluster centers 
d = mip_calc_squ_distance_matrix_of_point_sets(data, centers);

[tmp, post] = min(d, [], 2);

err = sum(tmp);
% display(['squared error: ', num2str(sum(tmp))]); 



