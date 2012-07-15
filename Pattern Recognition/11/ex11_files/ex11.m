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

%l2 regression
param = regression(X, y);
xfit = [xmin-1000 xmax+1000];
yfit = param(2) + param(1)*xfit; 
h = figure;
hold
plot(x, y, 'd', 'MarkerSize', 4.6, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
axis([xmin-1000 xmax+1000 0 ymax+10])
plot(xfit, yfit, 'k');

% l1 regression
A = [X -eye(m); -X -eye(m)];
l1y = [y; -y];
c = [zeros(p+1, 1); ones(m, 1)];
l1par = linprog(c, A, l1y);
l1y = l1par(2) + l1par(1)*xfit;
plot(xfit, l1y);
saveas(h, 'regression.pdf', 'pdf');