#!/usr/bin/python


import sys
import numpy as np
import matplotlib.pyplot as pl

def sieve( limit, counter = [0] ):
    """ gives all prime numbers below limit """


    # initialize two arrays to store numbers and lables (0 for prime, 1 otherwise)
    numbers = range(limit)
    labels  = [0]*(limit)


    # iterate through array 
    i = 2
    while i**2 < limit:
        nr = numbers[i]
        counter[0] += 1
        if labels[i] == 0:
            
            add = nr
            nr = nr**2
            while nr < limit:
                labels[nr] = 1
                nr += add
                counter[0] += 1

        i += 1


    result = [0]*(limit - sum(labels))
    j = 0
    for i in range(limit):
        if labels[i] == 0:
            result[j] = numbers[i]
            j += 1
    

    return result[2:]
        






        
if __name__ == "__main__":

    """if len(sys.argv) > 1:
        arg = int(sys.argv[1])
    else:
        arg = 10
    result = sieve( arg )
    print "Anzahl der Primzahlen < %i:" %( arg ), len( result )
    print result"""

    samples = 100
    const = 1.35
    numberOfOps = np.zeros(samples)
    arrayOfNs = np.arange(1, samples + 1)*10
    complexity = arrayOfNs*np.log(np.log(arrayOfNs))
    for i in range(samples):
        counter = [0]
        sieve(arrayOfNs[i], counter)
        numberOfOps[i] = counter[0]
    

    pl.plot(arrayOfNs, complexity, 'k', \
            arrayOfNs, const*numberOfOps, 'r<')
    pl.show()
