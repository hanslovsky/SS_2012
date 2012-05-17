#!/usr/bin/python

import matplotlib.pyplot as plt
import random
import numpy as np
import copy
import timeit


def timePyList(n=100000, reps=1000000):

    time_pylist = [0] * n
    for i in range(n):

        init = """
import random
randomlist   = [random.randint(0,1000) for r in xrange(%d)] 
newentry = random.randint(0,1000)
""" % i 
        prog = """randomlist.append(newentry) """
        
        timer_pylist = timeit.Timer(prog, init)
        
        time = timer_pylist.timeit(reps) #* 1.0/reps 

        time_pylist[i] = time

    return time_pylist


if __name__ == "__main__":
    

    max_size = 500
    reps = 1000000

    time_pylist = timePyList(max_size, reps);

    x_list = range(max_size)
    
    print "x_list.size = {0}".format(len(x_list))
    print "time_pylist.size = {0}".format(len(time_pylist))
    
    
    # plot fits and data
    p1 = plt.plot(range(max_size), time_pylist, 'ro')

   
    plt.xlabel('list size')
    plt.ylabel('cost (time) of list.append()')
    plt.title('Time for append() for varying list size')

#    plt.axis([0, max_size + 1, 0, sSortCount[-1] + 10])
    plt.show()

