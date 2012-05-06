clear; close all; clc;

fprintf('loading data\n');
load('digits.mat');

% (1a)
[lambdas, variance, pc] = pca(training);


% (1b) plot first 6 pc
displayData(pc(:, 1:6)');
variance_share = cumsum(variance);
variance_share = variance_share/variance_share(end);
indices        = find(variance_share >= 0.6);
comps_60       = indices(1)
indices        = find(variance_share >= 0.99);
comps_99       = indices(1)

fprintf('Program paused. Press enter to continue.\n');
pause

displayProjected(pc, training(:, 3080), 784);
fprintf('Program paused. Press enter to continue.\n');
pause
displayProjected(pc, training(:, 3080), comps_60);
fprintf('Program paused. Press enter to continue.\n');
pause
displayProjected(pc, training(:, 3080), comps_99);
fprintf('Program paused. Press enter to continue.\n');
pause


[lambdas, variance, pc] = pca(training(:, training_label==5));
variance_share = cumsum(variance);
variance_share = variance_share/variance_share(end);
indices        = find(variance_share >= 0.6);
comps_60       = indices(1);
indices        = find(variance_share >= 0.99);
comps_99       = indices(1);

figure
displayProjected(pc, training(:, 3080), size(pc, 2));
fprintf('Program paused. Press enter to continue.\n');
pause
displayProjected(pc, training(:, 3080), comps_60);
fprintf('Program paused. Press enter to continue.\n');
pause
displayProjected(pc, training(:, 3080), comps_99);
