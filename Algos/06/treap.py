#!/usr/bin/python
# -*- coding: utf-8 -*-

import random

class Node(object):
    def __init__(self, key, priority):
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
    randomPriority = random.random()
    if rootnode is None:
        return Node(key, randomPriority)
    if key == rootnode.key:
        return rootnode
    elif key < rootnode.key:
        rootnode.left = randomTreapInsert(rootnode.left, key)
    else:
        rootnode.right = randomTreapInsert(rootnode.right, key)
    return rootnode

def treeDepth(rootnode):
    if rootnode == None:
        return 0;
    else:
        return max((treeDepth(rootnode.left), treeDepth(rootnode.right))) + 1
