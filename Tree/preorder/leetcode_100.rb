def is_same_tree(p, q)
    # If both nodes are nil, trees match at this branch
    return true if !p && !q

    # If one node is nil OR values are different,
    # trees do not match
    return false if p.nil? || q.nil? || p.val != q.val

    # Recursively check:
    # 1. Left subtree
    # 2. Right subtree
    # Both must be true for trees to be identical
    is_same_tree(p.left, q.left) && is_same_tree(p.right, q.right)
end