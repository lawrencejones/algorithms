nodeCache = new Object()
class Node
  constructor: (val, nodes...) ->
    if !(@ instanceof Node)
      return new Node val, nodes...
    @nodes = nodes.map (n) ->
      return (if typeof n == 'string' then nodeCache[n] else n)
    @val = val
    nodeCache[val] = this

###

  W
  +-- S
  |   +-- R
  |       +-- V
  +-- T
  |   +-- U
  |   |
  +-- X
      +-- Y

###
Tree =
  Node('W'\
  , Node('S'\
    , Node('R', Node 'V'))
  , Node('T', Node('U'))
  , Node('X', Node('Y'), 'U')
  )

print = (Node, pad = 0) ->
  console.log (new Array(pad).join ' ')+Node.val
  Node.nodes.map (n) -> print n, pad+4

# Visits nodes so that we first hit the root, then the first of
# the nodes children, then the first of that child etc.
depthFirst = (Node, visited = {}) ->
  return [] if visited[Node.val]?
  visited[Node.val] = true
  children = Node.nodes.map (n) -> depthFirst n, visited
  [Node.val].concat [], children...

# Explores a graph in a breadth first fashion. Starts at a node,
# then visits the children of the node first. Once all children
# have been visited, the algorithm then proceeds to visit the
# children of all the previously visited nodes.
#
# In this way, we cover each expanding ring of nodes, terminating
# our journey if we hit a node that has already been visited.
breadthFirst = (Tree, visited = {}) ->
  results = []
  queue = [Tree]
  while queue.length != 0
    Nodes = queue.splice 0, queue.length
    for Node in Nodes
      if !visited[Node.val]?
        results.push(visited[Node.val] = Node.val)
        queue.push Node.nodes...
  results


print Tree
console.log depthFirst Tree
console.log breadthFirst Tree
