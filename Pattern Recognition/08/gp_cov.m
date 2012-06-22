function covariance = gp_cov(x1, x2, theta0, theta1, theta2, theta3, beta)
% x1 is a dxn1 matrix containing n2 observations of d dimensions
% x2 is a dxn2 matrix containing n2 observations of d dimensions
nugget = beta;
if nugget ~= 0
      nugget = 1/nugget;
end
n1 = size(x1, 2);
n2 = size(x2, 2);
par1 = repmat(diag(x1'*x1),1,n2) + repmat(diag(x2'*x2)',n1,1) - 2*x1'*x2;
delta = (par1 == 0);
par3 = x1'*x2;
covariance = theta0*exp(-theta1/2*par1)+theta2+theta3*par3+nugget*delta;

end
