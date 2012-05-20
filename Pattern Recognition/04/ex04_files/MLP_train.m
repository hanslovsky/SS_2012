function net = MLP_train(x, t, nin, nhidden, nout, outfunction, ncycles)
% clear; clc
% Generate the matrix of inputs x and targets t.



% alpha = 0.01;
% Coefficient of weight-decay prior.
net = mlp(nin, nhidden, nout, outfunction);
% Set up vector of options for the optimiser.
options = zeros(1,18);
options(1) = 1;
% This provides display of error values.
options(9) = 1;
% Check the gradient calculations.
options(14) = ncycles; 
% Number of training cycles.
% Train using scaled conjugate gradients.
[net, options] = netopt(net, options, x, t, 'scg');



end