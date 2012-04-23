#!/usr/bin/python
# -*- coding: utf-8 -*-

import random

class DynamicArray:
    def __init__(self):
        self.capacity = 1                      # memory for at least one item
        self.data     = [None]*self.capacity   # empty elements
        self.size     = 0                      # no items inserted

    def __getitem__(self, index):
        if index < 0 or index >= self.size:
            print "index out of range"
            return None
        return self.data[index]
    def append(self, item):
        if self.capacity == self.size:
            self.capacity = 2*self.capacity
            newdata = [None]*(self.capacity)
            for i in range(self.size):
                newdata[i] = self.data[i]
            self.data = newdata
        self.data[self.size] = item
        self.size += 1



if __name__ == "__main__":
    dynamicArray = DynamicArray()
    print dynamicArray[0], dynamicArray.capacity, dynamicArray.size
    for i in range(50):
        dynamicArray.append(random.randint(0,1000))
        print "Anzahl der appends...   ", i, "\n",\
              "Wert...                 ", dynamicArray[i], "\n",\
              "Kapazität...            ", dynamicArray.capacity, "\n",\
              "Size...                 ", dynamicArray.size, "\n"
