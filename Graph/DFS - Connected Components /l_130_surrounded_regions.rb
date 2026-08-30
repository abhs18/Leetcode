# Logic:
# 1. Any 'O' on the border cannot be surrounded.
# 2. Any 'O' connected to a border 'O' also cannot be surrounded.
# 3. So, first mark all border-connected 'O's as safe using DFS.
# 4. Then convert the remaining 'O's to 'X'.
# 5. Finally, convert the safe marker 'S' back to 'O'.

def solve(board)
  rows = board.length
  cols = board[0].length

  # Start DFS from every cell in the first and last column.
  # This marks all 'O's connected to the left or right border as safe.
  (0...rows).each do |r|
    dfs(board, r, 0, rows, cols)
    dfs(board, r, cols - 1, rows, cols)
  end

  # Start DFS from every cell in the first and last row.
  # This marks all 'O's connected to the top or bottom border as safe.
  (0...cols).each do |c|
    dfs(board, 0, c, rows, cols)
    dfs(board, rows - 1, c, rows, cols)
  end

  # After marking safe regions:
  # - Remaining 'O's are surrounded, so convert them to 'X'.
  # - Safe 'O's were marked as 'S', so convert them back to 'O'.
  (0...rows).each do |r|
    (0...cols).each do |c|
      if board[r][c] == "O"
        board[r][c] = "X"
      elsif board[r][c] == "S"
        board[r][c] = "O"
      end
    end
  end

  board
end

def dfs(board, r, c, rows, cols)
  # Stop if the cell is outside the board.
  return if r < 0 || r >= rows || c < 0 || c >= cols

  # Stop if the cell is not an unvisited 'O'.
  return if board[r][c] != "O"

  # Mark this 'O' as safe because it is connected to a border 'O'.
  board[r][c] = "S"

  # Visit all 4-directionally connected neighbors.
  dfs(board, r - 1, c, rows, cols) # up
  dfs(board, r + 1, c, rows, cols) # down
  dfs(board, r, c - 1, rows, cols) # left
  dfs(board, r, c + 1, rows, cols) # right
end

board = [
  ["X", "X", "X", "X"],
  ["X", "O", "O", "X"],
  ["X", "X", "O", "X"],
  ["X", "O", "X", "X"]
]

p solve(board)