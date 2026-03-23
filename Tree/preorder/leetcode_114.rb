def flatten(root)
    # Base case: if node is nil, nothing to flatten
    return unless root

    # Recursively flatten the left subtree
    flatten(root.left)

    # Recursively flatten the right subtree
    flatten(root.right)

    # Store the original right subtree
    # (because we are going to overwrite root.right)
    temp = root.right

    # Move the flattened left subtree to the right
    root.right = root.left

    # Set left child to nil as per problem requirement
    root.left = nil

    # Traverse to the end of the new right subtree
    # (which was originally the left subtree)
    cur = root
    cur = cur.right while cur.right

    # Attach the original right subtree at the end
    cur.right = temp 
end