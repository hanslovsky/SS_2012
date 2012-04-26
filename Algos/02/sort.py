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





def mergeSort(array, l = 0, r = None):

    if r == None:
        r = len(array)
    
    comparisonCount = 0
    if l >= r:
        return array
    else:
        leftArray  = mergeSort(array[l: (l+r)/2], l, (l+r)/2)
        rightArray = mergeSort(array[(l+r)/2: r], (l+r)/2+1, r)

        return mergeArrays(leftArray, rightArray)



def mergeArrays(leftArray, rightArray):
    l, r = 0, 0
    comparisonCount = 0
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
    comparisonCount = l + r
    return res






def quickSort(array):
    return array





if __name__ == "__main__":
    a = [9, 2, 3, 64, 2, 6,4, 1,3 ,23, 5,4 ,4]
    print a
    print mergeSort(a)
    

    xRange = range(1, 51)
    sSortCount = [0]*50
    for i in xRange:
        randomArray = [random.randint(0,1000) for r in xrange(i)]
        a, sSortCount[i-1] = selectionSort(randomArray)



        

    sSortFit = 0.5*(np.array(xRange)*np.array(xRange)-np.array(xRange))


        
    #plt.plot(xRange, sSortCount, 'ro', xRange, sSortFit, 'k')
    #plt.axis([0, 55, 0, 1300])
    #plt.show()
