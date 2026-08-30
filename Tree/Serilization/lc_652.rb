def find_duplicate_subtrees(root)
    # Stores one root node for each duplicate subtree found.
    @result = []

    # Counts how many times each serialized subtree appears.
    @hash = Hash.new(0)

    # Serialize every subtree using DFS.
    dfs(root)

    @result
end

def dfs(node)
    # Use '#' to represent a nil child.
    # This is important to preserve the exact tree structure.
    return '#' unless node

    # Serialize left and right subtrees first.
    left = dfs(node.left)
    right = dfs(node.right)

    # Create a unique key for the subtree rooted at current node.
    # Commas avoid ambiguity between values like 1 and 11.
    key = "#{node.val},#{left},#{right}"

    # Count this subtree serialization.
    @hash[key] += 1

    # Add the node only when we see this subtree for the second time.
    # This avoids adding the same duplicate subtree multiple times.
    @result << node if @hash[key] == 2

    # Return this subtree serialization to the parent call.
    key
end