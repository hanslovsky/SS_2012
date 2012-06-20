close all; clc; clear;

x = (-1:0.1:1);
x1 = randsample(x, 10);
[theta0, theta1, theta2, theta3, beta] = deal(9, 4, 0, 0, 0);
covariance = gp_cov(x1, x1, theta0, theta1, theta2, theta3, beta);



sample = exp(-1/2*x1*inv(covariance)*x1');