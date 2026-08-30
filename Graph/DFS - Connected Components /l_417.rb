# @param {Integer[][]} heights
# @return {Integer[][]}
def pacific_atlantic(heights)
  rows = heights.length
  cols = heights[0].length

  # pacific_visited[row][col] will be true if this cell can flow to Pacific.
  # atlantic_visited[row][col] will be true if this cell can flow to Atlantic.
  pacific_visited = Array.new(rows) { Array.new(cols, false) }
  atlantic_visited = Array.new(rows) { Array.new(cols, false) }

  # Pacific Ocean touches the left edge.
  # Start DFS from every cell in the first column.
  (0...rows).each do |row|
    dfs(heights, row, 0, rows, cols, pacific_visited, heights[row][0])
  end

  # Pacific Ocean touches the top edge.
  # Start DFS from every cell in the first row.
  (0...cols).each do |col|
    dfs(heights, 0, col, rows, cols, pacific_visited, heights[0][col])
  end

  # Atlantic Ocean touches the right edge.
  # Start DFS from every cell in the last column.
  (0...rows).each do |row|
    dfs(heights, row, cols - 1, rows, cols, atlantic_visited, heights[row][cols - 1])
  end

  # Atlantic Ocean touches the bottom edge.
  # Start DFS from every cell in the last row.
  (0...cols).each do |col|
    dfs(heights, rows - 1, col, rows, cols, atlantic_visited, heights[rows - 1][col])
  end

  result = []

  # A cell is part of the answer if it can reach both oceans.
  (0...rows).each do |row|
    (0...cols).each do |col|
      if pacific_visited[row][col] && atlantic_visited[row][col]
        result << [row, col]
      end
    end
  end

  result
end

def dfs(heights, r, c, rows, cols, visited, prev_height)
  # Stop if the position is outside the matrix.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if this cell has already been visited for this ocean.
  return if visited[r][c]

  # We are doing reverse DFS from the ocean inward.
  # So we can only move to cells with height >= previous cell height.
  #
  # Example:
  # If ocean can reach height 3, then it can move to height 3, 4, 5...
  # because water from those higher cells can flow back down to the ocean.
  return if heights[r][c] < prev_height

  # Mark this cell as reachable for the current ocean.
  visited[r][c] = true

  current_height = heights[r][c]

  # Explore all 4 neighboring cells.
  dfs(heights, r - 1, c, rows, cols, visited, current_height) # up
  dfs(heights, r + 1, c, rows, cols, visited, current_height) # down
  dfs(heights, r, c - 1, rows, cols, visited, current_height) # left
  dfs(heights, r, c + 1, rows, cols, visited, current_height) # right
end

heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]
heights = [[1]]
 p pacific_atlantic(heights)