class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None


def treeInsert(rootnode, key):
    if rootnode is None:
        return Node(key)
    if key == rootnode.key:
        return rootnode
    elif key < rootnode.key:
        rootnode.left = treeInsert(rootnode.left, key)
    else:
        rootnode.right = treeInsert(rootnode.right, key)
    return rootnode
        
def treePredecessor(rootnode):
    rootnode = rootnode.left
    while rootnode.right is not None:
        rootnode = rootnode.right
    return rootnode

def treeRemove(rootnode, key):
    if rootnode is None:
        return rootnode
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
            rootnote.key  = pred.key
            note.left = treeRemove(rootnode.left, pred.key)
    return node
    

def treeHasKey(rootnode, key):
    if rootnode == None:
        return None
    if rootnode.key == key:
        return rootnode
    elif key < rootnode.key:
        return treeHasKey(rootnode.left, key)
    else:
        return treeHasKey(rootnode.right, key)
        

def treeDepth(rootnode):
    if rootnode == None:
        return 0
    else:
        lDepth = treeDepth(rootnode.left)
        rDepth = treeDepth(rootnode.right)
    return max(lDepth, rDepth) + 1
