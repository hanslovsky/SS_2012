%% initialization
clear; close all; clc

fprintf('loading data\n');
load('mnist-digits.mat');

% number of sample points
n1 = size(training, 1);
n2 = size(test, 1);


fprintf(['\nProblem 1b)\n' ...
         'Digit #2932: b)\n' ...
         'Digit # 814: c)\n' ...
         '# of digits with label 5 in training dataset: 542\n\n'])
        
        

fprintf('compute distance matrix using loops\n');
%time it

tic
%dist_loop=calc_dist_mat_loop_a_b(training, test);
time_loop=toc;

fprintf('Program paused. Press enter to continue.\n');
pause

fprintf('compute distance matrix using vectors\n');
%time it
tic
dist_squ=calc_dist_mat_squ_a_b(training, test);
time_squ=toc;

fprintf(['Computation time\n' ...
         'Loop...    ' num2str(time_loop) 's\n' ...
         'Vector...  ' num2str(time_squ) 's\n\n'])
     
% check if both functions return the same result
% assert(all(all(dist_loop == dist_squ)));
fprintf('Program paused. Press enter to continue.\n');
pause

fprintf('use distance matrix to compute kNN for various values of k\n\n');
%%%% your code here %%%%


% store maximum number of true positives and the corresponding k
true_positive_max   = 0;
true_positive_max_k = 0;
false_positive_min  = n2;


% get number of actual digits with label 5 in test
actual_fives = size(test_label(test_label == 5), 1);


% sort neighbours by distance
[dist_sort,indices]=sort(dist_squ);


% repeat training_label so each sample of test can 
% look up the labels of k nearest neighbours in the
% training dataset
training_label_rep = repmat(training_label, 1, n2);

% set everything != 5 to zero
training_label_rep(training_label_rep ~= 5) = 0;

% histo for true positive and true positve - false positive
true_positive_histo = zeros(20, 1);
true_positive_false_positive_histo = zeros(20, 1);

for k=1:20

    
    


    
    

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
    size_fives_false = size_fives - size_fives_true;
    
    true_positive_histo(k) = size_fives_true;
    true_positive_false_positive_histo(k) = size_fives_true - size_fives_false;
    
    

    
    % print results to standard output
    fprintf(['\nConsidering ' int2str(k) ' nearest neighbours.\n' ...
             'Number of digits classified as 5...      ' int2str(size_fives) '\n' ...
             'True positive classifications...         ' int2str(size_fives_true) '\n' ...
             'Actual number of digits labelled 5...    ' int2str(actual_fives) '\n' ...
             'True positive/actual number...           ' num2str(size_fives_true/actual_fives) '\n\n'])
    
         
    % criterion 1: maximize true_positive
    % criterion 2: minimize false positives
    
    if size_fives_true >= true_positive_max && size_fives - size_fives_true < false_positive_min
        true_positive_max   = size_fives_true;
        false_positive_min     = size_fives - size_fives_true;
        true_positive_max_k = k;
    
    end

end

fprintf(['\n' ...
         'Positives...                                   ' int2str(false_positive_min + true_positive_max) '\n' ...
         'Max true positives...                          ' int2str(true_positive_max) '\n' ...
         'Number of neighbours taken into account...     ' int2str(true_positive_max_k) '\n' ...
         'True positive/actual number...                 ' num2str(true_positive_max/actual_fives) '\n\n'])


bar(true_positive_histo);
xlabel('k')
ylabel('number of true positives')
fprintf('\n\nProgram paused. Press enter to continue.\n');
pause

figure
bar(true_positive_false_positive_histo);
xlabel('k')
ylabel('true positive - false positive')


%%%%%%%%%%%%%%%%%%%%%%%%
 
fprintf('\n\nProgram paused. Press enter to continue.\n');
pause
 
 
% bonus: 
%%%% your code here %%%%

% binomial distributions for 5 and 20 neighbours respectively
hist_5  = factorial(5)./(factorial(0:5).*factorial(-(0:5) + 5)).*0.6.^(0:5).*0.4.^(-(0:5) + 5);
hist_20 = factorial(20)./(factorial(0:20).*factorial(-(0:20) + 20)).*0.6.^(0:20).*0.4.^(-(0:20) + 20);

figure
bar(0:5, hist_5)
xlabel('k')
ylabel('Binomial(k|0.4,5)')

fprintf('\n\nProgram paused. Press enter to continue.\n');
pause

figure
bar(0:20, hist_20)
xlabel('k')
ylabel('Binomial(k|0.4,20)')


fprintf('\n\nProgram paused. Press enter to continue.\n');
pause

p_predict_not5_k5  = sum(hist_5(1:3));
p_predict_not5_k20 = sum(hist_20(1:11));

fprintf(['probability of false prediction\n' ...
         'k =  5:      ' num2str(p_predict_not5_k5) '\n' ...
         'k = 20:      ' num2str(p_predict_not5_k20) '\n' ])


%%%%%%%%%%%%%%%%%%%%%%%%

