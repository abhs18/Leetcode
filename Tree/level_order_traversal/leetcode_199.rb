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
# @return {Integer[]}
def right_side_view(root)
   # If tree is empty, no nodes are visible
   return [] unless root

   # Queue for BFS traversal
   queue = [root]

   # Number of nodes at current level
   level_size = queue.size

   # Final result storing rightmost node of each level
   ans = []

   # Traverse level by level
   while !queue.empty?

    # Temporary array to store current level values
    temp = []

    # Process all nodes of current level
    while level_size > 0 

        # Remove node from front of queue
        cur = queue.shift

        # Store current node's value you can also use temp = cur.val as it will override all the values and will only consider the rightmost value
        temp << cur.val

        # Add left child for next level
        queue << cur.left if cur.left

        # Add right child for next level
        queue << cur.right if cur.right

        # Decrease count of nodes left in this level
        level_size -= 1
    end

    # The last element of this level is the rightmost node
    # (since we process left → right)
    ans << temp[-1]

    # Reset temp (not required but kept for clarity)
    temp = []

    # Update level_size for next level
    level_size = queue.size
   end

   # Return right side view of the tree
   return ans
end