clear; clc
% Generate the matrix of inputs x and targets t.
x = [0:1/19:1]';
ndata = size(x,1);
t = sin(2*pi*x) + 0.2*randn(ndata, 1);
figure(1);
plot(x, t, 'ob');
% Set up network parameters.
nin = 1;
% Number of inputs.
nhidden = 3;
% Number of hidden units.
nout = 1;
% Number of outputs.
outfunction= 'linear'; % outfunction (linear, logistic)
% alpha = 0.01;
% Coefficient of weight-decay prior.
net = mlp(nin, nhidden, nout, outfunction);
% Set up vector of options for the optimiser.
options = zeros(1,18);
options(1) = 1;
% This provides display of error values.
options(9) = 1;
% Check the gradient calculations.
options(14) = 100; 
% Number of training cycles.
% Train using scaled conjugate gradients.
[net, options] = netopt(net, options, x, t, 'scg');
% Plot the trained network predictions.
plotvals = [0:0.01:1]';
y = mlpfwd(net, plotvals);
figure(2);
plot(plotvals, y, 'ob')
