def check_inclusion(s1, s2)
    # Hash to store frequency of characters required from s1
    s1_hash = Hash.new(0)

    # Build frequency map for s1
    s1.each_char.with_index do |ch,index|
        s1_hash[ch] += 1
    end

    i = 0              # Left pointer of sliding window
    ans = false        # Final result (true if any valid permutation found)
    cnt = 0            # Count of characters matched so far

    # Traverse s2 with right pointer (index)
    s2.each_char.with_index do |ch,index|

        # If current character is still needed (frequency > 0),
        # it contributes to forming a valid permutation
        if s1_hash[ch] > 0
            cnt += 1
        end

        # Decrease frequency as this character is now included in the window
        # Can go negative → indicates extra characters in window
        s1_hash[ch] -= 1

        # If all characters are matched (cnt equals length of s1),
        # we found a valid permutation of s1 in s2
        if cnt == s1.length
            ans = true
            break
        end

        # If current window size reaches size of s1, shrink from left
        if (index - i + 1) == s1.length

            left_char = s2[i]

            # If the character being removed was contributing to the match
            # (i.e., its count is >= 0), then removing it breaks the match
            # so decrease cnt
            cnt -= 1 if s1_hash[left_char] >= 0

            # Add the left character back to the hash (restore frequency)
            s1_hash[left_char] += 1

            # Move left pointer forward
            i += 1
        end
    end

    # Return whether any valid permutation was found
    return ans
end