# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}

def top_k_frequent(nums, k)
    # Min heap to store top k frequent elements
    heap = []

    # Frequency map
    hash = Hash.new(0)

    # Count frequency of each number
    nums.each do |num|
        hash[num] += 1
    end
   
    # Iterate over unique numbers
    hash.each do |num, v|

        # Push current number into heap
        push(heap, num, hash)

        # Maintain heap size as k
        # Remove smallest frequency element
        if heap.size > k 
            pop(heap, hash)
        end
    end

    # Heap now contains top k frequent elements
    return heap
end


# Insert element into min heap
def push(heap, val, hash)

    # Add element at end
    heap << val

    # Start from last index
    i = heap.size - 1

    # Bubble up until heap property is restored
    while i > 0 

       # Parent index
       parent = (i - 1) / 2
      
       # Stop if parent frequency is smaller or equal
       # because this is a min heap
       break if hash[heap[parent]] <= hash[heap[i]]

       # Swap parent and child
       heap[parent], heap[i] = heap[i], heap[parent]

       # Move upward
       i = parent
    end
end


# Remove smallest frequency element from heap
def pop(heap, hash)

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

        # Assume current node is smallest
        smallest = i

        # Check left child
        if left < heap.size && hash[heap[left]] < hash[heap[smallest]]
            smallest = left
        end

        # Check right child
        if right < heap.size && hash[heap[right]] < hash[heap[smallest]]
            smallest = right
        end

        # Heap property satisfied
        break if smallest == i

        # Swap current node with smaller child
        heap[i], heap[smallest] = heap[smallest], heap[i]

        # Move downward
        i = smallest
    end
end



nums = [1,1,1,2,2,3]
k = 2

puts "ans is #{top_k_frequent(nums, k)}" 