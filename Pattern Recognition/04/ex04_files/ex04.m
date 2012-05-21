clear; clc; close all;

path(path, 'mlp');
% 4.1
%x = [0:0.01:1]';
%y = sin(2*pi*x);

%h = figure;
%plot(x, y, 'ob')
%saveas(h, 'sine.eps', 'eps')


clear; clc; close all;
% x = [0:1/19:1]';
% ndata = size(x,1);


% Set up network parameters.
nin = 1;
% Number of inputs.
nhidden = 3;
% Number of hidden units.
nout = 1;
% Number of outputs.
ncycles = 1000;
% Number of training cycles
outfunction = 'linear'; % outfunction (linear, logistic)

% for i=0:20:200
%     t = sin(2*pi*x) + i/100*randn(ndata, 1);
%     h1 = figure;
%     plot(x, t, 'ob');
%     net = MLP_train(x, t, nin, nhidden, nout, outfunction, ncycles);
%     % Plot the trained network predictions.
%     plotvals = [0:0.01:1]';
%     y = mlpfwd(net, plotvals);
%     h2 = figure;
%     plot(plotvals, y, 'ob')
%     saveas(h1, ['4-1-2_1-' sprintf('%03d', i) '.eps'], 'eps');
%     saveas(h2, ['4-1-2_2-' sprintf('%03d', i) '.eps'], 'eps');
%     close all;
% end



% 4.2
load('student-scores.mat');
nin = 2;
nhidden = 3;
nout = 1;
t = (training(3,:) - (training(3,:) == 0))';
x = training(1:2, :)';

% 4.2.1
% for i=1:5
%     net = MLP_train(x, t, nin, nhidden, nout, outfunction, ncycles);
% 
%     h = figure;
%     y = mlpfwd(net, test(1:2, :)') > 0;
%     
%     colormap(hsv(3));
%     scatter(test(1,:), test(2,:), 25, y, 'o', 'filled');
%     hold
%     scatter(test(1,:), test(2,:), 150, test(3,:), '>');
%     rate = sum(y == test(3,:)')/size(y, 1);
%     title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
%     saveas(h, ['test_' sprintf('%d', i) '.eps'], 'eps');
%     close all;
% 
%     h = figure;
%     y = mlpfwd(net, training(1:2, :)') > 0;
%     
%     colormap(hsv(3));
%     scatter(training(1,:), training(2,:), 25, y, 'o', 'filled');
%     hold
%     scatter(training(1,:), training(2,:), 150, training(3,:), '>');
%     rate = sum(y == training(3,:)')/size(y, 1);
%     title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
%     saveas(h, ['training_' sprintf('%d', i) '.eps'], 'eps');
%     close all;
% 
%     decision_boundary = zeros(100, 100);
% 
%     for k = 1:100
%         y = mlpfwd(net, [ones(1,100)*k; 1:100]') > 0;
%         
%         decision_boundary(k, :) = y; 
%     end
% 
%     
%     h = figure;
%     colormap(hsv(3));
%     imagesc(decision_boundary);
%     set(gca,'YDir','normal');
%     saveas(h, ['boundary' sprintf('%d', i) '.pdf'], 'pdf');
%     close all;
% end

% 4.2.2

% nhidden = 100;
% producePlots(x, t, training, test, nin, nhidden, nout, outfunction, ncycles);
% 
% outfunction = 'logistic';
% producePlots(x, t, training, test, nin, nhidden, nout, outfunction, ncycles);
% 
% ncycles = 5000;
% producePlots(x, t, training, test, nin, nhidden, nout, outfunction, ncycles);


% 4.2.3

% outfunction = 'logistic';
% nhidden = 95;
% 
% ncycles = 3000;
% 
% producePlots(x, t, training, test, nin, nhidden, nout, outfunction, ncycles);

% 4.3
nin = 2;
nhidden = 2;
nout = 1;
net = rbf(nin, nhidden, nout, 'gaussian');


options = zeros(1,18);
options(1) = 1;
options(9) = 1;
options(14) = 1000; 
net = rbftrain(net, options, x, t);


h = figure;
colormap(hsv(3));
y = rbffwd(net, training(1:2, :)') > 0;
scatter(training(1,:), training(2,:), 25, y, 'o');
hold;
scatter(training(1,:), training(2,:), 150, training(3, :), '>');
rate = sum(y == training(3,:)')/size(y, 1);
title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
saveas(h, 'gauss_training.eps', 'eps');
% close all;

h = figure;
colormap(hsv(3));
y = rbffwd(net, test(1:2, :)') > 0;
scatter(test(1,:), test(2,:), 25, y, 'o');
hold;
scatter(test(1,:), test(2,:), 150, test(3, :), '>');
rate = sum(y == test(3,:)')/size(y, 1);
title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
saveas(h, 'gauss_test.eps', 'eps');
% close all;


decision_boundary = zeros(100, 100);

for k = 1:100
    y = rbffwd(net, [ones(1,100)*k; 1:100]') > 0;
    decision_boundary(k, :) = y; 
end


h = figure;
colormap(hsv(3));
imagesc(decision_boundary);
set(gca,'YDir','normal');
saveas(h, 'gauss_boundary.pdf', 'pdf');
% close all;







