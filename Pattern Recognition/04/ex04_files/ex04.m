clear; clc;

path(path, 'mlp');
%x = [0:0.01:1]';
%y = sin(2*pi*x);

%h = figure;
%plot(x, y, 'ob')
%saveas(h, 'sine.eps', 'eps')


clear; clc; close all;
x = [0:1/19:1]';
ndata = size(x,1);


% Set up network parameters.
nin = 1;
% Number of inputs.
nhidden = 3;
% Number of hidden units.
nout = 1;
% Number of outputs.
outfunction = 'linear'; % outfunction (linear, logistic)

% for i=0:20:200
%     t = sin(2*pi*x) + i/100*randn(ndata, 1);
%     h1 = figure;
%     plot(x, t, 'ob');
%     net = MLP_train(x, t, nin, nhidden, nout, outfunction);
%     % Plot the trained network predictions.
%     plotvals = [0:0.01:1]';
%     y = mlpfwd(net, plotvals);
%     h2 = figure;
%     plot(plotvals, y, 'ob')
%     saveas(h1, ['4-1-2_1-' sprintf('%03d', i) '.eps'], 'eps');
%     saveas(h2, ['4-1-2_2-' sprintf('%03d', i) '.eps'], 'eps');
%     close all;
% end

load('student-scores.mat');
nin = 2;
nhidden = 3;
nout = 1;
t = training(3,:)';
x = training(1:2, :)';

for i=1:5
    net = MLP_train(x, t, nin, nhidden, nout, outfunction);

    h = figure;
    y = round(mlpfwd(net, test(1:2, :)'));
    colormap(hsv(3));
    scatter(test(1,:), test(2,:), 25, y, 'o', 'filled');
    hold
    scatter(test(1,:), test(2,:), 150, test(3,:), '>');
    saveas(h, ['test_' sprintf('%d', i) '.eps'], 'eps');
    close all;

    h = figure;
    y = round(mlpfwd(net, training(1:2, :)'));
    colormap(hsv(3));
    scatter(training(1,:), training(2,:), 25, y, 'o', 'filled');
    hold
    scatter(training(1,:), training(2,:), 150, training(3,:), '>');
    saveas(h, ['training_' sprintf('%d', i) '.eps'], 'eps');
    close all;

    decision_boundary = zeros(100, 100);

    for k = 1:100
        decision_boundary(k, :) = 1 - round(mlpfwd(net, [ones(1,100)*k; 1:100]')); 
    end


    h = figure;
    imagesc(decision_boundary);
    set(gca,'YDir','normal');
    saveas(h, ['boundary' sprintf('%d', i) '.eps'], 'eps');
    close all;
end











