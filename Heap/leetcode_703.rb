class KthLargest

=begin
    :type k: Integer
    :type nums: Integer[]
=end
    def initialize(k, nums)

        # Min heap to maintain k largest elements
        @heap = []

        # Required kth largest position
        @k = k

        # Initial numbers
        @nums = nums

        # Build initial heap
        init_heap
    end


=begin
    :type val: Integer
    :rtype: Integer
=end

    # Initialize heap using given nums
    def init_heap

      @nums.each do |num|

        # Insert number into heap
        push(num)

        # Maintain heap size as k
        # Remove smallest element if size exceeds k
        if @heap.size > @k 
          pop
        end
      end
    end


    # Add new value into stream
    def add(val)

        # Insert into heap
        push(val)

        # Keep only k largest elements
        if @heap.size > @k 
           pop
        end

        # Root of min heap is kth largest element
        return @heap[0]
    end


    # Insert element into min heap
    def push(val)

       # Add element at end
       @heap << val

       # Start from last index
       i = @heap.size - 1

       # Bubble up until heap property is restored
       while i > 0 

         # Parent index
         parent = (i - 1) / 2

         # Stop if parent is already smaller
         # because this is a min heap
         break if @heap[parent] <= @heap[i]

         # Swap parent and child
         @heap[parent], @heap[i] = @heap[i], @heap[parent]

         # Move upward
         i = parent
       end
    end


    # Remove smallest element from heap
    def pop

      # Move last element to root
      @heap[0] = @heap[-1]

      # Remove last element
      @heap.pop

      # Start heapify from root
      i = 0

      while true

        # Assume current node is smallest
        smallest = i

        # Left and right child indices
        left = (2 * i) + 1
        right = (2 * i) + 2

        # Check left child
        if left < @heap.size && @heap[left] < @heap[smallest]
          smallest = left
        end

        # Check right child
        if right < @heap.size && @heap[right] < @heap[smallest]
          smallest = right
        end

        # Heap property satisfied
        break if smallest == i

        # Swap current node with smaller child
        @heap[i], @heap[smallest] = @heap[smallest], @heap[i]

        # Move downward
        i = smallest
      end
    end
end

# Your KthLargest object will be instantiated and called as such:
# obj = KthLargest.new(k, nums)
# param_1 = obj.add(val)
# Input:
# ["KthLargest", "add", "add", "add", "add", "add"]
# [[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]

# Output: [null, 4, 5, 5, 8, 8]

# Explanation:

# KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
# kthLargest.add(3); // return 4
# kthLargest.add(5); // return 5
# kthLargest.add(10); // return 5
# kthLargest.add(9); // return 8
# kthLargest.add(4); // return 8