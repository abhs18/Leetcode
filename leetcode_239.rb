#Sliding window with monotonic queue

def max_sliding_window(nums, k)
    max_dq = []   # Monotonic deque (stores indices, values in decreasing order)
    i = 0         # Left pointer of the sliding window
    ans = []      # Result array to store maximums of each window

    nums.each_with_index do |num, index|

        # 1️⃣ Remove element that is going out of the window
        # Window size exceeded when index >= k
        # We check if the outgoing element (at index i) is at the front of deque
        # If yes, remove it because it's no longer part of the window
        if index >= k 
            max_dq.shift if max_dq[0] == i
            i += 1   # Move left pointer forward (slide window)
        end

        # 2️⃣ Maintain monotonic decreasing order in deque
        # Remove all indices from the back whose values are smaller than current element
        # Because they can never be maximum in this or any future window
        while !max_dq.empty? && nums[max_dq[-1]] < num
            max_dq.pop
        end 

        # 3️⃣ Add current index to deque
        # This index is a candidate for maximum in current/future windows
        max_dq << index

        # 4️⃣ Once the first window is formed (index >= k-1),
        # the front of deque contains index of maximum element
        ans << nums[max_dq[0]] if index >= k - 1
    end

    return ans
end


nums = [-7,-8,7,5,7,1,6,0]

#nums = [1]
k = 4

nums = [1,3,-1,-3,5,3,6,7]
k = 3


p max_sliding_window(nums, k)