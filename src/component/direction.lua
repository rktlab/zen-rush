local Direction = Component.create("Direction")

-- Take a vector denoted by x & y
function Direction:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
end

return Direction
