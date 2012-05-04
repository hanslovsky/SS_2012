#!/usr/bin/python

from math import sqrt
import matplotlib.pyplot as plt
import numpy as np


def archimedes1(k):
    """ algorithm of archimedes to compute pi.
    Starting with a squre...
    """

    edges = 4*2**k
    
    pi_lower = sqrt(2.0)
    pi_upper = 2.0
    
    for i in range(k):
        pi_lower = sqrt(2.0-sqrt(4.0-pi_lower**2))
        pi_upper = 2.0/pi_upper * (sqrt(4+pi_upper**2)-2)
    
    pi_lower = pi_lower*edges/2.0
    pi_upper = pi_upper*edges/2.0
    return edges, pi_lower, pi_upper, pi_upper-pi_lower



def archimedes2(k):
    """ algorithm of archimedes to compute pi.
    Starting with a squre...
    """

    edges = 4*2**k
    
    pi_lower = sqrt(2.0)
    pi_upper = 2.0
    
    for i in range(k):
        pi_lower = pi_lower/sqrt(2.0+sqrt(4.0-pi_lower**2))
        pi_upper = 2.0*pi_upper/(sqrt(4+pi_upper**2)+2)
    
    pi_lower = pi_lower*edges/2.0
    pi_upper = pi_upper*edges/2.0
    return edges, pi_lower, pi_upper, pi_upper-pi_lower


if __name__ == "__main__":

    
    ##compute estimates for different number of doublings
    doublings = 27
    xvalues = range(doublings)
    edges = [0] * doublings
    diff = [0] * doublings
    pi_upper = [0] * doublings
    pi_lower = [0] * doublings
    for i in xvalues:
        edges[i], pi_lower[i], pi_upper[i], diff[i]  = archimedes1(i)
    

    # plot lower und upper bound estimate for pi to number of doublings
    p1 = plt.plot(xvalues, pi_lower, 'ro')
    p2 = plt.plot(xvalues, pi_upper, 'ko')

    plt.legend([p1, p2], ["lower bound estimate", "upper bound estimate"], 
               loc = 2)

    plt.xlabel('number of doublings')
    plt.ylabel('estimate for pi')
    plt.title('archimedes estimate for pi')
        
    plt.axis([0, xvalues[-1] + 1, 2.5, 4.5])
    plt.show()

    #archimedes2
    edges, pi_lower, pi_upper, diff = archimedes2(28)
    print edges, pi_lower, pi_upper, diff
