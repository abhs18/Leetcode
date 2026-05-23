 ############OPTIMIZED
 def find_mode(root)
  # Start recursion with initial state:
  # prev: previous node value (to track duplicates)
  # count: current frequency streak
  # max_count: highest frequency found so far
  # modes: array of mode values
  _, _, max_count, modes = inorder(root, nil, 0, 0, [])

  return modes
end

def inorder(node, prev, count, max_count, modes)
  # Base case: return current state if node is nil
  return [prev, count, max_count, modes] if node.nil?

  # Traverse left subtree first (BST → sorted order)
  prev, count, max_count, modes = inorder(node.left, prev, count, max_count, modes)

  # If current value is same as previous, increment count
  if prev == node.val
    count += 1
  else
    count = 1   # reset count for new value
  end

  # Update modes based on frequency
  if count > max_count
    # Found new maximum frequency → reset modes
    max_count = count
    modes = [node.val]
  elsif count == max_count
    # Same frequency → add to modes
    modes << node.val
  end

  # Update previous value
  prev = node.val

  # Traverse right subtree
  inorder(node.right, prev, count, max_count, modes)
end


##### BASIC
def find_mode(root)
    # Initialize hash with default value 0 for counting frequency
    hash = Hash.new(0)

    # Fill the hash using inorder traversal
    hash = inorder(root, hash)

    # Sort elements by frequency in descending order
    arr = hash.sort_by { |k, v| -v }

    # Get the highest frequency (mode frequency)
    max = arr[0][1]

    ans = []

    # Collect all elements whose frequency == max
    arr.each do |a|
       break if a[1] < max   # stop once frequency drops
       ans << a[0]
    end

    return ans
end

def inorder(root, hash)
   # Traverse left subtree
   inorder(root.left, hash) if root.left

   # Process current node: increment its frequency
   hash[root.val] += 1

   # Traverse right subtree
   inorder(root.right, hash) if root.right

   # Return updated hash
   return hash
end