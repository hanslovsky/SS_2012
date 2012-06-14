#!/usr/bin/Rscript

source("regression.R")

# 7.1.2
pizzaData = read.csv(file="cities.csv",head=TRUE,sep=",")
population = pizzaData$population
profit = pizzaData$profit
samples = length(population)
X = rbind(population, rep(1, samples))
y = profit
# X = population
pdf(file="test.pdf")
plot(X[1,],y,main='a fascinating plot',xlab='population',ylab='profit')
dev.off()
parameters = regression(X, y)
#parameters
#a = seq(0,20,.5)
#b = parameters*a
#plot(a,b,main='a fascinating plot',xlab='population',ylab='profit')
