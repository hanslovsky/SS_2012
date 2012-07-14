close all; clear; clc

cpu = csvread('cpu_load.csv', 1, 0);
[m, p] = size(cpu(:, 1));
x = cpu(:, 1);
X = [x ones(m, 1)];
y = cpu(:, 2);
xmin = min(x);
xmax = max(x);
ymin = min(y);
ymax = max(y);
param = regression(X, y);
xfit = [xmin-1000 xmax+1000];
yfit = param(2) + param(1)*xfit; 
% h = figure('Position', [50 800 1300 600]);
hold
plot(x, y, 'd', 'MarkerSize', 4.6, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
axis([xmin-1000 xmax+1000 0 ymax+10])
plot(xfit, yfit, 'k');
hold off
saveas(h, 'squared.pdf', 'pdf');

