function d = mip_calc_squ_distance_matrix_of_point_sets(x1, x2)
%function d = mip_calc_squ_distance_matrix_of_point_sets(x1, x2)
%
%%% USAGE:
%
% Computes squared distance matrix between two sets of points with p dimensions 
% and n1 and n2 points, respectively. 
% Points are stored in an (n1 by p)-matrix x1 and 
% (n2 by p)-matrix x2
% 
%%% INPUT:
%
% x1     - required. (n1 by p)-matrix of points
% x2     - required. (n2 by p)-matrix of points
%                 
%%% OUTPUT:
%
% d     - is a (n1 by n2) matrix of squared Euclidean distances
%
%%% EXAMPLE:
%
%%% DESCRIPTION:
%
% Computes squared distance matrix between two sets of points with p dimensions 
% and n1 and n2 points, respectively. 
% Points are stored in an (n1 by p)-matrix x1 and 
% (n2 by p)-matrix x2
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

x1sq = sum(x1.^2, 2);
x2sq = sum(x2.^2, 2);

n1 = size(x1, 1);
n2 = size(x2, 1);

d = repmat(x1sq, 1, n2) + repmat(x2sq', n1, 1) - 2*x1*x2';






