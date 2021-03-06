#!/usr/bin/python
# -*- coding: utf-8 -*-

import random
import numpy as np
import unittest

class Node(object):
    def __init__(self, key, priority = 0):
        self.key = key
        self.priority = priority
        self.left = None
        self.right = None

# rotations (1a)
def treeRotateLeft(rootnode):
    newRootNode = rootnode.right
    rootnode.right = newRootNode.left
    newRootNode.left = rootnode
    return newRootNode

def treeRotateRight(rootnode):
    newRootNode = rootnode.left
    rootnode.left = newRootNode.right
    newRootNode.right = rootnode
    return newRootNode

# insert (1b)
def randomTreapInsert(rootnode, key):
    if rootnode is None:
        randomPriority = random.random()
        return Node(key, randomPriority)
    if key == rootnode.key:
        return rootnode
    elif key < rootnode.key:
        rootnode.left = randomTreapInsert(rootnode.left, key)
        if rootnode.left.priority > rootnode.priority:
            rootnode = treeRotateRight(rootnode)
    else:
        rootnode.right = randomTreapInsert(rootnode.right, key)
        if rootnode.right.priority > rootnode.priority:
            rootnode = treeRotateLeft(rootnode)
    return rootnode

def dynamicTreapInsert(rootnode, key):
    if rootnode is None:
        priority = 1
        return Node(key, priority)
    if key == rootnode.key:
        rootnode.priority += 1
        return rootnode
    elif key < rootnode.key:
        rootnode.left = dynamicTreapInsert(rootnode.left, key)
        if rootnode.left.priority > rootnode.priority:
            rootnode = treeRotateRight(rootnode)
    else:
        rootnode.right = dynamicTreapInsert(rootnode.right, key)
        if rootnode.right.priority > rootnode.priority:
            rootnode = treeRotateLeft(rootnode)
    return rootnode

# helper functions
def treeDepth(rootnode):
    if rootnode == None:
        return 0;
    else:
        return max((treeDepth(rootnode.left), treeDepth(rootnode.right))) + 1

def treeSize(rootnode):
    if rootnode == None:
        return 0;
    else:
        return treeSize(rootnode.left) + treeSize(rootnode.right) + 1
    

def treePrint(rootnode):
    if rootnode is not None:
        print "Key:", rootnode.key
        print "Priority:", rootnode.priority, "\n"
        if rootnode.left is not None:
            treePrint(rootnode.left)
        if rootnode.right is not None:
            treePrint(rootnode.right)

def treePrint2(rootnode):
    if rootnode is not None:
        treePrint2(rootnode.left)
        print "Key:", rootnode.key
        print "Priority:", rootnode.priority, "\n"
        treePrint2(rootnode.right)

def checkPriorities(rootnode):
    if rootnode == None:
        return True
    if rootnode.priority <= rootnode.left.priority:
        return checkPriorities(rootnode.left)
    else:
        return False
    if rootnode.priority <= rootnode.left.priority:
        return checkPriorities(rootnode.right)
    else:
        return False

# convert tree to arrays of keys, priorities and corresponding levels
# sorted by keys (increasing order)
# neccessarry to see if two trees contain the same elements and ordered the same
# way with regard to keys
def treeArr(rootnode, keys, priorities, levels, depth = 0):
    if rootnode is not None:
        treeArr(rootnode.left, keys, priorities, levels, depth + 1)
        keys +=  [rootnode.key]
        priorities += [rootnode.priority]
        levels += [depth]
        treeArr(rootnode.right, keys, priorities, levels, depth + 1)




class treapTest(unittest.TestCase):
    """ Check post conditions for sorting algorithm

    """

    def setUp(self):
        self.elements = 10000
        self.randomArray = [random.randint(0,1000) for r in xrange(self.elements)]
        self.randomTreap = None
        self.dynamicTreap = None
        for el in self.randomArray:
            self.randomTreap = randomTreapInsert(self.randomTreap, el)
            self.dynamicTreap = dynamicTreapInsert(self.dynamicTreap, el)
        self.ranKeys = []
        self.dynKeys = []
        self.ranPriorities = []
        self.dynPriorities = []

        treeArr(self.randomTreap, self.ranKeys, self.ranPriorities, [], depth = 0)
        treeArr(self.dynamicTreap, self.dynKeys, self.dynPriorities, [], depth = 0)

        self.ranKeys = np.array(self.ranKeys)
        self.dynKeys = np.array(self.dynKeys)
        self.ranPriorities = np.array(self.ranPriorities)
        self.dynPriorities = np.array(self.dynPriorities)
    
    def test_equal(self):
        # check if randomTreap and dynamicTreap are the same
        self.assertTrue(np.all(self.ranKeys == self.dynKeys))
        
    def test_contained(self):
        # check if the sum of priorities sums up to the number of elements in the original array,
        # i.e. if all elements were inserted in the treap
        self.assertEqual(self.elements, np.sum(self.dynPriorities))
        # check if all elements in the treap have an correspodning element in the original array
        for el in self.dynKeys:
            self.assertTrue(np.any(self.randomArray == el))
        # check if every element appears in the random/dynamic treap as often as in the original
        # array
        for i in xrange(len(self.dynKeys)):
            self.assertEqual(self.dynPriorities[i], np.sum(self.randomArray == self.dynKeys[i]))
            self.assertEqual(self.dynPriorities[i], np.sum(self.randomArray == self.ranKeys[i]))

    



if __name__ == "__main__":
    # create trees containing text from 'die-drei-musketiere.txt' (1c)
    s = file('die-drei-musketiere.txt').read()
    for k in ',;.:-"\'!?':
        s = s.replace(k, '')
    s=s.lower()
    text = s.split()
    randomTreap = None
    dynamicTreap = None
    for word in text:
        randomTreap = randomTreapInsert(randomTreap, word)
        dynamicTreap = dynamicTreapInsert(dynamicTreap, word)

    # print total number of words and number of nodes (i.e. number of different words) for each tree
    print "total words:", len(text), \
          "\nnodes in random Treap:", treeSize(randomTreap), \
          "\nnodes in dynamic Treap:", treeSize(dynamicTreap), "\n"

    # convert trees to arrays to check whether they contain the same elements
    ranKeys = []
    dynKeys = []
    ranPriorities = []
    dynPriorities = []
    ranLevels = []
    dynLevels = []
    ranDepth = treeDepth(randomTreap)
    dynDepth = treeDepth(dynamicTreap)

    treeArr(randomTreap, ranKeys, ranPriorities, ranLevels)
    treeArr(dynamicTreap, dynKeys, dynPriorities, dynLevels)

    # check if trees are the same and print depths of the trees
    print "random Treap and dynamic Treap contain the same elements sorted the same way:", ranKeys == dynKeys, "\n"
          
    ranKeys = np.array(ranKeys)
    dynKeys = np.array(dynKeys)
    ranPriorities = np.array(ranPriorities)
    dynPriorities = np.array(dynPriorities)
    ranLevels = np.array(ranLevels)
    dynLevels = np.array(dynLevels)

    highest = np.max(dynPriorities) == dynPriorities

    # print most frequent word and the number of its appearances
    print "most frequent word:", dynKeys[highest][0], \
          "\nnumber of apperances:", dynPriorities[highest][0], "\n"

    # print first 7 levels of dynamic Treap
    for i in xrange(7):
        indices = dynLevels == i
        print "level", i, "\n", \
              dynKeys[indices], "\n", \
              dynPriorities[indices], "\n"
              

    # print depths of the trees (1d)
    print "depth of random Treap:", ranDepth, \
          "\ndepth of dynamic Treap:", dynDepth, \
          "\ndepth of balanced Treap:", np.log2(0.5*(treeSize(randomTreap)+1)), "\n"

    # average access time (1d)
    weightSum = 1.0*np.sum(dynPriorities)
    print "average acces times", \
          "\nrandom Treap:", 1.0*np.sum(dynPriorities*ranLevels)/weightSum, \
          "\ndynamic Treap:", 1.0*np.sum(dynPriorities*dynLevels)/weightSum

    # unittest
    unittest.main()
