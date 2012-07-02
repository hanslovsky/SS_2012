function [means, sigmas, priors] = em_gmm(data, means0, sigmas0, priors0, threshold)
[nN, nD] = size(data);
nK = size(priors0, 2);
prob = zeros(nK, 1);
resp = zeros(nN, 1);
sgm = num2cell(sigmas0, [1 2]);
cellfun
for k=1:nK
    mean = meansT(k, :);
    prob(k) = 
end