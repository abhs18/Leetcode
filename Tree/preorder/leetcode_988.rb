# @param {TreeNode} root
# @return {String}
def smallest_from_leaf(root)
  # If tree is empty, return empty string
  return "" unless root

  # Start DFS traversal with an empty path (stack)
  preorder(root, [])
end

def preorder(root, stack)
  # Base case: if node is nil, return nil
  # (used later with .compact to ignore invalid paths)
  return nil unless root

  # Add current node value to the path
  stack.push(root.val)

  if root.left.nil? && root.right.nil?
    # If current node is a leaf:
    # Convert numeric values to characters:
    #   0 -> 'a', 1 -> 'b', ..., 25 -> 'z'
    # Then reverse because we need leaf -> root order
    val = stack.map { |x| (x + 97).chr }.reverse.join
  else
    # Recursively explore left and right subtrees
    left = preorder(root.left, stack)
    right = preorder(root.right, stack)

    # From both subtrees, pick the lexicographically smaller string
    # .compact removes nil values (in case one side is missing)
    val = [left, right].compact.min
  end

  # Backtracking step:
  # Remove current node before returning to parent
  # Ensures path remains correct for other branches
  stack.pop

  # Return the smallest string found for this subtree
  val
end