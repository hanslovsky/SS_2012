close all; clc; clear;

x = (-1:0.1:1)';
[theta0, theta1, theta2, theta3, beta] = deal(9, 4, 0, 0, 0);
covariance = gp_cov(x, x, theta0, theta1, theta2, theta3, beta)
samples = exp(-x'*covariance\x);
samples