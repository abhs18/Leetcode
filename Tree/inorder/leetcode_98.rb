# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst(root)
  # Start validation with the full valid range:
  # (-infinity, +infinity)
  inorder(root, -Float::INFINITY, Float::INFINITY)
end

def inorder(root, min, max)
  # Base case: an empty node is valid
  return true unless root

  # Check if current node violates BST property:
  # It must lie strictly between min and max
  return false if root.val <= min || root.val >= max

  # Recursively validate:
  # - Left subtree: values must be < current node value
  #   so update max to root.val
  # - Right subtree: values must be > current node value
  #   so update min to root.val
  inorder(root.left, min, root.val) &&
  inorder(root.right, root.val, max)
end