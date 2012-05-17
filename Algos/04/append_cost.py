#!/usr/bin/python

import timeit
import matplotlib.pyplot as pl
import numpy as np


if __name__ == "__main__":


    upperLimit = 1000
    reps = 1000
    xRange = np.arange(upperLimit) + 1
    appendTime = np.zeros(upperLimit)

    for i in xRange:


        timer = timeit.Timer("arr.append(0)", "arr = [0]*%d" % i)
        appendTime[i-1] = 1.0/reps*timer.timeit(reps)

    pl.plot(xRange, appendTime, 'r<')
    pl.xlabel('list size before append')
    pl.ylabel('time needed to append single element')
    pl.title('append time for python list')
    pl.show()
