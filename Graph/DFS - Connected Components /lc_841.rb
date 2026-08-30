# @param {Integer[][]} rooms
# @return {Boolean}
def can_visit_all_rooms(rooms)
  n = rooms.length

  # visited keeps track of rooms we have already entered.
  visited = {}

  # We always start from room 0.
  dfs(rooms, 0, visited)

  # If the number of visited rooms equals total rooms,
  # then we can visit every room.
  visited.keys.length == n
end

def dfs(rooms, room, visited)
  # Stop if this room was already visited.
  return if visited[room] == true

  # Mark the current room as visited.
  visited[room] = true

  # Each value inside rooms[room] is a key to another room.
  # Use each key to visit the connected room.
  rooms[room].each do |neighbour|
    dfs(rooms, neighbour, visited) unless visited[neighbour]
  end
end