#!/usr/bin/python
# -*- coding: utf-8 -*-

import random

class Node(object):
    def __init__(self, key, priority = 0):
        self.key = key
        self.priority = priority
        self.left = None
        self.right = None

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

def treeDepth(rootnode):
    if rootnode == None:
        return 0;
    else:
        return max((treeDepth(rootnode.left), treeDepth(rootnode.right))) + 1

def treePrint(rootnode):
    if rootnode is not None:
        print "Key:", rootnode.key
        print "Priority:", rootnode.priority, "\n"
        if rootnode.left is not None:
            treePrint(rootnode.left)
        if rootnode.right is not None:
            treePrint(rootnode.right)


if __name__ == "__main__":
    a = [1, 2, 3, 4, 0, 3]
    dynTree = None
    ranTree = None

    for el in a:
        dynTree = dynamicTreapInsert(dynTree, el)
        ranTree = randomTreapInsert(ranTree, el)

    print a
    treePrint(dynTree)
    
