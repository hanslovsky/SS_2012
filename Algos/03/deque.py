# -*- coding: utf-8 -*-

import unittest



class Deque:

    # constructor
    def __init__(self, N):
        if type(N) is not int:
            raise TypeError("Maximalgröße muss integer sein. Eingabe war %s." % type(N))
        if N < 1:
            raise ValueError("Maximalgröße muss > 0 sein. Eingabe war %i." % N)
        self._queue = [None]*N        # initialize array to hold elements of deque
        self._end = 0                 # set end index to 0
        self._start = 0               # set start index to 0
        self._size = 0                # set size to 0
        self._capacity = N            # set capacity to 0

        
    # return current size of deque
    def size(self):
        return self._size

    
    # return capacity of deque
    def capacity(self):
        return self._capacity

    
    # push element x in deque
    def push(self, x):
        self._queue[self._end] = x
        if self._end == (self._start) % self._capacity and self._size == self._capacity:
            self._start = (self._start + 1) % self._capacity
        if self._size < self._capacity:
            self._size += 1
        self._end = (self._end + 1) % self._capacity

        
    # pop first element of deque
    def popFirst(self):
        if self._size > 0:
            returnElement = self._queue[self._start]
            self._queue[self._start] = None
            self._start = (self._start + 1) % self._capacity
            self._size -= 1
            return returnElement
        else:
            raise RuntimeError("Deque is empty, no element to be popped")

        
    # pop last element of deque
    def popLast(self):
        if self._size > 0:
            returnElement = self._queue[self._end]
            self._queue[self._end] = None
            self._end = (self._end - 1) % self._capacity
            self._size -= 1
            return returnElement
        else:
            raise RuntimeError("Deque is empty, no element to be popped")
    
