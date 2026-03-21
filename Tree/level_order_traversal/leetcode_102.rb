def level_order(root)
   # If tree is empty, return empty array
   return [] unless root

   # Initialize queue for BFS (Breadth First Search)
   queue = [root]

   # Number of nodes at current level
   level_size = queue.size

   # Final result array (stores level-wise traversal)
   arr = []

   # Traverse until queue becomes empty
   while !queue.empty?

     # Temporary array to store current level values
     temp = []

     # Process all nodes of current level
     while level_size > 0 

        # Get the front node from queue
        cur = queue.first

        # Remove it from queue
        queue.shift

        # Add current node's value to level array
        temp << cur.val

        # Add left child to queue (for next level)
        queue << cur.left if cur.left

        # Add right child to queue (for next level)
        queue << cur.right if cur.right

        # Decrease count of nodes left in this level
        level_size -= 1
     end

     # Add current level result to final answer
     arr << temp

     # Update level_size for next level
     level_size = queue.size

     # Reset temp (not necessary but kept for clarity)
     temp = []
   end

   # Return level order traversal
   return arr
end