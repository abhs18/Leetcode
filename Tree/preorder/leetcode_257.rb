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
  # If tree is empty, return empty array
  return [] unless root

  # Stack to maintain current path from root to node
  @stack = []

  # Result array to store all root-to-leaf paths
  @result = []

  # Start DFS traversal
  preorder(root)

  # Return all collected paths
  return @result
end

def preorder(root)
  # Base case: if node is nil, do nothing
  return unless root

  # Add current node value to the path
  @stack.push(root.val)

  # Check if current node is a leaf node (no left and right child)
  if root.left.nil? && root.right.nil?
    # Convert current path to string and add to result
    @result << @stack.join('->')
  else
    # Traverse left subtree
    preorder(root.left)

    # Traverse right subtree
    preorder(root.right)
  end

  # Backtrack: remove current node from path before returning to parent
  @stack.pop
end