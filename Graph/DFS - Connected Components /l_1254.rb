# Logic:
# A closed island is a group of 0s completely surrounded by 1s.
#
# In this problem:
# - 0 means land
# - 1 means water
#
# Any land cell connected to the border cannot be a closed island,
# because it can "escape" outside the grid.
#
# So first, we remove all border-connected land using DFS.
# Then, whatever land remains inside the grid must be closed.
#
# Final idea:
# 1. DFS from all border cells and convert connected 0s to 1s.
# 2. Scan the inner grid.
# 3. Each remaining 0 starts one closed island.
# 4. DFS it to mark it visited.
# 5. Count how many such islands exist.

# @param {Integer[][]} grid
# @return {Integer}
def closed_island(grid)
  rows = grid.length
  cols = grid[0].length

  # Remove land connected to the left and right borders.
  # These cannot be closed islands.
  (0...rows).each do |r|
    dfs(grid, r, 0, rows, cols)
    dfs(grid, r, cols - 1, rows, cols)
  end

  # Remove land connected to the top and bottom borders.
  # These also cannot be closed islands.
  (0...cols).each do |c|
    dfs(grid, 0, c, rows, cols)
    dfs(grid, rows - 1, c, rows, cols)
  end

  cnt = 0

  # Now scan only the inner grid.
  # Any remaining 0 is a closed island.
  (1...rows - 1).each do |r|
    (1...cols - 1).each do |c|
      if grid[r][c] == 0
        cnt += 1

        # Mark this entire closed island as visited.
        dfs(grid, r, c, rows, cols)
      end
    end
  end

  cnt
end

def dfs(grid, r, c, rows, cols)
  # Stop if the position is outside the grid.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if this cell is water or already visited.
  return if grid[r][c] == 1

  # Mark this land cell as visited by converting it to water.
  grid[r][c] = 1

  # Visit all 4-directionally connected land cells.
  dfs(grid, r - 1, c, rows, cols) # up
  dfs(grid, r + 1, c, rows, cols) # down
  dfs(grid, r, c - 1, rows, cols) # left
  dfs(grid, r, c + 1, rows, cols) # right
end