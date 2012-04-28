#!/usr/bin/python

import matplotlib.pyplot as plt
import random
import numpy as np
import copy

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
        i = partition(array, l, r, counter)
        
        left  = quickSort(array, l, i-1, counter)
        right = quickSort(array, i+1, r, counter)
        


def partition(array, l, r, counter):
    pivot = array[r]
    i = l
    j = r-1

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
    return i



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
    a = [9, 2, 3, 64, 2, 6,4, 1,3 ,23, 5,4 ,4]
    c = [0]
    quickSort(a, 0, len(a) - 1, c)
    print c, a

    
    maxArrayLength = 1000
    
    xRange = np.arange(1, maxArrayLength + 1)
    sSortCount = [0]*maxArrayLength
    mSortCount = [0]*maxArrayLength
    qSortCount = [0]*maxArrayLength


    
    for i in xRange:
        tmpCountMerge = [0]
        tmpCountQuick = [0]
        
        randomArray     = [random.randint(0,1000) for r in xrange(i)]
        randomArray_m   = copy.deepcopy(randomArray)
        randomArray_q   = copy.deepcopy(randomArray)
        
        sSortCount[i-1] = selectionSort(randomArray)

        aMerge          = mergeSort(randomArray_m, tmpCountMerge)
        mSortCount[i-1] = tmpCountMerge

        quickSort(randomArray_q, 0, len(randomArray_q) - 1, tmpCountQuick)
        qSortCount[i-1] = tmpCountQuick
        

        

    sSortFit = 0.5*(xRange*xRange-xRange)
    mSortFit = xRange*np.log(xRange)
    qSortFit = xRange*np.log(xRange)


        
    plt.plot(xRange, sSortCount, 'ro',
             xRange, sSortFit, 'k',
             xRange, mSortCount, 'g^',
             xRange, mSortFit, 'k',
             xRange, qSortCount, 'bs',
             xRange, qSortFit, 'k')


    
    plt.axis([0, xRange[-1] + 1, 0, sSortCount[-1] + 10])
    plt.show()



    correct = checkSorting(a, dummy)
    print 'Did the sorting work? ---> {0}'.format(correct)
