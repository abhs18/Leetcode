# Logic:
# This is a directed graph cycle detection problem.
#
# Each course is a node.
# For prerequisite [course, prereq]:
# - You must take prereq before course.
# - So we create a directed edge: prereq -> course.
#
# If there is a cycle, it is impossible to finish all courses.
# Example:
# 0 -> 1 -> 0
#
# We use 3 states:
# 0 = unvisited
# 1 = visiting, currently in the DFS path
# 2 = done, fully checked and safe
#
# If DFS reaches a node with state 1, we found a cycle.

# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish(num_courses, prerequisites)
  # Graph stores each course and the courses unlocked by it.
  # Hash default creates an empty array for courses with no edges.
  @graph = Hash.new { |h, k| h[k] = [] }

  # Becomes true if we find any cycle.
  @cycle = false

  # Visited state for each course:
  # 0 = unvisited, 1 = visiting, 2 = done
  @vis = Array.new(num_courses, 0)

  # Build the directed graph.
  prerequisites.each do |edge|
    course = edge[0]
    prereq = edge[1]

    # To take course, we must first take prereq.
    # So prereq points to course.
    @graph[prereq] << course
  end

  # Try DFS from every course because the graph may be disconnected.
  (0...num_courses).each do |num|
    dfs(num) if @vis[num] == 0
  end

  # If there is no cycle, all courses can be finished.
  !@cycle
end

def dfs(root)
  # If this course is already fully processed, no need to check again.
  return if @vis[root] == 2

  # If we reach a course currently in the DFS path,
  # then we found a cycle.
  if @vis[root] == 1
    @cycle = true
    return
  end

  # Mark this course as currently being explored.
  @vis[root] = 1

  # Visit all courses that depend on this course.
  @graph[root].each do |node|
    dfs(node)
  end

  # Mark this course as fully processed.
  @vis[root] = 2
end