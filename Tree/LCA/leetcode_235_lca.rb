def lowest_common_ancestor(root, p, q)
    # Start searching from the root of the BST.
    current = root

    while current
        # If both nodes are smaller than current,
        # their LCA must be in the left subtree.
        if p.val < current.val && q.val < current.val
            current = current.left

        # If both nodes are greater than current,
        # their LCA must be in the right subtree.
        elsif p.val > current.val && q.val > current.val
            current = current.right

        else
            # Otherwise, current is the split point:
            # one node is on the left and one is on the right,
            # or current itself is p or q.
            return current
        end
    end

    # This is only reached if the tree is empty.
    return current
end