# @param {Integer[][]} points
# @param {Integer} k
# @return {Integer[][]}

def k_closest(points, k)

   # Max heap storing distances
   heap = []

   # Parallel heap storing points
   p_heap = []

   points.each do |point|

      # Calculate squared distance from origin
      # Using squared distance avoids unnecessary sqrt
      dist = (point[0] * point[0]) + (point[1] * point[1])

      # Insert point into max heap
      push(heap, p_heap, dist, point)

      # Maintain heap size as k
      # Remove farthest point if size exceeds k
      if heap.size > k 
        pop(heap, p_heap)
      end
   end

   # Remaining points are k closest points
   return p_heap
end


# Insert element into max heap
def push(heap, p_heap, dist, point)

    # Store distance
    heap << dist

    # Store corresponding point
    p_heap << point

    # Start from last index
    i = heap.size - 1

    # Bubble up until heap property is restored
    while i > 0 

       # Parent index
       parent = (i - 1) / 2

       # Stop if parent is already larger
       # because this is a max heap
       break if heap[parent] >= heap[i]

       # Swap distances
       heap[parent], heap[i] = heap[i], heap[parent]

       # Swap corresponding points
       p_heap[parent], p_heap[i] = p_heap[i], p_heap[parent]

       # Move upward
       i = parent
    end
end


# Remove largest distance point from heap
def pop(heap, p_heap)

    # Move last element to root
    heap[0] = heap[-1]
    p_heap[0] = p_heap[-1]

    # Remove last element
    heap.pop
    p_heap.pop

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

        # Swap distances
        heap[i], heap[largest] = heap[largest], heap[i]

        # Swap corresponding points
        p_heap[i], p_heap[largest] = p_heap[largest], p_heap[i]

        # Move downward
        i = largest
    end
end