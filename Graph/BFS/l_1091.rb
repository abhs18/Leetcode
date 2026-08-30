# @param {Integer[][]} grid
# @return {Integer}
def shortest_path_binary_matrix(grid)
  rows = grid.size
  cols = grid[0].size

  # If the starting cell or ending cell is blocked,
  # then there is no valid path.
  return -1 if grid[0][0] == 1 || grid[rows - 1][cols - 1] == 1

  queue = []

  # Start BFS from the top-left cell.
  queue << [0, 0]

  # dist_mat[r][c] stores the shortest path length
  # from (0, 0) to cell (r, c).
  #
  # -1 means the cell has not been visited yet.
  dist_mat = Array.new(rows) { Array.new(cols, -1) }

  # Distance starts at 1 because the path length counts cells,
  # not just moves.
  dist_mat[0][0] = 1

  # 8 possible directions:
  # up, down, left, right, and 4 diagonals.
  dir = [
    [-1, 0], [1, 0], [0, -1], [0, 1],
    [-1, -1], [1, 1], [1, -1], [-1, 1]
  ]

  # BFS continues until there are no more reachable cells.
  while !queue.empty?
    r, c = queue.first
    queue.shift

    # Try moving to each of the 8 neighboring cells.
    dir.each do |dr, dc|
      nr = r + dr
      nc = c + dc

      # Skip if the neighbor is outside the grid.
      next if nr < 0 || nr >= rows || nc < 0 || nc >= cols

      # Skip if the neighbor is blocked.
      next if grid[nr][nc] == 1

      # Skip if the neighbor has already been visited.
      # The first time BFS reaches a cell is the shortest path to it.
      next if dist_mat[nr][nc] != -1

      # Store shortest path length for this neighbor.
      dist_mat[nr][nc] = dist_mat[r][c] + 1

      # Add neighbor to queue so its neighbors can be explored later.
      queue << [nr, nc]
    end
  end

  # If the target was reached, this is its shortest path length.
  # If not reached, it remains -1.
  dist_mat[rows - 1][cols - 1]
end

grid = [[0,0,0,0,1],[1,0,0,0,0],[0,1,0,1,0],[0,0,0,1,1],[0,0,0,1,0]]

puts shortest_path_binary_matrix(grid)