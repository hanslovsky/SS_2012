function d = calc_dist_mat_squ_a_b(x1, x2)
% computes squared distance matrix between two sets of points with p dimensions 
% and n1 and n2 points, respectively. 
% Points are stored in an (p by n1)-matrix x1 and 
% (p by n2)-matrix x2
% Output is a (n1 by n2) matrix of squared distances
x1 = x1';
x2 = x2';
x1 = double(x1);
x2 = double(x2);
x1sq = sum(x1.^2, 2);
x2sq = sum(x2.^2, 2);

n1 = size(x1, 1);
n2 = size(x2, 1);

d = repmat(x1sq, 1,n2) + repmat(x2sq', n1,1) - 2*(x1*x2');