#!/usr/bin/python

import matplotlib.pyplot as plt
import random
import numpy as np
import copy
import timeit



def selectionSort(array):

    comparisonCount = 0
    for i in range(len(array)):
        minElement = i
        for j in range(i+1, len(array)):
            comparisonCount += 1
            if array[j] < array[minElement]:
                minElement = j
        array[i], array[minElement] = array[minElement], array[i]
    
    return comparisonCount





def mergeSort(array, comparisonCount = [0]):

    
    
    if len(array) <= 1:
        return array
    else:
        
        counterRight = [0]
        center = len(array)/2
        leftArray  = mergeSort(array[ :center], comparisonCount)
        rightArray = mergeSort(array[center: ], comparisonCount)
        
        return mergeArrays(leftArray, rightArray, comparisonCount)
        



def mergeArrays(leftArray, rightArray, counter):
    l, r = 0, 0
    
    res = []
    while l < len(leftArray) and r < len(rightArray):
        
        
        if leftArray[l] <= rightArray[r]:
            res.append(leftArray[l])
            l += 1
        else:
            res.append(rightArray[r])
            r += 1
    if l < len(leftArray):
        res += leftArray[l:]
    else:
        res += rightArray[r:]


    counter[0] += l + r
    
    
    return res





def quickSort(array, l, r, counter):
    

    if r > l:
        i, array = partition(array, l, r, counter)
        
        quickSort(array, l, i-1, counter)
        quickSort(array, i+1, r, counter)

            
        


def partition(array, l, r, counter):
    pivot = array[r]
    i = l
    j = r - 1

    while True:
        while array[i] <= pivot and i < r:
            i += 1
            counter[0] += 1
        while array[j] >= pivot and j > l:
            j -= 1
            counter[0] += 1
        if i >= j:
            break

        array[i], array[j] = array[j], array[i]
    if array[i] > pivot:
        array[i], array[r] = array[r], array[i]
        

    

    return i, array



def checkSorting(arrayBefore, arrayAfter):
    """ Check post conditions for sorting algorithm

    """
    #check the length
    if len(arrayBefore) != len(arrayAfter):
        return False
    _arrayBefore = arrayBefore[:]

    #check that arrays contain same elements
    for element in arrayAfter:
        index = 0
        length = len(_arrayBefore)
        while index < len(_arrayBefore):
            if element == _arrayBefore[index]:
                _arrayBefore.pop(index)
                break
            index += 1
        if len(_arrayBefore) == length: #element not in arrayBefore
            return False
        
    #check that array is sorted
    last = arrayAfter[0]
    for element in arrayAfter[1:]:
        if last > element:
            return False
        last = element

    return True





if __name__ == "__main__":


    # create arrays for number of comparisons for selection, merge and quicksort. Each array
    # is of length maxArrayLength which equals the number of different sizes of the arrays
    # to be sorted

    
    maxArrayLength = 10
    
    xRange = np.arange(1, maxArrayLength + 1)
    sSortCount = [0]*maxArrayLength
    mSortCount = [0]*maxArrayLength
    qSortCount = [0]*maxArrayLength

    sSortTime = [0]*maxArrayLength
    mSortTime = [0]*maxArrayLength
    qSortTime = [0]*maxArrayLength 
    
    
    for i in xRange:

        # create temporary counters for merge and quick sort
        tmpCountMerge = [0]
        tmpCountQuick = [0]


        # create random array and copies for selection, merge, quick sort
        randomArray   = [random.randint(0,1000) for r in xrange(i)]
        randomArray_s = copy.deepcopy(randomArray)
        randomArray_m = copy.deepcopy(randomArray)
        randomArray_q = copy.deepcopy(randomArray)

        # create timers for selection, merge, quick sort
        init = """
               import sort
               import copy
               randomArray   = [random.randint(0,1000) for r in xrange(i)]
               randomArray_c = copy.deepcopy(randomArray)
               """


        prog_s = """sort.selectionSort(randomArray_s)"""
        prog_m = """sort.mergeSort(randomArray_m)"""
        prog_q = """sort.quickSort(randomArray_q)"""
        
        timer_s = timeit.Timer(prog_s, init)
        timer_m = timeit.Timer(prog_m, init)
        timer_q = timeit.Timer(prog_q, init)

        sSortTime[i-1] = 0.1*timer_s.timeit(10)
        mSortTime[i-1] = 0.1*timer_m.timeit(10)
        qSortTime[i-1] = 0.1*timer_q.timeit(10)


        # sort arrays and save number of comparisons
        sSortCount[i-1] = selectionSort(randomArray_s)

        randomArray_m   = mergeSort(randomArray_m, tmpCountMerge)
        mSortCount[i-1] = tmpCountMerge

        quickSort(randomArray_q, 0, i - 1, tmpCountQuick)
        qSortCount[i-1] = tmpCountQuick




        # check if functions work correctly, raise exception otherwise
        if not checkSorting(randomArray, randomArray_s):
            raise Exception('%s: Error in selectionSort!' % i)
        if not checkSorting(randomArray, randomArray_m):
            raise Exception('%s: Error in mergeSort!' % i)
        if not checkSorting(randomArray, randomArray_q):
            raise Exception('%s: Error in quickSort!' % i)

        
        
    print "All arrays have been sorted correctly (no exception thrown)."
        
    # create fits to data
    sSortFit = 0.5*(xRange*xRange-xRange)
    mSortFit = 1.1*xRange*np.log(xRange)
    qSortFit = 1.2*xRange*np.log(xRange) + xRange


    # plot fits and data
    p1 = plt.plot(xRange, sSortCount, 'ro')
    p2 = plt.plot(xRange, sSortFit, 'k')
    p3 = plt.plot(xRange, mSortCount, 'g^')
    p4 = plt.plot(xRange, mSortFit, 'k')
    p5 = plt.plot(xRange, qSortCount, 'bs')
    p6 = plt.plot(xRange, qSortFit, 'k')

    plt.legend([p1, p2, p3, p4, p5, p6], ["selection sort", "selection sort fit", "merge sort", "merge sort fit", "quick sort", "quick sort fit"], loc = 2)

    plt.xlabel('array length')
    plt.ylabel('number of comparisons')
    plt.title('number of comparisons for various sort algorithms')


    
    plt.axis([0, xRange[-1] + 1, 0, sSortCount[-1] + 10])
    plt.show()

    plt.figure()
    t1 = plt.plot(xRange, sSortTime, 'ro')
    t2 = plt.plot(xRange, mSortTime, 'g^')
    t3 = plt.plot(xRange, qSortTime, 'bs')

    plt.legend([t1, t2, t3], ["selection sort", "merge sort", "quick sort"])
    plt.show()




