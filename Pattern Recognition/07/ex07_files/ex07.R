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
gridX = seq(-5,5,length=gridSections)
gridC = seq(-5,5,length=gridSections)
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
