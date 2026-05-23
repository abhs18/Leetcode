class MinStack
  def initialize
    # Main stack to store all values
    @stack = []

    # Auxiliary stack to store the minimum value at each level
    # min_stack[i] = minimum of stack[0..i]
    @min_stack = []
  end

  # Push a value onto the stack
  # Also update the min_stack to track the current minimum
  def push(val)
    @stack << val

    # If min_stack is empty, val is the current minimum
    if @min_stack.empty?
      @min_stack << val
    else
      # Otherwise, push the minimum between new value and previous minimum
      @min_stack << [val, @min_stack[-1]].min
    end
  end

  # Remove the top element from both stacks
  # No need to return anything as per LeetCode requirements
  def pop
    @stack.pop
    @min_stack.pop
  end

  # Retrieve the top element of the stack
  def top
    @stack[-1]
  end

  # Retrieve the minimum element in O(1) time
  def get_min
    @min_stack[-1]
  end
end