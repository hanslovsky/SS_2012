function gi = get_gini_impurity(labels)
samples = size(labels, 1);
gi = 1 - ((sum(labels == 1)/samples)^2 + (sum(labels == 2)/samples)^2);
end