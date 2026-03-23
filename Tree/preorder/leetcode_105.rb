# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {Integer[]} preorder
# @param {Integer[]} inorder
# @return {TreeNode}

def build_tree(preorder, inorder)
    # Base case: if preorder is empty, no tree can be formed
    return nil unless preorder.length > 0 

    # First element of preorder is always the root
    root_val = preorder[0]
    root = TreeNode.new(root_val)

    # If only one node, return it directly (leaf node)
    return root if preorder.size == 1

    # Find root index in inorder array
    # This helps split left and right subtrees
    root_index = inorder.index(root_val)

    # Elements before root_index belong to left subtree (inorder)
    inorder_left_subtree = inorder[0...root_index]

    # Elements after root_index belong to right subtree (inorder)
    inorder_right_subtree = inorder[root_index+1...inorder.length]
    
    # From preorder:
    # After root (index 0), next elements correspond to left subtree
    # Length of left subtree is same as inorder_left_subtree length
    preorder_left_subtree = preorder[1..inorder_left_subtree.length]

    # Remaining elements belong to right subtree
    preorder_right_subtree = preorder[(1+preorder_left_subtree.length)...preorder.size]

    # Recursively build left subtree
    root.left = build_tree(preorder_left_subtree, inorder_left_subtree)

    # Recursively build right subtree
    root.right = build_tree(preorder_right_subtree, inorder_right_subtree)

    # Return the constructed root
    return root
end