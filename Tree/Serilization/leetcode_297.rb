class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end


root = TreeNode.new(1)
root.left = TreeNode.new(2)
root.right = TreeNode.new(3)
root.right.left = TreeNode.new(4)
root.right.right = TreeNode.new(5)
root.right.left.left = TreeNode.new(6)
root.right.left.right = TreeNode.new(7)



# Encodes a tree to a single string.
#
# @param {TreeNode} root
# @return {string}
def serialize(root)
    # Empty tree is represented by an empty string.
    return '' unless root

    arr = []
    queue = [root]

    # Do level-order traversal.
    # Store real node values and use '#' for nil children.
    while !queue.empty?
        node = queue.shift

        if node
            arr << node.val.to_s

            # Add both children, even if they are nil,
            # because nils are needed to preserve tree shape.
            queue << node.left
            queue << node.right
        else
            arr << '#'
        end
    end

    # Use comma so values like -10 or 100 do not get split incorrectly.
    arr.join(',')
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize(data)
    # Empty string means empty tree.
    return nil if data.empty?

    arr = data.split(',')

    # First value is always the root.
    root = TreeNode.new(arr[0].to_i)
    queue = [root]
    index = 1

    # Rebuild the tree in the same level-order used during serialization.
    while !queue.empty?
        node = queue.shift

        # The next value is the left child of current node.
        if arr[index] != '#'
            node.left = TreeNode.new(arr[index].to_i)
            queue << node.left
        end
        index += 1

        # The next value after that is the right child.
        if arr[index] != '#'
            node.right = TreeNode.new(arr[index].to_i)
            queue << node.right
        end
        index += 1
    end

    root
end
  p deserialize(data)
