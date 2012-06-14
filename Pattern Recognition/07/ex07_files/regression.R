regression=function(X,y) {
  parameters = solve(t(X)%*%X) %*% (t(X) %*% y)
  return(parameters)
}


