def find_anagrams(s, p)
    # Hash to store frequency of characters in pattern p
    p_hash = Hash.new(0)
    ans = []

    # Build frequency map for p
    p.each_char.with_index do |ch,index|
      # Initialize (not really needed because of Hash.new(0), but kept as is)
      p_hash[ch] ||= 0
      p_hash[ch] += 1
    end

    i = 0              # Left pointer of sliding window
    cnt = 0            # Number of characters matched so far

    # Iterate over string s with right pointer (index)
    s.each_char.with_index do |ch,index|

       # If current character is still needed (frequency > 0),
       # then it contributes to forming an anagram
       if p_hash[ch] > 0
         cnt += 1 
       end
       
       # Decrease frequency as this character is now included in window
       # Can go negative → means extra characters in window
       p_hash[ch] -= 1

       # If all characters are matched (cnt == p.length),
       # we found an anagram starting at index i
       ans << i if cnt == p.length
       
       # If window size equals p.length, shrink from left
       if (index - i + 1) == p.length

           left_char = s[i]

           # If removing this character breaks a valid match
           # (i.e., its count was >= 0 → it was contributing),
           # then decrease cnt
           cnt -= 1 if p_hash[left_char] >= 0

           # Add back the left character to hash (restore frequency)
           p_hash[left_char] += 1

           # Move left pointer forward
           i += 1
        end
    end

    return ans
end