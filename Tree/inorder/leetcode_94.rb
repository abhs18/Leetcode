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
# @return {Integer[]}
def inorder_traversal(root)
  # Array to store the inorder traversal result
  arr = []

  # Start recursive traversal
  inorder(root, arr)

  # Return the final inorder sequence
  arr
end

def inorder(root, arr)
  # Base case: if node is nil, stop recursion
  return unless root

  # Traverse left subtree first (Left)
  inorder(root.left, arr) if root.left

  # Visit current node (Root)
  arr << root.val

  # Traverse right subtree (Right)
  inorder(root.right, arr) if root.right
end