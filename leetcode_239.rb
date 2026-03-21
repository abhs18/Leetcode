#Sliding window with monotonic queue


def max_sliding_window(nums, k)
    max_dq = []
    i = 0
    cnt = 0
    ans = []
    nums.each_with_index do |num,index|
        if index >= k 
            max_dq.shift if max_dq[0] == nums[i]
            i += 1
        end
        while !max_dq.empty? && nums[max_dq[-1]] < num
            max_dq.pop
        end 
        max_dq << index

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