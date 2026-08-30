# Logic:
# A node is called "eventually safe" if every path starting from it
# eventually ends at a terminal node.
#
# A terminal node has no outgoing edges.
#
# If a node is part of a cycle, or can reach a cycle,
# then it is not safe.
#
# We use DFS with states:
# 0 = unvisited / unknown
# 1 = visiting / currently in DFS path
# 2 = safe / fully checked
#
# If during DFS we reach a node with state 1,
# we found a cycle.
#
# If all neighbors of a node are safe,
# then the current node is also safe.

# @param {Integer[][]} graph
# @return {Integer[]}
def eventual_safe_nodes(graph)
  n = graph.length
  ans = []

  # State of each node:
  # 0 = unknown
  # 1 = visiting/current DFS path
  # 2 = confirmed safe
  vis = Array.new(n, 0)

  # Check every node.
  # If safe?(node) returns true, add it to answer.
  (0...n).each do |node|
    ans << node if safe?(node, vis, graph)
  end

  ans
end

def safe?(node, vis, graph)
  # If node is currently being visited, we found a cycle.
  # So this node is not safe.
  return false if vis[node] == 1

  # If node was already fully checked and marked safe,
  # no need to process it again.
  return true if vis[node] == 2

  # Mark this node as currently being explored.
  vis[node] = 1

  # Check every node reachable from the current node.
  graph[node].each do |n|
    # If any neighbor is unsafe, current node is also unsafe.
    return false unless safe?(n, vis, graph)
  end

  # If all neighbors are safe, this node is safe.
  vis[node] = 2

  true
end