def max_depth(root)
    # Base case: if the current node is nil, depth is 0
    return 0 if root.nil?

    # Recursively calculate the depth of the left subtree
    l_height = max_depth(root.left)

    # Recursively calculate the depth of the right subtree
    r_height = max_depth(root.right)

    # The depth of the current node is the maximum of left and right subtree depths + 1 (for current node)
    return [l_height, r_height].max + 1
end