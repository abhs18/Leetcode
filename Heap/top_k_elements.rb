heap = []
# 8 , 7, 5 , 3
# [8] => [7,8] => [5,7,8] => [3,5,8,7]

#left = (2 * i) + 1
#right = (2 * i) + 2
#parent = (i/2) - 1
#1.Add new element in the last index
#2.check that element with it's parent 
#3.swap if parent > i
#4.Continue untill heap is restored (i > 0)
def push(heap,val)
    heap << val
    i = heap.size - 1
    while i > 0 
       parent = (i - 1) / 2
       break if heap[parent] <= heap[i]
       heap[parent],heap[i] = heap[i],heap[parent]
       i = parent
    end
end

#add last element to root and remove last element
#check both left and right children of root 
#swap root with smallest children
#do untill heap is restored (smallest == i)
def pop(heap)
    heap[0] = heap[-1]
    heap.pop
    i = 0
    while true
        left = (2 * i) + 1
        right = (2 * i) + 2
        smallest = i
        #puts " left #{left} and right isn #{right} and smallest is #{smallest}"
        if left < heap.size && heap[left] < heap[smallest]
            smallest = left
        end

        if right < heap.size && heap[right] < heap[smallest]
            smallest = right
        end

        break if smallest == i
        #puts " After  left #{left} and right isn #{right} and smallest is #{smallest}"

        heap[i],heap[smallest] = heap[smallest],heap[i]
        i = smallest
    end
end


# push(heap,8)
# push(heap,7)
# push(heap,5)
# push(heap,3)
# p heap

# pop(heap)
# p heap

# pop(heap)
# p heap

# pop(heap)
# p heap


nums = [3,2,3,1,2,4,5,5,6]
k = 4

nums.each do |num|
    push(heap,num)
    if heap.size > k
        pop(heap)
    end
end

puts heap[0]