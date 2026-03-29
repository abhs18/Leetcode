# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

class BSTIterator

    # Initialize the iterator with the root of the BST.
    # We use a stack to simulate the inorder traversal.
    def initialize(root)
        @stack = []

        # Push all left nodes from root (smallest values first)
        push_left(root)
    end

    # Returns the next smallest number in the BST.
    def next()
        # Pop the top element from the stack (smallest available node)
        cur = @stack.pop

        # After visiting a node, the next smallest will be in its right subtree.
        # So push all left children from that right subtree.
        push_left(cur.right)

        return cur.val
    end

    # Returns true if there are still elements left in the iterator.
    def has_next()
        !@stack.empty?
    end

    private

    # Helper method to push all left nodes onto the stack.
    # This ensures the smallest element is always on top.
    def push_left(node)
       while node
         @stack.push(node)
         node = node.left
       end
    end
end

# Usage:
# obj = BSTIterator.new(root)
# next_val = obj.next()
# has_more = obj.has_next()