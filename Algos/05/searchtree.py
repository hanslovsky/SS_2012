#!/usr/bin/python
# -*- coding: utf-8 -*-

import unittest

class Node(object):
    def __init__(self, key):
        if type(key) is not float and type(key) is not int:
            raise TypeError("key is not of type float or type int")
        self.__class__ = Node
        self.key = key
        self.left = None
        self.right = None


def treeInsert(rootnode, key):
    if rootnode is None:
        return Node(key)
    if type(rootnode) is not Node:
        raise TypeError("rootnode is not of type Node")
    if type(key) is not float and type(key) is not int:
        raise TypeError("key is not of type float or type int")
    if key == rootnode.key:
        return rootnode
    elif key < rootnode.key:
        rootnode.left = treeInsert(rootnode.left, key)
    else:
        rootnode.right = treeInsert(rootnode.right, key)
    return rootnode
        
def treePredecessor(rootnode):
    if rootnode == None:
        return rootnode
    rootnode = rootnode.left
    while rootnode.right is not None:
        rootnode = rootnode.right
    return rootnode

def treeRemove(rootnode, key):
    if rootnode is None:
        return rootnode
    if type(rootnode) is not Node:
        raise TypeError("rootnode is not of type Node")
    if type(key) is not float and type(key) is not int:
        raise TypeError("key is not of type float or type int")
    if key < rootnode.key:
        rootnode.left = treeRemove(rootnode.left, key)
    elif key > rootnode.key:
        rootnode.right = treeRemove(rootnode.right, key)
    else:
        if rootnode.left is None and rootnode.right is None:
            rootnode = None
        elif rootnode.left == None:
            rootnode = rootnode.right
        elif rootnode.right == None:
            rootnode = rootnode.left
        else:
            pred = treePredecessor(rootnode)
            rootnode.key  = pred.key
            rootnode.left = treeRemove(rootnode.left, pred.key)
    return rootnode
    

def treeHasKey(rootnode, key):
    if rootnode == None:
        return None
    if type(rootnode) is not Node:
        raise TypeError("rootnode is not of type Node")
    if type(key) is not float and type(key) is not int:
        raise TypeError("key is not of type float or type int")
    if rootnode.key == key:
        return rootnode
    elif key < rootnode.key:
        return treeHasKey(rootnode.left, key)
    else:
        return treeHasKey(rootnode.right, key)
        

def treeDepth(rootnode):
    if rootnode == None:
        return 0
    if type(rootnode) is not Node:
        raise TypeError("rootnode is not of type Node")
    lDepth = treeDepth(rootnode.left)
    rDepth = treeDepth(rootnode.right)
    return max(lDepth, rDepth) + 1






class TreeTest(unittest.TestCase):
    def buildTrees(self):
        # erstelle Bäume #
        # ausgeglichener Baum
        self.bTree = Node(10)
        self.bTree = treeInsert(self.bTree,  3)
        self.bTree = treeInsert(self.bTree,  1)
        self.bTree = treeInsert(self.bTree,  0)
        self.bTree = treeInsert(self.bTree,  2)
        self.bTree = treeInsert(self.bTree,  6)
        self.bTree = treeInsert(self.bTree,  5)
        self.bTree = treeInsert(self.bTree,  8)
        self.bTree = treeInsert(self.bTree, 15)
        self.bTree = treeInsert(self.bTree, 20)
        self.bTree = treeInsert(self.bTree, 21)
        self.bTree = treeInsert(self.bTree, 19)
        self.bTree = treeInsert(self.bTree, 13)
        self.bTree = treeInsert(self.bTree, 14)
        self.bTree = treeInsert(self.bTree, 11)
        # vollständig unausgeglichen
        self.iTree = Node(2)
        for i in range(3,8):
            self.iTree = treeInsert(self.iTree, i)
        # dazwischen
        self.mTree = treeInsert(self.iTree, 1)
        self.mTree = treeInsert(self.mTree, 0)
        # ausgeglichener Baum
        self.rTree = Node(10)
        self.rTree = treeInsert(self.rTree,  3)
        self.rTree = treeInsert(self.rTree,  1)
        self.rTree = treeInsert(self.rTree,  0)
        self.rTree = treeInsert(self.rTree,  2)
        self.rTree = treeInsert(self.rTree,  6)
        self.rTree = treeInsert(self.rTree,  5)
        self.rTree = treeInsert(self.rTree,  8)
        self.rTree = treeInsert(self.rTree, 15)
        self.rTree = treeInsert(self.rTree, 20)
        self.rTree = treeInsert(self.rTree, 21)
        self.rTree = treeInsert(self.rTree, 19)
        self.rTree = treeInsert(self.rTree, 13)
        self.rTree = treeInsert(self.rTree, 14)
        self.rTree = treeInsert(self.rTree, 11)
    
    def runTest(self):
        # erstelle einige Trees

        # Überprüfe Vorbedingunen #
        # __init__
        self.assertRaises(TypeError, Node, 'Hello World!')
        # treeInsert
        self.assertRaises(TypeError, treeInsert, 5, 5)
        self.assertRaises(TypeError, treeInsert, Node(5), 'Hello World!')
        # treeRemove
        self.assertRaises(TypeError, treeRemove, 5, 5)
        self.assertRaises(TypeError, treeRemove, Node(5), 'Hello World!')
        # treeHasKey
        self.assertRaises(TypeError, treeHasKey, 5, 5)
        self.assertRaises(TypeError, treeHasKey, Node(5), 'Hello World!')
        #treeDepth
        self.assertRaises(TypeError, treeHasKey, 5, 5)

        # Nachbedingungen #
        #__init__
        self.assertEqual(type(Node(5)), Node, "__init__ does not construct object of type Node")
        self.assertEqual(Node(5).key, 5, "__init__ does not set key to the correct value")
        # treeInsert
        self.assertEqual(type(treeInsert(None, 5)), Node, "treeInsert does not create new Node on input rootnode None")
        self.assertEqual(treeInsert(None, 5).key, 5, "treeInsert does not set key to the correct value on creating a new Node")
        dTree = treeRemove(self.bTree, 8)
        self.assertEqual(treeHasKey(treeInsert(dTree, 8), 8), self.bTree.left.right.right, "treeInsert does not place new Node in the correct place")
        self.assertEqual(treeHasKey(treeInsert(dTree, 8), 8).key, self.bTree.left.right.right.key, "treeInsert does not set the key right")
        # treeRemove
        # rootnode == None
        self.assertEqual(treeRemove(None, 5), None, "treeRemove does not return None on input rootnode None")
        # two children at key to be removed
        self.rTree = treeRemove(self.rTree, 3)
        self.assertEqual(self.rTree.left.key, 2, "removeTree does not replace removed key with correct key if the Node has two children")
        self.assertEqual(treeHasKey(self.rTree, 3), None, "removeTree does not remove key if the Node has two children")
        self.assertEqual(self.rTree.left.left.right, None, "removeTree does not remove Node whose key replaced the eliminated key if the Node has two children")
        # only left child at key to be removed
        self.rTree = treeRemove(self.rTree, 1)
        self.assertEqual(self.rTree.left.left.key, 0, "removeTree does not replace removed key with correct key if the Node has only left child")
        self.assertEqual(treeHasKey(self.rTree, 1), None, "removeTree does not remove key if the Node has only left child")
        self.assertEqual(self.rTree.left.left.right, None, "removeTree does not remove Node whose key replaced the eliminated key if the Node only left child")
        self.rTree = treeRemove(self.rTree, 19)
        # no child at key to be removed
        self.assertEqual(self.rTree.right.right.left, None, "removeTree does not remove Node of eliminated key if the Node does not have any children")
        self.assertEqual(treeHasKey(self.rTree, 19), None, "removeTree does not remove key if the Node does not have any children")
        self.rTree = treeRemove(self.rTree, 20)
        # only right child at key to be removed
        self.assertEqual(self.rTree.right.right.key, 21, "removeTree does not replace removed key with correct key if the Node has only rightt child")
        self.assertEqual(treeHasKey(self.rTree, 20), None, "removeTree does not remove key if the Node has only right child")
        self.assertEqual(self.rTree.right.right.right, None, "removeTree does not remove Node whose key replaced the eliminated key if the Node only right child")
        # treeHasKey
        self.assertEqual(treeHasKey(None, 10), None, "treeHasKey gibt nicht None zurück, falls rootnode None ist")
        self.assertEqual(treeHasKey(self.bTree, 6), self.bTree.left.right, "treeHasKey gibt falsche Node zurück")
        self.assertEqual(treeHasKey(self.bTree, 18), None, "treeHasKey gibt nicht None zurück, wenn Key nicht im Baum ist")
        # treeDepth
        self.assertEqual(treeDepth(self.bTree), 4, "treeDepth bestimmt falsche Tiefe bei ausgeglichenem Baum")
        self.assertEqual(treeDepth(self.iTree), 6, "treeDepth bestimmt falsche Tiefe bei vollständig unausgeglichenem Baum")
        self.assertEqual(treeDepth(self.mTree), 6, "treeDepth bestimmt falsche Tiefe bei Baum, der weder vollständig un- noch vollständig ausgeglichen ist")

        

if __name__ == "__main__":
    tTest = TreeTest()
    tTest.buildTrees()
    tTest.runTest()
