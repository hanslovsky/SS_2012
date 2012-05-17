#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    steps = 100
    xAxis = np.arange(steps)

    f1 = xAxis*xAxis + xAxis + 10
    f2 = 15*xAxis*np.log2(xAxis)
    f3 = np.exp(np.log(2)*xAxis)


    expLim = min([steps, 14])


    p1 = plt.plot(xAxis, f1, 'k')
    p2 = plt.plot(xAxis, f1, 'ko')
    p3 = plt.plot(xAxis, f2, 'g')
    p4 = plt.plot(xAxis, f2, 'g^')
    p5 = plt.plot(xAxis[:expLim], f3[:expLim], 'r')
    p6 = plt.plot(xAxis[:expLim], f3[:expLim], 'rs')
    plt.legend([p2, p4, p6],["N^2 + N + 10", "15*N*ld(N)", "2^N"], loc = 2)
    plt.show()
