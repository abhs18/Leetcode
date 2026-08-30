# LeetCode 1642 - Furthest Building You Can Reach
#
# Problem:
# We are given:
#
# heights  -> heights of buildings
# bricks   -> total bricks available
# ladders  -> total ladders available
#
# To move from building i to i+1:
#
# If next building is smaller or equal:
#   no resources needed
#
# If next building is taller:
#   diff = heights[i+1] - heights[i]
#
# We can use:
#   1. bricks
#   2. ladder
#
# Goal:
# Reach the furthest possible building.
#
#
# --------------------------------------------------
# GREEDY IDEA
# --------------------------------------------------
#
# Use ladders for BIG climbs.
# Use bricks for SMALL climbs.
#
# Why?
#
# Ladder can cover any height.
# So using a ladder on a climb of 2 is wasteful
# if later we get a climb of 20.
#
#
# Example:
#
# climbs = [2, 20]
# ladders = 1
#
# Best strategy:
#
# ladder -> 20
# bricks -> 2
#
#
# --------------------------------------------------
# HEAP IDEA
# --------------------------------------------------
#
# We use a MIN HEAP.
#
# Heap stores all positive climbs encountered so far.
#
# Example:
#
# climbs encountered:
# [5, 3, 8]
#
# min heap:
# [3, 5, 8]
#
# Initially assume:
# ladders are used for ALL climbs.
#
# If heap size exceeds ladders:
# remove the SMALLEST climb
# and pay bricks for it.
#
# This ensures:
# ladders are always reserved for biggest climbs.
#


# @param {Integer[]} heights
# @param {Integer} bricks
# @param {Integer} ladders
# @return {Integer}
def furthest_building(heights, bricks, ladders)

    # Min Heap
    #
    # Stores all positive climbs
    #
    heap = []

    #
    # Traverse all buildings
    #
    heights.each_with_index do |height, index|

        # First building has no previous building
        next if index == 0

        #
        # Height difference
        #
        # Example:
        #
        # prev = 4
        # curr = 9
        #
        # diff = 5
        #
        diff = height - heights[index - 1]

        #
        # If diff <= 0
        # no resources required
        #
        next if diff <= 0

        #
        # Add climb into min heap
        #
        # Example:
        #
        # climbs:
        # [5,3,8]
        #
        # heap:
        # [3,5,8]
        #
        push(heap, diff)

        #
        # If climbs exceed available ladders
        #
        # Use bricks for the SMALLEST climb.
        #
        # Example:
        #
        # ladders = 2
        #
        # heap:
        # [2,5,10]
        #
        # Use bricks for 2
        # ladders remain for 5 and 10
        #
        if heap.size > ladders

            # Smallest climb
            smallest_climb = pop(heap)

            #
            # If enough bricks available
            #
            if bricks >= smallest_climb

                bricks -= smallest_climb

            else

                #
                # Cannot move further
                #
                # Return previous building index
                #
                return index - 1
            end
        end
    end

    #
    # Successfully reached last building
    #
    return heights.size - 1
end


#
# PUSH INTO MIN HEAP
#
# Heapify-Up operation
#
# Time Complexity:
# O(log n)
#
def push(heap, val)

    # Insert at end
    heap << val

    # Start from inserted index
    i = heap.size - 1

    #
    # Move upward while parent is larger
    #
    while i > 0

        parent = (i - 1) / 2

        #
        # Heap property satisfied
        #
        break if heap[parent] <= heap[i]

        #
        # Swap parent and child
        #
        heap[i], heap[parent] = heap[parent], heap[i]

        # Move upward
        i = parent
    end
end


#
# REMOVE SMALLEST ELEMENT FROM MIN HEAP
#
# Heapify-Down operation
#
# Time Complexity:
# O(log n)
#
def pop(heap)

    #
    # If only one element
    #
    return heap.pop if heap.size == 1

    #
    # Root contains smallest element
    #
    popped = heap[0]

    #
    # Move last element to root
    #
    heap[0] = heap.pop

    i = 0

    #
    # Heapify Down
    #
    while true

        left = (2 * i) + 1
        right = (2 * i) + 2

        smallest = i

        #
        # Compare left child
        #
        if left < heap.size &&
           heap[left] < heap[smallest]

            smallest = left
        end

        #
        # Compare right child
        #
        if right < heap.size &&
           heap[right] < heap[smallest]

            smallest = right
        end

        #
        # Heap property satisfied
        #
        break if smallest == i

        #
        # Swap current node with smaller child
        #
        heap[i], heap[smallest] =
            heap[smallest], heap[i]

        #
        # Continue downward
        #
        i = smallest
    end

    return popped
end


#
# --------------------------------------------------
# FULL DRY RUN
# --------------------------------------------------
#
# heights = [4,2,7,6,9,14,12]
# bricks = 5
# ladders = 1
#
#
# STEP 1
#
# 4 -> 2
# diff = -2
#
# no resources needed
#
#
# STEP 2
#
# 2 -> 7
# diff = 5
#
# heap = [5]
#
# heap.size = 1
# ladders = 1
#
# use ladder implicitly
#
#
# STEP 3
#
# 7 -> 6
# diff = -1
#
# no resources needed
#
#
# STEP 4
#
# 6 -> 9
# diff = 3
#
# heap = [3,5]
#
# heap.size = 2 > ladders
#
# remove smallest climb:
# 3
#
# use bricks:
#
# bricks = 5 - 3 = 2
#
# heap now:
# [5]
#
# ladder reserved for climb 5
#
#
# STEP 5
#
# 9 -> 14
# diff = 5
#
# heap = [5,5]
#
# heap.size = 2 > ladders
#
# remove smallest climb:
# 5
#
# bricks = 2 - 5 = -3
#
# not enough bricks
#
# return previous index:
# 4
#


# Input: h
heights = [4,2,7,6,9,14,12]
 bricks = 5
  ladders = 1
  puts "#{furthest_building(heights, bricks, ladders)}"
# Output: 4
# Explanation: Starting at building 0, you can follow these steps:
# - Go to building 1 without using ladders nor bricks since 4 >= 2.
# - Go to building 2 using 5 bricks. You must use either bricks or ladders because 2 < 7.
# - Go to building 3 without using ladders nor bricks since 7 >= 6.
# - Go to building 4 using your only ladder. You must use either bricks or ladders because 6 < 9.
# It is impossible to go beyond building 4 because you do not have any more bricks or ladders.
# Example 2:

# Input: 
heights = [4,12,2,7,3,18,20,3,19]
bricks = 10
 ladders = 2
   puts "#{furthest_building(heights, bricks, ladders)}"

# Output: 7
# Example 3:

# Input: 
heights = [14,3,19,3]
bricks = 17
ladders = 0
   puts "#{furthest_building(heights, bricks, ladders)}"

# Output: 3
