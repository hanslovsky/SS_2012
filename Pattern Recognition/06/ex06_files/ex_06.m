clear; clc; close all
load('digits.mat');
path('/home/phil/git/SS_2012/Pattern Recognition/06/ex06_files/rf_vigra_matlab_a64', path);


oob = zeros(1,10);
cr = zeros(1,10);
threshold = 0.6;
for treeCount=25:25:50
[RF, oob(treeCount/25)] = vigraLearnRF(training', training_label', treeCount);
probs = vigraPredictProbabilitiesRF(RF, test');
cr(treeCount/25) = sum((probs(:,1) > threshold) == test_label')/1000;
end

f = figure('Position', [100 100 1000 150]);
t = uitable('Parent', f, 'Position', [25 25 950 100]);

set(t, 'Data', [oob; 1-cr])
set(t, 'RowName', {'oob'; 'test error'})
set(t, 'ColumnName', 25:25:50)
set(t, 'ColumnWidth', {'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto' 'auto'});
set(t, 'Position', [75 25 853 58]);

f1 = figure;
plot(25:25:250, oob, '<', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
%title('oob');
xlabel('number of trees');
ylabel('oob');
f2 = figure;
plot(25:25:250, 1-cr, 'd', 'MarkeredgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
%title('test error');
xlabel('number of trees');
ylabel('test error');