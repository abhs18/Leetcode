def is_subtree(root, sub_root)
    # If the tree starting at current root is exactly same as sub_root,
    # then sub_root is a subtree.
    return true if same_tree?(root, sub_root)

    # If root is nil, there are no more nodes to check.
    return false unless root

    # Otherwise, check whether sub_root exists in the left or right subtree.
    is_subtree(root.left, sub_root) || is_subtree(root.right, sub_root)
end

def same_tree?(node1, node2)
    # If both nodes are nil, this part of the tree matches.
    return true if node1.nil? && node2.nil?

    # If only one node is nil, tree structure is different.
    return false if node1.nil? || node2.nil?

    # If values are different, trees are not the same.
    return false if node1.val != node2.val

    # Current nodes match, so both left and right subtrees must also match.
    same_tree?(node1.left, node2.left) &&
        same_tree?(node1.right, node2.right)
end