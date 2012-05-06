function displayProjected(pc, data, n_comps)


lambda = pc'*data;
displayData((pc(:, 1:n_comps)*lambda(1:n_comps, :))')