# @param {Integer[]} gifts
# @param {Integer} k
# @return {Integer}

def pick_gifts(gifts, k)

    # Max heap to store gift piles
    heap = []

    # Build max heap using all gifts
    gifts.each do |gift|
        push(heap, gift)
    end

    # Perform k operations
    while k > 0 

        # Take largest gift pile
        popped = pop(heap)

        # Replace it with floor(sqrt(pile))
        push(heap, Math.sqrt(popped).floor)

        k -= 1
    end

    # Return total remaining gifts
    return heap.sum
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