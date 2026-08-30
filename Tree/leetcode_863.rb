


#863. All Nodes Distance K in Binary Tree
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {TreeNode} target
# @param {Integer} k
# @return {Integer[]}
def distance_k(root, target, k)
  # Stores mapping: child node -> parent node
  @child_parent_map = {}

  # First DFS traversal to build parent references
  dfs(root, nil)

  # Perform BFS starting from the target node
  bfs(root, target, k)
end

# DFS to build child -> parent mapping
def dfs(node, parent_node)
  return unless node

  # Root has no parent, so don't store nil
  @child_parent_map[node] = parent_node if parent_node

  # Traverse left and right subtrees
  dfs(node.left, node)
  dfs(node.right, node)
end

def bfs(root, target, k)
  visited = {}
  queue = []

  # BFS starts from the target node
  queue << target
  visited[target] = true

  # Number of nodes in the current level
  size = queue.size

  # Current distance from target
  cnt = 0

  while !queue.empty?

    # Once we've reached distance K,
    # all nodes currently in the queue are the answer.
    break if cnt == k

    while size > 0
      node = queue.shift

      # Visit left child
      if node.left && !visited[node.left]
        queue << node.left
        visited[node.left] = true
      end

      # Visit right child
      if node.right && !visited[node.right]
        queue << node.right
        visited[node.right] = true
      end

      # Visit parent using the parent map
      if @child_parent_map[node] && !visited[@child_parent_map[node]]
        queue << @child_parent_map[node]
        visited[@child_parent_map[node]] = true
      end

      size -= 1
    end

    # Prepare for the next BFS level
    size = queue.size
    cnt += 1
  end

  # Queue now contains all nodes exactly K distance away
  queue.map(&:val)
end