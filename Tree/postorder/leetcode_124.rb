def max_path_sum(root)
  # Global variable to track the maximum path sum found anywhere in the tree
  @max = -Float::INFINITY
  
  # Start DFS traversal
  dfs(root)
  
  # Return the final maximum path sum
  @max
end

def dfs(root)
  # Base case: no contribution from null nodes
  return 0 if root.nil?

  # Recursively get max gain from left and right subtrees
  # Ignore negative paths by comparing with 0
  lmax = [dfs(root.left), 0].max
  rmax = [dfs(root.right), 0].max

  # Case 1: Path passing through current node (can take both left and right)
  # This represents a "complete path" with current node as the highest point
  current_sum = root.val + lmax + rmax

  # Update global maximum if current path is better
  @max = current_sum if current_sum > @max

  # Case 2: Return value to parent
  # We can only take ONE side (no branching allowed when going up)
  # This represents the maximum gain we can contribute upwards
  root.val + [lmax, rmax].max
end