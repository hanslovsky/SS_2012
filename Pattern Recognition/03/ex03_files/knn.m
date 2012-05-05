function [ rate ] = knn( training, training_label, test, test_label, digit, k)
%KNN k Nearest neighbors
% p dimensional input
%
% training - (p x n1)
% training_label - (1 x n1)
% test - (p x n2)
% test_label - (1 x n2)
% digit - predict digit vs non-digit
% k - number of nearest neighbors
% 
% rate - correct classification rate
training_label = (training_label == digit);
test_label = (test_label == digit);
d = calc_dist_mat_squ_a_b(training, test);
[~, sorted_idx] = sort(d);

pred = zeros(1,size(test,2));

for i=1:size(test,2),
if mean(training_label(sorted_idx(1:k, i))) > 0.5,
    pred(i) = 1;
end
end

rate = 1.0 - sum(abs(test_label - pred)) / size(test_label,2)

end

