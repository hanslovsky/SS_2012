#!/usr/bin/python

import unittest
import matplotlib.pyplot as plt
import random
import numpy as np
import copy
import timeit
import sys


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


def quickSort(array, l, r, counter = [0]):
    

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


class SelectionSortTestCase(SortingTestCase):
    def setUp(self):
        self.randomArray = [random.randint(0,1000) for r in xrange(100)]
        self.sortedArray = self.randomArray[:]
        selectionSort(self.sortedArray)
            
class QuickSortTestCase(SortingTestCase):
    def setUp(self):
        self.randomArray = [random.randint(0,1000) for r in xrange(100)]
        self.sortedArray = self.randomArray[:]
        quickSort(self.sortedArray, 0, len(self.sortedArray)-1)

class MergeSortTestCase(SortingTestCase):
    def setUp(self):
        self.randomArray = [random.randint(0,1000) for r in xrange(100)]
        self.sortedArray = mergeSort(self.randomArray[:])
            

if __name__ == "__main__":

    sortingTestSuite = unittest.TestSuite()
    sortingTestSuite.addTest(SelectionSortTestCase())
    sortingTestSuite.addTest(MergeSortTestCase())
    sortingTestSuite.addTest(QuickSortTestCase())
    
    unittest.TextTestRunner(verbosity=2).run(sortingTestSuite)
    
