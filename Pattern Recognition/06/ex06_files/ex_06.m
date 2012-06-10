close all; clear; clc;

path('/home/phil/git/SS_2012/Pattern Recognition/06/ex06_files/rf_vigra_matlab_a64', path);


% 6.2 

load('data_gini_1d.mat')
labels = data_gini(:,2);
feature = data_gini(:,1);
giDelta = zeros(65, 1);

for splitValue = 1:65
    giDelta(splitValue) = get_gini_impurity_decrease(feature, labels, splitValue/5);
end

fgi = figure;
plot(0.2*(1:65), giDelta, '<', 'MarkerSize', 5, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k')
xlabel('split value');
ylabel('gini \Delta');
hold

feature1 = feature(labels == 1);
feature2 = feature(labels == 2);
label1 = 0.1*labels(labels == 1);
label2 = 0.1*labels(labels == 2);
plot(feature1, label1, 'd', 'MarkerSize', 4, 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k')
plot(feature2, label2, 's', 'MarkerSize', 4, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k')

saveas(fgi, 'gidelta.pdf', 'pdf');

% 6.3

% load('digits.mat');
% oob = zeros(1,50);
% cr = zeros(1,50);
% threshold = 0.35;
% label_5 = test_label == 5;
% for treeCount=5:5:250
% [RF, oob(treeCount/5)] = vigraLearnRF(training', training_label', treeCount);
% probs = vigraPredictProbabilitiesRF(RF, test');
% cr(treeCount/5) = sum((probs(:,6) > threshold) == label_5')/1000;
% end

% f = figure('Position', [100 100 1000 150]);
% t = uitable('Parent', f, 'Position', [25 25 950 100]);
% 
% set(t, 'Data', [oob; 1-cr])
% set(t, 'RowName', {'oob'; 'test error'})
% set(t, 'ColumnName', 25:25:50)
% set(t, 'ColumnWidth', {'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto'});
% set(t, 'Position', [75 25 853 58]);
% 
% saveas(f, 'table.pdf', 'pdf');

% f1 = figure;
% plot(5:5:250, oob, '<', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
% 
% xlabel('number of trees');
% ylabel('oob');
% saveas(f1, 'oob.pdf', 'pdf')
% f2 = figure;
% plot(5:5:250, 1-cr, 'd', 'MarkeredgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
% 
% xlabel('number of trees');
% ylabel('test error');
% saveas(f2, 'test_error.pdf', 'pdf')