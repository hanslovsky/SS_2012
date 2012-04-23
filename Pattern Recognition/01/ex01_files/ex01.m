%% initialization
clear; close all; clc

fprintf('loading data\n');
load('mnist-digits.mat');

n1 = size(training, 1);
n2 = size(test, 1);


fprintf('compute distance matrix using loops\n');
%time it
%dist_loop=calc_dist_mat_loop_a_b(training, test);

fprintf('Program paused. Press enter to continue.\n');
pause

fprintf('compute distance matrix using vectors\n');
%time it
dist_squ=calc_dist_mat_squ_a_b(training, test);

% check if both functions return the same result
% assert(all(all(dist_loop == dist_squ)));
fprintf('Program paused. Press enter to continue.\n');
pause

fprintf('use distance matrix to compute kNN for various values of k\n\n');
%%%% your code here %%%%


% store maximum number of true positives and the corresponding k
true_positive_max   = 0;
true_positive_max_k = 0;


% get number of actual digits with label 5 in test
actual_fives = size(test_label(test_label == 5), 1);



for k=1:2:22

    % sort neighbours by distance
    [dist_sort,indices]=sort(dist_squ);


    % repeat training_label so each sample of test can 
    % look up the labels of k nearest neighbours in the
    % training dataset
    training_label_rep = repmat(training_label, 1, n2);

    % set everything != 5 to zero
    training_label_rep(training_label_rep ~= 5) = 0;
    

    % sum up the labels of the k nearest neighbours for
    % each sample of test
    % if the sum is larger than 5*k/2, sample is labelled 5
        
    % if k == 1 test_label_classifier is a vector
    % therefore summation would lead to a wrong result
    if k == 1
        test_label_classifier=training_label_rep(indices(1:k, :));
    else
        test_label_classifier=sum(training_label_rep(indices(1:k, :)));
    end
    indices_fives = test_label_classifier > 5*k/2;
    test_label_classifier = 5*indices_fives;
    
    % get number of digits labelled 5 and true positive
    % classifications for test
    size_fives = size(test_label_classifier(indices_fives), 2);
    indices_true = test_label_classifier(indices_fives) == (test_label(indices_fives'))';
    size_fives_true = size(test_label_classifier(indices_true), 2);
    
    
    

    
    % print results to standard output
    fprintf(['\nConsidering ' int2str(k) ' nearest neighbours.\n' ...
             'Number of digits classified as 5...      ' int2str(size_fives) '\n' ...
             'True positive classifications...         ' int2str(size_fives_true) '\n' ...
             'Actual number of digits labelled 5...    ' int2str(actual_fives) '\n' ...
             'True positive/actual number...           ' num2str(size_fives_true/actual_fives) '\n\n'])
    
    if size_fives_true > true_positive_max
        true_positive_max   = size_fives_true;
        true_positive_max_k = k;
    end

end

fprintf(['\n' ...
         'Max true positives...                          ' int2str(true_positive_max) '\n' ...
         'Number of neighbours taken into account...     ' int2str(true_positive_max_k) '\n' ...
         'True positive/actual number...                 ' num2str(true_positive_max/actual_fives) '\n\n'])





%%%%%%%%%%%%%%%%%%%%%%%%
 
fprintf('\n\nProgram paused. Press enter to continue.\n');
pause
 
 
% bonus: 
%%%% your code here %%%%

hist_5  = factorial(5)./(factorial(0:5).*factorial(-(0:5) + 5)).*0.4.^(0:5).*0.6.^(-(0:5) + 5);
hist_21 = factorial(21)./(factorial(0:21).*factorial(-(0:21) + 21)).*0.4.^(0:21).*0.6.^(-(0:21) + 21);

bar(hist_5)
fprintf('\n\nProgram paused. Press enter to continue.\n');
pause
bar(hist_21)

%%%%%%%%%%%%%%%%%%%%%%%%

