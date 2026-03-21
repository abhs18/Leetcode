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
def largest_values(root)
    # If tree is empty, return empty result
    return [] unless root

    # Queue for BFS (level order traversal)
    queue = [root]

    # Final result array storing max value of each level
    ans = []

    # Number of nodes at current level
    level_size = queue.size

    # Traverse level by level
    while !queue.empty?

        # Initialize max value for current level as negative infinity
        # so any node value will be larger than this
        max = -Float::INFINITY

        # Process all nodes in current level
        while level_size > 0 

            # Remove node from front of queue
            cur = queue.shift

            # Update max for this level
            max = [cur.val, max].max

            # Add left child to queue for next level
            queue << cur.left if cur.left

            # Add right child to queue for next level
            queue << cur.right if cur.right

            # Decrease count of nodes remaining in this level
            level_size -= 1
        end

        # After processing current level, store the maximum value
        ans << max

        # Update level_size for next level
        level_size = queue.size

        # Reset max for next level (not strictly needed due to reinitialization above)
        max = -Float::INFINITY
    end

    # Return largest values from each level
    return ans
end