import operator

dic = {'+': operator.add, '-': operator.sub, "*": operator.mul, 
       "/": operator.div, "0":0, "1":1, "2":2, "3":3, "4":4, "5":5, "6":6,
       "7":7, "8":8, "9":9}

class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        

def findBreakIndex(string_all):
    """ return operator of least priority
    """
    breakindex = 0
    pthesis = 0
    prio = 1000

    for ind, s in enumerate(string_all):
        if s == "(":
            pthesis += 1
        elif s == ")":
            pthesis -= 1
        elif s == "*" or s == "/":
            if 2*pthesis +1 <= prio:
                prio = 2*pthesis + 1
                breakindex = ind
        elif s == "+" or s == "-":
            if 2*pthesis <= prio:
                prio = 2*pthesis
                breakindex = ind
    return breakindex


def evalChildren(node):
    """ build children nodes from node.key string expression
    if node.key is a string of size>1, then the expression is 
    further broken down into its components.
    """
    if len(node.key) > 1:
        if node.key[0] == "(" and node.key[-1] == ")":
            node.key = node.key[1:-1]
        ind = findBreakIndex(node.key)
        string = node.key
        node.key = string[ind]
        node.left = Node(string[0:ind])
        node.right = Node(string[ind+1:])
        evalChildren(node.right)
        evalChildren(node.left)
        

def buildTree(string_all):
    """ recursively build the tree, starting at root
    """

    root = Node(string_all)
    evalChildren(root)
    
    return root

def calculateFromTree(tree):
    """ calculate expression from tree
    """
    if tree.left.left != None: # left child is operator
        calculateFromTree(tree.left)
    if tree.right.left != None: #right child is operator
        calculateFromTree(tree.right)

    #both children are numbers -> do operation
    if tree.left.left == None and tree.right.left == None:                    
        tree.key = dic[tree.key](int(tree.left.key), int(tree.right.key))
        tree.left = None
        tree.right = None
    return tree.key


#not needed anymore...
def printTree(tree):
    node = tree
    if node != None:
        print tree.key
        
        printTree(tree.left)
        printTree(tree.right)


def evalString(string):
    """ evaluate expression given as string
    build tree from string, then calculate expression from tree
    no checking that input string is correct...
    """
    tree = buildTree(string)
    result = calculateFromTree(tree)

    return result


if __name__=='__main__':

    string_all = "2+5*3"
    string_all2 = "2*4*(3+(4-7)*8)-(1-6)"

    result2 = evalString(string_all2)
    print string_all2, "="
    print "tree result: ", result2
    print "eval (python) result: ", eval(string_all2)
