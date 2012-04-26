#!/usr/bin/python

import matplotlib.pyplot as plt
import random
import numpy as np


def selectionSort(array):

    comparisonCount = 0
    for i in range(len(array)):
        minElement = i
        for j in range(i+1, len(array)):
            comparisonCount += 1
            if array[j] < array[minElement]:
                minElement = j
        array[i], array[minElement] = array[minElement], array[i]
    
    return array, comparisonCount





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





def quickSort(array):
    return array





if __name__ == "__main__":
    a = [9, 2, 3, 64, 2, 6,4, 1,3 ,23, 5,4 ,4]
    print a
    count = [0]
    b = mergeSort(a, count)
    print b
    print count[0]
    

    xRange = np.arange(1, 51)
    sSortCount = [0]*50
    mSortCount = [0]*50


    
    for i in xRange:
        tmpCountMerge = [0]
        
        randomArray = [random.randint(0,1000) for r in xrange(i)]
        aSelection, sSortCount[i-1] = selectionSort(randomArray)
        aMerge     = mergeSort(randomArray, tmpCountMerge)
        mSortCount[i-1] = tmpCountMerge



        

    sSortFit = 0.5*(xRange*xRange-xRange)
    mSortFit = xRange*np.log(xRange)


        
    plt.plot(xRange, sSortCount, 'ro', xRange, sSortFit, 'k', xRange, 
             mSortCount, 'g^', xRange, mSortFit, 'k')
    plt.axis([0, 55, 0, 1300])
    plt.show()
