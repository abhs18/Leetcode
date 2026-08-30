def lowest_common_ancestor(root, p, q)
    # If the current node is nil, there is nothing to search.
    return nil unless root

    # If current node is either p or q, return it upward.
    # This node could be the LCA, or one of the targets found so far.
    return root if root == p || root == q

    # Search for p and q in the left subtree.
    left = lowest_common_ancestor(root.left, p, q)

    # Search for p and q in the right subtree.
    right = lowest_common_ancestor(root.right, p, q)

    # If one target is found on the left and the other on the right,
    # current root is their lowest common ancestor.
    return root if left && right

    # If only one side found a target, return that target upward.
    # If neither side found anything, this returns nil.
    left || right
end