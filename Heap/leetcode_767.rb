# LeetCode 767 - Reorganize String
#
# Problem:
# Rearrange the characters of a string so that
# no two adjacent characters are the same.
#
# Example:
#
# Input:  "aab"
# Output: "aba"
#
# Input:  "aaab"
# Output: ""
#
# Approach:
# 1. Count frequency of each character.
# 2. Use a Max Heap to always pick the 2 most frequent characters.
# 3. Append them alternatively.
# 4. Reduce their frequencies and push them back if still remaining.
#
# Why this works:
# Picking the most frequent characters first prevents
# one character from getting accumulated at the end.


def reorganize_string(s)

    # Frequency map
    #
    # Example:
    # "aaabbc"
    #
    # {
    #   "a" => 3,
    #   "b" => 2,
    #   "c" => 1
    # }
    #
    hash = Hash.new(0)

    # Max Heap
    #
    # Heap stores only characters.
    # Priority is decided using frequency map.
    #
    heap = []

    # Count frequencies
    s.chars.each do |c|
       hash[c] += 1
    end

    # If any character frequency is greater than (n+1)/2
    # then reorganization is impossible.
    #
    # Example:
    # "aaab"
    #
    # length = 4
    # max allowed frequency = (4+1)/2 = 2
    #
    # 'a' frequency = 3
    # => impossible
    #
    hash.keys.each do |key|
        return "" if hash[key] > (s.length + 1) / 2

        # Push character into max heap
        push(heap, key, hash)
    end

    ans = ""

    #
    # Main Greedy Loop
    #
    # Always pick top 2 most frequent characters.
    #
    # Example:
    #
    # heap:
    # [a(3), b(2), c(1)]
    #
    # Pick:
    # a and b
    #
    # ans => "ab"
    #
    # Remaining:
    # a(2), b(1), c(1)
    #
    while heap.size >= 2

        # Most frequent character
        l1 = pop(heap, hash)

        # Second most frequent character
        l2 = pop(heap, hash)

        # Append both characters
        #
        # Since they are different characters,
        # adjacent duplicates won't happen.
        #
        ans += l1
        ans += l2

        # Reduce frequency after usage
        hash[l1] -= 1
        hash[l2] -= 1

        # Push back into heap if still remaining
        push(heap, l1, hash) if hash[l1] > 0
        push(heap, l2, hash) if hash[l2] > 0
    end

    #
    # One character may remain in heap.
    #
    # Example:
    #
    # ans => "abacab"
    # heap => ["c"]
    #
    # final => "abacabc"
    #
    ans += pop(heap, hash) if !heap.empty?

    return ans
end


#
# Push into Max Heap
#
# Heapify-Up operation
#
# Time Complexity: O(log n)
#
def push(heap, val, hash)

    # Insert at end
    heap << val

    # Start from inserted index
    i = heap.size - 1

    # Move upward while parent frequency is smaller
    while i > 0

        parent = (i - 1) / 2

        # Heap property satisfied
        break if hash[heap[parent]] >= hash[heap[i]]

        # Swap parent and child
        heap[parent], heap[i] = heap[i], heap[parent]

        # Continue upward
        i = parent
    end
end


#
# Remove maximum frequency character
#
# Heapify-Down operation
#
# Time Complexity: O(log n)
#
def pop(heap, hash)

    # Root element (maximum frequency)
    popped = heap[0]

    # Move last element to root
    heap[0] = heap[-1]

    # Remove last element
    heap.pop

    i = 0

    #
    # Heapify Down
    #
    while true

        biggest = i

        left = (2 * i) + 1
        right = (2 * i) + 2

        # Compare left child
        if left < heap.size &&
           hash[heap[left]] > hash[heap[biggest]]

            biggest = left
        end

        # Compare right child
        if right < heap.size &&
           hash[heap[right]] > hash[heap[biggest]]

            biggest = right
        end

        # Heap property satisfied
        break if biggest == i

        # Swap current with bigger child
        heap[i], heap[biggest] = heap[biggest], heap[i]

        # Continue downward
        i = biggest
    end

    return popped
end