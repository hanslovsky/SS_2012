#!/usr/bin/python

import matplotlib.pyplot as plt
import random
import numpy as np
import copy
import timeit


def matrixMultiplication1(A, B, C, size):
    # here raise exception if len(A)!=len(B)!=2*size
    if len(A) != len(B):
        print "size do not match!"

    for i in range(size):
        for j in range(size):
            for k in range(size):
                C[i+j*size] += A[i+k*size]*B[k+j*size]



def matrixMultiplication2(A, B, C, size):
    """ optimized matrix multiplication
    - the order of the loops is changed to make use of cache
    - invariant expressions of the loops (A[i+k*size], k*size)
      are taken out of loop
    - index j*size is computed by addition instead of multiplication
    """
   
    for k in range(size):
        ksize = k*size
        for i in range(size):
            a = A[i+ksize]
            ind1 = i
            ind2 = k
            for j in range(size):
                C[ind1] += a*B[ind2]
                ind1 += size
                ind2 += size

if __name__ == "__main__":
     

    reps = 10
    
    init="""
import random
import matrixmulti as matmult
size = 100

A = [random.randint(0,1000) for r in xrange(size**2)]
B = [random.randint(0,1000) for r in xrange(size**2)]    
C = [0] * (size)**2
""" 


    prog1 = """matmult.matrixMultiplication1(A[:], B[:], C, size) """
    prog2 = """matmult.matrixMultiplication2(A[:], B[:], C, size) """
        
    timer_mult1 = timeit.Timer(prog1, init)
    timer_mult2 = timeit.Timer(prog2, init)
    
    time1 = timer_mult1.timeit(reps) #* 1.0/reps 
    time2 = timer_mult2.timeit(reps)
    
    print "time for naive implementation:     {0}".format(time1)
    print "time for optimized implementation: {0}".format(time2)
    
    print "speedup version 2: {0}".format(time1/time2-1)
    
