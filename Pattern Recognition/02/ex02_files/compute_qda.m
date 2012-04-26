function [mu0, mu1, covmat0, covmat1, p0, p1] = compute_qda(trainingy,trainingx)
% computes means mu0 mu1 for both exams and their covariance matrices
% covmat0 covmat1 well es priors p0 and p1
% Input: labels (trainingy) and exam results (trainingx)


indices0 = trainingy == 0;
indices1 = ~indices0;


mu0 = mean(trainingx(:, indices0), 2);
mu1 = mean(trainingx(:, indices1), 2);


covmat0 = cov((trainingx(:, indices0)'));
covmat1 = cov((trainingx(:, indices1)'));


p0 = sum(indices0)/size(trainingy, 2);
p1 = 1 - p0;