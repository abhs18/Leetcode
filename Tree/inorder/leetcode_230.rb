# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# LeetCode 230: Kth Smallest Element in a BST
# ----------------------------------------------------
# We perform an inorder traversal because it visits nodes
# in sorted order for a BST (Left → Node → Right).
# 
# To avoid using global variables, the helper method
# returns three things:
#   - found:  whether we already found the kth element
#   - value:  the kth smallest value (when found)
#   - k:      updated k count after visiting nodes
# 
# Once the kth element is found, we stop traversal early
# and bubble the result back through recursive returns.
def kth_smallest(root, k)
    found, value, _k = inorder(root, k)
    return value
end

# inorder(root, k) → [found, value, updated_k]
def inorder(root, k)
   # Base case: empty node, nothing found, return k unchanged
   return [false, nil, k] unless root

   # Traverse left subtree first (smaller elements)
   found, value, k = inorder(root.left, k)
   return [found, value, k] if found == true   # If already found, stop early

   # Visit current node
   k -= 1                                       # Decrease k because we visited one node
   return [true, root.val, k] if k == 0         # If k becomes zero, we found the kth smallest

   # Traverse right subtree (larger elements)
   inorder(root.right, k)
end