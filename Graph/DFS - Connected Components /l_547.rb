# @param {Integer[][]} is_connected
# @return {Integer}
def find_circle_num(is_connected)
  number_of_provinces = 0

  # visited keeps track of cities we have already explored.
  # If a city is visited, it already belongs to a counted province.
  visited = Hash.new { false }

  # Each index represents one city.
  (0...is_connected.length).each do |city|
    # If this city is not visited, it starts a new province.
    unless visited[city]
      number_of_provinces += 1

      # DFS will visit this city and all cities connected to it,
      # marking the entire province as visited.
      dfs(is_connected, city, visited)
    end
  end

  number_of_provinces
end

def dfs(is_connected, city, visited)
  # Mark the current city as visited.
  visited[city] = true

  # Check every possible neighbor city.
  (0...is_connected.length).each do |neighbour|
    # is_connected[city][neighbour] == 1 means there is
    # a direct connection between current city and neighbour.
    #
    # If neighbour is not visited, it belongs to the same province.
    if is_connected[city][neighbour] == 1 && !visited[neighbour]
      dfs(is_connected, neighbour, visited)
    end
  end
end