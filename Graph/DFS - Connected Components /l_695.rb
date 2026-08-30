# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
  rows = grid.length
  cols = grid[0].length
  max = 0

  # Scan every cell in the grid.
  # Each cell with value 1 represents land.
  (0...rows).each do |row|
    (0...cols).each do |col|
      # If we find land, this is the start of a new unvisited island.
      if grid[row][col] == 1
        # Reset the area counter for this island.
        @num = 0

        # DFS visits all connected land cells in this island.
        # While visiting, it counts the island's area in @num.
        dfs(grid, row, col, rows, cols)

        # Keep the largest island area seen so far.
        max = @num if @num > max
      end
    end
  end

  max
end

def dfs(grid, r, c, rows, cols)
  # Stop if the position is outside the grid boundaries.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if the cell is water or already visited.
  # Visited land is changed from 1 to 0.
  return if grid[r][c] == 0

  # Mark this land cell as visited.
  grid[r][c] = 0

  # Count this cell as part of the current island's area.
  @num += 1

  # Explore all 4-directionally connected neighboring cells.
  dfs(grid, r - 1, c, rows, cols) # up
  dfs(grid, r + 1, c, rows, cols) # down
  dfs(grid, r, c - 1, rows, cols) # left
  dfs(grid, r, c + 1, rows, cols) # right
end