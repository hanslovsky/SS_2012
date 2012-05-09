# -*- coding: utf-8 -*-

import unittest



class Deque:

    # constructor
    def __init__(self, N):
        if type(N) is not int:
            raise TypeError("Maximalgröße muss integer sein. Eingabe war %s." % type(N))
        if N < 1:
            raise ValueError("Maximalgröße muss > 0 sein. Eingabe war %i." % N)
        self._queue = [None]*N
        self._max = 0
        self._min = 0
        self._size = 0
        self._capacity = N


    def size(self):
        return self._size

    def capacity(self):
        return self._capacity

    def push(self, x):
        self._queue[self._max] = x
        if self._max == (self._min) % self._capacity and self._size == self._capacity:
            self._min = (self._min + 1) % self._capacity
        if self._size < self._capacity:
            self._size += 1
        self._max = (self._max + 1) % self._capacity
        

    def popFirst(self):
        if self._size > 0:
            returnElement = self._queue[self._min]
            self._queue[self._min] = None
            self._min = (self._min + 1) % self._capacity
            self._size -= 1
            return returnElement
        else:
            raise RuntimeError("Deque is empty, no element to be popped")

    def popLast(self):
        if self._size > 0:
            returnElement = self._queue[self._max]
            self._queue[self._max] = None
            self._max = (self._max - 1) % self._capacity
            self._size -= 1
            return returnElement
        else:
            raise RuntimeError("Deque is empty, no element to be popped")
    
