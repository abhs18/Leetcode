def is_balanced(root)
    # Call post_order helper which returns:
    # 1. height of the tree
    # 2. whether the tree is balanced or not
    len, flag = post_order(root)

    # We only care about the balance flag for this problem
    return flag
end


def post_order(root)
    # Base case:
    # An empty tree has height = 0 and is balanced = true
    return 0, true if root.nil?

    # Recursively get height and balance status of left subtree
    left, lflag = post_order(root.left)

    # Recursively get height and balance status of right subtree
    right, rflag = post_order(root.right)

    # Current node's height = max height of left/right subtree + 1
    height = [left, right].max + 1

    # A tree is balanced if:
    # 1. Difference between left and right subtree heights is at most 1
    # 2. Left subtree is balanced
    # 3. Right subtree is balanced
    balanced = (left - right).abs <= 1 && lflag && rflag

    # Return both height and balance status to parent call
    return height, balanced
end