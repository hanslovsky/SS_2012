import random
from math import sqrt, fabs



def createData(size):
    a = []
    while len(a) < size:
        x, y = random.uniform(-1, 1), random.uniform(-1, 1)
        r = sqrt(x**2 + y**2)
        if r < 1.0:
            a.append(r)
    return a


def bucketMapLinear(M, a):
    buckets = [[] for k in xrange(M)]
    for r in a:
        index = int(r*M)
        buckets[index].append(a)
    return buckets
    

def bucketMapQuadratic(M, a):
    buckets = [[] for k in xrange(M)]
    for r in a:
        index = int(r**2*M)
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

            

if __name__ == "__main__":
        

    array_length = [10**i for i in xrange(2,7)]
    array_M = [2, 4, 8, 20, 100]
    n_total = len(array_M)*len(array_length)

    print "-"*40
    print "run test for quadratic indexing:"
    n_uniform_q = 0
    for l in array_length:
        a = createData(l)
        for M in array_M:
            print "Length = ", l, "  M = ",M 
            buckets_quad = bucketMapQuadratic(M, a)
            tau = testUniformity(buckets_quad)
            print 'tau = ', tau
            if tau <= 3:
                n_uniform_q += 1
    print "-"*40
    print "\n"

    print "run test for linear indexing: "
    n_uniform_l = 0
    for l in array_length:
        a = createData(l)
        for M in array_M:
            print "Length = ", l, "  M = ",M 
            buckets_lin = bucketMapLinear(M, a)
            tau = testUniformity(buckets_lin)
            print 'tau = ', tau
            if tau <= 3:
                n_uniform_l += 1

    print "-"*79
    print "\n"

    print "test result for quadratic indexing:"
    print n_uniform_q, " out of ", n_total, " tests passed"
    print "\n"

    print "test result for linear indexing:"
    print n_uniform_l, " out of ", n_total, " tests passed"


#def testUniformity(N, buckets):
#    M = len(buckets)
#    c = float(N)/float(M)
    
#    chiSquared = 0
#    for bucket in buckets:
#        chiSquared += (len(bucket)-c)**2
#    chiSquared = chiSquared/c

#    tau = sqrt(2*chiSquared)-sqrt(2*M-3)
#    return tau


#    size1 = 100
#    a = createData(size1)
#    buckets1 = bucketMapLinear(4, a)
#    buckets2 = bucketMapQuadratic(4, a)
    
#    print 'NotUniform:'
#    for bucket in buckets1:
#        print len(bucket)
#    print 'tau = {0}'.format(testUniformity(buckets1))
#    print 'Uniform?:'
#    for bucket in buckets2:
#        print len(bucket)
#    print 'tau = {0}'.format(testUniformity(buckets2))
#    print 'tau2 = {0}'.format(testUniformity(buckets2))
