function [qda_prediction] = perform_qda(mu0, mu1, covmat0, covmat1, p0, p1, testx)

samples = size(testx, 2);


% calculate ratio of likelihood for passing and failing
likelihoodRatio = diag(p1/p0*sqrt(det(covmat0)/det(covmat1))*exp(1/2*( ...
                    (testx - repmat(mu0, 1, samples))'*inv(covmat0)*(testx - repmat(mu0, 1, samples)) ...
                  - (testx - repmat(mu1, 1, samples))'*inv(covmat1)*(testx - repmat(mu1, 1, samples)))));



% predict passing exam where likelihood of passing is bigger than not
% passing
qda_prediction = likelihoodRatio > 1;