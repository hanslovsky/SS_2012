function k = gaussian_kernel(x, z, sigma)
% x are matrices of size pxn, containing n (number of samples) feature
% vectors of size p. z is a vector of size p. sigma is a scalar.

n = size(x, 2);
k = zeros(1, n);
SGM = 2*sigma^2;
z = z';

for i=1:n
    arg = x(:,i) - z;
    k(i) = exp(-(arg'*arg)/(SGM));  
end
end