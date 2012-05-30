close all; clear; clc;


path(pwd, path);
path('/home/phil/local/matlab', path);
% 5.1.2

% div = 20;
% 
% z = [0 0];
% grid = zeros(101);
% x = [(0:100) - 50; zeros(1, 101)];
% x = x/div;
% 
% sigma = [0.1 0.2 0.5 1 1.5 2];
% 
% h1 = figure
% for k = 1:size(sigma,2)
%     
%     for i=1:101
%         x(2, :) = (i*ones(1, 101) - 51)/div;
%         grid(i, :) = gaussian_kernel(x, z, sigma(k));
%     end
% 
%     ax = (-50:50)/div;
%     figure(h1)
%     subplot(2, 3, k)
%     imagesc(ax, ax, grid)
%     
%     title(['\sigma = ' num2str(sigma(k))])
%     
%     h2 = figure
%     surf(ax, ax, grid)
%     title(['\sigma = ' num2str(sigma(k))])
%     colorbar('location','southoutside')
%     
%     cd images;
%     saveas(h2, ['surf_' sprintf('%02d', sigma(k)*1/sigma(1)) '.pdf'], 'pdf')
%     cd ..;
%     close
% 
% 
% end



% 5.2.1

load('student-scores.mat');
% add libsvm matlab folder to path, cd to the appropriate folder
cd libsvm-3.12/matlab
LIBSVM = pwd;
cd ../..
path(LIBSVM, path);
colormap(hsv(3));

SVM = svmtrain(training(3,:)', training(1:2, :)', '-s 0 -t 0 -c 1');

SVs = SVM.SVs;
sv_coef = SVM.sv_coef;



scatter(SVs(:, 1), SVs(:, 2), 25, '<')

h = showBoundary(100, 100, SVM, '');

title('Decision boundary for linear soft margin SVM')
cd images
saveas(h, 'boundary_linear.pdf', 'pdf')
cd ..
close(h);

h = figure;
[predicted_label, accuracy, scc] = svmpredict(training(3,:)', training(1:2,:)', SVM);
scatter(training(1,:), training(2,:), 25, predicted_label)
hold;
scatter(training(1,:), training(2,:), 100, training(3,:), '<')
colormap(hsv(3))
title({'Prediction (circles) and labels (triangles) for training'; ['Classification rate:', num2str(accuracy(1))]})
cd images
saveas(h, '5_2_1_training.pdf', 'pdf')
cd ..


h = figure;
[predicted_label, accuracy, scc] = svmpredict(test(3,:)', test(1:2,:)', SVM);
scatter(test(1,:), test(2,:), 25, predicted_label)
hold;
scatter(test(1,:), test(2,:), 100, test(3,:), '<')
colormap(hsv(3))
title({'Prediction (circles) and labels (triangles) for test'; ['Classification rate: ' num2str(accuracy(1))]})
cd images
saveas(h, '5_2_1_test.pdf', 'pdf')
cd ..
close all

% 5.2.2

gamma = [0.005 0.01 0.02 0.1 0.5 1];
sigma = sqrt(2*gamma);

h1 = figure('Position',[100, 100, 700,900]);
h2 = figure('Position',[100, 100, 700,900]);
h3 = zeros(1, 6);

cd images



for k=1:size(gamma, 2);
    libsvm_options = ['-s 0 -t 2 -c 1 -g ' num2str(gamma(k))];
    SVM = svmtrain(training(3,:)', training(1:2, :)', libsvm_options);

    SVs = SVM.SVs;
    sv_coef = SVM.sv_coef;

    
    figure(h1);
    subplot(3, 2, k);
    [predicted_label, accuracy, scc] = svmpredict(training(3,:)', training(1:2,:)', SVM);
    scatter(training(1,:), training(2,:), 25, predicted_label)
    hold;
    scatter(training(1,:), training(2,:), 100, training(3,:), '<')
    title({['\gamma: ' num2str(gamma(k)) ', \sigma: ' num2str(sigma(k))]; ...
           ['Classification rate: ' num2str(accuracy(1))]})
    colormap(hsv(3))
    
    
    figure(h2);
    subplot(3, 2, k);
    [predicted_label, accuracy, scc] = svmpredict(test(3,:)', test(1:2,:)', SVM);
    scatter(test(1,:), test(2,:), 25, predicted_label)
    hold;
    scatter(test(1,:), test(2,:), 100, test(3,:), '<')
    title({['\gamma: ' num2str(gamma(k)) ', \sigma: ' num2str(sigma(k))]; ...
           ['Classification rate: ' num2str(accuracy(1))]})
    colormap(hsv(3))
    

    
    
    plottitle = ['\gamma: ' num2str(gamma(k)) ', \sigma: ' num2str(sigma(k))];
    h3(k) = showBoundary(100, 100, SVM, plottitle);
    
    
end

h3_bnd = figs2subplots(h3(:), [3 2]);
close(h3(:));
colormap(hsv(3));

% saveas(h1, 'training_gamma.pdf', 'pdf');
% saveas(h2, 'test_gamma.pdf', 'pdf');
% saveas(h3, 'boundary_gamma.pdf', 'pdf');


c = [0.2 0.5 1 2 3 100000];

h4 = figure('Position',[100, 100, 700,900]);
h5 = figure('Position',[100, 100, 700,900]);
h6 = zeros(1, 6);

for k=1:size(c, 2);
    libsvm_options = ['-s 0 -t 2 -c '  num2str(c(k)) ' -g 0.01'];
    SVM = svmtrain(training(3,:)', training(1:2, :)', libsvm_options);

    SVs = SVM.SVs;
    sv_coef = SVM.sv_coef;

    
    figure(h4);
    subplot(3, 2, k);
    [predicted_label, accuracy, scc] = svmpredict(training(3,:)', training(1:2,:)', SVM);
    scatter(training(1,:), training(2,:), 25, predicted_label)
    hold;
    scatter(training(1,:), training(2,:), 100, training(3,:), '<')
    title({['c: ' num2str(c(k))]; ...
           ['Classification rate: ' num2str(accuracy(1))]})
    colormap(hsv(3))
    
    
    figure(h5);
    subplot(3, 2, k);
    [predicted_label, accuracy, scc] = svmpredict(test(3,:)', test(1:2,:)', SVM);
    scatter(test(1,:), test(2,:), 25, predicted_label)
    hold;
    scatter(test(1,:), test(2,:), 100, test(3,:), '<')
    title({['c: ' num2str(c(k))]; ...
           ['Classification rate: ' num2str(accuracy(1))]})
    colormap(hsv(3))
    

    
    
    plottitle = ['C: ' num2str(c(k))];
    h6(k) = showBoundary(100, 100, SVM, plottitle);
    
    
end

h3_bnd = figs2subplots(h6(:), [3 2]);
colormap(hsv(3));
close(h6(:));

% saveas(h1, 'training_c.pdf', 'pdf');
% saveas(h2, 'test_c.pdf', 'pdf');
% saveas(h3, 'boundary_c.pdf', 'pdf');

cd ..

%close all


% 5.2.3

















