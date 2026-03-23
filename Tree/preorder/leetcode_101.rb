def is_symmetric(root)
    # If root is nil, tree is empty → by definition symmetric
    # (Note: ideally should return true, but keeping your logic as is)
    return false unless root

    # Check if left and right subtrees are mirror images
    return is_mirror(root.left, root.right)
end

def is_mirror(node1, node2)
    # If both nodes are nil → symmetric at this level
    return true if node1 == nil && node2 == nil

    # If only one is nil → not symmetric
    return false if node1 == nil || node2 ==  nil

    # If values are different → not symmetric
    return false if node1.val != node2.val

    # Recursively check mirror condition:
    # left subtree of node1 with right subtree of node2
    # AND
    # right subtree of node1 with left subtree of node2
    is_mirror(node1.left, node2.right) && is_mirror(node2.left, node1.right)
end