# @param {Integer[][]} image
# @param {Integer} sr
# @param {Integer} sc
# @param {Integer} color
# @return {Integer[][]}
def flood_fill(image, sr, sc, color)
    rows = image.length
    cols = image[0].length
    @color = color
    @node_color = image[sr][sc]
    return image if @color == @node_color
    dfs(image,sr,sc,rows,cols)
     return image

end

def dfs(image,r,c,rows,cols)
  return if r < 0 || r >= rows || c < 0 || c >= cols
  return if image[r][c] != @node_color
  image[r][c] = @color

  dfs(image,r-1,c,rows,cols)
  dfs(image,r+1,c,rows,cols)
  dfs(image,r,c-1,rows,cols)
  dfs(image,r,c+1,rows,cols)
end