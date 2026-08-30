# Logic:
# Treat the grid like a graph:
# - Each cell is a node.
# - A land cell "1" is connected to nearby land cells in 4 directions:
#   up, down, left, and right.
#
# We scan every cell in the grid.
# Whenever we find a "1", that means we found a new island.
# Then we run DFS from that cell to visit the entire island.
#
# During DFS, we change visited land "1" into water "0".
# This prevents the same island from being counted again.
#
# So:
# - each DFS call from the main loop represents one island
# - island_cnt increases once per island

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  rows = grid.length
  cols = grid[0].length
  island_cnt = 0

  # Scan every cell in the grid.
  (0...rows).each do |row|
    (0...cols).each do |col|
      # If we find unvisited land, we found a new island.
      if grid[row][col] == "1"
        island_cnt += 1

        # Mark the full connected island as visited.
        dfs(grid, row, col, rows, cols)
      end
    end
  end

  island_cnt
end

def dfs(grid, r, c, rows, cols)
  # Stop if the current position is outside the grid.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if the cell is water or already visited.
  return if grid[r][c] != "1"

  # Mark current land as visited by converting it to water.
  grid[r][c]