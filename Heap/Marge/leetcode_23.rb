# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)

   # Min heap
   #
   # Each element inside heap:
   # [node_value, node_reference]
   #
   # Example:
   # [
   #   [1, node1],
   #   [3, node2],
   #   [2, node3]
   # ]
   #
   heap = []

   # Push the head node of every linked list into heap
   #
   # We only push non-nil lists
   #
   lists.each do |list|
      push(heap, list.val, list) if list
   end

   # Dummy node helps simplify linked list construction
   #
   dummy = ListNode.new(0, nil)

   # Pointer used to build final merged list
   temp = dummy

   # Continue until heap becomes empty
   #
   while !heap.empty?

      # Smallest node is always at heap root
      #
      val, node = heap[0]

      # Remove smallest node from heap
      pop(heap)

      # Attach smallest node to answer linked list
      #
      temp.next = node

      # Move temp forward
      temp = temp.next

      # Next node from same linked list
      #
      pushed_node = temp.next

      # Push next node into heap if it exists
      #
      # This maintains heap size at most k
      #
      push(heap, pushed_node.val, pushed_node) if pushed_node
   end

   # Return actual head
   #
   # dummy node itself is skipped
   #
   return dummy.next
end



# Push element into min heap
#
# Heap stores:
# [value, node]
#
def push(heap, val, node)

    # Insert new element at end
    heap << [val, node]

    # Start bubbling upward
    i = heap.size - 1

    while i > 0 

       # Parent index
       parent = (i - 1) / 2

       # Stop if min heap property already satisfied
       #
       # parent value <= child value
       #
       break if heap[parent][0] <= heap[i][0]

       # Swap parent and child
       heap[parent], heap[i] = heap[i], heap[parent]

       # Move upward
       i = parent
    end
end



# Remove root element from min heap
#
# Root always contains smallest value
#
def pop(heap)

    # Move last element to root
    heap[0] = heap[-1]

    # Remove last element
    heap.pop

    # Start heapify downward from root
    i = 0

    while true

        # Left child index
        left = (2 * i) + 1

        # Right child index
        right = (2 * i) + 2

        # Assume current node is smallest
        smallest = i

        # Check left child
        #
        # If left child smaller than current smallest
        #
        if left < heap.size && heap[left][0] < heap[smallest][0]
            smallest = left
        end

        # Check right child
        #
        # If right child smaller than current smallest
        #
        if right < heap.size && heap[right][0] < heap[smallest][0]
            smallest = right
        end

        # Heap property restored
        #
        break if smallest == i

        # Swap current node with smaller child
        #
        heap[i], heap[smallest] = heap[smallest], heap[i]

        # Continue heapify downward
        i = smallest
    end
end