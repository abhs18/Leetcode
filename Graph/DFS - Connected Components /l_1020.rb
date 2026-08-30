# @param {Integer[][]} grid
# @return {Integer}
def num_enclaves(grid)
  rows = grid.length
  cols = grid[0].length

  # Start DFS from the left and right borders.
  # Any land connected to the border can walk off the grid,
  # so it is not an enclave.
  (0...rows).each do |r|
    dfs(grid, r, 0, rows, cols)
    dfs(grid, r, cols - 1, rows, cols)
  end

  # Start DFS from the top and bottom borders.
  # This removes/marks all border-connected land.
  (0...cols).each do |c|
    dfs(grid, 0, c, rows, cols)
    dfs(grid, rows - 1, c, rows, cols)
  end

  cnt = 0

  # After removing all land connected to the border,
  # the remaining 1s are enclaves.
  (0...rows).each do |row|
    (0...cols).each do |col|
      cnt += 1 if grid[row][col] == 1
    end
  end

  cnt
end

def dfs(grid, r, c, rows, cols)
  # Stop if the position is outside the grid.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if this cell is water or already visited.
  return if grid[r][c] != 1

  # Mark this border-connected land as visited.
  # You can also use 0 here instead of "S".
  grid[r][c] = "S"

  # Visit all 4-directionally connected land cells.
  dfs(grid, r - 1, c, rows, cols) # up
  dfs(grid, r + 1, c, rows, cols) # down
  dfs(grid, r, c - 1, rows, cols) # left
  dfs(grid, r, c + 1, rows, cols) # right
end