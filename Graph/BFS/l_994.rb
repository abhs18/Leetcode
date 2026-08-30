# @param {Integer[][]} grid
# @return {Integer}
def oranges_rotting(grid)
  rows = grid.size
  cols = grid[0].size

  queue = []

  # Add all initially rotten oranges to the queue.
  # These are the starting points for multi-source BFS.
  (0...rows).each do |r|
    (0...cols).each do |c|
      queue << [r, c] if grid[r][c] == 2
    end
  end

  minutes = 0
  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  # BFS level by level.
  # Each full level represents one minute passing.
  while queue.size > 0
    level_size = queue.size

    while level_size > 0
      r, c = queue.shift

      directions.each do |dr, dc|
        nr = r + dr
        nc = c + dc

        # Skip cells outside the grid.
        next if nr < 0 || nr >= rows || nc < 0 || nc >= cols

        # Only fresh oranges can become rotten.
        next if grid[nr][nc] != 1

        # Rot this fresh orange and add it for the next minute.
        grid[nr][nc] = 2
        queue << [nr, nc]
      end

      level_size -= 1
    end

    # If queue still has oranges, that means new oranges rotted,
    # so one minute has passed.
    minutes += 1 if queue.size > 0
  end

  # If any fresh orange remains, it was unreachable.
  return -1 if grid.flatten.include?(1)

  minutes
end