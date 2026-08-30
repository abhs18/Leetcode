# Calculates the diameter of a binary tree, defined as the length
# (in edges) of the longest path between any two nodes in the tree.
# This path may or may not pass through the root.
def diameter_of_binary_tree(root)
  # Tracks the maximum diameter found so far across the whole tree.
  # Declared as an instance variable so the height method (called recursively)
  # can update it as a side effect while computing heights.
  @diam = 0

  # Kick off the recursive height computation, which also updates @diam
  # along the way.
  height(root)

  return @diam
end

# Returns the height of the subtree rooted at `root`, measured in edges
# (i.e., the number of edges on the longest downward path to a leaf).
# As a side effect, updates @diam whenever it finds a longer path
# passing through the current node.
def height(root)
  # Base case: an empty subtree contributes 0 edges of height.
  return 0 unless root

  # Recursively compute the height of the left and right subtrees.
  left = height(root.left)
  right = height(root.right)

  # The longest path THROUGH the current node connects its two subtrees,
  # so its length is left height + right height (in edges).
  # Update the global diameter if this path is longer than any found so far.
  @diam = [@diam, left + right].max

  # The height of the current subtree is 1 (for the edge down to the
  # taller child) plus the larger of the two child heights.
  return 1 + [left, right].max
end