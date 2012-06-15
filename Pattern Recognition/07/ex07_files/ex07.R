#!/usr/bin/Rscript

source("regression.R")

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
pdf(file="test.pdf")
parameters = regression(X, y)
parameters

a = seq(minPopulation,maxPopulation,.5)
b = parameters[1]*a + parameters[2]
plot(a,b,main='pizza pizza',xlab='population',ylab='profit',type='l',col="#000000")
points(X[,1],y, pch=6,cex=0.7,col='darkred')
dev.off()


