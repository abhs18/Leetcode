# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# @param {TreeNode} root
# @return {String[]}
def binary_tree_paths(root)
  # If tree is empty, return empty list
  return [] unless root

  # Stack to maintain current path from root to current node
  stack = []

  # Result array to store all root-to-leaf paths
  result = []

  # Start DFS traversal
  preorder(root, stack, result)

  # Return all collected paths
  result
end

def preorder(root, stack, result)
  # Base case: if node is nil, stop recursion
  return unless root

  # Add current node value to the path
  stack.push(root.val)

  # If current node is a leaf (no left and right child)
  if root.left.nil? && root.right.nil?
    # Convert current path to string format "a->b->c"
    # and add it to the result
    result << stack.join('->')
  else
    # Traverse left subtree
    preorder(root.left, stack, result)

    # Traverse right subtree
    preorder(root.right, stack, result)
  end

  # Backtracking step:
  # Remove current node before returning to parent
  # Ensures correct path for other branches
  stack.pop
end