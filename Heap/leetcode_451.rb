# @param {String} s
# @return {String}
# WIth Sorting
# def frequency_sort(s)
#     hash = Hash.new(0)

#     s.chars.each do |char|
#       hash[char] += 1
#     end

#     hash = hash.sort_by {|k,v| -v}
#     ans = ""
#     hash.each do |k,cnt|
#        (0...cnt).each do |i|
#           ans += k
#        end
#     end

#     return ans
# end


#WIth Heap
def frequency_sort(s)
    hash = Hash.new(0)
    heap = []
    s.chars.each do |char|
      hash[char] += 1
    end

    hash.each do |k,v|
        push(heap,k,hash)
    end
    
    ans = ""
    while !heap.empty?
        popped = pop(heap,hash)
        (0...hash[popped]).each do |i|
            ans += popped
        end
    end
    return ans
end

def push(heap,val,hash)
    heap << val
    i = heap.size - 1
    while i > 0 
       parent = (i - 1) / 2
       break if hash[heap[parent]] >= hash[heap[i]]
       heap[parent],heap[i] = heap[i],heap[parent]
       i = parent
    end
end



def pop(heap,hash)
    popped = heap[0]
    heap[0] = heap[-1]
    heap.pop
    i = 0
    while true
        left = (2 * i) + 1
        right = (2 * i) + 2
        smallest = i
        if left < heap.size && hash[heap[left]] > hash[heap[smallest]]
            smallest = left
        end

        if right < heap.size && hash[heap[right]] > hash[heap[smallest]]
            smallest = right
        end

        break if smallest == i

        heap[i],heap[smallest] = heap[smallest],heap[i]
        i = smallest
    end
    return popped
end



s = "Aabb"


puts "#{frequency_sort(s)}"