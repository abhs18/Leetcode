def max_level_sum(root)
    # If tree is empty, return empty (note: ideally should return 0 as per problem)
    return [] unless root

    # Queue for BFS traversal (level order)
    queue = [root]

    # Number of nodes at current level
    level_size = queue.size

    # Stores the level number having maximum sum
    ans_level = 1

    # Current level number (1-based indexing)
    level = 1

    # Initialize max_sum to negative infinity to handle negative values
    max_sum = -Float::INFINITY

    # Traverse the tree level by level
    while !queue.empty?

        # Sum of values at current level
        sum = 0

        # Process all nodes in current level
        while level_size > 0 

           # Remove node from front of queue
           cur = queue.shift

           # Add current node's value to level sum
           sum += cur.val

           # Add left child to queue for next level
           queue << cur.left if cur.left

           # Add right child to queue for next level
           queue << cur.right if cur.right

           # Decrease count of nodes remaining in this level
           level_size -= 1
        end

        # After finishing current level, check if this level has maximum sum
        if sum > max_sum
            max_sum = sum       # Update maximum sum
            ans_level = level   # Store corresponding level number
        end

        # Move to next level
        level += 1

        # Update level_size for next level
        level_size = queue.size

        # Reset sum (not necessary since reinitialized at top of loop)
        sum = 0
    end

    # Return the level number with maximum sum
    return ans_level
end