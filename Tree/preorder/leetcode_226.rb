def invert_tree(root)
    # Base case: if the current node is nil, return nil
    return unless root

    # Recursively invert the left subtree
    invert_tree(root.left)

    # Recursively invert the right subtree
    invert_tree(root.right)

    # Swap the left and right children of the current node
    temp = root.right
    root.right = root.left
    root.left = temp 

    # Return the root of the inverted subtree
    return root
end