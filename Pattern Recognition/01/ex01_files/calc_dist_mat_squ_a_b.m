function d = calc_dist_mat_squ_a_b(x1, x2)
% computes squared distance matrix between two sets of points with p dimensions 
% and n1 and n2 points, respectively. 
% Points are stored in an (n1 by p)-matrix x1 and 
% (n2 by p)-matrix x2
% Output is a (n1 by n2) matrix of squared distances
x1 = double(x1);
x2 = double(x2);

n1 = size(x1, 1);
n2 = size(x2, 1);

d = zeros(n1, n2);

%%%% your code here %%%%

tic;

d = repmat(diag(x1*x1'),1,n2) + repmat(diag(x2*x2')',n1,1) - 2*x1*x2';

toc

%%%%%%%%%%%%%%%%%%%%%%%%
