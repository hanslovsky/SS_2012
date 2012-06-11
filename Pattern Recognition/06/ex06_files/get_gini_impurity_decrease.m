function giDelta = get_gini_impurity_decrease(feature, labels, splitValue)

% [sorted, IX] = sort(labels);

samples = size(feature, 1);
left = feature < splitValue;
right = feature >= splitValue;
p_l = sum(left)/samples;
p_r = 1-p_l;
i_l = get_gini_impurity(labels(left));
i_r = get_gini_impurity(labels(right));
i_p = get_gini_impurity(labels);

giDelta = i_p-p_l*i_l-p_r*i_r;
end