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
# @return {Integer[][]}
def zigzag_level_order(root)
    # If tree is empty, return empty result
    return [] unless root

    # Queue for BFS traversal
    queue = [root]

    # Final result storing level-wise values
    arr = []

    # Flag to track direction:
    # odd level → left to right
    # even level → right to left
    flag = 1

    # Number of nodes in current level
    level_size = queue.size

    # Traverse until queue is empty
    while !queue.empty?

        # Temporary array to store current level values
        temp = []

        # Process all nodes of current level
        while level_size > 0 

            # Remove node from front of queue
            cur = queue.shift

            # Add its value to current level
            temp << cur.val

            # Add left child for next level
            queue << cur.left if cur.left

            # Add right child for next level
            queue << cur.right if cur.right

            # Decrease remaining nodes count for this level
            level_size -= 1
        end

        # If current level is even (based on flag),
        # reverse the order to achieve zigzag pattern
        temp = temp.reverse if flag % 2 == 0 

        # Update level_size for next level
        level_size = queue.size

        # Add current level result to final array
        arr << temp

        # Reset temp (not required but kept for clarity)
        temp = []

        # Move to next level (toggle direction)
        flag += 1
    end

    # Return zigzag level order traversal
    return arr
end