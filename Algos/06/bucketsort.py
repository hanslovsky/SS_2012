import random
import timeit
import random
import unittest
from pylab import polyfit, poly1d
import matplotlib.pyplot as plt
from math import sqrt, fabs
from os import sys
import numpy as np
from scipy.optimize import curve_fit


def insertionSort(a):
    for i in xrange(len(a)):
        item = a[i]
        ihole = i
        while ihole > 0 and a[ihole-1] > item:
            a[ihole] = a[ihole-1]
            ihole -= 1

        a[ihole] = item


def createData(size):
    a = []
    while len(a) < size:
        x, y = random.uniform(-1, 1), random.uniform(-1, 1)
        r = sqrt(x**2 + y**2)
        if r < 1.0:
            a.append(r)
    return a


def bucketMapLinear(r, M):
    return int(r*M)

def bucketMapQuadratic(r, M):
    return int(r**2*M)
    #return int(r*M)


def returnBuckets(a, bucketMap, M):
    buckets = [[] for k in xrange(M)]
    for r in a:
        index = bucketMap(r, M)
        buckets[index].append(a)
    return buckets    
        

def testUniformity(buckets):
    N = 0
    for bucket in buckets:
        N += len(bucket)
    M = len(buckets)
    c = float(N)/float(M)
    
    chiSquared = 0
    for bucket in buckets:
        chiSquared += (len(bucket)-c)**2
    chiSquared = chiSquared/c

    tau = fabs(sqrt(2*chiSquared)-sqrt(2*M-3))
    return tau


def bucketSort(a, bucketMap, c):
    M = int(c*len(a))
    b = [[] for k in xrange(M)]
    for k in xrange(len(a)):
        index = bucketMap(a[k], M)
        b[index].append(a[k])
    i=0
    for k in xrange(M):
        insertionSort(b[k])
        a[i:i+len(b[k])] = b[k]
        i += len(b[k])

             
class SortingTestCase(unittest.TestCase):
    """ Check post conditions for sorting algorithm

    """

    def setUp(self):
        self.randomArray = [random.randint(0,1000) for r in xrange(100)]
        self.sortedArray = self.randomArray[:]
    
    #check the size
    def runTest(self):
        self.assertEqual(len(self.randomArray), len(self.sortedArray), 
                         'incorrect size')

    #check that arrays contain same elements
        _randomArray = self.randomArray[:]
        for element in self.sortedArray:
            index = 0
            length = len(_randomArray)
            while index < len(_randomArray):
                if element == _randomArray[index]:
                    _randomArray.pop(index)
                    break
                index += 1
                self.assertEqual(len(_randomArray), length, 
                                 'different elements in array')
        
    #check that array is sorted
        last = self.sortedArray[0]
        for element in self.sortedArray[1:]:
            self.assertTrue(last <= element,'not sorted')
            last = element

#test bucketMapQuadratic
class BucketSortTestCase1(SortingTestCase):
    def setUp(self):
        self.randomArray = [random.random() for r in xrange(1000)]
        self.sortedArray = self.randomArray[:]
        bucketSort(self.sortedArray, bucketMapQuadratic, 0.2)

#test bucketMapLinear
class BucketSortTestCase2(SortingTestCase):
    def setUp(self):
        self.randomArray = [random.random() for r in xrange(1000)]
        self.sortedArray = self.randomArray[:]
        bucketSort(self.sortedArray, bucketMapLinear, 0.2)


if __name__ == "__main__":
        
    print "takes about 2 minutes..."

    array_length = [10**i for i in xrange(2,7)]
    array_M = [2, 4, 8, 20, 100]
    n_total = len(array_M)*len(array_length)

    print "-"*40
    print "run test to check uniformity for quadratic indexing:"
    n_uniform_q = 0
    for l in array_length:
        a = createData(l)
        for M in array_M:
    #        print "Length = ", l, "  M = ",M 
            buckets_quad = returnBuckets(a, bucketMapQuadratic, M)
            tau = testUniformity(buckets_quad)
    #        print 'tau = ', tau
            if tau <= 3:
                n_uniform_q += 1
    print "-"*40
    print "\n"

    print "run test to check uniformity for linear indexing: "
    n_uniform_l = 0
    for l in array_length:
        a = createData(l)
        for M in array_M:
    #        print "Length = ", l, "  M = ",M 
            buckets_lin = returnBuckets(a, bucketMapLinear, M)
            tau = testUniformity(buckets_lin)
    #        print 'tau = ', tau
            if tau <= 3:
                n_uniform_l += 1

    print "-"*79
    print "\n"

    print "test result for quadratic indexing:"
    print n_uniform_q, " out of ", n_total, " tests passed"
    print "\n"

    print "test result for linear indexing:"
    print n_uniform_l, " out of ", n_total, " tests passed"
    print "\n"

    print "running unittest to check correctness of bucketSort\n"

    ## testing bucketSort with both bucketMaps
    sortingtestsuite = unittest.TestSuite()
    sortingtestsuite.addTest(BucketSortTestCase1())
    sortingtestsuite.addTest(BucketSortTestCase2())
    
    unittest.TextTestRunner(verbosity=2).run(sortingtestsuite)
    

    ## checking if runtime grows linear with arraysize
    print "compute runtime..."


    n_length = [1000, 5000, 10000, 20000, 40000, 100000, 200000, 
                300000, 400000, 500000, 600000, 700000]
    time_quad = []
    time_lin = []
    
    for n in n_length:
        reps = 10

        init="""                                                               
import bucketsort as bs                                                  
a = bs.createData(%d)
c=4.0
c=1.0/c
""" % n
        
        prog_lin  = """bs.bucketSort(a, bs.bucketMapLinear, c)"""
        prog_quad = """bs.bucketSort(a, bs.bucketMapQuadratic, c)"""

        timer_quad = timeit.Timer(prog_quad, init)
        timer_lin = timeit.Timer(prog_lin, init)
        
        time_quad.append(timer_quad.timeit(reps))               
        time_lin.append(timer_lin.timeit(reps))
        
    # linear fit to data
    fit = polyfit(n_length, time_quad, 1)
    fit_fn = poly1d(fit)
    
    x=range(n_length[-1])

    p_quad = plt.plot(n_length, time_quad, 'bs')
    p_lin  = plt.plot(n_length, time_lin, 'yo')
    p_fit  = plt.plot(x, fit_fn(x), 'k')

    plt.legend([p_quad, p_lin, p_fit], ["int(r**2*M)", "int(r*M", "linear fit"], loc = 2)

    plt.xlabel('array length')
    plt.ylabel('runtime')
    plt.title('Runtime of bucketSort with different bucketMaps')

    plt.axis([0, n_length[-1] + 10, 0, time_lin[-1] + 10])
    plt.show()


