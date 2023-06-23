local Position = Component.create("Position")

-- Take a point denoted by x & y
function Position:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
end

return Position
