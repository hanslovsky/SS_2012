errorFunction=function(X, y, parameters) {
  # X is a mx(p+1) matrix containing m samples of p random variables
  # and ones. y is the corresponding mx1 set of datapoints. parameters
  # is a (p+1)x1 vector containing the p+1 parameters of regression.

  samples = dim(X)[1]
  J = 1/(2*samples)*sum((X%*%parameters-y)^2)
  return(J) 
}
