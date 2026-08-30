
# Code
# Testcase
# Testcase
# Test Result
# 1110. Delete Nodes And Return Forest
# Solved
# Medium
# Topics
# premium lock icon
# Companies
# Given the root of a binary tree, each node in the tree has a distinct value.

# After deleting all nodes with a value in to_delete, we are left with a forest (a disjoint union of trees).

# Return the roots of the trees in the remaining forest. You may return the result in any order.

 

# Example 1:


# Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
# Output: [[1,2,null,4],[6],[7]]
# Example 2:

# Input: root = [1,2,4,null,3], to_delete = [3]
# Output: [[1,2,4]]

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# @param {TreeNode} root
# @param {Integer[]} to_delete
# @return {TreeNode[]}
def del_nodes(root, to_delete)
    # Store values to delete in a hash for O(1) lookup.
    @to_delete_hash = to_delete.to_h { |val| [val, true] }

    # Stores the roots of all trees remaining after deletion.
    @forest = []

    # The original root starts as a root candidate.
    dfs(root, true)

    @forest
end

def dfs(node, is_root)
    # Empty child, nothing to keep.
    return nil unless node

    # Check whether the current node should be deleted.
    deleted = @to_delete_hash[node.val]

    # If this node is a root candidate and is not deleted,
    # it becomes one of the roots in the final forest.
    @forest << node if is_root && !deleted

    # If the current node is deleted, its children become root candidates.
    # If it is not deleted, its children remain connected under it.
    node.left = dfs(node.left, deleted)
    node.right = dfs(node.right, deleted)

    # Return nil to disconnect deleted nodes from their parent.
    # Return the node itself if it should remain in the tree.
    deleted ? nil : node
end