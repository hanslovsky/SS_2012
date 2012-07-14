function parameters = regression(X, y)
% X is a mx(p+1) matrix containing m samples and p x-coordinates and a
% column of ones for the offset parameter
% y is a mx1 matrix containing m corresponding y-values
parameters = (X'*X)\X'*y;
end