# @param {Integer[][]} mat
# @return {Integer[][]}
def update_matrix(mat)
  rows = mat.length
  cols = mat[0].length

  queue = []

  # dist_mat[r][c] stores the distance from cell (r, c)
  # to the nearest 0.
  #
  # -1 means this cell has not been visited yet.
  dist_mat = Array.new(rows) { Array.new(cols, -1) }

  # Add all 0 cells to the queue first.
  # These are the starting points for multi-source BFS.
  (0...rows).each do |r|
    (0...cols).each do |c|
      if mat[r][c] == 0
        queue << [r, c]
        dist_mat[r][c] = 0
      end
    end
  end

  head = 0

  # BFS expands level by level.
  # First we process all cells at distance 0,
  # then distance 1, then distance 2, and so on.
  while head < queue.length
    r, c = queue[head]
    head += 1

    # Visit all 4-directional neighbors.
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |nr, nc|
      dr = r + nr
      dc = c + nc

      # Skip if neighbor is outside the matrix.
      next if dr < 0 || dr >= rows || dc < 0 || dc >= cols

      # Skip if neighbor already has a distance.
      next if dist_mat[dr][dc] != -1

      # Neighbor's distance is current cell's distance + 1.
      dist_mat[dr][dc] = dist_mat[r][c] + 1

      # Add neighbor to queue so its neighbors can be processed later.
      queue << [dr, dc]
    end
  end

  dist_mat
end