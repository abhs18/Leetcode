# Logic:
# We need to count islands in grid2 that are completely inside islands in grid1.
#
# A grid2 island is a sub-island only if every land cell in that grid2 island
# is also land in grid1.
#
# So:
# 1. Scan every cell in grid2.
# 2. When we find land in grid2, start DFS for that whole island.
# 3. During DFS, if any grid2 land cell is water in grid1, mark this island invalid.
# 4. Still finish DFS even if invalid, so the whole grid2 island is marked visited.
# 5. After DFS, count the island only if it stayed valid.

# @param {Integer[][]} grid1
# @param {Integer[][]} grid2
# @return {Integer}
def count_sub_islands(grid1, grid2)
  rows = grid1.length
  cols = grid1[0].length
  cnt = 0

  # Scan every cell in grid2.
  (0...rows).each do |r|
    (0...cols).each do |c|
      # Start DFS from every unvisited land cell in grid2.
      # This represents one full island in grid2.
      if grid2[r][c] == 1
        # Assume this grid2 island is a valid sub-island.
        @flag = true

        # DFS will visit the whole grid2 island and check it against grid1.
        dfs(grid1, grid2, r, c, rows, cols)

        # Count it only if every cell of this grid2 island was also land in grid1.
        cnt += 1 if @flag
      end
    end
  end

  cnt
end

def dfs(grid1, grid2, r, c, rows, cols)
  # Stop if outside the grid.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if this cell is water or already visited in grid2.
  return if grid2[r][c] == 0

  # If grid2 has land here but grid1 has water,
  # then this entire grid2 island is not a valid sub-island.
  @flag = false if grid1[r][c] == 0

  # Mark this grid2 land cell as visited.
  grid2[r][c] = 0

  # Visit all 4-directionally connected land cells in grid2.
  dfs(grid1, grid2, r - 1, c, rows, cols) # up
  dfs(grid1, grid2, r + 1, c, rows, cols) # down
  dfs(grid1, grid2, r, c - 1, rows, cols) # left
  dfs(grid1, grid2, r, c + 1, rows, cols) # right
end