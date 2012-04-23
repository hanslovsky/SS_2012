#!/usr/bin/python


import sys


def sieve( limit ):
    """ gives all prime numbers below limit """


    # initialize two arrays to store numbers and lables (0 for prime, 1 otherwise)
    numbers = range(limit)
    labels  = [0]*(limit)


    # iterate through array 
    i = 2
    while i**2 < limit:
        nr = numbers[i]

        if labels[i] == 0:
            
            add = nr
            nr = nr**2
            while nr < limit:
                labels[nr] = 1
                nr += add
            

        i += 1


    result = [0]*(limit - sum(labels))
    j = 0
    for i in range(limit):
        if labels[i] == 0:
            result[j] = numbers[i]
            j += 1
    

    return result[2:]
        






        
if __name__ == "__main__":

    if len(sys.argv) > 1:
        arg = int(sys.argv[1])
    else:
        print "Usage:", sys.argv[0], "<maximum>"
        print "Default for maximum: 10"
        arg = 10
    result = sieve( arg )
    print "Anzahl der Primzahlen < %i:" %( arg ), len( result )
    print result
