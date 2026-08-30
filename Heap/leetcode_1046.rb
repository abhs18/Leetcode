# @param {Integer[]} stones
# @return {Integer}

def last_stone_weight(stones)

     # Max heap
     heap = []

     # Build heap using all stones
     stones.each do |stone|
       push(heap, stone)
     end

     # Continue until one or no stones remain
     while heap.length > 1

        # Largest stone
        y = pop(heap)

        # Second largest stone
        x = pop(heap)

        # If stones are unequal,
        # push remaining weight back into heap
        push(heap, (y - x)) if x != y 
     end

     # Return remaining stone or 0 if heap empty
     return heap[0] || 0 
end


# Insert element into max heap
def push(heap, val)

   # Add element at end
   heap << val

   # Start from last index
   i = heap.size - 1

   # Bubble up until heap property is restored
   while i > 0 

     # Parent index
     parent = (i - 1) / 2

     # Stop if parent is already larger
     # because this is a max heap
     break if heap[parent] >= heap[i]

     # Swap parent and child
     heap[parent], heap[i] = heap[i], heap[parent]

     # Move upward
     i = parent 
   end
end


# Remove largest element from heap
def pop(heap)

   # Store root element to return later
   popped = heap[0]

   # Move last element to root
   heap[0] = heap[-1]

   # Remove last element
   heap.pop

   # Start heapify from root
   i = 0

   while true
     
      # Left and right child indices
      left = (2 * i) + 1
      right = (2 * i) + 2

      # Assume current node is largest
      largest = i

      # Check left child
      if left < heap.size && heap[left] > heap[largest]
        largest = left
      end

      # Check right child
      if right < heap.size && heap[right] > heap[largest]
        largest = right
      end

      # Heap property satisfied
      break if largest == i 

      # Swap current node with larger child
      heap[i], heap[largest] = heap[largest], heap[i]

      # Move downward
      i = largest
   end

   # Return removed maximum element
   return popped
end



# Example 1:

# Input: stones = [2,7,4,1,8,1]
# Output: 1
# Explanation: 
# We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
# we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
# we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
# we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of the last stone.
# Example 2:

# Input: stones = [1]
# Output: 1