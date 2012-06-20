function covariance = gp_cov(x1, x2, theta0, theta1, theta2, theta3, beta)
nugget = 0;
if all(x1 == x2)
    nugget = beta;
par1 = (x1-x2)'*(x1-x2);
par3 = x1'*x2;
covariance = theta0*exp(-theta1/2*par1)+theta2+theta3*par3+nugget;
end