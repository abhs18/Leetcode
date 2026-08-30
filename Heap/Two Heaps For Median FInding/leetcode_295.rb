class MedianFinder

    # Initialize two heaps
    #
    # left_max_heap  -> stores smaller half of numbers
    # right_min_heap -> stores larger half of numbers
    #
    # Invariant:
    # 1. All elements in left_max_heap <= all elements in right_min_heap
    # 2. Size difference between heaps is at most 1
    #
    def initialize()
        @left_max_heap = []
        @right_min_heap =[]
    end


=begin
------------------------------------------------------------------------------
APPROACH 1 (WITHOUT GENERIC HEAP METHODS)

Separate heap functions for:
- max heap
- min heap

This approach is easier to understand initially,
but contains duplicated heap logic.
------------------------------------------------------------------------------
=end

=begin
    :type num: Integer
    :rtype: Void
=end
    def add_num_common(num)

        # First element always goes into left max heap
        if @left_max_heap.size == 0 

          push_into_left_max_heap(num)

        else

            # If number belongs to larger half
            if num >= @left_max_heap[0]

                # Insert into right min heap
                push_into_right_min_heap(num)

                puts "Add NUm 11111111 =>>>>> @left_max_heap is #{@left_max_heap} and @right_min_heap #{@right_min_heap}"

                # Rebalance heaps if right heap becomes larger
                if @right_min_heap.size > @left_max_heap.size

                    # Take smallest element from right heap
                    popped = @right_min_heap[0]

                    pop_from_right_min_heap

                    # Push into left heap
                    push_into_left_max_heap(popped)
                end

            else

                # Number belongs to smaller half
                push_into_left_max_heap(num)

                # Rebalance if left heap size exceeds by more than 1
                if @left_max_heap.size > @right_min_heap.size + 1

                    # Take largest element from left heap
                    popped = @left_max_heap[0]

                    pop_from_left_max_heap

                    # Push into right heap
                    push_into_right_min_heap(popped)
                end
            end
        end 

        puts "Add NUm =>>>>> @left_max_heap is #{@left_max_heap} and @right_min_heap #{@right_min_heap}"
    end



=begin
------------------------------------------------------------------------------
APPROACH 2 (GENERIC HEAP METHODS)

Instead of writing separate push/pop functions for:
- min heap
- max heap

we reuse:
- push()
- pop()

by passing:
is_max_heap = true / false

This removes duplicated logic and improves readability.
------------------------------------------------------------------------------
=end

    def add_num_common(num)

        # First element always goes into left max heap
        if @left_max_heap.size == 0 

          push(@left_max_heap, num, true)

        else

            # Number belongs to larger half
            if num >= @left_max_heap[0]

                # Insert into right min heap
                push(@right_min_heap, num, false)

                puts "Add NUm 11111111 =>>>>> @left_max_heap is #{@left_max_heap} and @right_min_heap #{@right_min_heap}"

                # Rebalance if right heap becomes larger
                if @right_min_heap.size > @left_max_heap.size

                    # Take smallest from right heap
                    popped = @right_min_heap[0]

                    pop(@right_min_heap, false)

                    # Move it to left heap
                    push(@left_max_heap, popped, true)
                end

            else

                # Insert into left max heap
                push(@left_max_heap, num, true)

                # Rebalance if left heap exceeds allowed size
                if @left_max_heap.size > @right_min_heap.size + 1

                    # Take largest element from left heap
                    popped = @left_max_heap[0]

                    pop(@left_max_heap, true)

                    # Move it into right heap
                    push(@right_min_heap, popped, false)
                end
            end
        end 
    end


=begin
    :rtype: Float
=end
    def find_median()

        puts "FIND MEDIAN =>>>>> @left_max_heap is #{@left_max_heap} and @right_min_heap #{@right_min_heap}"

        # Total number count
        count =  @left_max_heap.size + @right_min_heap.size

        # Even count
        if count % 2 == 0 

            # Median is average of both heap tops
            return (@left_max_heap[0].to_f + @right_min_heap[0].to_f) / 2.0

        else

            # Left heap always contains extra element
            return @left_max_heap[0]
        end
    end



=begin
------------------------------------------------------------------------------
GENERIC PUSH FUNCTION

Works for:
- max heap
- min heap

depending on is_max_heap flag.
------------------------------------------------------------------------------
=end
    def push(heap, val, is_max_heap)

      # Insert at end
      heap << val

      # Start from last index
      i = heap.size - 1

      # Bubble up until heap property is restored
      while i > 0 

         # Parent index
         parent = (i - 1) / 2

         # Stop if heap property already valid
         break if is_valid_heap?(heap[parent], heap[i], is_max_heap)

         # Swap parent and child
         heap[parent], heap[i] = heap[i], heap[parent]

         # Move upward
         i = parent
      end
    end



=begin
------------------------------------------------------------------------------
GENERIC POP FUNCTION

Works for:
- max heap
- min heap

depending on is_max_heap flag.
------------------------------------------------------------------------------
=end
    def pop(heap, is_max_heap)

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

        # Assume current node is correct
        smallest = i

        # Check left child
        if left < heap.size && check_pop_cond?(heap[left], heap[smallest], is_max_heap)
            smallest = left
        end

        # Check right child
        if right < heap.size && check_pop_cond?(heap[right], heap[smallest], is_max_heap)
            smallest = right
        end

        # Heap property satisfied
        break if smallest == i

        # Swap current node with better child
        heap[i], heap[smallest] = heap[smallest], heap[i]

        # Continue downward
        i = smallest
      end
    end



=begin
------------------------------------------------------------------------------
CHECK IF HEAP PROPERTY IS VALID

For max heap:
parent >= child

For min heap:
parent <= child
------------------------------------------------------------------------------
=end
    def is_valid_heap?(parent, child, is_max_heap)

        if is_max_heap
            parent >= child
        else
            parent <= child
        end
    end
    


=begin
------------------------------------------------------------------------------
CHECK WHICH CHILD SHOULD BE CHOSEN DURING HEAPIFY

For max heap:
choose larger child

For min heap:
choose smaller child
------------------------------------------------------------------------------
=end
    def check_pop_cond?(child, parent, is_max_heap)

        if is_max_heap
            child > parent
        else
            child < parent
        end
    end



=begin
------------------------------------------------------------------------------
SEPARATE MIN HEAP PUSH (APPROACH 1)
------------------------------------------------------------------------------
=end
    def push_into_right_min_heap(val)

      @right_min_heap << val

      i = @right_min_heap.size - 1

      while i > 0 

         parent = (i - 1) / 2

         break if @right_min_heap[parent] <= @right_min_heap[i]

         @right_min_heap[parent], @right_min_heap[i] = @right_min_heap[i], @right_min_heap[parent]

         i = parent
      end
    end



=begin
------------------------------------------------------------------------------
SEPARATE MAX HEAP PUSH (APPROACH 1)
------------------------------------------------------------------------------
=end
    def push_into_left_max_heap(val)

      @left_max_heap << val

      i = @left_max_heap.size - 1

      while i > 0 

         parent = (i - 1) / 2

         break if @left_max_heap[parent] >= @left_max_heap[i]

         @left_max_heap[parent], @left_max_heap[i] = @left_max_heap[i], @left_max_heap[parent]

         i = parent
      end
    end



=begin
------------------------------------------------------------------------------
SEPARATE MIN HEAP POP (APPROACH 1)
------------------------------------------------------------------------------
=end
    def pop_from_right_min_heap

      @right_min_heap[0] = @right_min_heap[-1]

      @right_min_heap.pop

      i = 0

      while true

         left = (2 * i) + 1
         right = (2 * i) + 2

         smallest = i

         if left < @right_min_heap.size && @right_min_heap[left] < @right_min_heap[smallest]
            smallest = left
         end

         if right < @right_min_heap.size && @right_min_heap[right] < @right_min_heap[smallest]
            smallest = right
         end

         break if smallest == i

         @right_min_heap[i], @right_min_heap[smallest] = @right_min_heap[smallest], @right_min_heap[i]

         i = smallest
      end
    end



=begin
------------------------------------------------------------------------------
SEPARATE MAX HEAP POP (APPROACH 1)
------------------------------------------------------------------------------
=end
    def pop_from_left_max_heap

      @left_max_heap[0] = @left_max_heap[-1]

      @left_max_heap.pop

      i = 0

      while true

         left = (2 * i) + 1
         right = (2 * i) + 2

         smallest = i

         if left < @left_max_heap.size && @left_max_heap[left] > @left_max_heap[smallest]
            smallest = left
         end

         if right < @left_max_heap.size && @left_max_heap[right] > @left_max_heap[smallest]
            smallest = right
         end

         break if smallest == i

         @left_max_heap[i], @left_max_heap[smallest] = @left_max_heap[smallest], @left_max_heap[i]

         i = smallest
      end
    end

end




# Example 1:

# Input
# ["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
# [[], [1], [2], [], [3], []]
# Output
# [null, null, null, 1.5, null, 2.0]

# Explanation
# MedianFinder medianFinder = new MedianFinder();
# medianFinder.addNum(1);    // arr = [1]
# medianFinder.addNum(2);    // arr = [1, 2]
# medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
# medianFinder.addNum(3);    // arr[1, 2, 3]
# medianFinder.findMedian(); // return 2.0