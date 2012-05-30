import operator

dic = {'+': operator.add, '-': operator.sub, "*": operator.mul, 
       "/": operator.div, "0":0, "1":1, "2":2, "3":3, "4":4, "5":5, "6":6,
       "7":7, "8":8, "9":9}



numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]



#parantheses #paranthesis




class Node:
    def __init__(self, key):
        self.key = key
        #if key[0] == "(" and key[-1] == ")":
        #    key = key[1:-1]
        self.left = None
        self.right = None
        

def findBreakIndex(string_all):
    
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
    
    print node.key
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

    root = Node(string_all)
    evalChildren(root)
    
    return root

def readOutTree(tree):
    if tree.left.left != None: # left child is operator
        readOutTree(tree.left)
    if tree.right.left != None: #right child is operator
        readOutTree(tree.right)

    #both children are numbers -> do operation
    if tree.left.left == None and tree.right.left == None:                    
        tree.key = dic[tree.key](int(tree.left.key), int(tree.right.key))
        tree.left = None
        tree.right = None
        print tree.key
    return tree.key

def evalString(string):
    tree = buildTree(string)
    result = readOutTree(tree)

    return result

def printTree(tree):
    node = tree
    if node != None:
        print tree.key
        
        printTree(tree.left)
        printTree(tree.right)


if __name__=='__main__':

    #print dic['+'](dic["5"],dic["2"])

    s1 = "+"

    #if s1 in numbers:
    #    print s1

    string_all = "2+(5-3)"
    string_all2 = "((3+4)+1)*4"
    string_all3 = "(4+9-2+3*5-(2-2*4*3))"



    last = None

    breakindex = findBreakIndex(string_all2)

    #print breakindex
            
    #print string_all[1:-1]        
            
    tree = buildTree(string_all2)

    #printTree(tree)

    result = evalString(string_all3)
    print result
    print "eval result: ", eval(string_all3)
