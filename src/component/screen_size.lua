local ScreenSize = Component.create("ScreenSize")

-- Take a point denoted by x & y
function ScreenSize:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
end

return ScreenSize
