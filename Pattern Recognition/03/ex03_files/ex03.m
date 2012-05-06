clear; close all; clc;

fprintf('loading data\n');
load('digits.mat');

% (1a)
[lambdas, variance, pc] = pca(training);


% (1b) plot first 6 pc
displayData(pc(:, 1:6)');
variance_share = cumsum(variance);
variance_share = variance_share/variance_share(end);
indices        = find(variance_share >= 0.6);
indices(1)
indices        = find(variance_share >= 0.99);
indices(1)