#Prefix + Monotonic queue (min deq)


def shortest_subarray(nums, k)

    # 1️⃣ Build INCLUSIVE prefix sum
    # prefix[i] = sum of nums[0..i]
    prefix = [nums[0]]
    (1...nums.length).each do |index|
      prefix[index] = nums[index] + prefix[index - 1]
    end

    dq = []  # Monotonic deque (stores indices of prefix array in increasing order of values)
    min_len = Float::INFINITY  # Stores minimum length of valid subarray

    nums.each_with_index do |num, index|

        # 2️⃣ Handle subarray starting from index 0 separately
        # sum(0 → index) = prefix[index]
        # If it satisfies condition, update answer
        if prefix[index] >= k 
            min_len = [min_len, index + 1].min
        end

        # 3️⃣ Check if we can form a valid subarray using previous prefix indices
        # prefix[index] - prefix[dq[0]] >= k
        # => sum(dq[0] + 1 → index) >= k
        # Try to minimize length by removing from front
        while !dq.empty? && prefix[index] - prefix[dq[0]] >= k 
            min_len = [min_len, (index - dq[0])].min
            dq.shift   # remove because we want shorter subarray
        end

        # 4️⃣ Maintain monotonic increasing deque
        # Remove indices whose prefix value is >= current prefix[index]
        # Because current prefix is a better candidate (smaller value)
        while !dq.empty? && prefix[dq[-1]] >= prefix[index]
            dq.pop
        end

        # 5️⃣ Add current index to deque
        dq << index

    end

    # 6️⃣ If no valid subarray found, return -1
    return min_len == Float::INFINITY ? -1 : min_len
end

nums = [2,-1,2]
nums = [2,7,3,-8,4]
nums = [1,2]
k = 4

p  shortest_subarray(nums, k)