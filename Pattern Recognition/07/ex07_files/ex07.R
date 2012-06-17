#!/usr/bin/Rscript

library(lattice)
source("regression.R")
source("errorFunction.R")


# 7.1.2
pizzaData = read.csv(file="cities.csv",head=TRUE,sep=",")
population = pizzaData$population
profit = pizzaData$profit
samples = length(population)
X = cbind(population, rep(1, samples))
y = profit
maxPopulation = ceiling(max(X))
minPopulation = floor(min(X))
X
y
# X = population
pdf(file="7_1_2.pdf")
parameters = regression(X, y)
parameters

a = seq(minPopulation,maxPopulation,.5)
b = parameters[1]*a + parameters[2]
plot(a,b,main='pizza pizza',xlab='population',ylab='profit',type='l',col="#000000")
points(X[,1],y, pch=6,cex=0.7,col='darkred')
dev.off()


# 7.1.3
pdf(file="7_1_3.pdf")
gridSections = 101
mid = floor(gridSections/2)
gridX = seq(-10,10,length=gridSections)
gridC = seq(-40,40,length=gridSections)
grid = matrix(nrow=gridSections, ncol=gridSections)
for(i in 1:gridSections) {
  for(j in 1:gridSections) {
    grid[i,j] = errorFunction(X, y, rbind(gridX[i], gridC[j]))
  }
}


wireframe(as.vector(grid)~rep(gridX,gridSections)*rep(gridC,gridSections), xlab='slope', ylab='offset',zlab='error J', main='3D surface plot of the error J', colorkey=TRUE, drape=TRUE, screen = list(z = -60, x = -60))
plot(gridX, grid[,mid], xlab='slope', ylab='error J', pch=6,cex=0.7,col='darkred', main='error J for a fixed value of the offset')
plot(gridC, grid[mid,], xlab='offset', ylab='error J', pch=6,cex=0.7,col='darkred', main='error J for a fixed value of the slope')
filled.contour(gridX, gridC, grid, xlab='slope', ylab='offset', main='Contour plot of the error J')
points(parameters[1], parameters[2], pch=1,cex=0.7,col='black')
dev.off()

errorFunction(X, y, parameters)
min(grid)

# 7.2.2
students = read.csv("student-scores-training.csv")
score1 = students$score1
score2 = students$score2
passed = students$exam.passed
frame = data.frame(score1, score2, passed)
regress = glm(passed~score1+score2, binomial)
coefficients = regress$coefficients
intersect = coefficients[1]
theta1 = coefficients[2]
theta2 = coefficients[3]
pdf(file="7_2_2.pdf")
plot(0:100, -(theta1*(0:100)+intersect)/theta2, xlab='score1', ylab='score2',type ='l', lty=4, main='pass/fail in dependance of scores')
points(score1[passed == 1], score2[passed == 1], pch=6, col='darkred')
points(score1[passed == 0], score2[passed == 0], pch=6, col=259)
gridSections=101
gridX = seq(0,100,length=gridSections)
gridY = seq(0,100,length=gridSections)
grid  = matrix(nrow=gridSections, ncol=gridSections)
for(i in 1:gridSections) {
  for(j in 1:gridSections) {
    denominator = 1+exp(-(coefficients%*%c(1,i,j)))
    grid[i,j] = 1/denominator
  }
}
filled.contour(gridX, gridY, grid, xlab='score1', ylab='score2', main='Contour plot of the class posterior probabilities')
boundary = which(abs(grid-0.5) < 0.00665, arr.in=TRUE)
# add contour to filled contour:
mar.orig <- par("mar")
 w <- (3 + mar.orig[2]) * par("csi") * 2.15
 layout(matrix(c(2, 1), nc = 2), widths = c(1, lcm(w)))
contour(gridX, gridY, grid, levels=0.5, drawlabels = FALSE, axes = FALSE, frame.plot = FFALSE, add = TRUE)

dev.off()
