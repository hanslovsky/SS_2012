clear; close all; clc;

fprintf('loading data\n');
load('student-scores.mat');

[mu0, mu1, covmat0, covmat1, p0, p1] = compute_qda(training(3, :), training(1:2, :));

qda_prediction_test     = perform_qda(mu0, mu1, covmat0, covmat1, p0, p1, test(1:2, :));
qda_prediction_training = perform_qda(mu0, mu1, covmat0, covmat1, p0, p1, training(1:2, :));

colormap(hsv(3))
scatter(training(1,:), training(2,:), 25, qda_prediction_training, 'o', 'filled');
hold


scatter(training(1,:), training(2,:), 150, training(3,:), '>');






qda_prediction_decision = zeros(100, 100);

for k = 1:100
    qda_prediction_decision(k, :) = perform_qda(mu0, mu1, covmat0, covmat1, p0, p1, [ones(1,100)*k; 1:100]); 
end

figure
imagesc(qda_prediction_decision)