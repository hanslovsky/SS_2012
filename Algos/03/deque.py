# -*- coding: utf-8 -*-

import unittest
import copy


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

    def __eq__(self, other):
        queueEqual = self._queue == other._queue
        endEqual = self._end == other._end
        startEqual = self._start == other._start
        sizeEqual = self._size == other._size
        capacityEqual = self._capacity == other._capacity
        return queueEqual and endEqual and startEqual and sizeEqual and capacityEqual

        
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
            returnElement = self._queue[(self._end - 1) % self._capacity]
            self._queue[(self._end - 1) %self._capacity] = None
            self._end = (self._end - 1) % self._capacity
            self._size -= 1
            return returnElement
        else:
            raise RuntimeError("Deque is empty, no element to be popped")
    



class DequeTest(unittest.TestCase):
    def runTest(self):

        # überprüfe Vorbedingungen
        emptyDeque = Deque(1)

        # TypeError falls N nicht vom Typ int ist
        self.assertRaises(TypeError, Deque, 1.2)
        # ValueError falls N kleiner als 1 ist
        self.assertRaises(ValueError, Deque, 0)
        # RuntimeError falls popLast() oder popFirst() auf einem leeren Array ausgeführt wird
        self.assertRaises(RuntimeError, emptyDeque.popLast)
        self.assertRaises(RuntimeError, emptyDeque.popFirst)

        
        # überprüfe Nachbedingungen

        # Konstruktor

        self.assertEqual(isinstance(emptyDeque, Deque), True, "is not an instance of Deque")
        self.assertEqual(emptyDeque._size, 0, 'wrong size')
        self.assertEqual(emptyDeque._capacity, 1, 'wrong capacity')

        # size() und capacity()
        testDeque = Deque(5)
        for i in range(3):
            testDeque.push(i)
        testDeque_copy = copy.deepcopy(testDeque)

        self.assertEqual(testDeque.size(), 3, "size() returns wrong size")
        self.assertEqual(testDeque == testDeque_copy, True, "size() changes deque")
        self.assertEqual(testDeque.capacity(), 5, "capacity() returns wrong capacity")
        self.assertEqual(testDeque == testDeque_copy, True, "capacity() changes deque")

        # push(x)
        testDeque = Deque(5)
        for i in range(5):
            size_old = testDeque.size()
            testDeque.push(i)
            self.assertEqual(testDeque._queue[(testDeque._end - 1) % 5], i, "push back does not push the element to the right place")
            self.assertEqual(size_old + 1, testDeque.size(), "Size isn't changed properly on push (size < capacity): %i" % i)
        for i in range(8):
            size_old = testDeque.size()
            testDeque.push(i+1)
            self.assertEqual(testDeque._queue[(testDeque._end - 1) % 5], i+1, "push back does not push the element to the right place")
            self.assertEqual(size_old, testDeque.size(), "Size isn't changed properly on push (size == capacity): %i" % i)
        
        testDeque_copy = copy.deepcopy(testDeque)
        # q.popLast()
        while testDeque.size() > 0:
            index = (testDeque._end - 1) % testDeque.capacity()
            size_old = testDeque.size()
            element = testDeque._queue[index]
            self.assertEqual(testDeque.popLast(), element, "popLast() does not return correct element")
            self.assertEqual(testDeque.size(), size_old - 1, "popLast() does not decrement size")

        testDeque = testDeque_copy
        # q.popFirst()
        while testDeque.size() > 0:
            index = (testDeque._start) % testDeque.capacity()
            size_old = testDeque.size()
            element = testDeque._queue[index]
            self.assertEqual(testDeque.popFirst(), element, "popLast() does not return correct element")
            self.assertEqual(testDeque.size(), size_old - 1, "popLast() does not decrement size")
            
        
        
dTest = DequeTest()
dTest.runTest()
        
