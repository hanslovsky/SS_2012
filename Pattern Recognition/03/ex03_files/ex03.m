clear; close all; clc;

fprintf('loading data\n');
load('digits.mat');


[lambdas, variance, pc] = pca(test);


%displayData(pc);
