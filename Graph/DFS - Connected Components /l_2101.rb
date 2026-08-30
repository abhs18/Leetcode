# Logic:
# Each bomb is a node in a directed graph.
#
# If bomb i can detonate bomb j, we create a directed edge:
# i -> j
#
# The edge is directed because bomb i may reach bomb j,
# but bomb j may not reach bomb i.
#
# After building the graph:
# 1. Try starting the explosion from every bomb.
# 2. Run DFS to see how many bombs can be reached/detonated.
# 3. Track the maximum count.

# @param {Integer[][]} bombs
# @return {Integer}
def maximum_detonation(bombs)
  graph = {}
  n = bombs.length

  # Build the graph.
  # Each bomb index is a node.
  (0...n).each do |i|
    (0...n).each do |j|
      next if i == j

      # Create an empty adjacency list for bomb i if needed.
      graph[i] ||= []

      # If bomb i can detonate bomb j,
      # add a directed edge from i to j.
      graph[i] << j if can_detonate(bombs[i], bombs[j])
    end
  end

  max_count = 0

  # Try detonating each bomb as the starting bomb.
  bombs.each_with_index do |bomb, i|
    # Fresh visited hash for each starting bomb.
    # This is important because every start is a separate simulation.
    vis = {}

    # DFS marks all bombs reachable from bomb i.
    dfs(graph, i, vis)

    # Update the maximum number of bombs detonated.
    max_count = [max_count, vis.keys.count].max
  end

  max_count
end

def can_detonate(p1, p2)
  # Return true if bomb p1 can detonate bomb p2.

  x1 = p1[0]
  x2 = p2[0]
  y1 = p1[1]
  y2 = p2[1]

  r = p1[2]

  dx = x1 - x2
  dy = y1 - y2

  # Instead of calculating actual distance using square root,
  # compare squared distance with squared radius.
  #
  # p1 can detonate p2 if:
  # dx^2 + dy^2 <= r^2
  ((dx * dx) + (dy * dy)) <= (r * r)
end

def dfs(graph, bomb, vis)
  # Stop if this bomb has already been detonated in this simulation.
  return if vis[bomb]

  # Mark current bomb as detonated.
  vis[bomb] = true

  # If this bomb cannot detonate any other bomb, stop.
  return unless graph[bomb]

  # Detonate all bombs directly reachable from this bomb.
  graph[bomb].each do |connected_bomb|
    dfs(graph, connected_bomb, vis) unless vis[connected_bomb]
  end
end